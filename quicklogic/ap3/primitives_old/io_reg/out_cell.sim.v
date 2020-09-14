`include "../vpr_pad/vpr_opad.sim.v"
`include "out_reg_cell.sim.v"

module OUT_CELL (
	IQC,
	QRT,
	OQI
);

	input wire IQC;
	input wire QRT;
	input wire OQI;

	parameter MODE = "OUT_REG";

	(* pack="OUT_REG_TO_OPAD" *)
	wire out_pad;
	(* FASM_PREFIX="INTERFACE.OUT_REG" *)
	OUT_REG_CELL out_reg_cell_inst (
		.IQC(IQC),
		.QRT(QRT),
		.OQI(OQI),
		.F2A(out_pad)
	);

	(* keep *)
	VPR_OPAD opad_inst(out_pad);

endmodule
