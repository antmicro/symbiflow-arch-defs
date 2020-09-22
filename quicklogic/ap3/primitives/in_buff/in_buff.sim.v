`include "../vpr_pad/vpr_opad.sim.v"

module IN_BUFF (
	A,
	Q
    );

    input wire A;
    output wire Q;

    /*(* pack="A_TO_OPAD" *)
    wire out_pad;

    (* keep *)
    VPR_OPAD opad_inst(out_pad);*/
    
    assign Q = A;

endmodule
