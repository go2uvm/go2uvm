class sprot_rand_test extends sprot_base_test;

  `uvm_component_utils(sprot_rand_test)

  sprot_rand_seq sprot_rand_seq_0;

  extern virtual task main_phase(uvm_phase phase);

  function new(string name, uvm_component parent = null);
    super.new(.name(name), .parent(parent));
  endfunction : new

endclass : sprot_rand_test 


task sprot_rand_test::main_phase(uvm_phase phase);
  phase.raise_objection(this);
  `uvm_info(get_name(),"Test is running...",UVM_MEDIUM)

  sprot_rand_seq_0 = sprot_rand_seq::type_id::create(.name("sprot_rand_seq_0"),
                                            .parent(this));
  this.sprot_rand_seq_0.start(sprot_env_0.sprot_agent_0.sprot_sequencer_0);

  `uvm_info(get_name(),"End of main phase in test ",UVM_MEDIUM)
  phase.drop_objection(this);

endtask : main_phase
