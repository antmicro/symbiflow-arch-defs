add_file_target(FILE in_reg.sim.v SCANNER_TYPE verilog)

v2x(NAME in_reg SRCS in_reg.sim.v)

add_to_cells_sim(in_reg.sim.v ap3)
