class environment extends uvm_env;
`uvm_component_utils(environment)
  
m_agent h_magent;
s_agent h_s_agent;
scoreboard h_sb;
apb_cov cov;

  
  function new(string name="environment",uvm_component parent);
  super.new(name,parent);
  `uvm_info("ENVIRONMENT","ENVIRONMENT",UVM_NONE);
  endfunction
  
      function void build_phase(uvm_phase phase);
      h_magent = m_agent::type_id::create("h_magent",this);
      h_s_agent = s_agent::type_id::create("h_s_agent",this);
      h_sb = scoreboard::type_id::create("h_sb",this);
      cov = apb_cov#(seq_item)::type_id::create("cov",this);
      endfunction
  
          function void connect_phase(uvm_phase phase);
          super.connect_phase(phase);
          h_magent.a_port.connect(h_sb.sb_imp);
	  h_magent.a_port.connect(cov.analysis_export);
          h_s_agent.s_port.connect(h_sb.sb_omp);
          endfunction
  
  
endclass
