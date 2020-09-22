`include "../vpr_pad/vpr_opad.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODES="" *)
(* whitebox *)
module out_reg (
	dataIn,
	sel,
	rst,
	hold,
	clk,
	dataOut
);

	(* SETUP="clk 1e-10" *) (* NO_COMB *)
	input wire dataIn;
	
	(* SETUP="clk 1e-10" *) (* NO_COMB *)
	input wire sel;
	
	(* SETUP="clk 1e-10" *) (* NO_COMB *)
	input wire rst;
	
	(* SETUP="clk 1e-10" *) (* NO_COMB *)
	input wire hold;
    
	(* CLOCK *)
	(* clkbuf_sink *)
	input wire clk;
	
    (* CLK_TO_Q = "clk 1e-10" *)
	output reg dataOut;

	(* pack="DATAOUT_TO_OPAD" *)
	wire out_pad;

	(* ASSOC_CLOCK="clk" *)
    always @(posedge clk or posedge rst or posedge hold)
        if (rst)
            dataOut <= 1'b0;
        else if (hold)
            dataOut <= 1'b1;
        else if (sel)
            dataOut <= dataIn;

	(* keep *)
	VPR_OPAD opad_inst(out_pad);

endmodule
