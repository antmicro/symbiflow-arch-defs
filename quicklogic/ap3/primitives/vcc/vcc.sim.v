`include "vcc_cell.sim.v"

(* keep_hierarchy *)
module VCC (
    output wire VCC
);

    VCC_CELL vcc (.VCC(VCC));

endmodule
