`timescale 1ns / 1ps

module lab7_top_tb;
    reg clk;
    reg reset;
    wire [3:0] anode;
    wire [6:0] cathode;
    wire rdy;

    lab7_top uut (
        .clk(clk),
        .reset(reset),
        .anode(anode),
        .cathode(cathode),
        .rdy(rdy)
    );

    // Use smaller counts only in simulation so results appear quickly.
    // These settings do not change the FPGA's clock or board settings.
    defparam uut.clk_driver.CLK_HZ = 40;
    defparam uut.display.ag.REFRESH_DIV = 4;

    // A 10 ns clock period represents the board's 100 MHz clock.
    initial begin
        clk = 0;
    end

    always #5 clk = ~clk;

    initial begin
        reset = 1;
        #22;
        reset = 0;

        // Run long enough to see counts 1 through 5.
        #2200;
        $finish;
    end
endmodule
