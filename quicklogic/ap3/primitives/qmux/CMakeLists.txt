add_file_target(FILE qpmux_cell.sim.v SCANNER_TYPE verilog)
add_file_target(FILE qmux_cell.sim.v SCANNER_TYPE verilog)

v2x(NAME QPMUX SRCS qpmux_cell.sim.v)
v2x(NAME QMUX SRCS qmux_cell.sim.v)

add_to_cells_sim(qpmux_cell.sim.v)
add_to_cells_sim(qmux_cell.sim.v)