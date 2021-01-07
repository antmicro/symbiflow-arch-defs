module top (
    input  wire clk,

    output wire [3:0] led
);

    wire syn_clk;
    SYN_IBUF syn_ibuf(.I(clk), .O(syn_clk));

    localparam BITS = 4;
    localparam LOG2DELAY = 22;

    reg [BITS+LOG2DELAY-1:0] counter = 0;

    always @(posedge syn_clk) begin
    	counter <= counter + 1;
    end

    assign led = counter >> LOG2DELAY;
endmodule
