add_file_target(FILE vcc.sim.v SCANNER_TYPE verilog)

v2x(NAME vcc SRCS vcc.sim.v)

add_to_cells_sim(vcc.sim.v)
add_dependencies(all_ql_primitives v2x_quicklogic_pp3_primitives_vcc_vcc)
