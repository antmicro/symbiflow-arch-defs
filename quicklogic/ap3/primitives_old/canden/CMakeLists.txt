add_file_target(FILE canden.sim.v SCANNER_TYPE verilog)

v2x(NAME canden SRCS canden.sim.v)

add_to_cells_sim(canden.sim.v ap3)
