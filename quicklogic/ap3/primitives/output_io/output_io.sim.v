`include "../vpr_pad/vpr_opad.sim.v"
`include "../out_buff/out_buff.sim.v"
//`include "../out_reg/out_reg.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODES="out_buff" *)
//(* MODES="out_buff; out_reg" *)
(* keep_hierarchy *)
module OUTPUT_IO (
	OQI,
	QRT,
	IQC,
	F2A
    );

    parameter MODE = "out_buff";

    input wire OQI;

    input wire QRT;

    (* CLOCK *)
    input wire IQC;

    output wire F2A;

    generate if (MODE == "out_buff") begin

        (* PACK="OBUF_TO_OPAD" *)
        wire pad;

        OUT_BUFF inst_buff(.A(OQI), .Q(pad));

        (* keep *)
        VPR_OPAD opad(.outpad(pad));

    /*end else if (MODE == "out_reg") begin 

        OUT_REG inst_reg(.dataIn(OQI), .sel(), .rst(QRT), .clk(IQC), .dataOut(F2A));*/

    end endgenerate

endmodule
