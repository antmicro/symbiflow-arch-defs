// ============================================================================
// Constant sources

// Reduce logic_0 and logic_1 cells to 1'b0 and 1'b1. Const sources suitable
// for VPR will be added by Yosys during EBLIF write.
module logic_0(output a);
    assign a = 0;
endmodule

module logic_1(output a);
    assign a = 1;
endmodule


// ============================================================================