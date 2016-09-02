# clear the console
clear

# create project library and make sure it is empty
alib work
adel -all

transcript file go2uvm_comp.log

# compile project's source file (alongside the UVM library)
alog $UVMCOMP -msg 0 -dbg -f flist.lv1      


# run simulation
asim +access +rw  $UVMSIM sprot_go2uvm +UVM_VERBOSITY=UVM_FULL
run -all
