#set(LIB_TIMING_FILES "*_ss_0p990v_m040c.lib" "*_ss_0p990v_m040c_Cmax_2P97V.lib")
#set(DONT_NORMALIZE_FILES "RAM_ss_0p990v_m040c.lib" "RAM_ff_0p990v_m040c.lib")

set(FAMILY "ap3")
set(DEVICE "ql-ap3-8x8")
set(PACKAGES "ql745a")
set(DEVICE_TYPE "ql-ap3-8x8-virt")

quicklogic_define_device_type(
  FAMILY ${FAMILY}
  DEVICE ${DEVICE}
  ARCH ql-ap3
  PACKAGES ${PACKAGES}
  ROUTING_TIMING_FILE_NAME QL745A_RoutingDelays_SSM40.csv
  TECHFILE_NAME QL745A.xml
  LIB_TIMING_FILES ""#${LIB_TIMING_FILES}
  DONT_NORMALIZE_FILES ""#${DONT_NORMALIZE_FILES}
  PB_TYPES
    GND VCC
    SUPER_LOGIC_CELL
    INPUT_IO
    OUTPUT_IO
    CONST_PAD
  ARCH_XML_INCLUDES
    "layout/ql-ap3-8x8-layout.xml"
    "models/ql-ap3-8x8-models.xml"
    "tiles/ql-ap3-8x8-tiles.xml"
)
    #RAM
    #DSP

foreach(PACKAGE ${PACKAGES})
  define_ql_device_cells_install_target(
    DEVICE ${DEVICE}
    DEVICE_TYPE ${DEVICE_TYPE}
    PACKAGE ${PACKAGES}
    )
endforeach()
