get_target_property_required(PYTHON3 env PYTHON3)

add_fpga_target(
  NAME sv2v_counter_basys3
  BOARD basys3-full
  SV2V_CONVERT
  SOURCES
    counter.sv
  SV2V_FLAGS "-v"
  INPUT_IO_FILE basys3.pcf
  EXPLICIT_ADD_FILE_TARGER
)
