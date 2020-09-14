add_file_target(FILE out_buff.sim.v SCANNER_TYPE verilog)

v2x(NAME out_buff SRCS out_buff.sim.v)

add_to_cells_sim(out_buff.sim.v ap3)
