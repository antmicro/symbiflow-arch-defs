add_file_target(FILE lut4.sim.v SCANNER_TYPE verilog)

v2x(NAME lut4 SRCS lut4.sim.v)

add_to_cells_sim(lut4.sim.v ap3)
