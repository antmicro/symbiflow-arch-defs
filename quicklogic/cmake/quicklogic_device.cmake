function(DEFINE_QUICKLOGIC_DEVICE)

#  set(options )
  set(oneValueArgs DEVICE ARCH GRID_LIMIT)
  set(multiValueArgs PACKAGES PB_TYPES)
  cmake_parse_arguments(
    DEFINE_QUICKLOGIC_DEVICE
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  set(DEVICE ${DEFINE_QUICKLOGIC_DEVICE_DEVICE})
  set(ARCH ${DEFINE_QUICKLOGIC_DEVICE_ARCH})
  set(PACKAGES ${DEFINE_QUICKLOGIC_DEVICE_PACKAGES})

  set(DEVICE_TYPE ${DEVICE}-virt)

  get_target_property_required(PYTHON3 env PYTHON3)
  get_target_property_required(PYTHON3_TARGET env PYTHON3_TARGET)

  set(SDF_TIMING_DIRECTORY ${symbiflow-arch-defs_SOURCE_DIR}/quicklogic/timings)
  set(BELS_MAP ${symbiflow-arch-defs_SOURCE_DIR}/quicklogic/bels.json)

  set(TECHFILE "${symbiflow-arch-defs_SOURCE_DIR}/quicklogic/QLAL4S3B.xml")
  set(PHY_DB_FILE "db_phy.pickle")
  set(VPR_DB_FILE "db_vpr.pickle")
  set(ARCH_XML "arch.xml")

  # Import data from the techfile
  set(DATA_IMPORT ${symbiflow-arch-defs_SOURCE_DIR}/quicklogic/utils/data_import.py)
  add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${PHY_DB_FILE}
    COMMAND ${PYTHON3} ${DATA_IMPORT}
      --techfile ${TECHFILE}
      --db ${PHY_DB_FILE}
    DEPENDS ${TECHFILE} ${DATA_IMPORT} ${PYTHON3_TARGET}
  )
  add_file_target(FILE ${PHY_DB_FILE} GENERATED)

  # Process the database, create the VPR database
  set(PREPARE_VPR_DATABASE ${symbiflow-arch-defs_SOURCE_DIR}/quicklogic/utils/prepare_vpr_database.py)

  if(NOT "${DEFINE_QUICKLOGIC_DEVICE_GRID_LIMIT}" STREQUAL "")
    separate_arguments(GRID_LIMIT_ARGS UNIX_COMMAND "--grid-limit ${DEFINE_QUICKLOGIC_DEVICE_GRID_LIMIT}")
  else()
    set(GRID_LIMIT_ARGS "")
  endif()

  add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${VPR_DB_FILE}
    COMMAND ${PYTHON3} ${PREPARE_VPR_DATABASE}
      --phy-db ${PHY_DB_FILE}
      --vpr-db ${VPR_DB_FILE}
      ${GRID_LIMIT_ARGS}
    DEPENDS ${PHY_DB_FILE} ${PREPARE_VPR_DATABASE} ${PYTHON3_TARGET}
  )
  add_file_target(FILE ${VPR_DB_FILE} GENERATED)

  # Get dependencies for arch.xml
  # FIXME: Not sure, this probably should be a part of ARCH instrad of DEVICE.
  set(XML_DEPS "")
  foreach(PB_TYPE ${DEFINE_QUICKLOGIC_DEVICE_PB_TYPES})
    string(TOLOWER ${PB_TYPE} PB_TYPE_LOWER)
    set(PB_TYPE_XML ${symbiflow-arch-defs_SOURCE_DIR}/quicklogic/primitives/${PB_TYPE_LOWER}/${PB_TYPE_LOWER}.pb_type.xml)
    set(MODEL_XML   ${symbiflow-arch-defs_SOURCE_DIR}/quicklogic/primitives/${PB_TYPE_LOWER}/${PB_TYPE_LOWER}.model.xml)
    append_file_dependency(XML_DEPS ${PB_TYPE_XML})
    append_file_dependency(XML_DEPS ${MODEL_XML})
  endforeach()

  # Generate the arch.xml
  set(ARCH_IMPORT ${symbiflow-arch-defs_SOURCE_DIR}/quicklogic/utils/arch_import.py)
  add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${ARCH_XML}
    COMMAND ${PYTHON3} ${ARCH_IMPORT}
      --vpr-db ${VPR_DB_FILE}
      --arch-out ${ARCH_XML}
      --device ${DEVICE}
    DEPENDS ${VPR_DB_FILE} ${XML_DEPS} ${ARCH_IMPORT} ${PYTHON3_TARGET}
  )
  add_file_target(FILE ${ARCH_XML} GENERATED)

  # Timing import stuff
  set(UPDATE_ARCH_TIMINGS ${symbiflow-arch-defs_SOURCE_DIR}/utils/update_arch_timings.py)
  set(PYTHON_SDF_TIMING_DIR ${symbiflow-arch-defs_SOURCE_DIR}/third_party/python-sdf-timing)
  get_target_property(SDF_TIMING_TARGET env SDF_TIMING_TARGET)

  set(TIMING_IMPORT "${PYTHON3} ${UPDATE_ARCH_TIMINGS} --sdf_dir ${SDF_TIMING_DIRECTORY} --bels_map ${BELS_MAP} --out_arch /dev/stdout --input_arch /dev/stdin")
  set(TIMING_DEPS ${SDF_TIMING_TARGET})
 
  # Define the device type
  define_device_type(
    DEVICE_TYPE ${DEVICE_TYPE}
    ARCH ${ARCH}
    ARCH_XML ${ARCH_XML}
    SCRIPT_OUTPUT_NAME timing
    SCRIPTS ${TIMING_IMPORT}
    SCRIPT_DEPS TIMING_DEPS
  )

  # Define the device
  define_device(
    DEVICE ${DEVICE}
    ARCH ${ARCH}
    DEVICE_TYPE ${DEVICE_TYPE}
    PACKAGES ${PACKAGES}
    WIRE_EBLIF ${symbiflow-arch-defs_SOURCE_DIR}/quicklogic/dummy.eblif
    CACHE_PLACE_DELAY
    CACHE_ARGS
      --route_chan_width 100
      --clock_modeling route
      --allow_unrelated_clustering off
      --target_ext_pin_util 0.7
      --router_init_wirelength_abort_threshold 2
      --congested_routing_iteration_threshold 0.8
  )

endfunction()
