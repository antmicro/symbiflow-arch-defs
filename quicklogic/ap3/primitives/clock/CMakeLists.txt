add_file_target(FILE clock_cell.sim.v SCANNER_TYPE verilog)

v2x(NAME CLOCK SRCS clock_cell.sim.v)

add_to_cells_sim(clock_cell.sim.v)