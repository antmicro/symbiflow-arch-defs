(* whitebox *)
module DFF (
	D,
	Q,
	CLK,
	RST
);

    (* SETUP="CLK {setup_CLK_D}" *) (* NO_COMB *)
    (* HOLD="CLK {hold_CLK_D}" *) (* NO_COMB *)
	input wire D;
    
	(* CLK_TO_Q = "CLK {iopath_CLK_Q}" *)
	output reg Q;

    (* CLOCK *)
	(* clkbuf_sink *)
	input wire CLK;

	(* SETUP="CLK 1e-10" *) (* NO_COMB *)
	input wire RST;

    specify
        (CLK => Q) = "";
        $setup(QRT, posedge CLK, "");
        $hold(posedge CLK, QRT, "");
    endspecify

	always @(posedge CLK or posedge RST)
	begin
	if (RST)
	    Q <= 1'b0;
	else
	    Q <= D;
	end

endmodule
