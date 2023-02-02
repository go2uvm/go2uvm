clear
alib work
adel -all 
transcript file go2uvm_comp.log
set VW_GO2UVM_HOME /home/srini/proj/git_GO2UVM/g2u_jan2013
alog -dbg $UVMCOMP -msg 0 -error_limit 1 -f flist
transcript file go2uvm_run.log
asim +access +rw $UVMSIM vw_go2uvm_sim_utils apb2_master_tb_dut_top +UVM_TESTNAME=apb2_master_rand_test +UVM_VERBOSITY=UVM_HIGH
run -all 
exit 
