module top (
  output reg [15:0] led,
  input  wire      enable,
  input  wire      clk,
  input  wire      reset
);

  reg [25:0] counter;

  always_ff @(posedge clk)
  if (reset) begin
    counter <= 26'b0;
  end else if (enable) begin
    counter++;
  end

  assign led[7:0] = counter[26:19];

endmodule
