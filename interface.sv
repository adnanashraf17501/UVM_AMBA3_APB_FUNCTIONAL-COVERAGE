interface apb_intf(input PCLK);
bit PRESETn;
bit PENABLE;
bit PWRITE;
logic PSELx;
bit [31:0] PADDR;
bit [31:0] PWDATA;
bit [31:0] PRDATA;
logic PREADY;
logic PSLVERR;
  
clocking cb_mon@(posedge PCLK);
input PCLK;
input PRESETn;
input PENABLE;
input PWRITE;
input PSELx;
input PADDR;
input PWDATA;
input PRDATA;
input PREADY;
input PSLVERR;
endclocking
property reset;
@(posedge PCLK)
(!PRESETn)|-> (PWDATA==0 && PRDATA==0);
endproperty
assert property(reset);
property p1;
@(posedge PCLK)
$rose(PWRITE) |-> $rose(PSELx) |=> $rose(PENABLE);
endproperty
assert property(p1);
endinterface

