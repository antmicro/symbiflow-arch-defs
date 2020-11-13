add_file_target(FILE sdiomux_cell.sim.v SCANNER_TYPE verilog)
add_file_target(FILE sdiomux.sim.v SCANNER_TYPE verilog)

v2x(NAME sdiomux_cell SRCS sdiomux_cell.sim.v)
v2x(NAME sdiomux SRCS sdiomux.sim.v)

add_to_cells_sim(sdiomux_cell.sim.v)

add_dependencies(all_ql_primitives v2x_quicklogic_pp3_primitives_sdiomux_sdiomux_cell)
add_dependencies(all_ql_primitives v2x_quicklogic_pp3_primitives_sdiomux_sdiomux)
