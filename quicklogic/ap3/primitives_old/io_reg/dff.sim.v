(* whitebox *)
module DFF (
	D,
	CLK,
	RST,
	Q,
);

    (* CLOCK *)
	(* clkbuf_sink *)
	input wire CLK;

	/*(* SETUP="CLK {setup_CLK_D}" *)
	(* HOLD="CLK {hold_CLK_D}" *)
    (* NO_COMB *)*/
	(* SETUP="CLK 1e-10" *) (* NO_COMB *)
	input wire D;
    
	(* SETUP="CLK 1e-10" *) (* NO_COMB *)
	input wire RST;

	//(* CLK_TO_Q = "CLK {iopath_CLK_Q}" *)
	(* CLK_TO_Q = "CLK 1e-10" *)
	output reg Q;

    specify
        (CLK => Q) = "";
        $setup(RST, posedge CLK, "");
        $hold(posedge CLK, RST, "");
        $setup(D, posedge CLK, "");
        $hold(posedge CLK, D, "");
    endspecify

	always @(posedge CLK or posedge RST)
	begin
	if (RST)
	    Q <= 1'b0;
	else
	    Q <= D;
	end

endmodule
