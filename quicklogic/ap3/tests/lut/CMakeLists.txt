add_file_target(FILE lut1.v SCANNER_TYPE verilog)
add_file_target(FILE lut2.v SCANNER_TYPE verilog)
add_file_target(FILE lut3.v SCANNER_TYPE verilog)
add_file_target(FILE lut4.v SCANNER_TYPE verilog)
add_file_target(FILE ql745a.pcf)

add_fpga_target(
  NAME lut1-ql-ql745a
  BOARD ql745a
  SOURCES lut1.v
  INPUT_IO_FILE ql745a.pcf
  EXPLICIT_ADD_FILE_TARGET
  )

add_fpga_target(
  NAME lut2-ql-ql745a
  BOARD ql745a
  SOURCES lut2.v
  INPUT_IO_FILE ql745a.pcf
  EXPLICIT_ADD_FILE_TARGET
  )

add_fpga_target(
  NAME lut3-ql-ql745a
  BOARD ql745a
  SOURCES lut3.v
  INPUT_IO_FILE ql745a.pcf
  EXPLICIT_ADD_FILE_TARGET
  )

add_fpga_target(
  NAME lut4-ql-ql745a
  BOARD ql745a
  SOURCES lut4.v
  INPUT_IO_FILE ql745a.pcf
  EXPLICIT_ADD_FILE_TARGET
  )

add_dependencies(all_ql_tests lut1-ql-ql745a_route)
add_dependencies(all_ql_tests lut2-ql-ql745a_route)
add_dependencies(all_ql_tests lut3-ql-ql745a_route)
add_dependencies(all_ql_tests lut4-ql-ql745a_route)

