`include "../vpr_pad/vpr_ipad.sim.v"
`include "../in_buff/in_buff.sim.v"
//`include "../in_reg/in_reg.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODES="in_buff" *)
//(* MODES="in_buff;in_reg" *)
(* keep_hierarchy *)
module INPUT_IO (
	A2F,
	QRT,
	IQC,
	IQZ
    );

    parameter MODE = "in_buff";

    input wire A2F;

    input wire QRT;

    (* CLOCK *)
    input wire IQC;

    output wire IQZ;

    generate if (MODE == "in_buff") begin

        (* PACK="IPAD_TO_IBUF" *)
        wire pad;

        VPR_IPAD ipad (.inpad(pad));

        (* keep *)
        IN_BUFF inst_buff(.A(pad), .Q(IQZ));

    /*end else if (MODE == "in_reg") begin 

        IN_REG inst_reg(.dataIn(A2F), .sel(), .rst(QRT), .hold(), .clk(IQC), .dataOut(IQZ));*/

    end endgenerate

endmodule
