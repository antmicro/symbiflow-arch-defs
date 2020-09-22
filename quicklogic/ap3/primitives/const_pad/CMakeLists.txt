add_file_target(FILE const_pad.sim.v SCANNER_TYPE verilog)

v2x(NAME const_pad SRCS const_pad.sim.v)

add_to_cells_sim(const_pad.sim.v ap3)
