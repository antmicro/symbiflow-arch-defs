add_file_target(FILE gnd_cell.sim.v SCANNER_TYPE verilog)
add_file_target(FILE gnd.sim.v SCANNER_TYPE verilog)

v2x(NAME gnd_cell SRCS gnd_cell.sim.v)
v2x(NAME gnd SRCS gnd.sim.v)

add_to_cells_sim(gnd_cell.sim.v ap3)
