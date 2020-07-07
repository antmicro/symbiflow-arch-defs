add_file_target(FILE clock.sim.v SCANNER_TYPE verilog)

v2x(NAME clock SRCS clock.sim.v)

#add_to_cells_sim(clock.sim.v)