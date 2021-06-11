//IMONITOR FILE
//OMONITOR FILE


//==================IMONITOR=======================
class imonitor extends uvm_monitor;
`uvm_component_utils(imonitor)
seq_item req1;
virtual apb_intf imon_c_intf;
uvm_analysis_port#(seq_item)m_port;
uvm_analysis_port#(seq_item)cov_port;
  
function new(string name="imonitor",uvm_component parent);
super.new(name,parent);
`uvm_info("I_MONITOR","I_MONITOR",UVM_NONE);
endfunction
  
    function void connect_phase(uvm_phase phase);
    if(!uvm_config_db #(virtual apb_intf)::get(null,"","name",imon_c_intf))
    `uvm_fatal("obj not created","----");
    endfunction
  
        function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        req1=seq_item::type_id::create("req1",this);
        m_port=new("m_port",this);
	cov_port=new("analysis_port",this);
        endfunction
  
task run_phase(uvm_phase phase);
super.run_phase(phase);
  forever begin
  @(posedge imon_c_intf.PCLK);
    if(imon_c_intf.PENABLE==1 && imon_c_intf.PSELx==1 && imon_c_intf.PWRITE==1 && imon_c_intf.PREADY==1)
    begin
    req1.PADDR=imon_c_intf.PADDR;
    req1.PWDATA=imon_c_intf.PWDATA;
    `uvm_info("I_MONITOR",$sformatf("IMON_________PADDR=%0d,PWDATA=%0d,time=%0d",imon_c_intf.PADDR,imon_c_intf.PWDATA,$time),UVM_NONE);

    m_port.write(req1);
    cov_port.write(req1);
    end
  end
endtask
endclass
         

//==================OMONITOR CLASS============================

class omonitor extends uvm_monitor;
`uvm_component_utils(omonitor)
seq_item req1;
virtual apb_intf omon_c_intf;
uvm_analysis_port#(seq_item)s_o_port;
  
function new(string name="omonitor",uvm_component parent);
super.new(name,parent);
`uvm_info("O_MONITOR","O_MONITOR",UVM_NONE);
endfunction
  function void connect_phase(uvm_phase phase);
  if(!uvm_config_db #(virtual apb_intf)::get(this,"","name",omon_c_intf))
  `uvm_fatal("obj not created","----");
  endfunction
      function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      req1=seq_item::type_id::create("req1");
      s_o_port=new("s_o_port",this);
      endfunction
task run_phase(uvm_phase phase);
  forever begin
  @(posedge omon_c_intf.PCLK);
    if(omon_c_intf.PENABLE==1 && omon_c_intf.PSELx==1 && omon_c_intf.PWRITE==0 && omon_c_intf.PREADY==1)
    begin
    req1.PADDR=omon_c_intf.PADDR;

    req1.PRDATA=omon_c_intf.PRDATA;

    `uvm_info("O_MONITOR",$sformatf("OMON_____________________PADDR=%0d,PRDATA=%0d,time=%0d",omon_c_intf.PADDR,omon_c_intf.PRDATA,$time),UVM_NONE);

    s_o_port.write(req1);
    end
  end
endtask
endclass
