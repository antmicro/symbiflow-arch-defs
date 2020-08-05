`include "../vpr_pad/vpr_opad.sim.v"
`include "in_cell.sim.v"
`include "out_cell.sim.v"
`include "d_buff_cell.sim.v"

`timescale 1ns/10ps

module IO_REG (
		IQC,
		QRT,
		OQI,
		IQZ,
		);

	input wire IQC;
	input wire QRT;
	input wire [0:17] OQI;
	output reg [0:7] IQZ;

	genvar i;
	// input
	generate for (i = 0; i < 8; i = i + 1)
	begin
		IN_CELL in_cell_inst(IQC, QRT, IQZ[i]);
	end
	endgenerate

	//output
	generate for (i = 0; i < 18; i = i + 1)
	begin
		(* keep *)
		OUT_CELL out_cell_inst(IQC, QRT, OQI[i]);

	end
	endgenerate

	(* pack="D_BUFF_TO_OPAD" *)
	wire [0:3] out_pad;
	generate for (i = 0; i < 4; i = i + 1)
	begin
		D_BUFF_CELL d_buff_inst (
			.F2A_DEF(out_pad[i])
		);
		(* keep *)
		VPR_OPAD opad_inst(out_pad[i]);
	end
	endgenerate


endmodule