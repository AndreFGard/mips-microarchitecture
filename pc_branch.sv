module pc_branch(
  
  // juntou <<2 e pcbranch
  input [31:0] SignImm,
  input [31:0] PCplus4,
  output [31:0] result
);
  
  assign result = PCplus4 + SignImm*4; 
endmodule;
