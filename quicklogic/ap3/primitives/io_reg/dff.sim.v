(* whitebox *)
module DFF (
	D,
	Q,
	CLK,
	RST
);

	input wire D;
	output reg Q;
	input wire CLK;
	input wire RST;

	always @(posedge CLK or posedge RST)
	begin
	if (RST)
	    Q <= 1'b0;
	else
	    Q <= D;
	end

endmodule
