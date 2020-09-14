add_file_target(FILE qmux.sim.v SCANNER_TYPE verilog)

v2x(NAME qmux SRCS qmux.sim.v)

add_to_cells_sim(qmux.sim.v ap3)
