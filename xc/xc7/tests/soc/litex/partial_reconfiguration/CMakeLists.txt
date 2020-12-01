set(ARTY_PLATFORM ${CMAKE_CURRENT_SOURCE_DIR}/arty_prm_platform.py)
add_file_target(FILE arty_prm_platform.py)
set(ARTY_OVERLAY_GEN ${CMAKE_CURRENT_SOURCE_DIR}/arty_overlay.py)
add_file_target(FILE arty_overlay.py)

set(TOP "arty_prm_platform")
set(SOURCES
  ${TOP}.v
  ${TOP}.xdc
  mem.init
  mem_1.init
  mem_2.init
)

add_litex_test(
  NAME partial_reconfiguration_static
  TOP ${TOP}
  LITEX_DIR arty_soc
  USE_XDC
  LITEX_SOURCES ${SOURCES}
  EXTERNAL_SOURCES ${VEXRISCV}
  BOARD arty-partial-reconfiguration-overlay
  GENERATE_SCRIPT ${ARTY_OVERLAY_GEN}
  FIXUP_SCRIPT ${FIXUP_XDC}
  FLAGS
    --toolchain symbiflow
    --cpu-type vexriscv
)
