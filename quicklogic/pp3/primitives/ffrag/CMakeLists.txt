add_file_target(FILE f_frag.sim.v SCANNER_TYPE verilog)
add_file_target(FILE ffrag.sim.v SCANNER_TYPE verilog)

v2x(NAME f_frag SRCS f_frag.sim.v)
v2x(NAME ffrag  SRCS ffrag.sim.v)

add_to_cells_sim(f_frag.sim.v)
