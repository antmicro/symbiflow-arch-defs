add_file_target(FILE sqemux.sim.v SCANNER_TYPE verilog)

v2x(NAME sqemux SRCS sqemux.sim.v)

add_to_cells_sim(sqemux.sim.v ap3)
