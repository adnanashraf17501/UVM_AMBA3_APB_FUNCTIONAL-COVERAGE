module apb(input PCLK, PRESETn, PENABLE, PWRITE, PSELx, input[31:0]
PADDR,PWDATA, output reg[31:0] PRDATA, output reg PREADY, PSLVERR);
int mem[int]; //Associative memory
//Logic for Writing PWDATA into PADDR location of the memory.
always @(posedge PCLK)
begin
if(!PRESETn)
begin
foreach(mem[i])
begin
mem.delete(i);
end
end
else if(PSELx && PENABLE && PWRITE)
begin
mem[PADDR]=PWDATA;
end
end
//Logic for reading the memory contents as per the given PADDR and driving that data on to
//PRDATA line.
always @(posedge PCLK)
begin
if(!PRESETn)
begin
PRDATA<=32'd0;
end
else if(PSELx && PENABLE && !PWRITE)
begin
PRDATA<=mem[PADDR];
end
end
//Logic for PREADY(This RTL offers one cycle wait state response)// Included By 1 state Cycle Response 
 always @(posedge PCLK or negedge PRESETn)
 begin
 if (PRESETn == 0)
 PREADY <= 1'b0;
 else
 PREADY <= PSELx & PENABLE & ~PREADY;
 end
//PSLVERR not included By Adnan Ashraf . So it is connected to logic 0.
assign PSLVERR=0;
endmodule