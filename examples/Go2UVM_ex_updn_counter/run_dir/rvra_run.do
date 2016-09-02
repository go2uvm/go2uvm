# clear the console
clear

# create project library and make sure it is empty
alib work
adel -all


# compile project's source file (alongside the UVM library)
alog $UVMCOMP -msg 0 -dbg -f flist      

transcript file up_down_uvm.log

# run simulation
asim +access +rw  $UVMSIM go2uvm_count +UVM_VERBOSITY=UVM_FULL
wave -rec sim:/go2uvm_count/* 
run -all
