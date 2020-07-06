add_file_target(FILE logic.sim.v SCANNER_TYPE verilog)
add_file_target(FILE one_logic_cell.sim.v SCANNER_TYPE verilog)
add_file_target(FILE q_frag.sim.v SCANNER_TYPE verilog)
add_file_target(FILE l_frag.sim.v SCANNER_TYPE verilog)

v2x(NAME IO_REG SRCS logic.sim.v)
v2x(NAME IO_REG SRCS one_logic_cell.sim.v)
v2x(NAME IO_REG SRCS q_frag.sim.v)
v2x(NAME IO_REG SRCS l_frag.sim.v)

add_to_cells_sim(logic.sim.v)
add_to_cells_sim(one_logic_cell.sim.v)
add_to_cells_sim(q_frag.sim.v)
add_to_cells_sim(l_frag.sim.v)