`timescale 1ns / 1ps

// 12-bit binary -> four BCD digits, using double dabble.
// Pulse en for one clock to start; rdy pulses for one clock on completion.
module Bin2BCD (
    input wire clk,
    input wire reset,
    input wire en,
    input wire [11:0] bin_in,
    output reg rdy,
    output reg [15:0] bcd_out
);
    parameter IDLE = 2'd0,
              SHIFT = 2'd1,
              DONE = 2'd2;

    reg [1:0] state;
    reg [3:0] shift_index;
    reg [27:0] shift_reg;
    reg [27:0] adjusted;

    // Check all four BCD digits independently before each shift.
    always @(*) begin
        adjusted = shift_reg;
        if (adjusted[15:12] > 4'd4) begin
            adjusted[15:12] = adjusted[15:12] + 4'd3;
        end
        if (adjusted[19:16] > 4'd4) begin
            adjusted[19:16] = adjusted[19:16] + 4'd3;
        end
        if (adjusted[23:20] > 4'd4) begin
            adjusted[23:20] = adjusted[23:20] + 4'd3;
        end
        if (adjusted[27:24] > 4'd4) begin
            adjusted[27:24] = adjusted[27:24] + 4'd3;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_index <= 4'd0;
            shift_reg <= 28'd0;
            bcd_out <= 16'd0;
            rdy <= 1'b0;
        end else begin
            rdy <= 1'b0;
            case (state)
                IDLE: begin
                    if (en) begin
                        shift_reg <= {16'd0, bin_in};
                        shift_index <= 4'd0;
                        state <= SHIFT;
                    end
                end
                SHIFT: begin
                    shift_reg <= adjusted << 1;
                    if (shift_index == 4'd11)
                        state <= DONE;
                    else
                        shift_index <= shift_index + 1'b1;
                end
                DONE: begin
                    bcd_out <= shift_reg[27:12];
                    rdy <= 1'b1;
                    state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule
