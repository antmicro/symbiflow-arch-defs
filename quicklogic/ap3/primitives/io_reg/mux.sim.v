`default_nettype none

(* CLASS="routing" *)
(* MODES="I0; I1" *)
(* whitebox *)
module MUX(I0, I1, O);

	input wire I0;
	input wire I1;

	parameter MODE = "";

	output wire O;

	generate
		if ( MODE == "I0" )
		begin:SELECT_I0
			assign O = I0;
		end
		else if ( MODE == "I1" )
		begin:SELECT_I1
			assign O = I1;
		end
		else
		begin
			//$error("MUX: Invalid routing value %s (options are: I0, I1)", MODE);
		end
	endgenerate
endmodule
