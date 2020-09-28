`include "./gnd_cell.sim.v"

(* keep_hierarchy *)
module GND (
    output wire GND
);

    GND_CELL gnd (.GND(GND));

endmodule
