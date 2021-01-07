add_xc_device_define_type(
  ARCH artix7
  DEVICE xc7a50t-netv2-pcie-overlay
  OVERLAY_DIR ${symbiflow-arch-defs_SOURCE_DIR}/xc/xc7/archs/artix7/devices/xc7a50t-netv2-pcie-overlay-virt
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
