(* whitebox *)
module DELAY (
	IN,
	OUT
);
input wire IN;

(* DELAY_CONST_IN="1e-10" *)
output wire OUT;

assign OUT = IN;

endmodule
