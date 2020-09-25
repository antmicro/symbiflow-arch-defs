add_file_target(FILE vcc_cell.sim.v SCANNER_TYPE verilog)
add_file_target(FILE vcc.sim.v SCANNER_TYPE verilog)

v2x(NAME vcc_cell SRCS vcc_cell.sim.v)
v2x(NAME vcc SRCS vcc.sim.v)

add_to_cells_sim(vcc_cell.sim.v ap3)
