class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
`uvm_analysis_imp_decl(_omon)
uvm_analysis_imp#(seq_item,scoreboard) sb_imp;
uvm_analysis_imp_omon#(seq_item,scoreboard) sb_omp;
  
int imon_array[int];
int omon_array[int];
int addr;
  
function new(string name="scoreboard",uvm_component parent);
super.new(name,parent);
`uvm_info("scoreboard","_______________scoreboard_________________",UVM_NONE);
endfunction
  
  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  sb_imp=new("sb_imp",this);
  sb_omp=new("sb_omp",this);
  endfunction
  
function void write(seq_item h_seq);
`uvm_info("SCOREBOARD",$sformatf("imon_____________________addr=%0d,data= %0d",h_seq.PADDR,h_seq.PWDATA),UVM_NONE);
 addr=h_seq.PADDR;
 imon_array[addr]=h_seq.PWDATA;
`uvm_info("scoreboard",$sformatf("_________ARRAY OF imon___________imon_array=%p",imon_array),UVM_NONE);
endfunction
  
    function void write_omon(seq_item h_seq_omon);
    `uvm_info("SCOREBOARD",$sformatf(" omon________________________addr=%0d,data=%0d",h_seq_omon.PADDR,h_seq_omon.PRDATA),UVM_NONE);
    addr=h_seq_omon.PADDR;
    omon_array[addr]=h_seq_omon.PRDATA;
    `uvm_info("scoreboard",$sformatf("_________ARRAY OF omon___________omon_array=%p",omon_array),UVM_NONE);
    endfunction
  
  function void check_phase(uvm_phase phase);
  super.check_phase(phase);
      foreach(imon_array[i])
    begin
      if(imon_array[i]==omon_array[i])
      begin
        `uvm_info("SCOREBOARD*******PASS*******",$sformatf("imon_array=%0p,omon_array=%0p",imon_array[i],omon_array[i]),UVM_NONE)
      end
    else
      `uvm_info("SCOREBOARD*******FAIL*******",$sformatf("imon_array=%0p,omon_array=%0p",imon_array[i],omon_array[i]),UVM_NONE)
    end
  endfunction
  

endclass