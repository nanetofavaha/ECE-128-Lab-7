`timescale 1ns / 1ps

module clock_enable_1hz (
    input wire clk,
    input wire reset,
    output reg tick
);
    // Number of board clock cycles in one second.
    parameter integer CLK_HZ = 100000000;

    reg [31:0] count;

    always @(posedge clk) begin
        if (reset) begin
            count <= 32'd0;
            tick <= 1'b0;
        end else if (count == CLK_HZ - 1) begin
            count <= 32'd0;
            tick <= 1'b1;
        end else begin
            count <= count + 1'b1;
            tick <= 1'b0;
        end
    end
endmodule
