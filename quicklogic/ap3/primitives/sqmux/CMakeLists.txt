add_file_target(FILE sqmux.sim.v SCANNER_TYPE verilog)

v2x(NAME sqmux SRCS sqmux.sim.v)

add_to_cells_sim(sqmux.sim.v ap3)
