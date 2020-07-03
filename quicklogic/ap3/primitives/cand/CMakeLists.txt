add_file_target(FILE canden_cell.sim.v SCANNER_TYPE verilog)
add_file_target(FILE cand_cell.sim.v SCANNER_TYPE verilog)

v2x(NAME CANDEN SRCS canden_cell.sim.v)
v2x(NAME CAND SRCS cand_cell.sim.v)

add_to_cells_sim(canden_cell.sim.v)
add_to_cells_sim(cand_cell.sim.v)