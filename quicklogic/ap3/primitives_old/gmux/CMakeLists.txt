add_file_target(FILE gmux_clk.sim.v SCANNER_TYPE verilog)
add_file_target(FILE gmux_hsck.sim.v SCANNER_TYPE verilog)
add_file_target(FILE gmux.sim.v SCANNER_TYPE verilog)

v2x(NAME gmux_clk SRCS gmux_clk.sim.v)
v2x(NAME gmux_hsck SRCS gmux_hsck.sim.v)
v2x(NAME gmux SRCS gmux.sim.v)

add_to_cells_sim(gmux_clk.sim.v ap3)
add_to_cells_sim(gmux_hsck.sim.v ap3)
