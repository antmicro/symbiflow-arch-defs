add_file_target(FILE out_reg.sim.v SCANNER_TYPE verilog)

v2x(NAME out_reg SRCS out_reg.sim.v)

add_to_cells_sim(out_reg.sim.v ap3)
