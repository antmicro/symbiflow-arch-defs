`include "../vpr_pad/vpr_ipad.sim.v"
`include "in_buff_cell.sim.v"
`include "in_reg_cell.sim.v"

(* MODES="IN_REG;IN_BUFF" *)
module IN_CELL (
	IQC,
	QRT,
	IQZ
);

	input wire IQC;
	input wire QRT;
	output wire IQZ;

	parameter MODE = "IN_REG";

	generate if (MODE == "IN_REG") begin

		(* pack="IPAD_TO_IN_REG" *)
		wire in_pad;
		(* FASM_PREFIX="INTERFACE.IN_REG" *)
		IN_REG_CELL in_reg_inst (IQC, ISEL, FIXHOLD, QRT, in_pad, IQZ);
		(* keep *)
		VPR_IPAD ipad_inst(in_pad);

	end else if (MODE == "IN_BUFF") begin

		(* pack="IPAD_TO_IN_BUFF" *)
		wire in_pad;
		(* FASM_PREFIX="INTERFACE.IN_BUFF" *)
		IN_BUFF_CELL in_buff_inst (in_pad, IQZ);
		(* keep *)
		VPR_IPAD ipad_inst(in_pad);
	end
	endgenerate
endmodule
