add_file_target(FILE full_adder.sim.v SCANNER_TYPE verilog)

v2x(NAME full_adder SRCS full_adder.sim.v)

add_to_cells_sim(full_adder.sim.v ap3)
