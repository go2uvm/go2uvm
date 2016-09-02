class sprot_base_test extends uvm_test;

  sprot_env sprot_env_0;

  `uvm_component_utils(sprot_base_test)

  function new(string name, uvm_component parent);
    super.new(.name(name), .parent(parent));
  endfunction : new

  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task main_phase (uvm_phase phase);

endclass : sprot_base_test


function void sprot_base_test::build_phase(uvm_phase phase);
  super.build_phase(.phase(phase));
  sprot_env_0 = sprot_env::type_id::create(.name("sprot_env"),
				   .parent(this));
endfunction : build_phase


function void sprot_base_test::connect_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction : connect_phase


task sprot_base_test::main_phase(uvm_phase phase);
  phase.raise_objection(this);
  `uvm_info(get_name(),"Test is running...",UVM_MEDIUM)
  #1000; 
  //delay is simple "end of test" mechanism
  //use objections in sequences for better "end of test" detection
  `uvm_info(get_name(), "End of main phase",UVM_MEDIUM)
  phase.drop_objection(this);
endtask : main_phase
