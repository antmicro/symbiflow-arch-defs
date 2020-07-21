`include "in_buff_cell.sim.v"
`include "out_buff_cell.sim.v"
`include "in_reg_cell.sim.v"
`include "out_reg_cell.sim.v"
`include "d_buff_cell.sim.v"

`timescale 1ns/10ps

(*MODES="IN_REG;OUT_REG;IN_BUFF;OUT_BUFF;D_BUFF" *)
module IO_REG (
		IQC,
		QRT,
		ISEL,
		OSEL,
		DSEL,
		FIXHOLD,
		A2F,
		OQI,
		IQZ,
		F2A,
		F2A_DEF);

	input wire IQC;
	input wire QRT;
	input wire [0:7] ISEL;

	input wire [0:17] OSEL;

	input wire [0:3] DSEL;

	input wire [0:7] FIXHOLD;

	input wire [0:7] A2F;

	input wire [0:17] OQI;

	output reg [0:7] IQZ;

	output [0:17] F2A;

	output [0:3] F2A_DEF;

	parameter MODE = "IN_REG";

	// IN_REF 
    generate if (MODE == "IN_REG") begin

        (* keep *)
		(* FASM_PREFIX="INTERFACE.IN_REG" *)
		genvar i;
		generate for (i = 0; i < 8; i = i + 1) 
		begin
			IN_REG_CELL in_reg_inst (IQC, ISEL[i], FIXHOLD[i], QRT, A2F[i], IQZ[i]);
		end 
		endgenerate
	end else if (MODE == "OUT_REG") begin
		(* keep *)
		(* FASM_PREFIX="INTERFACE.OUT_REG" *)
		genvar i;
		generate for (i = 0; i < 18; i = i + 1) 
		begin
			OUT_REG_CELL out_reg_inst (IQC, OSEL[i], QRT, OQI[i], F2A[i]);
		end 
		endgenerate
	end else if (MODE == "IN_BUFF") begin
		(* keep *)
		(* FASM_PREFIX="INTERFACE.IN_BUFF" *)
		genvar i;
		generate for (i = 0; i < 8; i = i + 1) 
		begin
			IN_BUFF_CELL in_buff_inst (A2F[i], IQZ[i]);
		end 
		endgenerate
	end else if (MODE == "OUT_BUFF") begin
		(* keep *)
		(* FASM_PREFIX="INTERFACE.OUT_BUFF" *)
		genvar i;
		generate for (i = 0; i < 18; i = i + 1) 
		begin
			OUT_BUFF_CELL out_buff_inst (OQI[i], F2A[i]);
		end 
		endgenerate
	end else if (MODE == "D_BUFF") begin
		(* keep *)
		(* FASM_PREFIX="INTERFACE.D_BUFF" *)
		genvar i;
		generate for (i = 0; i < 4; i = i + 1) 
		begin
			D_BUFF_CELL d_buff_inst (DSEL[i], F2A_DEF[i]);
		end 
		endgenerate
	end
	endgenerate


endmodule 