add_file_target(FILE in_buff.sim.v SCANNER_TYPE verilog)

v2x(NAME in_buff SRCS in_buff.sim.v)

add_to_cells_sim(in_buff.sim.v ap3)
