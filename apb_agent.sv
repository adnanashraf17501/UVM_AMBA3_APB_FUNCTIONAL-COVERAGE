//M_AGENT FILE
//S_AGENT FILE

class m_agent extends uvm_agent;
`uvm_component_utils(m_agent)

//==============================
uvm_analysis_port#(seq_item) a_port;
m_sequencer h_sequencer;
m_driver h_drv;
imonitor h_imonitor;
  
  function new(string name="m_agent",uvm_component parent);
  super.new(name,parent);
  `uvm_info("M_AGENT","M_AGENT",UVM_NONE);
  endfunction
  
  		
        function void build_phase(uvm_phase phase);
        h_sequencer = m_sequencer::type_id::create("h_sequencer",this);
        h_drv = m_driver::type_id::create("h_drv",this);
        h_imonitor = imonitor::type_id::create("h_imonitor",this);
        a_port=new("a_port",this);
        endfunction
  
  
  function void connect_phase(uvm_phase phase);
  h_drv.seq_item_port.connect(h_sequencer.seq_item_export);
  h_imonitor.m_port.connect(a_port);
  endfunction
  
  
endclass

//===================S_AGENT CLASS=================================

class s_agent extends uvm_agent;
`uvm_component_utils(s_agent)
uvm_analysis_port#(seq_item) s_port;

omonitor h_omonitor;

  function new(string name="s_agent",uvm_component parent);
  super.new(name,parent);
  `uvm_info("S_AGENT","S_AGENT",UVM_NONE);
  endfunction
  
    function void build_phase(uvm_phase phase);
    h_omonitor = omonitor::type_id::create("h_omonitor",this);
    s_port=new("s_port",this);
    endfunction
  
  function void connect_phase(uvm_phase phase);
  h_omonitor.s_o_port.connect(s_port);
  endfunction
  
endclass