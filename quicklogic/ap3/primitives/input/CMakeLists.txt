add_file_target(FILE input.sim.v SCANNER_TYPE verilog)

v2x(NAME input SRCS input.sim.v)

add_to_cells_sim(input.sim.v ap3)
