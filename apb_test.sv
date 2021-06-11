
class test extends uvm_test;
`uvm_component_utils(test)
sequence1 h_seq;
environment h_env;
  
  function new(string name="test",uvm_component parent);
  super.new(name,parent);
  `uvm_info("TEST","TEST",UVM_NONE);
  endfunction
  
      function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      h_env = environment::type_id::create("h_env",this);
      h_seq=sequence1::type_id::create("h_seq");
      endfunction
  
          task run_phase(uvm_phase phase);
          phase.raise_objection(this,"raise objection");
          h_seq.start(h_env.h_magent.h_sequencer);
          #400;
          phase.drop_objection(this,"drop objection");
          endtask
  
                function void start_of_simulation_phase(uvm_phase phase);
                uvm_top.print_topology();
                endfunction
endclass
