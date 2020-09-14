`timescale 1ns/10ps
(* whitebox *)
(* FASM_FEATURES="" *)
module CLOCK_CELL(I_PAD, O_CLK);

    (* iopad_external_pin *)
    input  wire I_PAD;

    (* CLOCK=0 *)
    //(* DELAY_CONST_I_PAD="{iopath_I_PAD_O_CLK}" *)
    (* DELAY_CONST_I_PAD="1e-10" *)
    output wire O_CLK;
	
	specify
        (I_PAD=>O_CLK)="";
    endspecify

    assign O_CLK = I_PAD;

endmodule
