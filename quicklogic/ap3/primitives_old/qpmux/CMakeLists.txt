add_file_target(FILE qpmux.sim.v SCANNER_TYPE verilog)

v2x(NAME qpmux SRCS qpmux.sim.v)

add_to_cells_sim(qpmux.sim.v ap3)
