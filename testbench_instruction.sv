/////////////// PCPLUS4 tb
module ttb;
  reg [4:0] last_instr = 0;
  wire [4:0] next_instr;
pcplus4 pcp4 (last_instr, next_instr);

initial begin 
	
    #5 last_instr = last_instr +7;
end

  
  initial forever begin
  	#5 $display("last %d mext %d", last_instr, next_instr);
  end
  
  
  initial begin
    #70 $finish;
  end
endmodule

///////// pc_multiplexer
module ttb;
  reg [3:0] last_instr = 5;
  reg [3:0] branch = 9;
  reg usebranch = 0;
  wire [3:0] next_instr;
  pc_multiplexer pcp4 (last_instr, branch, usebranch, next_instr);

initial begin 
	
    #5 usebranch = 0;
   #5 usebranch = 1;
end

  
  initial forever begin
  	#5 $display("last %d mext %d", last_instr, next_instr);
  end
  
  
  initial begin
    #70 $finish;
  end
endmodule