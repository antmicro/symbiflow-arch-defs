`include "../vpr_pad/vpr_opad.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODES="" *)
(* whitebox *)
module IN_REG (
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

    /*(* pack="DATAOUT_TO_OPAD" *)
    wire out_pad;

    (* keep *)
    VPR_OPAD outpad(out_pad);*/

    wire dataIn_reg_int, dataIn_reg_int_buff;
    wire fixhold_mux_op;
    
    reg iqz_reg;

    assign dataIn_reg_int = dataIn;

    assign dataIn_reg_int_buff = dataIn_reg_int;

    assign fixhold_mux_op = (hold) ? dataIn_reg_int_buff : dataIn_reg_int;

    (* ASSOC_CLOCK="clk" *)
    always @(posedge clk or posedge rst)
    begin
        if(rst)
            iqz_reg <= 1'b0;
        else
            iqz_reg <= fixhold_mux_op;	
    end

    assign dataOut = (sel) ? dataIn_reg_int : iqz_reg;
    
endmodule
