# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Wed Dec 17 17:21:47 IST 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design Low_area_ALU

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clk]
set_clock_transition 0.1 [get_clocks clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {A[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {A[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {A[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {A[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {A[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {A[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {A[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {A[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {B[7]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {B[6]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {B[5]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {B[4]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {B[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {B[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {B[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {B[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {opt[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {opt[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {opt[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports load]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports rst]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {Dout[7]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {Dout[6]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {Dout[5]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {Dout[4]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {Dout[3]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {Dout[2]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {Dout[1]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {Dout[0]}]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports done]
set_wire_load_mode "enclosed"
set_clock_uncertainty -setup 0.01 [get_ports clk]
set_clock_uncertainty -hold 0.01 [get_ports clk]
