clear
alib work
adel -all 
transcript file go2uvm_comp.log
alog -dbg $UVMCOMP -msg 0 -error_limit 1 -f flist
transcript file go2uvm_run.log
asim +access +rw $UVMSIM top +UVM_TESTNAME=sva_test +UVM_VERBOSITY=UVM_HIGH
run -all 
exit 
