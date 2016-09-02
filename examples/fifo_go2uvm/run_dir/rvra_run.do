#clear the console
clear

# create project library and make sure it is empty
alib work
adel -all

# compile project's source file (alongside the UVM library)
alog $UVMCOMP -msg 0 -dbg -f go2uvm_flist

#transcript file go2uvm_fifo_comp.log

# run simulation
asim +access +rw  $UVMSIM go2uvm_fifo +UVM_VERBOSITY=UVM_FULL
wave -rec sim:/go2uvm_fifo/* 
run -all
