add_file_target(FILE mux.sim.v SCANNER_TYPE verilog)
add_file_target(FILE d_buff.sim.v SCANNER_TYPE verilog)

v2x(NAME mux SRCS mux.sim.v)
v2x(NAME d_buff SRCS d_buff.sim.v)

add_to_cells_sim(d_buff.sim.v ap3)
