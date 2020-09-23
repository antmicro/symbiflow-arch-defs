`include "../vpr_pad/vpr_ipad.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODEL_NAME="OUT_REG" *)
(* whitebox *)
module OUT_REG (
	dataIn,
	sel,
	rst,
	clk,
	dataOut
    );

    (* SETUP="clk 1e-10" *) (* NO_COMB *)
    input wire dataIn;

    (* SETUP="clk 1e-10" *) (* NO_COMB *)
    input wire sel;

    (* SETUP="clk 1e-10" *) (* NO_COMB *)
    input wire rst;

    (* CLOCK *)
    (* clkbuf_sink *)
    input wire clk;

    (* CLK_TO_Q = "clk 1e-10" *)
    output reg dataOut;

    (* pack="IPAD_TO_DATAOUT" *)
    wire in_pad;
    
    (* keep *)
    VPR_IPAD inpad(in_pad);

    wire sel_mux_op;

    reg dataOut_reg;

    (* ASSOC_CLOCK="clk" *)
    always @(posedge clk or posedge rst)
    begin
        if (rst)
            dataOut_reg <= 1'b0;
        else
            dataOut_reg <= dataIn;
    end

    assign sel_mux_op = (sel) ? dataIn : dataOut_reg;

    assign dataOut = sel_mux_op;

endmodule
