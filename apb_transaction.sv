class seq_item extends uvm_sequence_item;
`uvm_object_utils(seq_item)
  rand bit PCLK;
  rand bit PRESETn;
  rand bit PENABLE;
  rand bit PWRITE;
  rand bit PSELx;
  rand bit[31:0] PADDR;
  bit[31:0] PRDATA;
  rand bit[31:0] PWDATA;
  
constraint addr{
PADDR inside {[0:50]};
}
constraint data{
PWDATA inside {[0:100]};
}
  constraint con{
  soft PCLK==0;
  soft PRESETn==0;
  soft PENABLE==0;
  soft PWRITE==0;
  soft PSELx==0;
  }
function new(string name="seq_item");
super.new(name);
  `uvm_info("SEQ_ITEM","_______________SEQ_ITEM_________________",UVM_NONE);
endfunction
endclass