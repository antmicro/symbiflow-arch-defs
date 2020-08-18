`include "../vpr_pad/vpr_ipad.sim.v"
`include "in_reg_cell.sim.v"

module IN_CELL (
	IQC,
	QRT,
	IQZ
);

	input wire IQC;
	input wire QRT;
	output wire IQZ;

	(* pack="IPAD_TO_IN_REG" *)
	wire in_pad;

	(* FASM_PREFIX="INTERFACE.IN_REG" *)
	IN_REG_CELL in_reg_inst (
		.IQC(IQC),
		.QRT(QRT),
		.A2F(in_pad),
		.IQZ(IQZ)
	);
	(* keep *)
	VPR_IPAD ipad_inst(in_pad);

endmodule
