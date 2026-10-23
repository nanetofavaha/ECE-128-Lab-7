## ECE 128 Lab 7 - Basys 3
## CLK = W5 (100 MHz), reset = center button (U18)
set_property -dict { PACKAGE_PIN W5 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin [get_ports clk]
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports reset]

## Seven segment outputs: cathode[0]=CA through cathode[6]=CG
set_property -dict { PACKAGE_PIN W7 IOSTANDARD LVCMOS33 } [get_ports {cathode[0]}]
set_property -dict { PACKAGE_PIN W6 IOSTANDARD LVCMOS33 } [get_ports {cathode[1]}]
set_property -dict { PACKAGE_PIN U8 IOSTANDARD LVCMOS33 } [get_ports {cathode[2]}]
set_property -dict { PACKAGE_PIN V8 IOSTANDARD LVCMOS33 } [get_ports {cathode[3]}]
set_property -dict { PACKAGE_PIN U5 IOSTANDARD LVCMOS33 } [get_ports {cathode[4]}]
set_property -dict { PACKAGE_PIN V5 IOSTANDARD LVCMOS33 } [get_ports {cathode[5]}]
set_property -dict { PACKAGE_PIN U7 IOSTANDARD LVCMOS33 } [get_ports {cathode[6]}]

## Active LOW anodes (rightmost to leftmost)
set_property -dict { PACKAGE_PIN U2 IOSTANDARD LVCMOS33 } [get_ports {anode[0]}]
set_property -dict { PACKAGE_PIN U4 IOSTANDARD LVCMOS33 } [get_ports {anode[1]}]
set_property -dict { PACKAGE_PIN V4 IOSTANDARD LVCMOS33 } [get_ports {anode[2]}]
set_property -dict { PACKAGE_PIN W4 IOSTANDARD LVCMOS33 } [get_ports {anode[3]}]

## One-clock-cycle ready pulse (optional output on LED0)
set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports rdy]
