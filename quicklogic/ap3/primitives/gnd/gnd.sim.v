`include "./gnd_cell.sim.v"

(* whitebox *)
module GND (
    output wire GND
);

    GND_CELL gnd (.GND(GND));

endmodule
