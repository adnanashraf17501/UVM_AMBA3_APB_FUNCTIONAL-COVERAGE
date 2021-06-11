class m_sequencer extends uvm_sequencer #(seq_item);
`uvm_component_utils(m_sequencer)
  function new(string name="m_sequencer",uvm_component parent);
  super.new(name,parent);
    `uvm_info("SEQUENCER","_______________SEQUENCER_________________",UVM_NONE);
  endfunction
endclass
