module pc_src_mux (
  parameter INSIZE = 31;
  input PCSrc,
  input [INSIZE:0] PCPlus4,
  input [INSIZE:0] PCBranch,
  output [INSIZE:0] Result
);

 assign Result = PCSrc ? PCBranch : PCPlus4;
  
endmodule;
