add_file_target(FILE output.sim.v SCANNER_TYPE verilog)

v2x(NAME output SRCS output.sim.v)

add_to_cells_sim(output.sim.v ap3)
