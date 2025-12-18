set log file low_area_alu.log -replace
read library /home/student/22BEC1413/LEC/slow.v -verilog -both
read design /home/student/22BEC1413/WORK/Low_area_ALU.v -verilog -golden
read design /home/student/22BEC1413/synthesis/Low_area_ALU_netlist_dft.v -verilog -revised
add pin constraints 0 SE -revised
add ignored inputs scan_in -revised
add ignored outputs scan_out -revised
set system mode lec
add compare point -all
compare

report verification
set gui on

