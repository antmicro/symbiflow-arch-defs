add_file_target(FILE io_reg_cell.sim.v SCANNER_TYPE verilog)

v2x(NAME IO_REG SRCS io_reg_cell.sim.v)

add_to_cells_sim(io_reg_cell.sim.v)