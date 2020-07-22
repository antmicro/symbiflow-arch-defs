`timescale 1ns/10ps
(* whitebox *)
(* FASM_PARAMS="" *)
module IN_REG_CELL(IQC, ISEL_$inp, FIXHOLD_$inp, QRT, A2F_$inp, IQZ_$out);

    (* SETUP="IQC {setup_IQC_A2F_$inp}" *) (* NO_COMB *)
    (* HOLD="IQC {hold_IQC_A2F_$inp}" *) (* NO_COMB *)
    (* iopad_external_pin *)
    input wire A2F_$inp;

    (* CLOCK *)
	(* clkbuf_sink *)
    input wire IQC;
    
    (* SETUP="IQC {setup_IQC_ISEL_$inp}" *) (* NO_COMB *)
    (* HOLD="IQC {hold_IQC_ISEL_$inp}" *) (* NO_COMB *)
    input wire ISEL_$inp;
    
    (* SETUP="IQC {setup_IQC_FIXHOLD_$inp}" *) (* NO_COMB *)
    (* HOLD="IQC {hold_IQC_FIXHOLD_$inp}" *) (* NO_COMB *)
    input wire FIXHOLD_$inp;

        (* SETUP="IQC 1e-10" *) (* NO_COMB *)
    input wire QRT;

    (* CLK_TO_Q = "IQC {iopath_IQC_IQZ_$out}" *)
    (* iopad_external_pin *)
    output wire IQZ_$out;

    wire A2F_reg_int, A2F_reg_int_buff;
    wire fixhold_mux_op;

    reg iqz_reg;

    specify
        (IQC => QZ) = "";
        $setup(QRT, posedge IQC, "");
        $hold(posedge IQC, QRT, "");
        $setup(A2F_$inp, posedge IQC, "");
        $hold(posedge IQC, A2F_$inp, "");
        $setup(ISEL_$inp, posedge IQC, "");
        $hold(posedge IQC, ISEL_$inp, "");
        $setup(FIXHOLD_$inp, posedge IQC, "");
        $hold(posedge IQC, FIXHOLD_$inp, "");
    endspecify

    assign A2F_reg_int = A2F_$inp;
    
    assign A2F_reg_int_buff = A2F_reg_int;

    assign fixhold_mux_op = FIXHOLD_$inp ? A2F_reg_int_buff : A2F_reg_int;

    always @(posedge IQC or posedge QRT)
    begin
        if (QRT)
            iqz_reg <= 1'b0;
        else
            iqz_reg <= fixhold_mux_op; 
    end

    assign IQZ_$out = ISEL_$inp ? A2F_reg_int : iqz_reg;

endmodule
