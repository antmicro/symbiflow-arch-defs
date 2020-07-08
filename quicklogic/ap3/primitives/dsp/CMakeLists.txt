add_file_target(FILE dsp.sim.v SCANNER_TYPE verilog)

v2x(NAME dsp SRCS dsp.sim.v)

add_to_cells_sim(dsp.sim.v)