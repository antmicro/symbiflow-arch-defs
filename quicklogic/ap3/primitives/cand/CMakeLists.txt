add_file_target(FILE cand.sim.v SCANNER_TYPE verilog)

v2x(NAME cand SRCS cand.sim.v)

add_to_cells_sim(cand.sim.v ap3)
