`timescale 1ns / 1ps

// FPGA top-level: 100 MHz clk, active-high reset button.
module lab7_top (
    input wire clk,
    input wire reset,
    output wire [3:0] anode,
    output wire [6:0] cathode,
    output wire rdy
);
    wire one_hz_tick;
    wire [11:0] binary_count;
    wire [15:0] bcd_digits;
    reg convert_start;

    clock_enable_1hz clk_driver (
        .clk(clk),
        .reset(reset),
        .tick(one_hz_tick)
    );

    up_counter12 counter (
        .clk(clk),
        .reset(reset),
        .tick(one_hz_tick),
        .count(binary_count)
    );

    // Delay the conversion request by one clock, so it reads the new count.
    always @(posedge clk) begin
        if (reset)
            convert_start <= 1'b0;
        else
            convert_start <= one_hz_tick;
    end

    Bin2BCD converter (
        .clk(clk),
        .reset(reset),
        .en(convert_start),
        .bin_in(binary_count),
        .rdy(rdy),
        .bcd_out(bcd_digits)
    );

    multi_segment_driver display (
        .clk(clk),
        .reset(reset),
        .bcd_in(bcd_digits),
        .anode(anode),
        .cathode(cathode)
    );
endmodule
