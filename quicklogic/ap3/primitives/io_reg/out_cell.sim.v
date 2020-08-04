`include "../vpr_pad/vpr_opad.sim.v"
`include "out_buff_cell.sim.v"
`include "out_reg_cell.sim.v"

(* MODES="OUT_REG;OUT_BUFF" *)
module OUT_CELL (
	IQC,
	QRT,
	QDI
);

	input wire IQC;
	input wire QRT;
	input wire QDI;

	parameter MODE = "OUT_REG";

	generate if (MODE = "OUT_REG") begin

		(* pack="OUT_REG_TO_OPAD" *)
		wire out_pad;
		(* FASM_PREFIX="INTERFACE.OUT_REG" *)
		OUT_REG_CELL out_reg_cell_inst (IQC, QRT, out_pad);
		(* keep *)
		VPR_OPAD opad_inst(out_pad);

	end else if (MODE == "OUT_BUFF") begin

		(* pack="OUT_BUFF_TO_OPAD" *)
		wire out_pad;
		(* FASM_PREFIX="INTERFACE.OUT_BUFF" *)
		OUT_BUFF_CELL out_buff_inst (QDI, out_pad);
		(* keep *)
		VPR_OPAD opad_inst(out_pad);

	end
	endgenerate
endmodule
