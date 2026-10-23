`timescale 1ns / 1ps

module up_counter12 (
    input wire clk,
    input wire reset,
    input wire tick,
    output reg [11:0] count
);
    always @(posedge clk) begin
        if (reset)
            count <= 12'd0;
        else if (tick)
            count <= count + 12'd1; // 4095 wraps to 0
    end
endmodule
