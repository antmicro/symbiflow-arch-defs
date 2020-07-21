add_file_target(FILE q_frag.sim.v SCANNER_TYPE verilog)
add_file_target(FILE l_frag.sim.v SCANNER_TYPE verilog)
add_file_target(FILE one_logic_cell.sim.v SCANNER_TYPE verilog)
add_file_target(FILE logic.sim.v SCANNER_TYPE verilog)

v2x(NAME q_frag SRCS q_frag.sim.v)
v2x(NAME l_frag SRCS l_frag.sim.v)
v2x(NAME one_logic_cell SRCS one_logic_cell.sim.v)
v2x(NAME logic SRCS logic.sim.v)

add_to_cells_sim(q_frag.sim.v ap3)
add_to_cells_sim(l_frag.sim.v ap3)
