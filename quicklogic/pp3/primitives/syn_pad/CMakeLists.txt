add_file_target(FILE syn_pad.sim.v SCANNER_TYPE verilog)
v2x(NAME syn_pad SRCS syn_pad.sim.v)
add_dependencies(all_ql_primitives v2x_quicklogic_pp3_primitives_syn_pad_syn_pad)
