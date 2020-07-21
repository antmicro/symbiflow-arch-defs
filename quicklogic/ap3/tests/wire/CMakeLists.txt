add_file_target(FILE wire.v SCANNER_TYPE verilog)
add_file_target(FILE ql745a.pcf)

add_fpga_target(
  NAME wire-ql-ql745a
  BOARD ql745a
  SOURCES wire.v
  INPUT_IO_FILE ql745a.pcf
  EXPLICIT_ADD_FILE_TARGET
  )

add_dependencies(all_ql_tests wire-ql-ql745a_route)
