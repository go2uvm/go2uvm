# clear the console
clear

# create project library and make sure it is empty
alib work
adel -all

transcript  file sprot_rvra_comp.log

# compile project's source file (using the UVM library)
alog -dbg $UVMCOMP -msg 0 -error_limit 1 -f flist_uvm

transcript  file sprot_rvra_run.log

# run simulation
asim +access +rw $UVMSIM sprot_tb_dut_top +UVM_TESTNAME=sprot_rand_test +UVM_VERBOSITY=UVM_HIGH
wave -rec sim:/sprot_tb_dut_top/* 
run -all
fcover report -html
exit
