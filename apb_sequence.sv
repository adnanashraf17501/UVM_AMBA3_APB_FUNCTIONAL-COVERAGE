
class sequence1 extends uvm_sequence #(seq_item);
`uvm_object_utils(sequence1)
  function new(string name="sequence1");
  super.new(name);
    `uvm_info("SEQUENCE","_______________SEQUENCE_________________",UVM_NONE);

  endfunction
task body();
  req=seq_item::type_id::create("req");
  
  //WRITE OPERATION
  start_item(req);
  `uvm_info("SEQUENCE","_______________ENTERED_IN_TO_START_ITEM_________________",UVM_NONE);

  assert(req.randomize()with { PWRITE==1;PADDR==10;PWDATA==20;});
  
  `uvm_info("SEQUENCE","______________WAITING_FOR_FINISH_ITEM_________________",UVM_NONE);

  finish_item(req);
  `uvm_info("SEQUENCE","_______________FINISH_ITEM_________________",UVM_NONE);

  start_item(req);
  assert(req.randomize()with { PWRITE==1;PADDR==20;PWDATA==90;});
  finish_item(req);
  start_item(req);
  assert(req.randomize()with { PWRITE==1;PADDR==30;PWDATA==90;});
  finish_item(req);
  start_item(req);
  assert(req.randomize()with { PWRITE==1;PADDR==40;PWDATA==10;});
  finish_item(req);
  
  
  //READ OPERATION
  
  start_item(req);
  assert(req.randomize()with { PWRITE==0;PADDR==10;});
  finish_item(req);
  start_item(req);
  assert(req.randomize()with { PWRITE==0;PADDR==20;});
  finish_item(req);
  start_item(req);
  assert(req.randomize()with { PWRITE==0;PADDR==30;});
  finish_item(req);
  start_item(req);
  assert(req.randomize()with { PWRITE==0;PADDR==40;});
  finish_item(req);
 
endtask
endclass