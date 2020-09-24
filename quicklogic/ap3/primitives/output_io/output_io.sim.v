`include "../out_buff/out_buff.sim.v"
//`include "../out_reg/out_reg.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODES="out_buff" *)
//(* MODES="out_buff; out_reg" *)
(* whitebox *)
module OUTPUT_IO (
	OQI,
	QRT,
	IQC,
	F2A
    );

    parameter MODE = "out_buff";

    input wire OQI;

    input wire QRT;

    input wire IQC;

    output wire F2A;

    generate if (MODE == "out_buff") begin

        OUT_BUFF inst_buff(.A(OQI), .Q(F2A));

    /*end else if (MODE == "out_reg") begin 

        OUT_REG inst_reg(.dataIn(OQI), .sel(), .rst(QRT), .clk(IQC), .dataOut(F2A));*/

    end endgenerate

endmodule
