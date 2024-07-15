module pc_branch(
  
  // juntou <<2 e pcbranch
  input [4:0] SignImm,
  input [4:0] PCplus4,
  output [4:0] result
);
  
  assign result = PCplus4 + SignImm*4; 
endmodule;
