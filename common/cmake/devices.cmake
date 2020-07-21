# This CMake include defines the following functions:
#
# * DEFINE_ARCH - Define an FPGA architecture and tools to use that
#   architecture.
# * DEFINE_DEVICE_TYPE - Define a device type within an FPGA architecture.
# * DEFINE_DEVICE - Define a device and packaging for a specific device type and
#   FPGA architecture.
# * DEFINE_BOARD - Define a board that uses specific device and package.
# * ADD_FPGA_TARGET - Creates a FPGA image build against a specific board.

function(DEFINE_ARCH)
  # ~~~
  # DEFINE_ARCH(
  #    ARCH <arch>
  #    FAMILY <family>
  #    DOC_PRJ <documentation_project>
  #    DOC_PRJ_DB <documentation_database>
  #    PROTOTYPE_PART <prototype_part>
  #    YOSYS_SYNTH_SCRIPT <yosys_script>
  #    YOSYS_CONV_SCRIPT <yosys_script>
  #    BITSTREAM_EXTENSION <ext>
  #    [VPR_ARCH_ARGS <arg list>]
  #    RR_PATCH_TOOL <path to rr_patch tool>
  #    RR_PATCH_CMD <command to run RR_PATCH_TOOL>
  #    DEVICE_FULL_TEMPLATE <template for constructing DEVICE_FULL strings.
  #    [NO_PINS]
  #    [NO_PLACE]
  #    [NO_PLACE_CONSTR]
  #    [USE_FASM]
  #    PLACE_TOOL <path to place tool>
  #    PLACE_TOOL_CMD <command to run PLACE_TOOL>
  #    PLACE_CONSTR_TOOL <path to place constraints tool>
  #    PLACE_CONSTR_TOOL_CMD <command to run PLACE_CONSTR_TOOL>
  #    [NO_BITSTREAM]
  #    [NO_BIT_TO_BIN]
  #    [NO_BIT_TO_V]
  #    [CELLS_SIM <path to verilog file used for simulation>]
  #    HLC_TO_BIT <path to HLC to bitstream converter>
  #    HLC_TO_BIT_CMD <command to run HLC_TO_BIT>
  #    FASM_TO_BIT <path to FASM to bitstream converter>
  #    FASM_TO_BIT_CMD <command to run FASM_TO_BIT>
  #    FASM_TO_BIT_DEPS <list of dependencies for FASM_TO_BIT_CMD>
  #    BIT_TO_V <path to bitstream to verilog converter>
  #    BIT_TO_V_CMD <command to run BIT_TO_V>
  #    BIT_TO_BIN <path to bitstream to binary>
  #    BIT_TO_BIN_CMD <command to run BIT_TO_BIN>
  #    BIT_TIME <path to BIT_TIME executable>
  #    BIT_TIME_CMD <command to run BIT_TIME>
  #    [RR_GRAPH_EXT <ext>]
  #   )
  # ~~~
  #
  # DEFINE_ARCH defines an FPGA architecture.
  #
  # FAMILY refers to the family under which the architecture is located.
  # e.g. 7series, UltraScale, Spartan are all different kinds of families.
  #
  # DOC_PRJ and DOC_PRJ_DB are optional arguments that are relative to the
  # third party projects containing tools and information to correctly run
  # the flow:
  #
  #  * DOC_PRJ - path to the third party documentation project
  #  * DOC_PRJ_DB - path to the third party documentation database
  #
  # If NO_PINS is set, PLACE_TOOL and PLACE_TOOL_CMD cannot be specified.
  # If NO_BITSTREAM is set, HLC_TO_BIT, HLC_TO_BIT_CMD BIT_TO_V,
  # BIT_TO_V_CMD, BIT_TO_BIN and BIT_TO_BIN_CMD cannot be specified.
  #
  # if NO_BIT_TO_BIN is given then there will be no BIT to BIN stage.
  #
  # YOSYS_SYNTH_SCRIPT - The main design synthesis script. It needs to write
  #  the synthesized design in JSON format to a file name pointed by the
  #  OUT_JSON env. variable.
  #
  # YOSYS_CONV_SCRIPT - This is the name of the script that makes Yosys convert
  #  the processed JSON design to the EBLIF format accepted by the VPR. The
  #  EBLIF file name is given in the OUT_EBLIF env. variable.
  #
  # DEVICE_FULL_TEMPLATE, RR_PATCH_CMD, PLACE_TOOL_CMD and HLC_TO_BIT_CMD will
  # all be called with string(CONFIGURE) to substitute variables.
  #
  # DEVICE_FULL_TEMPLATE variables:
  #
  #  * DEVICE
  #  * PACKAGE
  #
  # RR_PATCH_CMD variables:
  #
  # * RR_PATCH_TOOL - Value of RR_PATCH_TOOL property of <arch>.
  # * DEVICE - What device is being patch (see DEFINE_DEVICE).
  # * OUT_RRXML_VIRT - Input virtual rr_graph file for device.
  # * OUT_RRXML_REAL - Output real XML rr_graph file for device.
  # * OUT_RRBIN_REAL - Output real BIN rr_graph file for device.
  #
  # PLACE_TOOL_CMD variables:
  #
  # * PLACE_TOOL - Value of PLACE_TOOL property of <arch>.
  # * PINMAP - Path to pinmap file.  This file will be retrieved from the
  #   PINMAP property of the ${BOARD}.  ${DEVICE} and ${PACKAGE}
  #   will be defined by the BOARD being used. See DEFINE_BOARD.
  # * OUT_EBLIF - Input path to EBLIF file.
  # * INPUT_IO_FILE - Path to input io file, as specified by ADD_FPGA_TARGET.
  #
  # PLACE_TOOL_CONSTR_CMD variables:
  #
  # * PLACE_CONSTR_TOOL - Value of PLACE_CONSTR_TOOL property of <arch>.
  # * NO_PLACE_CONSTR - If this option is set, the PLACE_CONSTR_TOOL is disabled
  #
  # This command enables the possibility to add an additional step consisting
  # on the addition of extra placement constraints through the usage of the chosen
  # script.
  # The IO placement file is passed to the script through standard input and, when
  # the new placement constraints for non-IO tiles have been added, a new placement
  # constraint file is generated and fed to standard output.
  #
  #
  #
  # HLC_TO_BIT_CMD variables:
  #
  # * HLC_TO_BIT - Value of HLC_TO_BIT property of <arch>.
  # * OUT_HLC - Input path to HLC file.
  # * OUT_BITSTREAM - Output path to bitstream file.
  #
  # BIT_TO_V variables:
  #
  # * BIT_TO_V - Value of BIT_TO_V property of <arch>.
  # * TOP - Name of top module.
  # * INPUT_IO_FILE - Logic to IO pad constraint file.
  # * PACKAGE - Package of bitstream.
  # * OUT_BITSTREAM - Input path to bitstream.
  # * OUT_BIT_VERILOG - Output path to verilog version of bitstream.
  set(options
    NO_PLACE_CONSTR
    NO_PINS
    NO_BITSTREAM
    NO_BIT_TO_BIN
    NO_BIT_TO_V
    NO_BIT_TIME
    USE_FASM
  )

  set(
    oneValueArgs
    ARCH
    FAMILY
    DOC_PRJ
    DOC_PRJ_DB
    PROTOTYPE_PART
    YOSYS_SYNTH_SCRIPT
    YOSYS_CONV_SCRIPT
    YOSYS_TECHMAP
    DEVICE_FULL_TEMPLATE
    BITSTREAM_EXTENSION
    BIN_EXTENSION
    RR_PATCH_TOOL
    RR_PATCH_CMD
    PLACE_TOOL
    PLACE_TOOL_CMD
    PLACE_CONSTR_TOOL
    PLACE_CONSTR_TOOL_CMD
    HLC_TO_BIT
    HLC_TO_BIT_CMD
    FASM_TO_BIT
    FASM_TO_BIT_CMD
    BIT_TO_V
    BIT_TO_V_CMD
    BIT_TO_BIN
    BIT_TO_BIN_CMD
    BIT_TIME
    BIT_TIME_CMD
    RR_GRAPH_EXT
    ROUTE_CHAN_WIDTH
  )

  set(
    multiValueArgs
    CELLS_SIM
    VPR_ARCH_ARGS
    FASM_TO_BIT_DEPS
  )

  cmake_parse_arguments(
    DEFINE_ARCH
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  add_custom_target(${DEFINE_ARCH_ARCH})

  set(REQUIRED_ARGS
    YOSYS_SYNTH_SCRIPT
    YOSYS_CONV_SCRIPT
    DEVICE_FULL_TEMPLATE
    RR_PATCH_TOOL
    RR_PATCH_CMD
    NO_PLACE_CONSTR
    NO_PINS
    NO_BITSTREAM
    NO_BIT_TO_BIN
    NO_BIT_TO_V
    NO_BIT_TIME
    USE_FASM
    ROUTE_CHAN_WIDTH
    )
  set(DISALLOWED_ARGS "")
  set(OPTIONAL_ARGS
    FAMILY
    DOC_PRJ
    DOC_PRJ_DB
    PROTOTYPE_PART
    VPR_ARCH_ARGS
    YOSYS_TECHMAP
    CELLS_SIM
    )

  set(PLACE_ARGS
    PLACE_TOOL
    PLACE_TOOL_CMD
    )

  set(PLACE_CONSTR_ARGS
    PLACE_CONSTR_TOOL
    PLACE_CONSTR_TOOL_CMD
    )

  set(FASM_BIT_ARGS
    FASM_TO_BIT
    FASM_TO_BIT_CMD
    )

  set(HLC_BIT_ARGS
    HLC_TO_BIT
    HLC_TO_BIT_CMD
    )

  set(BIT_ARGS
    BITSTREAM_EXTENSION
    )

  set(BIN_ARGS
    BIN_EXTENSION
    BIT_TO_BIN
    BIT_TO_BIN_CMD
    )

  set(BIT_TO_V_ARGS
    BIT_TO_V
    BIT_TO_V_CMD
    )

  set(BIT_TIME_ARGS
    BIT_TIME
    BIT_TIME_CMD
    )

  if(NOT ${DEFINE_ARCH_NO_BIT_TO_BIN})
    list(APPEND BIT_ARGS ${BIN_ARGS})
  else()
    list(APPEND DISALLOWED_ARGS ${BIN_ARGS})
  endif()

  if(${DEFINE_ARCH_USE_FASM})
    list(APPEND DISALLOWED_ARGS ${HLC_BIT_ARGS})
    list(APPEND OPTIONAL_ARGS FASM_TO_BIT_DEPS)
    list(APPEND BIT_ARGS ${FASM_BIT_ARGS})
  else()
    list(APPEND DISALLOWED_ARGS ${FASM_BIT_ARGS})
    list(APPEND DISALLOWED_ARGS FASM_TO_BIT_DEPS)
    list(APPEND BIT_ARGS ${HLC_BIT_ARGS})
  endif()

  set(VPR_${DEFINE_ARCH_ARCH}_ARCH_ARGS "${DEFINE_ARCH_VPR_ARCH_ARGS}"
    CACHE STRING "Extra VPR arguments for ARCH=${ARCH}")

  if(${DEFINE_ARCH_NO_PINS})
    list(APPEND DISALLOWED_ARGS ${PLACE_ARGS})
  else()
    list(APPEND REQUIRED_ARGS ${PLACE_ARGS})
  endif()

  if(${DEFINE_ARCH_NO_PLACE_CONSTR})
    list(APPEND DISALLOWED_ARGS ${PLACE_CONSTR_ARGS})
  else()
    list(APPEND REQUIRED_ARGS ${PLACE_CONSTR_ARGS})
  endif()

  set(RR_GRAPH_EXT ".xml")
  if(NOT "${DEFINE_ARCH_RR_GRAPH_EXT}" STREQUAL "")
    set(RR_GRAPH_EXT "${DEFINE_ARCH_RR_GRAPH_EXT}")
  endif()

  if(${DEFINE_ARCH_NO_BITSTREAM})
    list(APPEND DISALLOWED_ARGS ${BIT_ARGS})
  else()
    list(APPEND REQUIRED_ARGS ${BIT_ARGS})
  endif()

  if(${DEFINE_ARCH_NO_BIT_TO_V})
    list(APPEND DISALLOWED_ARGS ${BIT_TO_V_ARGS})
  else()
    list(APPEND REQUIRED_ARGS ${BIT_TO_V_ARGS})
  endif()

  if(${DEFINE_ARCH_NO_BIT_TIME})
    list(APPEND DISALLOWED_ARGS ${BIT_TIME_ARGS})
  else()
    list(APPEND REQUIRED_ARGS ${BIT_TIME_ARGS})
  endif()

  foreach(ARG ${REQUIRED_ARGS})
    if("${DEFINE_ARCH_${ARG}}" STREQUAL "")
      message(FATAL_ERROR "Required argument ${ARG} is the empty string.")
    endif()
    set_target_properties(
      ${DEFINE_ARCH_ARCH}
      PROPERTIES ${ARG} "${DEFINE_ARCH_${ARG}}"
    )
  endforeach()
  set_target_properties(
    ${DEFINE_ARCH_ARCH}
    PROPERTIES RR_GRAPH_EXT "${RR_GRAPH_EXT}"
  )
  foreach(ARG ${OPTIONAL_ARGS})
    set_target_properties(
      ${DEFINE_ARCH_ARCH}
      PROPERTIES ${ARG} "${DEFINE_ARCH_${ARG}}"
    )
  endforeach()
  foreach(ARG ${DISALLOWED_ARGS})
    if(NOT "${DEFINE_ARCH_${ARG}}" STREQUAL "")
      message(FATAL_ERROR "Argument ${ARG} is disallowed when NO_PINS = ${NO_PINS} and NO_BITSTREAM = ${NO_BITSTREAM}.")
    endif()
  endforeach()
endfunction()

function(DEFINE_DEVICE_TYPE)
  # ~~~
  # DEFINE_DEVICE_TYPE(
  #   DEVICE_TYPE <device_type>
  #   ARCH <arch>
  #   ARCH_XML <arch.xml>
  #   [SCRIPT_OUTPUT_NAME]
  #   [SCRIPT_DEPS]
  #   [SCRIPTS]
  #   )
  # ~~~
  #
  # Defines a device type with the specified architecture.  ARCH_XML argument
  # must be a file target (see ADD_FILE_TARGET).
  #
  # optional SCRIPTs can be run after the standard flow to augment the
  # final arch xml. The name and script must be provided and each
  # script will be run as `cmd < input > output`.
  # If the SCRIPT has dependencies, SCRIPT_DEPS can be used to be passed to the
  # SCRIPT command.
  #
  # DEFINE_DEVICE_TYPE defines a dummy target <arch>_<device_type>_arch that
  # will build the merged architecture file for the device type.
  set(options "")
  set(oneValueArgs DEVICE_TYPE ARCH ARCH_XML)
  set(multiValueArgs SCRIPT_OUTPUT_NAME SCRIPTS SCRIPT_DEPS)
  cmake_parse_arguments(
    DEFINE_DEVICE_TYPE
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  #
  # Generate a arch.xml for a device.
  #
  set(DEVICE_MERGED_FILE arch.merged.xml)
  set(DEVICE_UNIQUE_PACK_FILE arch.unique_pack.xml)
  set(DEVICE_LINT_FILE arch.lint.html)

  set(MERGE_XML_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${DEVICE_MERGED_FILE})
  set(UNIQUE_PACK_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${DEVICE_UNIQUE_PACK_FILE})
  set(XMLLINT_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${DEVICE_LINT_FILE})

  xml_canonicalize_merge(
    NAME ${DEFINE_DEVICE_TYPE_ARCH}_${DEFINE_DEVICE_TYPE_DEVICE_TYPE}_arch_merged
    FILE ${DEFINE_DEVICE_TYPE_ARCH_XML}
    OUTPUT ${DEVICE_MERGED_FILE}
  )
  get_target_property_required(PYTHON3 env PYTHON3)

  append_file_dependency(SPECIALIZE_CARRYCHAINS_DEPS ${DEVICE_MERGED_FILE})

  set(SPECIALIZE_CARRYCHAINS ${symbiflow-arch-defs_SOURCE_DIR}/utils/specialize_carrychains.py)
  add_custom_command(
      OUTPUT ${UNIQUE_PACK_OUTPUT}
      COMMAND ${PYTHON3} ${SPECIALIZE_CARRYCHAINS}
      --input_arch_xml ${MERGE_XML_OUTPUT} > ${DEVICE_UNIQUE_PACK_FILE}
      DEPENDS
        ${PYTHON3}
        ${SPECIALIZE_CARRYCHAINS}
        ${SPECIALIZE_CARRYCHAINS_DEPS}
  )

  add_file_target(FILE ${DEVICE_UNIQUE_PACK_FILE} GENERATED)
  get_file_target(FINAL_TARGET ${DEVICE_UNIQUE_PACK_FILE})
  get_file_location(FINAL_FILE ${DEVICE_UNIQUE_PACK_FILE})
  set(FINAL_OUTPUT ${DEVICE_UNIQUE_PACK_FILE})

  # for each script generate next chain of deps
  if (DEFINE_DEVICE_TYPE_SCRIPTS)
    list(LENGTH DEFINE_DEVICE_TYPE_SCRIPT_OUTPUT_NAME SCRIPT_LEN)
    math(EXPR SCRIPT_LEN ${SCRIPT_LEN}-1)
    foreach(SCRIPT_IND RANGE ${SCRIPT_LEN})
      list(GET DEFINE_DEVICE_TYPE_SCRIPT_OUTPUT_NAME ${SCRIPT_IND} OUTPUT_NAME)
      list(GET DEFINE_DEVICE_TYPE_SCRIPT_DEPS ${SCRIPT_IND} DEFINE_DEVICE_TYPE_SCRIPT_DEP_VAR)
      list(GET DEFINE_DEVICE_TYPE_SCRIPTS ${SCRIPT_IND} SCRIPT)

      set(SCRIPT ${${SCRIPT}})
      set(DEFINE_DEVICE_TYPE_SCRIPT_DEP_VAR ${${DEFINE_DEVICE_TYPE_SCRIPT_DEP_VAR}})

      separate_arguments(CMD_W_ARGS UNIX_COMMAND ${SCRIPT})
      list(GET CMD_W_ARGS 0 CMD)
      set(TEMP_TARGET arch.${OUTPUT_NAME}.xml)
      set(DEFINE_DEVICE_DEPS ${PYTHON3} ${CMD} ${DEFINE_DEVICE_TYPE_SCRIPT_DEP_VAR})
      append_file_dependency(DEFINE_DEVICE_DEPS ${FINAL_OUTPUT})

      add_custom_command(
        OUTPUT ${TEMP_TARGET}
        COMMAND ${CMD_W_ARGS} < ${FINAL_FILE} > ${TEMP_TARGET}
        DEPENDS ${DEFINE_DEVICE_DEPS}
        )

      add_file_target(FILE ${TEMP_TARGET} GENERATED)
      get_file_target(FINAL_TARGET ${TEMP_TARGET})
      get_file_location(FINAL_FILE ${TEMP_TARGET})
      set(FINAL_OUTPUT ${TEMP_TARGET})
    endforeach(SCRIPT_IND RANGE ${SCRIPT_LEN})
  endif (DEFINE_DEVICE_TYPE_SCRIPTS)

  add_custom_target(
    ${DEFINE_DEVICE_TYPE_ARCH}_${DEFINE_DEVICE_TYPE_DEVICE_TYPE}_arch
    DEPENDS ${FINAL_TARGET}
  )
  add_dependencies(
    all_merged_arch_xmls
    ${DEFINE_DEVICE_TYPE_ARCH}_${DEFINE_DEVICE_TYPE_DEVICE_TYPE}_arch
  )

  set(ARCH_SCHEMA ${symbiflow-arch-defs_SOURCE_DIR}/common/xml/fpga_architecture.xsd)
  xml_lint(
    NAME ${DEFINE_DEVICE_TYPE_ARCH}_${DEFINE_DEVICE_TYPE_DEVICE_TYPE}_arch_lint
    FILE ${FINAL_FILE}
    LINT_OUTPUT ${XMLLINT_OUTPUT}
    SCHEMA ${ARCH_SCHEMA}
  )

  append_file_dependency(FINAL_DEPS ${FINAL_OUTPUT})

  add_custom_target(
    ${DEFINE_DEVICE_TYPE_DEVICE_TYPE}
    DEPENDS ${FINAL_DEPS}
    )

  foreach(ARG ARCH)
    if("${DEFINE_DEVICE_TYPE_${ARG}}" STREQUAL "")
      message(FATAL_ERROR "Required argument ${ARG} is the empty string.")
    endif()
    set_target_properties(
      ${DEFINE_DEVICE_TYPE_DEVICE_TYPE}
      PROPERTIES ${ARG} ${DEFINE_DEVICE_TYPE_${ARG}}
    )
  endforeach()

  set_target_properties(
    ${DEFINE_DEVICE_TYPE_DEVICE_TYPE}
    PROPERTIES
    DEVICE_MERGED_FILE ${CMAKE_CURRENT_SOURCE_DIR}/${FINAL_OUTPUT}
    )

endfunction()

function(DEFINE_DEVICE)
  # ~~~
  # DEFINE_DEVICE(
  #   DEVICE <device>
  #   ARCH <arch>
  #   PART <part>
  #   DEVICE_TYPE <device_type>
  #   PACKAGES <list of packages>
  #   [WIRE_EBLIF <a dummy design eblif file>
  #   [CACHE_PLACE_DELAY]
  #   [CACHE_LOOKAHEAD]
  #   [CACHE_ARGS <args>]
  #   )
  # ~~~
  #
  # Defines a device within a specified FPGA architecture.
  #
  # Creates dummy targets <arch>_<device>_<package>_rrxml_virt and
  # <arch>_<device>_<package>_rrxml_virt  that generates the the virtual and
  # real rr_graph for a specific device and package.
  #
  # The WIRE_EBLIF specifies a dummy design file to use. If not given then
  # the default "common/wire.eblif" is used.
  #
  # To prevent VPR from recomputing the place delay matrix and/or lookahead,
  # CACHE_PLACE_DELAY and CACHE_LOOKAHEAD options may be specified.
  #
  # If either are specified, CACHE_ARGS must be supplied with the relevant
  # VPR arguments needed to emit the correct place delay and lookahead outputs.
  # It is not required that the all arguments match the DEFINE_ARCH.VPR_ARCH_ARGS
  # as it may be advantagous to increase routing effort for the placement delay
  # matrix computation (e.g. lower astar_fac, etc).
  #
  # At a minimum, the --route_chan_width argument must be supplied.
  #
  # WARNING: Using a different place delay or lookahead algorithm will result
  # in an invalid cache.
  set(options CACHE_LOOKAHEAD CACHE_PLACE_DELAY)
  set(oneValueArgs DEVICE ARCH PART DEVICE_TYPE PACKAGES WIRE_EBLIF)
  set(multiValueArgs RR_PATCH_DEPS RR_PATCH_EXTRA_ARGS CACHE_ARGS)
  cmake_parse_arguments(
    DEFINE_DEVICE
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  add_custom_target(${DEFINE_DEVICE_DEVICE})
  foreach(ARG ARCH DEVICE_TYPE PACKAGES)
    if("${DEFINE_DEVICE_${ARG}}" STREQUAL "")
      message(FATAL_ERROR "Required argument ${ARG} is the empty string.")
    endif()
    set_target_properties(
      ${DEFINE_DEVICE_DEVICE}
      PROPERTIES ${ARG} ${DEFINE_DEVICE_${ARG}}
    )
  endforeach()

  if("${DEFINE_DEVICE_WIRE_EBLIF}" STREQUAL "")
    set(WIRE_EBLIF ${symbiflow-arch-defs_SOURCE_DIR}/common/wire.eblif)
  else()
    set(WIRE_EBLIF ${DEFINE_DEVICE_WIRE_EBLIF})
  endif()

  get_target_property_required(
    RR_PATCH_TOOL ${DEFINE_DEVICE_ARCH} RR_PATCH_TOOL
  )
  get_target_property_required(RR_PATCH_CMD ${DEFINE_DEVICE_ARCH} RR_PATCH_CMD)
  get_target_property_required(ROUTE_CHAN_WIDTH ${DEFINE_DEVICE_ARCH}
    ROUTE_CHAN_WIDTH)

  get_target_property_required(
    VIRT_DEVICE_MERGED_FILE ${DEFINE_DEVICE_DEVICE_TYPE} DEVICE_MERGED_FILE
  )
  get_file_target(DEVICE_MERGED_FILE_TARGET ${VIRT_DEVICE_MERGED_FILE})
  get_file_location(DEVICE_MERGED_FILE ${VIRT_DEVICE_MERGED_FILE})
  get_target_property_required(VPR env VPR)
  get_target_property_required(QUIET_CMD env QUIET_CMD)
  get_target_property_required(RR_GRAPH_EXT ${DEFINE_DEVICE_ARCH} RR_GRAPH_EXT)

  set(ROUTING_SCHEMA ${symbiflow-arch-defs_SOURCE_DIR}/common/xml/routing_resource.xsd)

  set(PART ${DEFINE_DEVICE_PART})
  set(DEVICE ${DEFINE_DEVICE_DEVICE})
  foreach(PACKAGE ${DEFINE_DEVICE_PACKAGES})
    get_target_property_required(DEVICE_FULL_TEMPLATE ${DEFINE_DEVICE_ARCH} DEVICE_FULL_TEMPLATE)
    string(CONFIGURE ${DEVICE_FULL_TEMPLATE} DEVICE_FULL)
    set(OUT_RRXML_VIRT_FILENAME
      rr_graph_${DEVICE}_${PACKAGE}.rr_graph.virt${RR_GRAPH_EXT})
    set(OUT_RRXML_REAL_FILENAME
      rr_graph_${DEVICE}_${PACKAGE}.rr_graph.real.patched${RR_GRAPH_EXT})
    set(OUT_RRBIN_REAL_FILENAME
      rr_graph_${DEVICE}_${PACKAGE}.rr_graph.real.bin)
    set(LOOKAHEAD_FILENAME
      rr_graph_${DEVICE}_${PACKAGE}.lookahead.bin)
    set(PLACE_DELAY_FILENAME
      rr_graph_${DEVICE}_${PACKAGE}.place_delay.bin)
    set(OUT_RRXML_REAL_LINT_FILENAME rr_graph_${DEVICE}_${PACKAGE}.rr_graph.real.lint.html)
    set(OUT_RRXML_VIRT ${CMAKE_CURRENT_BINARY_DIR}/${OUT_RRXML_VIRT_FILENAME})
    set(OUT_RRXML_REAL ${CMAKE_CURRENT_BINARY_DIR}/${OUT_RRXML_REAL_FILENAME})
    set(OUT_RRBIN_REAL ${CMAKE_CURRENT_BINARY_DIR}/${OUT_RRBIN_REAL_FILENAME})
    set(OUT_RRXML_REAL_LINT ${CMAKE_CURRENT_BINARY_DIR}/${OUT_RRXML_REAL_LINT_FILENAME})

    #
    # Generate a rr_graph for a device.
    #

    # Generate the "default" rr_graph.xml we are going to patch using wire.
    add_custom_command(
      OUTPUT ${OUT_RRXML_VIRT} rr_graph_${DEVICE}_${PACKAGE}.virt.out
      DEPENDS
        ${WIRE_EBLIF}
        ${DEVICE_MERGED_FILE} ${DEVICE_MERGED_FILE_TARGET}
        ${QUIET_CMD}
        ${VPR} ${DEFINE_DEVICE_DEVICE_TYPE}
      COMMAND
        ${QUIET_CMD} ${VPR} ${DEVICE_MERGED_FILE}
        --device ${DEVICE_FULL}
        ${WIRE_EBLIF}
        --place_algorithm bounding_box
        --enable_timing_computations off
        --route_chan_width 6
        --echo_file on
        --min_route_chan_width_hint 1
        --write_rr_graph ${OUT_RRXML_VIRT}
        --outfile_prefix ${DEVICE}_${PACKAGE}
        --pack
        --pack_verbosity 100
        --place
        --allow_dangling_combinational_nodes on
      COMMAND
        ${CMAKE_COMMAND} -E copy vpr_stdout.log
        rr_graph_${DEVICE}_${PACKAGE}.virt.out
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    )
    add_custom_target(
      ${DEFINE_DEVICE_ARCH}_${DEFINE_DEVICE_DEVICE}_${PACKAGE}_rrxml_virt
      DEPENDS ${OUT_RRXML_VIRT}
    )

    add_file_target(FILE ${OUT_RRXML_VIRT_FILENAME} GENERATED)

    set_target_properties(
      ${DEFINE_DEVICE_DEVICE}
      PROPERTIES
        OUT_RRXML_VIRT ${CMAKE_CURRENT_SOURCE_DIR}/${OUT_RRXML_VIRT_FILENAME}
    )

    set(RR_PATCH_DEPS ${DEFINE_DEVICE_RR_PATCH_DEPS})
    append_file_dependency(RR_PATCH_DEPS ${VIRT_DEVICE_MERGED_FILE})
    append_file_dependency(RR_PATCH_DEPS ${OUT_RRXML_VIRT_FILENAME})

    # Generate the "real" rr_graph.xml from the default rr_graph.xml file
    get_target_property_required(PYTHON3 env PYTHON3)
    string(CONFIGURE ${RR_PATCH_CMD} RR_PATCH_CMD_FOR_TARGET)
    separate_arguments(
      RR_PATCH_CMD_FOR_TARGET_LIST UNIX_COMMAND ${RR_PATCH_CMD_FOR_TARGET}
    )
    add_custom_command(
      OUTPUT ${OUT_RRXML_REAL}
      DEPENDS ${RR_PATCH_DEPS} ${RR_PATCH_TOOL}
      COMMAND ${RR_PATCH_CMD_FOR_TARGET_LIST} ${DEFINE_DEVICE_RR_PATCH_EXTRA_ARGS}
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      VERBATIM
    )

    add_file_target(FILE ${OUT_RRXML_REAL_FILENAME} GENERATED)

    set_target_properties(
      ${DEFINE_DEVICE_DEVICE}
      PROPERTIES
        ${PACKAGE}_OUT_RRXML_REAL
        ${CMAKE_CURRENT_SOURCE_DIR}/${OUT_RRXML_REAL_FILENAME}
    )

    add_custom_target(
      ${DEFINE_DEVICE_ARCH}_${DEFINE_DEVICE_DEVICE}_${PACKAGE}_rrxml_real
      DEPENDS ${OUT_RRXML_REAL}
      )
    add_dependencies(all_rrgraph_xmls ${DEFINE_DEVICE_ARCH}_${DEFINE_DEVICE_DEVICE}_${PACKAGE}_rrxml_real)

    # Lint the "real" rr_graph.xml
    if("${RR_GRAPH_EXT}" STREQUAL ".xml")
      xml_lint(
        NAME ${DEFINE_DEVICE_ARCH}_${DEFINE_DEVICE_DEVICE}_${PACKAGE}_rrxml_real_lint
        LINT_OUTPUT ${OUT_RRXML_REAL_LINT}
        FILE ${OUT_RRXML_REAL}
        SCHEMA ${ROUTING_SCHEMA}
        )
    endif()

    # Generate lookahead and place delay lookup caches
    set(DEPS)
    append_file_dependency(DEPS ${OUT_RRXML_REAL_FILENAME})
    append_file_dependency(DEPS ${VIRT_DEVICE_MERGED_FILE})

    set(OUTPUTS ${OUT_RRBIN_REAL_FILENAME})
    set(ARGS)
    if(${DEFINE_DEVICE_CACHE_LOOKAHEAD})
        list(APPEND OUTPUTS ${LOOKAHEAD_FILENAME})
        list(APPEND ARGS --write_router_lookahead ${LOOKAHEAD_FILENAME})
    endif()
    if(${DEFINE_DEVICE_CACHE_PLACE_DELAY})
        list(APPEND OUTPUTS ${PLACE_DELAY_FILENAME})
        list(APPEND ARGS --write_placement_delay_lookup ${PLACE_DELAY_FILENAME})
    endif()

    add_custom_command(
      OUTPUT ${OUT_RRXML_REAL}.cache ${OUTPUTS}
      DEPENDS
          ${WIRE_EBLIF}
          ${VPR}
          ${QUIET_CMD}
          ${DEFINE_DEVICE_DEVICE_TYPE}
          ${DEPS} ${PYTHON3}
      COMMAND
          ${PYTHON3} ${symbiflow-arch-defs_SOURCE_DIR}/utils/check_cache.py ${OUT_RRXML_REAL} ${OUT_RRXML_REAL}.cache ${OUTPUTS} || (
          ${QUIET_CMD} ${VPR} ${DEVICE_MERGED_FILE}
          --device ${DEVICE_FULL}
          ${WIRE_EBLIF}
          --read_rr_graph ${OUT_RRXML_REAL}
          --write_rr_graph ${OUT_RRBIN_REAL}
          --read_rr_edge_metadata on
          --outfile_prefix ${DEVICE}_${PACKAGE}_cache
          --pack
          --place
          ${ARGS}
          ${DEFINE_DEVICE_CACHE_ARGS} &&
          ${PYTHON3} ${symbiflow-arch-defs_SOURCE_DIR}/utils/update_cache.py ${OUT_RRXML_REAL} ${OUT_RRXML_REAL}.cache)
      COMMAND
          ${CMAKE_COMMAND} -E copy vpr_stdout.log
            rr_graph_${DEVICE}_${PACKAGE}.cache.out
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    )

    add_file_target(FILE ${OUT_RRBIN_REAL_FILENAME} GENERATED)
    get_file_target(RRBIN_REAL_TARGET ${OUT_RRBIN_REAL_FILENAME})

    set_target_properties(
      ${DEFINE_DEVICE_DEVICE}
      PROPERTIES
        ${PACKAGE}_OUT_RRBIN_REAL ${CMAKE_CURRENT_SOURCE_DIR}/${OUT_RRBIN_REAL_FILENAME}
    )

    if(${DEFINE_DEVICE_CACHE_LOOKAHEAD})
      add_file_target(FILE ${LOOKAHEAD_FILENAME} GENERATED)

      # Linearize target dependency.
      get_file_target(LOOKAHEAD_TARGET ${LOOKAHEAD_FILENAME})
      add_dependencies(${LOOKAHEAD_TARGET} ${RRBIN_REAL_TARGET})
    endif()

    if(${DEFINE_DEVICE_CACHE_PLACE_DELAY})
      add_file_target(FILE ${PLACE_DELAY_FILENAME} GENERATED)

      # Linearize target dependency.
      get_file_target(PLACE_DELAY_TARGET ${PLACE_DELAY_FILENAME})
      add_dependencies(${PLACE_DELAY_TARGET} ${RRBIN_REAL_TARGET})
    endif()

    if(${DEFINE_DEVICE_CACHE_LOOKAHEAD} OR ${DEFINE_DEVICE_CACHE_PLACE_DELAY})
      set_target_properties(
        ${DEFINE_DEVICE_DEVICE}
        PROPERTIES
          ${PACKAGE}_HAS_PLACE_DELAY_CACHE ${DEFINE_DEVICE_CACHE_PLACE_DELAY}
          ${PACKAGE}_HAS_LOOKAHEAD_CACHE ${DEFINE_DEVICE_CACHE_LOOKAHEAD}
          ${PACKAGE}_LOOKAHEAD_FILE ${CMAKE_CURRENT_SOURCE_DIR}/${LOOKAHEAD_FILENAME}
          ${PACKAGE}_PLACE_DELAY_FILE ${CMAKE_CURRENT_SOURCE_DIR}/${PLACE_DELAY_FILENAME}
      )
    else()
      set_target_properties(
        ${DEFINE_DEVICE_DEVICE}
        PROPERTIES
          ${PACKAGE}_HAS_PLACE_DELAY_CACHE FALSE
          ${PACKAGE}_HAS_LOOKAHEAD_CACHE FALSE
      )
    endif()

    # Define dummy boards.  PROG_TOOL is set to false to disallow programming.
    define_board(
      BOARD dummy_${DEFINE_DEVICE_ARCH}_${DEFINE_DEVICE_DEVICE}_${PACKAGE}
      DEVICE ${DEFINE_DEVICE_DEVICE}
      PACKAGE ${PACKAGE}
      PROG_TOOL false
      )

    install_device_files(
      PART ${PART}
      DEVICE ${DEFINE_DEVICE_DEVICE}
      DEVICE_TYPE ${DEFINE_DEVICE_DEVICE_TYPE}
      PACKAGE ${PACKAGE})
  endforeach()
endfunction()

function(DEFINE_BOARD)
  # ~~~
  # DEFINE_BOARD(
  #   BOARD <board>
  #   DEVICE <device>
  #   PACKAGE <package>
  #   PROG_TOOL <prog_tool>
  #   [PROG_CMD <command to use PROG_TOOL>
  #   )
  # ~~~
  #
  # Defines a target board for a project.  The listed device and package must
  # have been defined using DEFINE_DEVICE.
  #
  # PROG_TOOL should be an executable that will program a bitstream to the
  # specified board. PROG_CMD is an optional command string.  If PROG_CMD is not
  # provided, PROG_CMD will simply be ${PROG_TOOL}.
  #
  set(options)
  set(oneValueArgs BOARD DEVICE PACKAGE PROG_TOOL PROG_CMD)
  set(multiValueArgs)
  cmake_parse_arguments(
    DEFINE_BOARD
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  add_custom_target(${DEFINE_BOARD_BOARD})
  foreach(ARG DEVICE PACKAGE PROG_TOOL PROG_CMD)
    set_target_properties(
      ${DEFINE_BOARD_BOARD}
      PROPERTIES ${ARG} "${DEFINE_BOARD_${ARG}}"
    )
  endforeach()

  # Target for gathering all targets for a particular board.
  add_custom_target(all_${DEFINE_BOARD_BOARD}_route)
  add_custom_target(all_${DEFINE_BOARD_BOARD}_bin)
endfunction()

function(ADD_OUTPUT_TO_FPGA_TARGET name property file)
  add_file_target(FILE ${file} GENERATED)
  set_target_properties(${name} PROPERTIES ${property} ${file})
endfunction()

set(VPR_BASE_ARGS
    --max_router_iterations 500
    --routing_failure_predictor off
    --router_high_fanout_threshold -1
    --constant_net_method route
    CACHE STRING "Base VPR arguments")
set(VPR_EXTRA_ARGS "" CACHE STRING "Extra VPR arguments")
function(ADD_FPGA_TARGET_BOARDS)
  # ~~~
  # ADD_FPGA_TARGET_BOARDS(
  #   NAME <name>
  #   [TOP <top>]
  #   BOARDS <board list>
  #   SOURCES <source list>
  #   TESTBENCH_SOURCES <testbench source list>
  #   [IMPLICIT_INPUT_IO_FILES]
  #   [INPUT_IO_FILES <input_io_file list>]
  #   [EXPLICIT_ADD_FILE_TARGET]
  #   [EMIT_CHECK_TESTS EQUIV_CHECK_SCRIPT <yosys to script verify two bitstreams gold and gate>]
  #   )
  # ~~~
  # Version of ADD_FPGA_TARGET that emits targets for multiple boards.
  #
  # If INPUT_IO_FILES is supplied, BOARDS[i] will use INPUT_IO_FILES[i].
  #
  # If IMPLICIT_INPUT_IO_FILES is supplied, INPUT_IO_FILES[i] will be set to
  # "BOARDS[i].pcf".
  #
  # Targets will be named <name>_<board>.
  #
  set(options EXPLICIT_ADD_FILE_TARGET EMIT_CHECK_TESTS IMPLICIT_INPUT_IO_FILES)
  set(oneValueArgs NAME TOP  EQUIV_CHECK_SCRIPT)
  set(multiValueArgs SOURCES BOARDS INPUT_IO_FILE TESTBENCH_SOURCES)
  cmake_parse_arguments(
    ADD_FPGA_TARGET_BOARDS
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  set(INPUT_IO_FILES ${ADD_FPGA_TARGET_BOARDS_INPUT_IO_FILES})
  if(NOT "${INPUT_IO_FILES}" STREQUAL "" AND ${ADD_FPGA_TARGET_BOARDS_IMPLICIT_INPUT_IO_FILES})
    message(FATAL_ERROR "Cannot request implicit IO files and supply explicit IO file list")
  endif()

  set(BOARDS ${ADD_FPGA_TARGET_BOARDS_BOARDS})
  list(LENGTH BOARDS NUM_BOARDS)
  if(${ADD_FPGA_TARGET_BOARDS_IMPLICIT_INPUT_IO_FILES})
    foreach(BOARD ${BOARDS})
      list(APPEND INPUT_IO_FILES ${BOARD}.pcf)
    endforeach()
    set(HAVE_IO_FILES TRUE)
  else()
    list(LENGTH INPUT_IO_FILES NUM_INPUT_IO_FILES)
    if(${NUM_INPUT_IO_FILES} GREATER 0)
      set(HAVE_IO_FILES TRUE)
    else()
      set(HAVE_IO_FILES FALSE)
    endif()
    if(${HAVE_IO_FILES} AND NOT ${NUM_INPUT_IO_FILES} EQUAL ${NUM_BOARDS})
      message(FATAL_ERROR "Provide ${NUM_BOARDS} boards and ${NUM_INPUT_IO_FILES} io files, must be equal.")
    endif()
  endif()

  if(NOT ${ADD_FPGA_TARGET_BOARDS_EXPLICIT_ADD_FILE_TARGET})
    set(FILE_LIST  "")
    foreach(SRC ${ADD_FPGA_TARGET_BOARDS_SOURCES} ${ADD_FPGA_TARGET_BOARDS_TESTBENCH_SOURCES})
      add_file_target(FILE ${SRC} SCANNER_TYPE verilog)
    endforeach()
    foreach(SRC ${INPUT_IO_FILES})
      add_file_target(FILE ${SRC})
    endforeach()
  endif()

  set(OPT_ARGS "")
  foreach(OPT_STR_ARG TOP EQUIV_CHECK_SCRIPT)
    if("${ADD_FPGA_TARGET_BOARDS_${OPT_STR_ARG}}" STREQUAL "")
      list(APPEND OPT_ARGS ${OPT_STR_ARG} ${ADD_FPGA_TARGET_BOARDS_${OPT_STR_ARG}})
    endif()
  endforeach()
  foreach(OPT_OPTION_ARG EMIT_CHECK_TESTS)
    if(${ADD_FPGA_TARGET_BOARDS_${OPT_OPTION_ARG}})
      list(APPEND OPT_ARGS ${OPT_OPTION_ARG})
    endif()
  endforeach()
  list(LENGTH ADD_FPGA_TARGET_BOARDS_TESTBENCH_SOURCES NUM_TESTBENCH_SOURCES)
  if($NUM_TESTBENCH_SOURCES} GREATER 0)
    list(APPEND OPT_ARGS TESTBENCH_SOURCES ${ADD_FPGA_TARGET_BOARDS_TESTBENCH_SOURCES})
  endif()

  math(EXPR NUM_BOARDS_MINUS_1 ${NUM_BOARDS}-1)
  foreach(IDX RANGE ${NUM_BOARDS_MINUS_1})
    list(GET BOARDS ${IDX} BOARD)
    set(BOARD_OPT_ARGS ${OPT_ARGS})
    if(${HAVE_IO_FILES})
      list(GET INPUT_IO_FILES ${IDX} INPUT_IO_FILE)
      list(APPEND BOARD_OPT_ARGS INPUT_IO_FILE ${INPUT_IO_FILE})
    endif()
    add_fpga_target(
      NAME ${ADD_FPGA_TARGET_BOARDS_NAME}_${BOARD}
      BOARD ${BOARD}
      SOURCES ${ADD_FPGA_TARGET_BOARDS_SOURCES}
      EXPLICIT_ADD_FILE_TARGET
      ${BOARD_OPT_ARGS}
      )
  endforeach()
endfunction()

function(ADD_FPGA_TARGET)
  # ~~~
  # ADD_FPGA_TARGET(
  #   NAME <name>
  #   [TOP <top>]
  #   BOARD <board>
  #   SOURCES <source list>
  #   TESTBENCH_SOURCES <testbench source list>
  #   [INPUT_IO_FILE <input_io_file>]
  #   [EXPLICIT_ADD_FILE_TARGET]
  #   [EMIT_CHECK_TESTS EQUIV_CHECK_SCRIPT <yosys to script verify two bitstreams gold and gate>]
  #   [NO_SYNTHESIS]
  #   [ASSERT_USAGE <usage_spec>]
  #   [DEFINES <definitions>]
  #   [SDC_FILE <sdc file>]
  #   [BIT_TO_V_EXTRA_ARGS]
  #   )
  # ~~~
  #
  # ADD_FPGA_TARGET defines a FPGA build targetting a specific board.  By
  # default input files (SOURCES, TESTBENCH_SOURCES, INPUT_IO_FILE) will be
  # implicitly passed to ADD_FILE_TARGET.  If EXPLICIT_ADD_FILE_TARGET is
  # supplied, this behavior is supressed.
  #
  # TOP is the name of the top-level module in the design.  If no supplied,
  # TOP is set to "top".
  #
  # The SOURCES file list will be used to synthesize the FPGA images.
  # INPUT_IO_FILE is required to define an io map. TESTBENCH_SOURCES will be
  # used to run test benches.
  #
  # If NO_SYNTHESIS is supplied, <source list> must be 1 eblif file.
  #
  # DEFINES is a list of environment variables to be defined during Yosys
  # invocation.
  #
  # SDC_FILE can be supplied to provide a SDC constraints file to the flow.
  #
  # Targets generated:
  #
  # * <name>_eblif - Generated eblif file.
  # * <name>_route - Generate place and routing synthesized design.
  # * <name>_bit - Generate output bitstream.
  #
  # Outputs for this target will all be located in
  # ~~~
  # ${CMAKE_CURRENT_BINARY_DIR}/${NAME}/${ARCH}-${DEVICE_TYPE}-${DEVICE}-${PACKAGE}
  # ~~~
  #
  # Output files:
  #
  # * ${TOP}.eblif - Synthesized design (http://docs.verilogtorouting.org/en/latest/vpr/file_formats/#extended-blif-eblif)
  # * ${TOP}_io.place - IO placement.
  # * ${TOP}.route - Place and routed design (http://docs.verilogtorouting.org/en/latest/vpr/file_formats/#routing-file-format-route)
  # * ${TOP}.${BITSTREAM_EXTENSION} - Bitstream for target.
  #
  set(options EXPLICIT_ADD_FILE_TARGET EMIT_CHECK_TESTS NO_SYNTHESIS ROUTE_ONLY)
  set(oneValueArgs NAME TOP BOARD INPUT_IO_FILE EQUIV_CHECK_SCRIPT AUTOSIM_CYCLES ASSERT_USAGE SDC_FILE INPUT_XDC_FILE)
  set(multiValueArgs SOURCES TESTBENCH_SOURCES DEFINES BIT_TO_V_EXTRA_ARGS)
  cmake_parse_arguments(
    ADD_FPGA_TARGET
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )
 
  get_target_property_required(PYTHON3 env PYTHON3)

  set(TOP "top")
  if(NOT "${ADD_FPGA_TARGET_TOP}" STREQUAL "")
    set(TOP ${ADD_FPGA_TARGET_TOP})
  endif()

  set(BOARD ${ADD_FPGA_TARGET_BOARD})
  if("${BOARD}" STREQUAL "")
    message(FATAL_ERROR "BOARD is a required parameters.")
  endif()

  get_target_property_required(DEVICE ${BOARD} DEVICE)
  get_target_property_required(PACKAGE ${BOARD} PACKAGE)

  get_target_property_required(ARCH ${DEVICE} ARCH)
  get_target_property_required(DEVICE_TYPE ${DEVICE} DEVICE_TYPE)

  get_target_property_required(YOSYS env YOSYS)
  get_target_property_required(QUIET_CMD env QUIET_CMD)
  get_target_property_required(YOSYS_SYNTH_SCRIPT ${ARCH} YOSYS_SYNTH_SCRIPT)
  get_target_property_required(YOSYS_CONV_SCRIPT ${ARCH} YOSYS_CONV_SCRIPT)

  get_target_property_required(
    DEVICE_MERGED_FILE ${DEVICE_TYPE} DEVICE_MERGED_FILE
  )
  get_target_property_required(
    OUT_RRXML_REAL ${DEVICE} ${PACKAGE}_OUT_RRXML_REAL
  )
  get_target_property_required(
    OUT_RRBIN_REAL ${DEVICE} ${PACKAGE}_OUT_RRBIN_REAL
  )
  get_target_property_required(
    OUT_RRXML_VIRT ${DEVICE} OUT_RRXML_VIRT
  )

  if(NOT "${ADD_FPGA_TARGET_INPUT_XDC_FILE}" STREQUAL "")
      get_target_property_required(PART_JSON ${BOARD} PART_JSON)
  endif()

  set(NAME ${ADD_FPGA_TARGET_NAME})
  get_target_property_required(DEVICE_FULL_TEMPLATE ${ARCH} DEVICE_FULL_TEMPLATE)
  string(CONFIGURE ${DEVICE_FULL_TEMPLATE} DEVICE_FULL)
  set(FQDN ${ARCH}-${DEVICE_TYPE}-${DEVICE}-${PACKAGE})
  set(OUT_LOCAL_REL ${NAME}/${FQDN})
  set(OUT_LOCAL ${CMAKE_CURRENT_BINARY_DIR}/${OUT_LOCAL_REL})

  # Create target to handle all output paths of off
  add_custom_target(${NAME})
  set_target_properties(${NAME} PROPERTIES
      TOP ${TOP}
      BOARD ${BOARD}
      )
  set(VPR_ROUTE_CHAN_WIDTH 100)
  set(VPR_ROUTE_CHAN_MINWIDTH_HINT ${VPR_ROUTE_CHAN_WIDTH})

  if(${ADD_FPGA_TARGET_NO_SYNTHESIS})
    list(LENGTH ADD_FPGA_TARGET_SOURCES SRC_COUNT)
    if(NOT ${SRC_COUNT} EQUAL 1)
      message(FATAL_ERROR "In NO_SYNTHESIS, only one input source is allowed, given ${SRC_COUNT}.")
    endif()
    set(READ_FUNCTION "read_blif")
  else()
    set(READ_FUNCTION "read_verilog")
  endif()

  if(NOT ${ADD_FPGA_TARGET_EXPLICIT_ADD_FILE_TARGET})
    if(NOT ${ADD_FPGA_TARGET_NO_SYNTHESIS})
      foreach(SRC ${ADD_FPGA_TARGET_SOURCES})
        add_file_target(FILE ${SRC} SCANNER_TYPE verilog)
      endforeach()
    else()
      foreach(SRC ${ADD_FPGA_TARGET_SOURCES})
        add_file_target(FILE ${SRC})
      endforeach()
    endif()
    foreach(SRC ${ADD_FPGA_TARGET_TESTBENCH_SOURCES})
      add_file_target(FILE ${SRC} SCANNER_TYPE verilog)
    endforeach()

    if(NOT "${ADD_FPGA_TARGET_INPUT_IO_FILE}" STREQUAL "")
      add_file_target(FILE ${ADD_FPGA_TARGET_INPUT_IO_FILE})
    endif()
    if(NOT "${ADD_FPGA_TARGET_INPUT_XDC_FILE}" STREQUAL "")
      add_file_target(FILE ${ADD_FPGA_TARGET_INPUT_XDC_FILE})
    endif()
  endif()

  if(NOT "${ADD_FPGA_TARGET_INPUT_XDC_FILE}" STREQUAL "")
    get_file_location(INPUT_XDC_FILE ${ADD_FPGA_TARGET_INPUT_XDC_FILE})
    append_file_dependency(YOSYS_IO_DEPS ${ADD_FPGA_TARGET_INPUT_XDC_FILE})
  endif()

  #
  # Generate BLIF as start of vpr input.
  #
  set(OUT_EBLIF ${OUT_LOCAL}/${TOP}.eblif)
  set(OUT_EBLIF_REL ${OUT_LOCAL_REL}/${TOP}.eblif)
  set(OUT_SYNTH_V ${OUT_LOCAL}/${TOP}_synth.v)
  set(OUT_SYNTH_V_REL ${OUT_LOCAL_REL}/${TOP}_synth.v)
  set(OUT_FASM_EXTRA ${OUT_LOCAL}/${TOP}_fasm_extra.fasm)

  set(SOURCE_FILES_DEPS "")
  set(SOURCE_FILES "")
  foreach(SRC ${ADD_FPGA_TARGET_SOURCES})
    append_file_location(SOURCE_FILES ${SRC})
    append_file_dependency(SOURCE_FILES_DEPS ${SRC})
  endforeach()

  set(CELLS_SIM_DEPS "")
  get_cells_sim_path(PATH_TO_CELLS_SIM ${ARCH})
  foreach(CELL ${PATH_TO_CELLS_SIM})
    get_file_target(CELL_TARGET ${CELL})
    list(APPEND CELLS_SIM_DEPS ${CELL_TARGET})
  endforeach()

  set(YOSYS_IO_DEPS "")

  if(NOT ${ADD_FPGA_TARGET_INPUT_IO_FILE} STREQUAL "" OR NOT ${ADD_FPGA_TARGET_INPUT_XDC_FILE} STREQUAL "")
    get_target_property_required(PINMAP_FILE ${BOARD} PINMAP)
    get_file_location(PINMAP ${PINMAP_FILE})
    append_file_dependency(YOSYS_IO_DEPS ${PINMAP_FILE})
  endif()

  if(NOT ${ADD_FPGA_TARGET_INPUT_IO_FILE} STREQUAL "")
    get_file_location(INPUT_IO_FILE ${ADD_FPGA_TARGET_INPUT_IO_FILE})
    append_file_dependency(YOSYS_IO_DEPS ${ADD_FPGA_TARGET_INPUT_IO_FILE})
  endif()

  if(NOT ${ADD_FPGA_TARGET_NO_SYNTHESIS})
    set(COMPLETE_YOSYS_SYNTH_SCRIPT "tcl ${YOSYS_SYNTH_SCRIPT}")

    set(OUT_JSON_SYNTH ${OUT_LOCAL}/${TOP}_synth.json)
    set(OUT_JSON_SYNTH_REL ${OUT_LOCAL_REL}/${TOP}_synth.json)
    set(OUT_JSON ${OUT_LOCAL}/${TOP}.json)
    set(OUT_JSON_REL ${OUT_LOCAL_REL}/${TOP}.json)

    get_target_property(USE_ROI ${DEVICE_TYPE} USE_ROI)
    if("${USE_ROI}" STREQUAL "NOTFOUND")
        set(USE_ROI FALSE)
    endif()
    # TECHMAP is optional for ARCH. We don't care if this is NOTFOUND
    # as targets not defining it should not use TECHMAP_PATH ENV variable
    get_target_property(YOSYS_TECHMAP ${ARCH} YOSYS_TECHMAP)

    add_custom_command(
      OUTPUT ${OUT_JSON_SYNTH} ${OUT_SYNTH_V} ${OUT_FASM_EXTRA}
      DEPENDS ${SOURCE_FILES} ${SOURCE_FILES_DEPS} ${INPUT_XDC_FILE} ${CELLS_SIM_DEPS}
              ${YOSYS} ${QUIET_CMD} ${YOSYS_IO_DEPS}
              ${YOSYS_SYNTH_SCRIPT}
      COMMAND
        ${CMAKE_COMMAND} -E make_directory ${OUT_LOCAL}
      COMMAND
        ${CMAKE_COMMAND} -E env
          TECHMAP_PATH=${YOSYS_TECHMAP}
          symbiflow-arch-defs_SOURCE_DIR=${symbiflow-arch-defs_SOURCE_DIR}
          symbiflow-arch-defs_BINARY_DIR=${symbiflow-arch-defs_BINARY_DIR}
          OUT_JSON=${OUT_JSON_SYNTH}
          OUT_SYNTH_V=${OUT_SYNTH_V}
          OUT_FASM_EXTRA=${OUT_FASM_EXTRA}
          PART_JSON=${PART_JSON}
          INPUT_XDC_FILE=${INPUT_XDC_FILE}
          USE_ROI=${USE_ROI}
          PCF_FILE=${INPUT_IO_FILE}
          PINMAP_FILE=${PINMAP}
          ${ADD_FPGA_TARGET_DEFINES}
          ${QUIET_CMD} ${YOSYS} -p "${COMPLETE_YOSYS_SYNTH_SCRIPT}" -l ${OUT_JSON_SYNTH}.log ${SOURCE_FILES}
      COMMAND
        ${CMAKE_COMMAND} -E touch ${OUT_FASM_EXTRA}
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      VERBATIM
    )

    set(SPLIT_INOUTS ${symbiflow-arch-defs_SOURCE_DIR}/utils/split_inouts.py)

    add_custom_command(
      OUTPUT ${OUT_JSON}
      DEPENDS ${OUT_JSON_SYNTH} ${QUIET_CMD} ${SPLIT_INOUTS} ${PYTHON3}
      COMMAND
        ${PYTHON3} ${SPLIT_INOUTS} -i ${OUT_JSON_SYNTH} -o ${OUT_JSON}
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      VERBATIM
    )

    add_custom_command(
      OUTPUT ${OUT_EBLIF}
      DEPENDS ${OUT_JSON}
              ${YOSYS} ${QUIET_CMD}
              ${YOSYS_CONV_SCRIPT}
      COMMAND
        ${CMAKE_COMMAND} -E env
          symbiflow-arch-defs_SOURCE_DIR=${symbiflow-arch-defs_SOURCE_DIR}
          OUT_EBLIF=${OUT_EBLIF}
          ${ADD_FPGA_TARGET_DEFINES}
          ${QUIET_CMD} ${YOSYS} -p "read_json ${OUT_JSON}; tcl ${YOSYS_CONV_SCRIPT}" -l ${OUT_EBLIF}.log
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      VERBATIM
    )

    add_output_to_fpga_target(${NAME} EBLIF ${OUT_EBLIF_REL})
    add_output_to_fpga_target(${NAME} SYNTH_V ${OUT_SYNTH_V_REL})
    add_output_to_fpga_target(${NAME} JSON_SYNTH ${OUT_JSON_SYNTH_REL})
    add_output_to_fpga_target(${NAME} JSON ${OUT_JSON_REL})

  else()
    add_custom_command(
      OUTPUT ${OUT_EBLIF}
      DEPENDS ${SOURCE_FILES_DEPS}
      COMMAND
        ${CMAKE_COMMAND} -E make_directory ${OUT_LOCAL}
      COMMAND ${CMAKE_COMMAND} -E copy ${SOURCE_FILES} ${OUT_EBLIF}
      )
    add_output_to_fpga_target(${NAME} EBLIF ${OUT_EBLIF_REL})
  endif()

  add_custom_target(${NAME}_eblif DEPENDS ${OUT_EBLIF})

  # Generate routing and generate HLC.
  set(OUT_ROUTE ${OUT_LOCAL}/${TOP}.route)

  set(VPR_DEPS "")
  append_file_dependency(VPR_DEPS ${OUT_EBLIF_REL})
  list(APPEND VPR_DEPS ${DEFINE_DEVICE_DEVICE_TYPE})

  get_file_location(OUT_RRXML_VIRT_LOCATION ${OUT_RRXML_VIRT})
  get_file_location(OUT_RRXML_REAL_LOCATION ${OUT_RRXML_REAL})
  get_file_location(OUT_RRBIN_REAL_LOCATION ${OUT_RRBIN_REAL})
  get_file_location(DEVICE_MERGED_FILE_LOCATION ${DEVICE_MERGED_FILE})

  foreach(SRC ${DEVICE_MERGED_FILE} ${OUT_RRBIN_REAL})
    append_file_dependency(VPR_DEPS ${SRC})
  endforeach()

  get_target_property_required(VPR env VPR)

  get_target_property_required(ROUTE_CHAN_WIDTH ${ARCH} ROUTE_CHAN_WIDTH)

  get_target_property(VPR_ARCH_ARGS ${ARCH} VPR_ARCH_ARGS)
  if("${VPR_ARCH_ARGS}" STREQUAL "VPR_ARCH_ARGS-NOTFOUND")
    set(VPR_ARCH_ARGS "")
  endif()

  separate_arguments(
    VPR_BASE_ARGS_LIST UNIX_COMMAND "${VPR_BASE_ARGS}"
    )
  list(APPEND VPR_BASE_ARGS_LIST --route_chan_width ${ROUTE_CHAN_WIDTH})
  separate_arguments(
    VPR_EXTRA_ARGS_LIST UNIX_COMMAND "${VPR_EXTRA_ARGS}"
    )

  # Setting noisy warnings log file if needed.
  set(OUT_NOISY_WARNINGS ${OUT_LOCAL}/noisy_warnings.log)
  string(CONFIGURE ${VPR_ARCH_ARGS} VPR_ARCH_ARGS_EXPANDED)
  separate_arguments(
    VPR_ARCH_ARGS_LIST UNIX_COMMAND "${VPR_ARCH_ARGS_EXPANDED}"
    )

  if(NOT "${ADD_FPGA_TARGET_SDC_FILE}" STREQUAL "")
    append_file_dependency(VPR_DEPS ${ADD_FPGA_TARGET_SDC_FILE})
    get_file_location(SDC_LOCATION ${ADD_FPGA_TARGET_SDC_FILE})
    set(SDC_ARG --sdc_file ${SDC_LOCATION})
  else()
    set(SDC_ARG "")
  endif()

  set(
    VPR_CMD
    ${QUIET_CMD} ${VPR}
    ${DEVICE_MERGED_FILE_LOCATION}
    ${OUT_EBLIF}
    --device ${DEVICE_FULL}
    --read_rr_graph ${OUT_RRBIN_REAL_LOCATION}
    ${VPR_BASE_ARGS_LIST}
    ${VPR_ARCH_ARGS_LIST}
    ${VPR_EXTRA_ARGS_LIST}
    ${SDC_ARG}
  )

  get_target_property_required(
    USE_LOOKAHEAD_CACHE ${DEVICE} ${PACKAGE}_HAS_LOOKAHEAD_CACHE
  )
  if(${USE_LOOKAHEAD_CACHE})
    # If lookahead is cached, use the cache instead of recomputing lookaheads.
    get_target_property_required(
      LOOKAHEAD_FILE ${DEVICE} ${PACKAGE}_LOOKAHEAD_FILE
      )
    append_file_dependency(VPR_DEPS ${LOOKAHEAD_FILE})
    get_file_location(LOOKAHEAD_LOCATION ${LOOKAHEAD_FILE})
    list(APPEND VPR_CMD --read_router_lookahead ${LOOKAHEAD_LOCATION})
  endif()

  get_target_property_required(
    USE_PLACE_DELAY_CACHE ${DEVICE} ${PACKAGE}_HAS_PLACE_DELAY_CACHE
  )
  if(${USE_PLACE_DELAY_CACHE})
    get_target_property_required(
      PLACE_DELAY_FILE ${DEVICE} ${PACKAGE}_PLACE_DELAY_FILE
      )
    append_file_dependency(VPR_DEPS ${PLACE_DELAY_FILE})
    get_file_location(PLACE_DELAY_LOCATION ${PLACE_DELAY_FILE})
    list(APPEND VPR_CMD --read_placement_delay_lookup ${PLACE_DELAY_LOCATION})
  endif()

  list(APPEND VPR_DEPS ${VPR} ${QUIET_CMD})
  append_file_dependency(VPR_DEPS ${OUT_EBLIF_REL})

  # Generate packing.
  # -------------------------------------------------------------------------
  set(OUT_NET ${OUT_LOCAL}/${TOP}.net)
  set(OUT_NET_REL ${OUT_LOCAL_REL}/${TOP}.net)

  add_custom_command(
    OUTPUT ${OUT_NET} ${OUT_LOCAL}/pack.log
    DEPENDS ${VPR_DEPS}
    COMMAND ${VPR_CMD} --pack
    COMMAND
      ${CMAKE_COMMAND} -E copy ${OUT_LOCAL}/vpr_stdout.log ${OUT_LOCAL}/pack.log
    WORKING_DIRECTORY ${OUT_LOCAL}
  )

  add_output_to_fpga_target(${NAME} NET ${OUT_NET_REL})

  if(NOT "${ADD_FPGA_TARGET_ASSERT_USAGE}" STREQUAL "")
      set(USAGE_UTIL ${symbiflow-arch-defs_SOURCE_DIR}/utils/report_block_usage.py)
      add_custom_target(
          ${NAME}_assert_usage
          COMMAND ${PYTHON3} ${USAGE_UTIL}
            --assert_usage ${ADD_FPGA_TARGET_ASSERT_USAGE}
            ${OUT_LOCAL}/pack.log
          DEPENDS ${PYTHON3} ${USAGE_UTIL} ${OUT_LOCAL}/pack.log
          )
  endif()

  set(ECHO_OUT_NET ${OUT_LOCAL}/echo/${TOP}.net)
  add_custom_command(
    OUTPUT ${ECHO_OUT_NET}
    DEPENDS ${VPR_DEPS}
    COMMAND ${CMAKE_COMMAND} -E make_directory ${OUT_LOCAL}/echo
    COMMAND cd ${OUT_LOCAL}/echo && ${VPR_CMD} --pack_verbosity 3 --echo_file on --pack
    COMMAND
      ${CMAKE_COMMAND} -E copy ${OUT_LOCAL}/echo/vpr_stdout.log ${OUT_LOCAL}/echo/pack.log
    )

  # Generate placement constraints.
  # -------------------------------------------------------------------------
  set(FIX_PINS_ARG "")

  if(NOT ${ADD_FPGA_TARGET_INPUT_IO_FILE} STREQUAL "" OR NOT ${ADD_FPGA_TARGET_INPUT_XDC_FILE} STREQUAL "")
    get_target_property_required(NO_PINS ${ARCH} NO_PINS)
    if(${NO_PINS})
      message(FATAL_ERROR "Arch ${ARCH} does not currently support pin constraints.")
    endif()
    get_target_property_required(PLACE_TOOL ${ARCH} PLACE_TOOL)
    get_target_property_required(PLACE_TOOL_CMD ${ARCH} PLACE_TOOL_CMD)

    get_target_property_required(NO_PLACE_CONSTR ${ARCH} NO_PLACE_CONSTR)
    if(NOT ${NO_PLACE_CONSTR})
      get_target_property_required(PLACE_CONSTR_TOOL ${ARCH} PLACE_CONSTR_TOOL)
      get_target_property_required(PLACE_CONSTR_TOOL_CMD ${ARCH} PLACE_CONSTR_TOOL_CMD)
    endif()

    get_target_property_required(PYTHON3 env PYTHON3)


    # Add complete dependency chain
    set(IO_DEPS ${VPR_DEPS})
    if(NOT ${ADD_FPGA_TARGET_INPUT_IO_FILE} STREQUAL "")
      append_file_dependency(IO_DEPS ${ADD_FPGA_TARGET_INPUT_IO_FILE})
    endif()
    append_file_dependency(IO_DEPS ${PINMAP_FILE})
    append_file_dependency(IO_DEPS ${OUT_NET_REL})

    if(NOT ${ADD_FPGA_TARGET_INPUT_IO_FILE} STREQUAL "")
      set_target_properties(${NAME} PROPERTIES
          INPUT_IO_FILE ${ADD_FPGA_TARGET_INPUT_IO_FILE})
      set(PCF_INPUT_IO_FILE "--pcf ${INPUT_IO_FILE}")
    endif()

    # Set variables for the string(CONFIGURE) below.
    set(OUT_IO ${OUT_LOCAL}/${TOP}_io.place)
    set(OUT_IO_REL ${OUT_LOCAL_REL}/${TOP}_io.place)
    set(OUT_CONSTR ${OUT_LOCAL}/${TOP}_constraints.place)
    set(OUT_CONSTR_REL ${OUT_LOCAL_REL}/${TOP}_constraints.place)
    set(OUT_NET ${OUT_LOCAL}/${TOP}.net)

    # Generate IO constraints
    string(CONFIGURE ${PLACE_TOOL_CMD} PLACE_TOOL_CMD_FOR_TARGET)
    separate_arguments(
      PLACE_TOOL_CMD_FOR_TARGET_LIST UNIX_COMMAND ${PLACE_TOOL_CMD_FOR_TARGET}
    )

    add_custom_command(
      OUTPUT ${OUT_IO}
      DEPENDS ${IO_DEPS}
      COMMAND ${PLACE_TOOL_CMD_FOR_TARGET_LIST} --out ${OUT_IO}
      WORKING_DIRECTORY ${OUT_LOCAL}
    )

    add_output_to_fpga_target(${NAME} IO_PLACE ${OUT_IO_REL})
    append_file_dependency(VPR_DEPS ${OUT_IO_REL})

    set(CONSTR_DEPS "")
    if(NOT ${NO_PLACE_CONSTR})
      append_file_dependency(CONSTR_DEPS ${OUT_IO_REL})

      get_target_property(PLACE_CONSTR_TOOL_EXTRA_ARGS ${BOARD} PLACE_CONSTR_TOOL_EXTRA_ARGS)
      if ("${PLACE_CONSTR_TOOL_EXTRA_ARGS}" STREQUAL "PLACE_CONSTR_TOOL_EXTRA_ARGS-NOTFOUND")
        set(PLACE_CONSTR_TOOL_EXTRA_ARGS "")
      endif()

      # Generate LOC constrains
      string(CONFIGURE ${PLACE_CONSTR_TOOL_CMD} PLACE_CONSTR_TOOL_CMD_FOR_TARGET)
      separate_arguments(
        PLACE_CONSTR_TOOL_CMD_FOR_TARGET_LIST UNIX_COMMAND ${PLACE_CONSTR_TOOL_CMD_FOR_TARGET}
      )

      add_custom_command(
        OUTPUT ${OUT_CONSTR}
        DEPENDS ${CONSTR_DEPS}
        COMMAND
          ${PLACE_CONSTR_TOOL_CMD_FOR_TARGET_LIST} < ${OUT_IO} > ${OUT_CONSTR}
        WORKING_DIRECTORY ${OUT_LOCAL}
      )

      add_output_to_fpga_target(${NAME} IO_PLACE ${OUT_CONSTR_REL})
      append_file_dependency(VPR_DEPS ${OUT_CONSTR_REL})

      set(FIX_PINS_ARG --fix_pins ${OUT_CONSTR})
    else()
      set(FIX_PINS_ARG --fix_pins ${OUT_IO})
    endif()

  endif()

  # Generate placement.
  # -------------------------------------------------------------------------
  set(OUT_PLACE ${OUT_LOCAL}/${TOP}.place)
  add_custom_command(
    OUTPUT ${OUT_PLACE}
    DEPENDS ${OUT_NET} ${VPR_DEPS}
    COMMAND ${VPR_CMD} ${FIX_PINS_ARG} --place
    COMMAND
      ${CMAKE_COMMAND} -E copy ${OUT_LOCAL}/vpr_stdout.log
      ${OUT_LOCAL}/place.log
    WORKING_DIRECTORY ${OUT_LOCAL}
  )

  set(ECHO_OUT_PLACE ${OUT_LOCAL}/echo/${TOP}.place)
  add_custom_command(
    OUTPUT ${ECHO_OUT_PLACE}
    DEPENDS ${ECHO_OUT_NET} ${VPR_DEPS}
    COMMAND ${VPR_CMD} ${FIX_PINS_ARG} --echo_file on --place
    COMMAND
      ${CMAKE_COMMAND} -E copy ${OUT_LOCAL}/echo/vpr_stdout.log
        ${OUT_LOCAL}/echo/place.log
    WORKING_DIRECTORY ${OUT_LOCAL}/echo
  )

  # Generate routing.
  # -------------------------------------------------------------------------
  add_custom_command(
    OUTPUT ${OUT_ROUTE}
    DEPENDS ${OUT_PLACE} ${VPR_DEPS}
    COMMAND ${VPR_CMD} --route
    COMMAND
      ${CMAKE_COMMAND} -E copy ${OUT_LOCAL}/vpr_stdout.log
        ${OUT_LOCAL}/route.log
    WORKING_DIRECTORY ${OUT_LOCAL}
  )
  add_custom_target(${NAME}_route DEPENDS ${OUT_ROUTE})
  add_dependencies(all_${BOARD}_route ${NAME}_route)

  set(ECHO_ATOM_NETLIST_ORIG ${OUT_LOCAL}/echo/atom_netlist.orig.echo.blif)
  set(ECHO_ATOM_NETLIST_CLEANED ${OUT_LOCAL}/echo/atom_netlist.cleaned.echo.blif)
  add_custom_command(
    OUTPUT ${ECHO_ATOM_NETLIST_ORIG} ${ECHO_ATOM_NETLIST_CLEANED}
    DEPENDS ${ECHO_OUT_PLACE} ${VPR_DEPS} ${ECHO_DIRECTORY_TARGET}
    COMMAND ${VPR_CMD} --echo_file on --route
    COMMAND
      ${CMAKE_COMMAND} -E copy ${OUT_LOCAL}/echo/vpr_stdout.log
        ${OUT_LOCAL}/echo/route.log
    WORKING_DIRECTORY ${OUT_LOCAL}/echo
  )
  add_custom_target(${NAME}_route_echo DEPENDS ${ECHO_ATOM_NETLIST_ORIG})

  if(${ADD_FPGA_TARGET_ROUTE_ONLY})
    return()
  endif()

  get_target_property_required(USE_FASM ${ARCH} USE_FASM)

  if(${USE_FASM})
    get_target_property_required(GENFASM env GENFASM)
    set(
      GENFASM_CMD
      ${QUIET_CMD} ${GENFASM}
      ${DEVICE_MERGED_FILE_LOCATION}
      ${OUT_EBLIF}
      --device ${DEVICE_FULL}
      --read_rr_graph ${OUT_RRBIN_REAL_LOCATION}
      ${VPR_BASE_ARGS_LIST}
      ${VPR_ARCH_ARGS_LIST}
      ${VPR_EXTRA_ARGS_LIST}
    )
  else()
    get_target_property_required(GENHLC env GENHLC)
    set(
      GENHLC_CMD
      ${QUIET_CMD} ${GENHLC}
      ${DEVICE_MERGED_FILE_LOCATION}
      ${OUT_EBLIF}
      --device ${DEVICE_FULL}
      --read_rr_graph ${OUT_RRBIN_REAL_LOCATION}
      ${VPR_BASE_ARGS_LIST}
      ${VPR_ARCH_ARGS_LIST}
      ${VPR_EXTRA_ARGS_LIST}
    )
  endif()

  if(${USE_FASM})
    # Generate FASM
    # -------------------------------------------------------------------------
    set(OUT_FASM ${OUT_LOCAL}/${TOP}.fasm)
    set(OUT_FASM_CONCATENATED ${OUT_LOCAL}/${TOP}.concat.fasm)
    set(OUT_FASM_GENFASM ${OUT_LOCAL}/${TOP}.genfasm.fasm)
    add_custom_command(
      OUTPUT ${OUT_FASM}
      DEPENDS ${OUT_ROUTE} ${OUT_PLACE} ${VPR_DEPS}
      COMMAND ${GENFASM_CMD}
      COMMAND
        ${CMAKE_COMMAND} -E copy ${OUT_LOCAL}/vpr_stdout.log
          ${OUT_LOCAL}/genhlc.log
      COMMAND
        ${CMAKE_COMMAND} -E copy ${OUT_FASM} ${OUT_FASM_GENFASM}
      COMMAND cat ${OUT_FASM} ${OUT_FASM_EXTRA} > ${OUT_FASM_CONCATENATED}
      COMMAND
        ${CMAKE_COMMAND} -E rename ${OUT_FASM_CONCATENATED} ${OUT_FASM}
      WORKING_DIRECTORY ${OUT_LOCAL}
    )
    add_custom_target(${NAME}_fasm DEPENDS ${OUT_FASM})

    set_target_properties(${NAME} PROPERTIES OUT_FASM ${OUT_FASM})
  else()
    # Generate HLC
    # -------------------------------------------------------------------------
    set(OUT_HLC ${OUT_LOCAL}/${TOP}.hlc)
    add_custom_command(
      OUTPUT ${OUT_HLC}
      DEPENDS ${OUT_ROUTE} ${OUT_PLACE} ${VPR_DEPS}
      COMMAND ${GENHLC_CMD}
      COMMAND
        ${CMAKE_COMMAND} -E copy ${OUT_LOCAL}/vpr_stdout.log
          ${OUT_LOCAL}/genhlc.log
      WORKING_DIRECTORY ${OUT_LOCAL}
    )
    add_custom_target(${NAME}_hlc DEPENDS ${OUT_HLC})
  endif()

  # Generate analysis.
  #-------------------------------------------------------------------------
  set(OUT_ANALYSIS ${OUT_LOCAL}/analysis.log)
  set(OUT_POST_SYNTHESIS_V ${OUT_LOCAL}/top_post_synthesis.v)
  set(OUT_POST_SYNTHESIS_BLIF ${OUT_LOCAL}/top_post_synthesis.blif)
  add_custom_command(
    OUTPUT ${OUT_ANALYSIS} ${OUT_POST_SYNTHESIS_V} ${OUT_POST_SYNTHESIS_BLIF}
    DEPENDS ${OUT_ROUTE} ${VPR_DEPS}
    COMMAND ${VPR_CMD} --analysis --gen_post_synthesis_netlist on
    COMMAND ${CMAKE_COMMAND} -E copy ${OUT_LOCAL}/vpr_stdout.log
        ${OUT_LOCAL}/analysis.log
    WORKING_DIRECTORY ${OUT_LOCAL}
    )
  add_custom_target(${NAME}_analysis DEPENDS ${OUT_ANALYSIS})

  get_target_property_required(NO_BITSTREAM ${ARCH} NO_BITSTREAM)
  if(NOT ${NO_BITSTREAM})
    # Generate bitstream
    # -------------------------------------------------------------------------
    get_target_property_required(BITSTREAM_EXTENSION ${ARCH} BITSTREAM_EXTENSION)
    set(OUT_BITSTREAM ${OUT_LOCAL}/${TOP}.${BITSTREAM_EXTENSION})

    if(${USE_FASM})
      get_target_property_required(FASM_TO_BIT ${ARCH} FASM_TO_BIT)
      get_target_property_required(FASM_TO_BIT_CMD ${ARCH} FASM_TO_BIT_CMD)
      get_target_property(FASM_TO_BIT_DEPS ${ARCH} FASM_TO_BIT_DEPS)
      if ("${FASM_TO_BIT_DEPS}" STREQUAL "FASM_TO_BIT_DEPS-NOTFOUND")
        set(FASM_TO_BIT_DEPS "")
      endif()
      get_target_property(FASM_TO_BIT_EXTRA_ARGS ${BOARD} FASM_TO_BIT_EXTRA_ARGS)
      if ("${FASM_TO_BIT_EXTRA_ARGS}" STREQUAL "FASM_TO_BIT_EXTRA_ARGS-NOTFOUND")
        set(FASM_TO_BIT_EXTRA_ARGS "")
      endif()

      get_target_property_required(PYTHON3 env PYTHON3)

      set(BITSTREAM_DEPS ${OUT_FASM} ${FASM_TO_BIT} ${FASM_TO_BIT_DEPS})

      string(CONFIGURE ${FASM_TO_BIT_CMD} FASM_TO_BIT_CMD_FOR_TARGET)
      separate_arguments(
        FASM_TO_BIT_CMD_FOR_TARGET_LIST UNIX_COMMAND ${FASM_TO_BIT_CMD_FOR_TARGET}
      )

      separate_arguments(
        FASM_TO_BIT_EXTRA_ARGS_LIST UNIX_COMMAND ${FASM_TO_BIT_EXTRA_ARGS}
      )
      set(FASM_TO_BIT_CMD_FOR_TARGET_LIST ${FASM_TO_BIT_CMD_FOR_TARGET_LIST} ${FASM_TO_BIT_EXTRA_ARGS_LIST})

      add_custom_command(
        OUTPUT ${OUT_BITSTREAM}
        DEPENDS ${BITSTREAM_DEPS}
        COMMAND ${FASM_TO_BIT_CMD_FOR_TARGET_LIST}
      )
    else()
      get_target_property_required(HLC_TO_BIT ${ARCH} HLC_TO_BIT)
      get_target_property_required(HLC_TO_BIT_CMD ${ARCH} HLC_TO_BIT_CMD)
      string(CONFIGURE ${HLC_TO_BIT_CMD} HLC_TO_BIT_CMD_FOR_TARGET)
      separate_arguments(
        HLC_TO_BIT_CMD_FOR_TARGET_LIST UNIX_COMMAND ${HLC_TO_BIT_CMD_FOR_TARGET}
      )
      add_custom_command(
        OUTPUT ${OUT_BITSTREAM}
        DEPENDS ${OUT_HLC} ${HLC_TO_BIT}
        COMMAND ${HLC_TO_BIT_CMD_FOR_TARGET_LIST}
      )
    endif()

    add_custom_target(${NAME}_bit DEPENDS ${OUT_BITSTREAM})
    add_output_to_fpga_target(${NAME} BIT ${OUT_LOCAL_REL}/${TOP}.${BITSTREAM_EXTENSION})

    get_target_property_required(NO_BIT_TO_BIN ${ARCH} NO_BIT_TO_BIN)
    set(OUT_BIN ${OUT_BITSTREAM})
    if(NOT ${NO_BIT_TO_BIN})
      get_target_property_required(BIN_EXTENSION ${ARCH} BIN_EXTENSION)
      set(OUT_BIN ${OUT_LOCAL}/${TOP}.${BIN_EXTENSION})
      get_target_property_required(BIT_TO_BIN ${ARCH} BIT_TO_BIN)
      get_target_property_required(BIT_TO_BIN_CMD ${ARCH} BIT_TO_BIN_CMD)
      get_target_property(BIT_TO_BIN_EXTRA_ARGS ${BOARD} BIT_TO_BIN_EXTRA_ARGS)
      if (${BIT_TO_BIN_EXTRA_ARGS} STREQUAL NOTFOUND)
        set(BIT_TO_BIN_EXTRA_ARGS "")
      endif()
      string(CONFIGURE ${BIT_TO_BIN_CMD} BIT_TO_BIN_CMD_FOR_TARGET)
      separate_arguments(
        BIT_TO_BIN_CMD_FOR_TARGET_LIST UNIX_COMMAND ${BIT_TO_BIN_CMD_FOR_TARGET}
      )
      add_custom_command(
        OUTPUT ${OUT_BIN}
        COMMAND ${BIT_TO_BIN_CMD_FOR_TARGET_LIST}
        DEPENDS ${BIT_TO_BIN} ${OUT_BITSTREAM}
        )

      add_custom_target(${NAME}_bin DEPENDS ${OUT_BIN})
      add_output_to_fpga_target(${NAME} BIN ${OUT_LOCAL_REL}/${TOP}.${BIN_EXTENSION})
      add_dependencies(all_${BOARD}_bin ${NAME}_bin)
    else()
      add_dependencies(all_${BOARD}_bin ${NAME}_bit)
    endif()

    get_target_property(PROG_TOOL ${BOARD} PROG_TOOL)
    get_target_property(PROG_CMD ${BOARD} PROG_CMD)

    if("${PROG_CMD}" STREQUAL "${BOARD}-NOTFOUND" OR "${PROG_CMD}" STREQUAL "")
        set(PROG_CMD_LIST ${PROG_TOOL} ${OUT_BIN})
    else()
        string(CONFIGURE ${PROG_CMD} PROG_CMD_FOR_TARGET)
        separate_arguments(
            PROG_CMD_LIST UNIX_COMMAND ${PROG_CMD_FOR_TARGET}
        )
    endif()

    add_custom_target(
      ${NAME}_prog
      COMMAND ${PROG_CMD_LIST}
      DEPENDS ${OUT_BIN} ${PROG_TOOL}
      )

    get_target_property_required(NO_BIT_TO_V ${ARCH} NO_BIT_TO_V)
    if(NOT ${NO_BIT_TO_V})
        # Generate verilog from bitstream
        # -------------------------------------------------------------------------

        set(OUT_BIT_VERILOG ${OUT_LOCAL}/${TOP}_bit.v)
        get_target_property_required(BIT_TO_V ${ARCH} BIT_TO_V)
        get_target_property_required(BIT_TO_V_CMD ${ARCH} BIT_TO_V_CMD)
        if(NOT ${ADD_FPGA_TARGET_INPUT_IO_FILE} STREQUAL "")
            set(PCF_INPUT_IO_FILE "--pcf ${INPUT_IO_FILE}")
        endif()
        string(CONFIGURE ${BIT_TO_V_CMD} BIT_TO_V_CMD_FOR_TARGET)
        separate_arguments(
          BIT_TO_V_CMD_FOR_TARGET_LIST UNIX_COMMAND ${BIT_TO_V_CMD_FOR_TARGET}
        )

        get_target_property(BIT_TO_V_EXTRA_ARGS ${BOARD} BIT_TO_V_EXTRA_ARGS)
        if (${BIT_TO_V_EXTRA_ARGS} STREQUAL BIT_TO_V_EXTRA_ARGS-NOTFOUND OR
            ${BIT_TO_V_EXTRA_ARGS} STREQUAL NOTFOUND)
          set(BIT_TO_V_EXTRA_ARGS "")
        endif()

        separate_arguments(
          BIT_TO_V_EXTRA_ARGS_LIST UNIX_COMMAND ${BIT_TO_V_EXTRA_ARGS}
        )
        set(BIT_TO_V_CMD_FOR_TARGET_LIST ${BIT_TO_V_CMD_FOR_TARGET_LIST} ${BIT_TO_V_EXTRA_ARGS_LIST})

        separate_arguments(
          BIT_TO_V_EXTRA_ARGS_LIST UNIX_COMMAND ${ADD_FPGA_TARGET_BIT_TO_V_EXTRA_ARGS}
        )
        set(BIT_TO_V_CMD_FOR_TARGET_LIST ${BIT_TO_V_CMD_FOR_TARGET_LIST} ${BIT_TO_V_EXTRA_ARGS_LIST})

        add_custom_command(
        OUTPUT ${OUT_BIT_VERILOG}
        COMMAND ${BIT_TO_V_CMD_FOR_TARGET_LIST}
        DEPENDS ${BIT_TO_V} ${OUT_BITSTREAM} ${OUT_BIN}
        )

        add_output_to_fpga_target(${NAME} BIT_V ${OUT_LOCAL_REL}/${TOP}_bit.v)
        get_file_target(BIT_V_TARGET ${OUT_LOCAL_REL}/${TOP}_bit.v)
        add_custom_target(${NAME}_bit_v DEPENDS ${BIT_V_TARGET})

        set(AUTOSIM_CYCLES ${ADD_FPGA_TARGET_AUTOSIM_CYCLES})
        if("${AUTOSIM_CYCLES}" STREQUAL "")
        set(AUTOSIM_CYCLES 100)
        endif()

        add_autosim(
        NAME ${NAME}_autosim_bit
        TOP ${TOP}
        ARCH ${ARCH}
        SOURCES ${OUT_LOCAL_REL}/${TOP}_bit.v
        CYCLES ${AUTOSIM_CYCLES}
        )
    endif()

    get_target_property_required(NO_BIT_TIME ${ARCH} NO_BIT_TIME)
    if(NOT ${NO_BIT_TIME})
        set(OUT_TIME_VERILOG ${OUT_LOCAL}/${TOP}_time.v)
        get_target_property_required(BIT_TIME ${ARCH} BIT_TIME)
        get_target_property_required(BIT_TIME_CMD ${ARCH} BIT_TIME_CMD)
        string(CONFIGURE ${BIT_TIME_CMD} BIT_TIME_CMD_FOR_TARGET)
        separate_arguments(
        BIT_TIME_CMD_FOR_TARGET_LIST UNIX_COMMAND ${BIT_TIME_CMD_FOR_TARGET}
        )
        add_custom_command(
        OUTPUT ${OUT_TIME_VERILOG}
        COMMAND ${BIT_TIME_CMD_FOR_TARGET_LIST}
        DEPENDS ${OUT_BITSTREAM} ${BIT_TIME}
        )

        add_custom_target(
        ${NAME}_time
        DEPENDS ${OUT_TIME_VERILOG}
        )
    endif()
  endif()

  # Add test bench targets
  # -------------------------------------------------------------------------
  foreach(TESTBENCH ${ADD_FPGA_TARGET_TESTBENCH_SOURCES})
    get_filename_component(TESTBENCH_NAME ${TESTBENCH} NAME_WE)
    add_testbench(
      NAME testbench_${TESTBENCH_NAME}
      ARCH ${ARCH}
      SOURCES ${ADD_FPGA_TARGET_SOURCES} ${TESTBENCH}
      )

    add_testbench(
      NAME testbench_synth_${TESTBENCH_NAME}
      ARCH ${ARCH}
      SOURCES ${OUT_LOCAL_REL}/${TOP}_synth.v ${TESTBENCH}
      )

    if(NOT ${NO_BIT_TO_V})
      add_testbench(
        NAME testbinch_${TESTBENCH_NAME}
        ARCH ${ARCH}
        SOURCES ${OUT_LOCAL_REL}/${TOP}_bit.v ${TESTBENCH}
        )
    endif()
  endforeach()

  if(${ADD_FPGA_TARGET_EMIT_CHECK_TESTS})
    if("${ADD_FPGA_TARGET_EQUIV_CHECK_SCRIPT}" STREQUAL "")
      message(FATAL_ERROR "EQUIV_CHECK_SCRIPT is required if EMIT_CHECK_TESTS is set.")
    endif()

    set(READ_GOLD "")

    foreach(FILE ${SOURCE_FILES})
        set(READ_GOLD "${READ_GOLD}${READ_FUNCTION} ${FILE} $<SEMICOLON> ")
    endforeach()

    if(NOT ${NO_BIT_TO_V})
      add_check_test(
        NAME ${NAME}_check
        ARCH ${ARCH}
        READ_GOLD "${READ_GOLD} rename ${TOP} gold"
        READ_GATE "read_verilog ${OUT_BIT_VERILOG} $<SEMICOLON> rename ${TOP} gate"
        EQUIV_CHECK_SCRIPT ${ADD_FPGA_TARGET_EQUIV_CHECK_SCRIPT}
        DEPENDS ${SOURCE_FILES} ${SOURCE_FILES_DEPS} ${BIT_V_TARGET} ${OUT_BIT_VERILOG}
        )
      # Add bit-to-v check tests to all_check_tests.
      add_dependencies(all_check_tests ${NAME}_check_eblif)
    endif()

    add_check_test(
      NAME ${NAME}_check_eblif
      ARCH ${ARCH}
      READ_GOLD "${READ_FUNCTION} ${SOURCE_FILES} $<SEMICOLON> rename ${TOP} gold"
      READ_GATE "read_blif -wideports ${OUT_EBLIF} $<SEMICOLON> rename ${TOP} gate"
      EQUIV_CHECK_SCRIPT ${ADD_FPGA_TARGET_EQUIV_CHECK_SCRIPT}
      DEPENDS ${SOURCE_FILES} ${SOURCE_FILES_DEPS} ${OUT_EBLIF}
      )

    # Add post-synthesis check tests to all_check_tests.
    add_dependencies(all_check_tests ${NAME}_check_eblif)

    add_check_test(
      NAME ${NAME}_check_post_blif
      ARCH ${ARCH}
      READ_GOLD "${READ_FUNCTION} ${SOURCE_FILES} $<SEMICOLON> rename ${TOP} gold"
      READ_GATE "read_blif -wideports ${OUT_POST_SYNTHESIS_BLIF} $<SEMICOLON> rename ${TOP} gate"
      EQUIV_CHECK_SCRIPT ${ADD_FPGA_TARGET_EQUIV_CHECK_SCRIPT}
      DEPENDS ${SOURCE_FILES} ${SOURCE_FILES_DEPS} ${OUT_POST_SYNTHESIS_BLIF}
      )

    add_dependencies(all_check_tests ${NAME}_check_post_blif)

    add_check_test(
      NAME ${NAME}_check_post_v
      ARCH ${ARCH}
      READ_GOLD "${READ_FUNCTION} ${SOURCE_FILES} $<SEMICOLON> rename ${TOP} gold"
      READ_GATE "read_verilog ${OUT_POST_SYNTHESIS_V} $<SEMICOLON> rename ${TOP} gate"
      EQUIV_CHECK_SCRIPT ${ADD_FPGA_TARGET_EQUIV_CHECK_SCRIPT}
      DEPENDS ${SOURCE_FILES} ${SOURCE_FILES_DEPS} ${OUT_POST_SYNTHESIS_V}
      )

    add_check_test(
      NAME ${NAME}_check_orig_blif
      ARCH ${ARCH}
      READ_GOLD "${READ_FUNCTION} ${SOURCE_FILES} $<SEMICOLON> rename ${TOP} gold"
      READ_GATE "read_blif -wideports ${ECHO_ATOM_NETLIST_ORIG} $<SEMICOLON> rename ${TOP} gate"
      EQUIV_CHECK_SCRIPT ${ADD_FPGA_TARGET_EQUIV_CHECK_SCRIPT}
      DEPENDS ${SOURCE_FILES} ${SOURCE_FILES_DEPS} ${ECHO_ATOM_NETLIST_ORIG}
      )

    add_check_test(
      NAME ${NAME}_check_cleaned_blif
      ARCH ${ARCH}
      READ_GOLD "${READ_FUNCTION} ${SOURCE_FILES} $<SEMICOLON> rename ${TOP} gold"
      READ_GATE "read_blif -wideports ${ECHO_ATOM_NETLIST_CLEANED} $<SEMICOLON> rename ${TOP} gate"
      EQUIV_CHECK_SCRIPT ${ADD_FPGA_TARGET_EQUIV_CHECK_SCRIPT}
      DEPENDS ${SOURCE_FILES} ${SOURCE_FILES_DEPS} ${ECHO_ATOM_NETLIST_CLEANED}
      )
  endif()
endfunction()

function(get_cells_sim_path var arch)
  # If CELLS_SIM is defined for ${arch}, sets var to the path to CELLS_SIM,
  # otherwise sets var to "".
  get_target_property(CELLS_SIM ${arch} CELLS_SIM)
  set(${var} ${CELLS_SIM} PARENT_SCOPE)
endfunction()

function(add_check_test)
  # ~~~
  # ADD_CHECK_TEST(
  #    NAME <name>
  #    ARCH <arch>
  #    READ_GOLD <yosys script>
  #    READ_GATE <yosys script>
  #    EQUIV_CHECK_SCRIPT <yosys to script verify two bitstreams gold and gate>
  #    DEPENDS <files and targets>
  #   )
  # ~~~
  #
  # ADD_CHECK_TEST defines a cmake test to compare analytically two modules.
  # READ_GOLD should be a yosys script that puts the truth module in a module
  # named gold. READ_GATE should be a yosys script that puts the gate module
  # in a module named gate.
  #
  # DEPENDS should the be complete list of dependencies to add to the check
  # target.
  set(options)
  set(oneValueArgs NAME ARCH READ_GOLD READ_GATE EQUIV_CHECK_SCRIPT)
  set(multiValueArgs DEPENDS)
  cmake_parse_arguments(
    ADD_CHECK_TEST
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  get_target_property_required(YOSYS env YOSYS)
  get_target_property_required(QUIET_CMD env QUIET_CMD)
  set(EQUIV_CHECK_SCRIPT ${ADD_CHECK_TEST_EQUIV_CHECK_SCRIPT})
  if("${EQUIV_CHECK_SCRIPT}" STREQUAL "")
    message(FATAL_ERROR "EQUIV_CHECK_SCRIPT is not optional to add_check_test.")
  endif()

  get_file_location(EQUIV_CHECK_SCRIPT_LOCATION ${EQUIV_CHECK_SCRIPT})
  get_file_target(EQUIV_CHECK_SCRIPT_TARGET ${EQUIV_CHECK_SCRIPT})

  get_cells_sim_path(PATH_TO_CELLS_SIM ${ADD_CHECK_TEST_ARCH})
  # CTest doesn't support build target dependencies, so we have to manually
  # make them.
  #
  # See https://stackoverflow.com/questions/733475/cmake-ctest-make-test-doesnt-build-tests
  add_custom_target(_target_${ADD_CHECK_TEST_NAME}_build_depends
    DEPENDS
      ${ADD_CHECK_TEST_DEPENDS}
      ${PATH_TO_CELLS_SIM}
      ${EQUIV_CHECK_SCRIPT_TARGET}
      ${EQUIV_CHECK_SCRIPT_LOCATION}
      ${YOSYS}
    )
  add_test(
    NAME _test_${ADD_CHECK_TEST_NAME}_build
    COMMAND "${CMAKE_COMMAND}" --build ${CMAKE_BINARY_DIR} --target _target_${ADD_CHECK_TEST_NAME}_build_depends --config $<CONFIG>
    )
  # Make sure only one build is running at a time, ninja (and probably make)
  # output doesn't support multiple calls into it from seperate processes.
  set_tests_properties(
    _test_${ADD_CHECK_TEST_NAME}_build PROPERTIES RESOURCE_LOCK cmake
    )
  add_test(
    NAME ${ADD_CHECK_TEST_NAME}
    COMMAND ${YOSYS} -p "${ADD_CHECK_TEST_READ_GOLD} $<SEMICOLON> ${ADD_CHECK_TEST_READ_GATE} $<SEMICOLON> script ${EQUIV_CHECK_SCRIPT_LOCATION}" ${PATH_TO_CELLS_SIM}
    )
  set_tests_properties(
    ${ADD_CHECK_TEST_NAME} PROPERTIES DEPENDS _test_${ADD_CHECK_TEST_NAME}_build
    )

  # Also provide a make target that runs the analysis.
  add_custom_target(
    ${ADD_CHECK_TEST_NAME}
    COMMAND ${QUIET_CMD} ${YOSYS} -p "${ADD_CHECK_TEST_READ_GOLD} $<SEMICOLON> ${ADD_CHECK_TEST_READ_GATE} $<SEMICOLON> script ${EQUIV_CHECK_SCRIPT_LOCATION}" ${PATH_TO_CELLS_SIM}
    DEPENDS
      ${QUIET_CMD}
      ${ADD_CHECK_TEST_DEPENDS} ${PATH_TO_CELLS_SIM}
      ${EQUIV_CHECK_SCRIPT_TARGET} ${EQUIV_CHECK_SCRIPT_LOCATION}
      ${YOSYS}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    VERBATIM
    )
endfunction()

find_program(GTKWAVE gtkwave)

function(add_testbench)
  # ~~~
  #   ADD_TESTBENCH(
  #     NAME <name of testbench>
  #     ARCH <arch>
  #     SOURCES <source list>
  #   )
  # ~~~
  #
  # ADD_TESTBENCH emits two custom targets, ${NAME} and ${NAME}_view.  ${NAME}
  # builds and executes a testbench with iverilog.
  #
  # ${NAME}_view launches GTKWAVE on the output wave file. For wave viewing, it
  # is assumed that all testbenches will output some variable dump and dump
  # to a file defined by VCDFILE.  If this is not true, the ${NAME}_view target
  # will not work.

  set(options)
  set(oneValueArgs NAME ARCH)
  set(multiValueArgs SOURCES)
  cmake_parse_arguments(
    ADD_TESTBENCH
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  get_target_property(IVERILOG env IVERILOG)
  get_target_property(VVP env VVP)
  set(SOURCE_LOCATIONS "")
  set(FILE_DEPENDS "")
  foreach(SRC ${ADD_TESTBENCH_SOURCES})
    append_file_location(SOURCE_LOCATIONS ${SRC})
    append_file_dependency(FILE_DEPENDS ${SRC})
  endforeach()

  get_cells_sim_path(PATH_TO_CELLS_SIM ${ADD_TESTBENCH_ARCH})

  set(NAME ${ADD_TESTBENCH_NAME})

  add_custom_command(
    OUTPUT ${NAME}.vpp
    COMMAND
      ${IVERILOG} -v -DVCDFILE=\"${NAME}.vcd\"
      -DCLK_MHZ=0.001 -o ${CMAKE_CURRENT_BINARY_DIR}/${NAME}.vpp
      ${PATH_TO_CELLS_SIM}
      ${SOURCE_LOCATIONS}
      DEPENDS ${IVERILOG} ${FILE_DEPENDS}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    VERBATIM
    )

  # This target always just executes the testbench.  If the user wants to view
  # waves generated from this executation, they should just build ${NAME}_view
  # not ${NAME}.
  add_custom_target(
    ${NAME}
    COMMAND ${VVP} -v -N ${NAME}.vpp
    DEPENDS ${VVP} ${NAME}.vpp
    )

  add_custom_command(
    OUTPUT ${NAME}.vcd
    COMMAND ${VVP} -v -N ${NAME}.vpp
    DEPENDS ${VVP} ${NAME}.vpp
    )
  add_custom_target(
    ${NAME}_view
    COMMAND ${GTKWAVE} ${NAME}.vcd
    DEPENDS ${NAME}.vcd ${GTKWAVE}
    )
endfunction()

function(generate_pinmap)
  # ~~~
  #   GENERATE_PINMAP(
  #     NAME <name of file to output pinmap file>
  #     TOP <module name to generate pinmap for>
  #     BOARD <board to generate pinmap for>
  #     SOURCES <list of sources to load>
  #   )
  # ~~~
  #
  # Generate pinmap blindly assigns each input and output from the module
  # ${TOP} to valid pins for the specified board. In its current version,
  # GENERATE_PINMAP may assign IO to global wire.
  #
  # TODO: Consider adding knowledge of global wires and be able to assign
  # specific wires to global wires (e.g. clock or reset lines).
  #
  # SOURCES must contain a module that matches ${TOP}.
  set(options)
  set(oneValueArgs NAME TOP BOARD)
  set(multiValueArgs SOURCES)

  cmake_parse_arguments(
    GENERATE_PINMAP
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  get_target_property_required(YOSYS env YOSYS)
  get_target_property_required(PYTHON3 env PYTHON3)
  get_target_property_required(QUIET_CMD env QUIET_CMD)

  set(BOARD ${GENERATE_PINMAP_BOARD})
  get_target_property_required(DEVICE ${BOARD} DEVICE)
  get_target_property_required(PACKAGE ${BOARD} PACKAGE)
  get_target_property_required(PINMAP_FILE ${BOARD} PINMAP)
  get_file_location(PINMAP ${PINMAP_FILE})
  get_file_target(PINMAP_TARGET ${PINMAP_FILE})

  set(CREATE_PINMAP ${symbiflow-arch-defs_SOURCE_DIR}/utils/create_pinmap.py)

  set(SOURCE_FILES "")
  set(SOURCE_FILES_DEPS "")
  foreach(SRC ${GENERATE_PINMAP_SOURCES})
    append_file_location(SOURCE_FILES ${SRC})
    append_file_dependency(SOURCE_FILES_DEPS ${SRC})
  endforeach()

  add_custom_command(
    OUTPUT ${GENERATE_PINMAP_NAME}.json
    COMMAND ${QUIET_CMD} ${YOSYS} -p "write_json ${CMAKE_CURRENT_BINARY_DIR}/${GENERATE_PINMAP_NAME}.json" ${SOURCE_FILES}
    DEPENDS
      ${QUIET_CMD}
      ${YOSYS}
      ${SOURCE_FILES} ${SOURCE_FILES_DEPS}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    )

  add_custom_command(
    OUTPUT ${GENERATE_PINMAP_NAME}
    COMMAND ${PYTHON3} ${CREATE_PINMAP}
      --design_json ${CMAKE_CURRENT_BINARY_DIR}/${GENERATE_PINMAP_NAME}.json
      --pinmap_csv ${PINMAP}
      --module ${GENERATE_PINMAP_TOP} > ${CMAKE_CURRENT_BINARY_DIR}/${GENERATE_PINMAP_NAME}
    DEPENDS
      ${PYTHON3}
      ${CREATE_PINMAP}
      ${PINMAP} ${PINMAP_TARGET}
      ${GENERATE_PINMAP_NAME}.json
    )

  add_file_target(FILE ${GENERATE_PINMAP_NAME} GENERATED)
endfunction()

function(add_autosim)
  # ~~~
  #   ADD_AUTOSIM(
  #     NAME <name of autosim target>
  #     TOP <name of top module>
  #     SOURCES <source list to autosim>
  #     CYCLES <number of cycles to sim>
  #   )
  # ~~~
  #
  set(options)
  set(oneValueArgs NAME ARCH TOP CYCLES)
  set(multiValueArgs SOURCES)

  cmake_parse_arguments(
    ADD_AUTOSIM
    "${options}"
    "${oneValueArgs}"
    "${multiValueArgs}"
    ${ARGN}
  )

  set(SOURCE_FILES "")
  set(SOURCE_FILES_DEPS "")
  foreach(SRC ${ADD_AUTOSIM_SOURCES})
    append_file_dependency(SOURCE_FILES_DEPS ${SRC})
    append_file_location(SOURCE_FILES ${SRC})
  endforeach()

  get_target_property_required(YOSYS env YOSYS)

  set(AUTOSIM_VCD ${ADD_AUTOSIM_NAME}.vcd)
  get_cells_sim_path(CELLS_SIM_LOCATION ${ADD_AUTOSIM_ARCH})
  add_custom_command(
    OUTPUT ${AUTOSIM_VCD}
    COMMAND ${YOSYS} -p "prep -top ${ADD_AUTOSIM_TOP}; $<SEMICOLON> sim -clock clk -n ${ADD_AUTOSIM_CYCLES} -vcd ${AUTOSIM_VCD} -zinit ${ADD_AUTOSIM_TOP}" ${SOURCE_FILES} ${CELLS_SIM_LOCATION}
    DEPENDS ${YOSYS} ${SOURCE_FILES_DEPS} ${CELLS_SIM_LOCATION}
    VERBATIM
    )

  add_custom_target(${ADD_AUTOSIM_NAME} DEPENDS ${AUTOSIM_VCD})

  add_custom_target(${ADD_AUTOSIM_NAME}_view
    COMMAND ${GTKWAVE} ${AUTOSIM_VCD}
    DEPENDS ${AUTOSIM_VCD}
    )
endfunction()
