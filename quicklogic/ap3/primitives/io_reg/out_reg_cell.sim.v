`timescale 1ns/10ps
(* whitebox *)
(* FASM_PARAMS="" *)
module OUT_REG_CELL(IQC, OSEL_$inp, QRT, OQI_$inp, F2A_$out);

    (* SETUP="IQC {setup_IQC_OQI_$inp}" *) (* NO_COMB *)
    (* HOLD="IQC {hold_IQC_OQI_$inp}" *) (* NO_COMB *)
    (* iopad_external_pin *)
    input wire OQI_$inp;

    (* CLOCK *)
	(* clkbuf_sink *)
    input wire IQC;
    
    (* SETUP="IQC {setup_IQC_OSEL_$inp}" *) (* NO_COMB *)
    (* HOLD="IQC {hold_IQC_OSEL_$inp}" *) (* NO_COMB *)
    input wire OSEL_$inp;
        
    (* SETUP="IQC 1e-10" *) (* NO_COMB *)
    input wire QRT;

    (* CLK_TO_Q = "IQC {iopath_IQC_F2A_$out}" *)
    (* iopad_external_pin *)
    output wire F2A_$out;

    wire osel_mux_op;

    reg f2a_reg;

    specify
        (IQC => QZ) = "";
        $setup(QRT, posedge IQC, "");
        $hold(posedge IQC, QRT, "");
        $setup(OQI_$inp, posedge IQC, "");
        $hold(posedge IQC, OQI_$inp, "");
        $setup(OSEL_$inp, posedge IQC, "");
        $hold(posedge IQC, OSEL_$inp, "");
    endspecify

    always @(posedge IQC or posedge QRT)
    begin
        if (QRT)
            f2a_reg <= 1'b0;
        else
            f2a_reg <= OQI_$inp;
    end

    assign osel_mux_op = OSEL_$inp ? OQI_$inp : f2a_reg;

    buf F2F_reg_buf1 (F2A_$out, osel_mux_op);
    
endmodule
