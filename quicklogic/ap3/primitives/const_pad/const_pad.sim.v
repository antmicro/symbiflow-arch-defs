`include "../d_buff/d_buff.sim.v"

module const_pad (
	F2A_DEF
);

	output wire F2A_DEF;

    d_buff d_inst(F2A_DEF);

endmodule
