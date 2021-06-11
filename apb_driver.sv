class m_driver extends uvm_driver #(seq_item);
`uvm_component_utils(m_driver)
virtual apb_intf drv_c_intf;
        function new(string name="m_driver",uvm_component parent);
        super.new(name,parent);
        endfunction
  			  //=========CONNECT_PHASE===========
              function void connect_phase(uvm_phase phase);
              if(!uvm_config_db #(virtual apb_intf)::get(null,"","name",drv_c_intf))
              `uvm_fatal("obj not created","----");
              endfunction
  
//==========TASK FOR RESET==================
  task drv_rst;
  drv_c_intf.PRESETn<=1;
  @(posedge drv_c_intf.PCLK);
  drv_c_intf.PRESETn<=0;
  @(posedge drv_c_intf.PCLK);
  drv_c_intf.PRESETn<=1;
  endtask
//==============RUN_PHASE==================
    task run_phase(uvm_phase phase);
      drv_rst();
      forever
          begin
          seq_item_port.get_next_item(req);

           `uvm_info("DRIVER","_______________ENTERED_IN_TO_GET_NEXT_ITEM_________________",UVM_NONE);

          drv_c_intf.PENABLE<=0;
          drv_c_intf.PSELx<=0;
          @(posedge drv_c_intf.PCLK);
          drv_c_intf.PADDR<=req.PADDR;
          drv_c_intf.PWRITE<=req.PWRITE;
          drv_c_intf.PWDATA<=req.PWDATA;
          drv_c_intf.PSELx<=1;
          @(posedge drv_c_intf.PCLK);
          drv_c_intf.PENABLE<=1;
          wait(drv_c_intf.PREADY)
          @(posedge drv_c_intf.PCLK);
          drv_c_intf.PENABLE<=0;
          drv_c_intf.PSELx<=0;
             `uvm_info("DRIVER","_______________WAITING_FOR_ITEM_DONE_________________",UVM_NONE);

          seq_item_port.item_done();
           `uvm_info("DRIVER","_______________ITEM_DONE_________________",UVM_NONE);

          end
    endtask
endclass
