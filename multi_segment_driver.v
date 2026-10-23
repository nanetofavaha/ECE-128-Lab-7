`timescale 1ns / 1ps

// This file is self-contained for the four-digit display subsystem.
// Project synthesis top: lab7_top. This file contains all display submodules.
// Basys 3 seven-segment display is active LOW for anodes and segments.
module multi_segment_driver (
    input wire clk,
    input wire reset,
    input wire [15:0] bcd_in,
    output wire [3:0] anode,
    output wire [6:0] cathode
);
    wire [1:0] select_digit;
    wire [3:0] bcd_val;

    anode_generator ag (
        .clk(clk),
        .reset(reset),
        .select_digit(select_digit),
        .anode(anode)
    );
    bcd_mux4 mux (
        .bcd_in(bcd_in),
        .select_digit(select_digit),
        .bcd_val(bcd_val)
    );
    bcd_to_7seg decoder (
        .bcd_val(bcd_val),
        .cathode(cathode)
    );
endmodule

module anode_generator (
    input wire clk,
    input wire reset,
    output reg [1:0] select_digit,
    output reg [3:0] anode
);
    // Clock cycles between digit changes.
    parameter integer REFRESH_DIV = 25000;

    reg [31:0] refresh_count;

    always @(posedge clk) begin
        if (reset) begin
            refresh_count <= 32'd0;
            select_digit <= 2'd0;
        end else if (refresh_count == REFRESH_DIV - 1) begin
            refresh_count <= 32'd0;
            select_digit <= select_digit + 2'd1;
        end else begin
            refresh_count <= refresh_count + 1'b1;
        end
    end

    always @(*) begin
        case (select_digit)
            2'd0: anode = 4'b1110; // ones, rightmost
            2'd1: anode = 4'b1101; // tens
            2'd2: anode = 4'b1011; // hundreds
            2'd3: anode = 4'b0111; // thousands, leftmost
            default: anode = 4'b1111;
        endcase
    end
endmodule

module bcd_mux4 (
    input wire [15:0] bcd_in,
    input wire [1:0] select_digit,
    output reg [3:0] bcd_val
);
    always @(*) begin
        case (select_digit)
            2'd0: bcd_val = bcd_in[3:0];
            2'd1: bcd_val = bcd_in[7:4];
            2'd2: bcd_val = bcd_in[11:8];
            2'd3: bcd_val = bcd_in[15:12];
            default: bcd_val = 4'd0;
        endcase
    end
endmodule

module bcd_to_7seg (
    input wire [3:0] bcd_val,
    output reg [6:0] cathode
);
    // cathode[6:0] corresponds to {g,f,e,d,c,b,a}; active LOW
    always @(*) begin
        case (bcd_val)
            4'd0: cathode = 7'b1000000;
            4'd1: cathode = 7'b1111001;
            4'd2: cathode = 7'b0100100;
            4'd3: cathode = 7'b0110000;
            4'd4: cathode = 7'b0011001;
            4'd5: cathode = 7'b0010010;
            4'd6: cathode = 7'b0000010;
            4'd7: cathode = 7'b1111000;
            4'd8: cathode = 7'b0000000;
            4'd9: cathode = 7'b0010000;
            default: cathode = 7'b1111111;
        endcase
    end
endmodule
