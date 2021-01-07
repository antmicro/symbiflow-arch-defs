add_xc_device_define_type(
  ARCH artix7
  DEVICE xc7a50t-netv2-pcie
  ROI_DIR ${PRJXRAY_DB_DIR}/artix7/harness/netv2/pcie
  TILE_TYPES
    CLBLL_L
    CLBLL_R
    CLBLM_L
    CLBLM_R
    BRAM_L
    LIOPAD_M
    LIOPAD_S
    LIOPAD_SING
    RIOPAD_M
    RIOPAD_S
    RIOPAD_SING
  PB_TYPES
    SLICEL
    SLICEM
    BRAM_L
    IOPAD
    IOPAD_M
    IOPAD_S
)
