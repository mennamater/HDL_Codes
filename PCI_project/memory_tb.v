`timescale 1ns / 1ps



module memory_tb();

reg   [3:0]         BE;
reg 			        Mem_WE;
reg   [3:0]         ADDR_M;
reg   [31:0]        IN_DATA_M;
wire  [31:0]        OUT_DATA_M;

memory uut (
.BE(BE),
.ADDR_M(ADDR_M),
 .Mem_WE(Mem_WE),
  .IN_DATA_M(IN_DATA_M),
   .OUT_DATA_M(OUT_DATA_M)
);
    integer i;
    initial begin 
    
        for ( i=0 ; i < 16  ; i=i+1 ) begin
            Mem_WE=1'b1;
            ADDR_M=i;
            IN_DATA_M={0,i};
            #10;
         end 
        for ( i=0 ; i < 16  ; i=i+1 ) begin
          Mem_WE=1'b0;
          ADDR_M=i;
            #10;
        end  
          
      
    end 
    
endmodule
