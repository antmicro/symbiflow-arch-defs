`include "vcc_cell.sim.v"

(* whitebox *)
module VCC (
    output wire VCC
);

    VCC_CELL vcc (.VCC(VCC));

endmodule
