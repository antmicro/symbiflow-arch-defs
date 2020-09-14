`include "./le4.sim.v"
`include "./le4_qdi.sim.v"
`include "./badder.sim.v"

`timescale 1ns/10ps
(* FASM_PARAMS="" *)
(* MODES="LUT_FF; LUT_FF_Separate; ADDER" *)
(* whitebox *)
module LOGIC_CELL (
        LI,
        CI,
        QEN,
        QST,
        QRT,
        QCK,
        FZ,
        AQZ,
        BQZ,
        CQZ,
        CO
);

    input wire [3:0] LI;
    input wire CI, QEN, QST, QRT, QCK;

    output wire FZ, AQZ, BQZ, CQZ, CO;

    parameter MODE = "LUT_FF";

    generate if (MODE == "LUT_FF") begin
        // LOGIC Cell used as LUT+FF where LUT output is input to FF

        parameter LE_BQZ_MUX = "I0";
        parameter LE_CQZ_MUX = "I0";

        LE4 #(.BQZ_MUX(LE_BQZ_MUX), .CQZ_MUX(LE_CQZ_MUX)) le4_inst(
                .LI(LI),
                .QEN(QEN),
                .QST(QST),
                .QRT(QRT),
                .QCK(QCK),
                .FZ(FZ),
                .AQZ(AQZ),
                .BQZ(BQZ),
                .CQZ(CQZ)
        );
    end else if (MODE == "LUT_FF_Separate") begin 
            
        parameter LE_BQZ_MUX = "I0";
        parameter LE_CQZ_MUX = "I0";

        LE4_QDI #(.BQZ_MUX(LE_BQZ_MUX), .CQZ_MUX(LE_CQZ_MUX)) le4_qdi_inst(
                .LI(LI),
                .QEN(QEN),
                .QST(QST),
                .QRT(QRT),
                .QCK(QCK),
                .FZ(FZ),
                .AQZ(AQZ),
                .BQZ(BQZ),
                .CQZ(CQZ)
        );
    
    end else if (MODE == "LUT_ADDER") begin 
    
        parameter LE_QDI_MUX = "I0";
        parameter LE_BQZ_MUX = "I0";
        parameter LE_CQZ_MUX = "I0";
        
        BADDER #(.QDI_MUX(LE_QDI_MUX), .BQZ_MUX(LE_BQZ_MUX), .CQZ_MUX(LE_CQZ_MUX)) add_inst(
                .LI(LI),
                .CI(CI),
                .QEN(QEN),
                .QST(QST),
                .QRT(QRT),
                .QCK(QCK),
                .FZ(FZ),
                .AQZ(AQZ),
                .BQZ(BQZ),
                .CQZ(CQZ),
                .CO(CO)
        );
    end endgenerate

endmodule

