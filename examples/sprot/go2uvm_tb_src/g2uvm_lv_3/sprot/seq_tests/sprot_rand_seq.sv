class sprot_rand_seq extends uvm_sequence #(sprot_xactn);

  `uvm_object_utils(sprot_rand_seq)

  function new(string name = "sprot_rand_seq");
    super.new(name);
  endfunction : new

  extern virtual task body();

endclass : sprot_rand_seq


task sprot_rand_seq::body();
  `uvm_info(get_name(),$sformatf(":Sequence is Running ...."),UVM_MEDIUM)

 
  `uvm_info(get_name(),$sformatf(":Sequence is Complete ...."),UVM_MEDIUM)
endtask : body
