module top (
    input  wire harness_usr_clk,
    input  wire harness_other_clk,

    output wire roi_usr_clk,
    output wire roi_other_clk,

    output wire [3:0] led
);

    wire harness_usr_clk_tmp, harness_other_clk_tmp;
    wire usr_clk, other_clk;

    SYN_OBUF syn_obuf1(.I(usr_clk), .O(roi_usr_clk));
    SYN_OBUF syn_obuf2(.I(other_clk), .O(roi_other_clk));

    SYN_IBUF syn_ibuf1(.I(harness_usr_clk), .O(harness_usr_clk_tmp));
    SYN_IBUF syn_ibuf2(.I(harness_other_clk), .O(harness_other_clk_tmp));

    BUFG bufg_usr(.I(harness_usr_clk_tmp), .O(usr_clk));
    BUFG bufg_other(.I(harness_other_clk_tmp), .O(other_clk));


    localparam BITS = 4;
    localparam LOG2DELAY = 22;

    reg [BITS+LOG2DELAY-1:0] counter = 0;

    always @(posedge usr_clk) begin
    	counter <= counter + 1;
    end

    assign led = counter >> LOG2DELAY;
endmodule
