add_file_target(FILE btn_xor.v SCANNER_TYPE verilog)
add_file_target(FILE ql745a.pcf)

add_fpga_target(
  NAME btn_xor-ql-ql745a
  BOARD ql745a
  SOURCES btn_xor.v
  INPUT_IO_FILE ql745a.pcf
  EXPLICIT_ADD_FILE_TARGET
  )

add_jlink_output(
  PARENT btn_xor-ql-ql745a
)

add_dependencies(all_ql_tests btn_xor-ql-ql745a_bit)
add_dependencies(all_ql_tests btn_xor-ql-ql745a_jlink)

