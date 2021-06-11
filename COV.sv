class apb_cov #(type T=seq_item) extends uvm_subscriber #(T);
`uvm_component_utils(apb_cov)
T pkt;
real cov;

covergroup ApbCov;	
   ADDR: coverpoint pkt.PADDR {
    bins l    = {[0:20]};
    bins m    = {[21:30]};
    //bins h   = {[31:40]};
  }
  PWDATA: coverpoint  pkt.PWDATA {
    bins l    = {[0:10]};
    bins m    = {[11:50]};
    bins h   = {[51:93]};
  }
  WRITE: coverpoint pkt.PWRITE{
	  bins l = {0};
  	  bins h = {1};
  }
  ENABLE: coverpoint pkt.PENABLE{
	  bins l = {1};
  	  bins h = {0};
  }
 /* READY: coverpoint pkt.PREADY{
	  bins l = {1};
  	  bins h = {0};
  }*/
  PRDATA: coverpoint pkt.PRDATA {
  	  bins a = {[0:63]};
  }
  /*
  DATA_X_WRITE:cross WRITE,ENABLE{
	  bins valid = (binsof(WRITE.h)&&binsof(ENABLE.h));
          ignore_bins invalid = binsof(WRITE.l);
	  ignore_bins invalid1 = (binsof(WRITE.h)&&binsof(ENABLE.l));
	  ignore_bins invalid2 = (binsof(WRITE.h)&&binsof(ENABLE.h));
	  ignore_bins invalid3 = (binsof(WRITE.h)&&binsof(ENABLE.l));
	}
  RDATA_X_WRITE:cross WRITE,ENABLE{
  	 bins valid = (binsof(WRITE.l)&&binsof(ENABLE.h));
          ignore_bins invalid = binsof(WRITE.h);
	  ignore_bins invalid1 = (binsof(WRITE.l)&&binsof(ENABLE.l));
	  ignore_bins invalid2 = (binsof(WRITE.l)&&binsof(ENABLE.h));
	  ignore_bins invalid3 = (binsof(WRITE.l)&&binsof(ENABLE.l));
  }*/

endgroup

function new (string name = "apb_cov", uvm_component parent);
      super.new (name, parent);
	  ApbCov = new;
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	//pkt=dram_seq_item::type_id::create("pkt");
    //CovPort = new("CovPort",this);
endfunction
	  
virtual function void write (T t);
//	`uvm_info("SEQ","SEQUENCE TRANSACTIONS",UVM_NONE);
	pkt = t;
	ApbCov.sample();
endfunction
function void extract_phase(uvm_phase phase);
             cov = ApbCov.get_coverage();
endfunction	

function void report_phase(uvm_phase phase);
 `uvm_info(get_type_name(), $sformatf("Coverage is: %f", cov), UVM_MEDIUM)
endfunction

endclass
