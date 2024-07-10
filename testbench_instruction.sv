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
  reg [4:0] last_instr = 5;
  reg [4:0] branch = 9;
  reg usebranch = 0;
  wire [4:0] next_instr;
  reg [4:0] next_next_instr;
  reg clk = 0;
  pc_multiplexer pcp4 (last_instr, branch, usebranch, next_instr);
  pc papapapa (next_instr, clk, next_next_instr);

  initial forever #5 clk = ~clk;
initial begin 
	
    #5 usebranch = 0;
    #5 usebranch = 1;
end

  
  initial forever begin
    #5 $display("last %d mext %d pc_instr %d", last_instr, next_instr, next_next_instr);
  end
  
  
  initial begin
    #70 $finish;
  end
endmodule

////////// ALU arithmetic logic unit
module ttb;
  reg clk = 0;
  
  reg [31:0] a = 30;
  reg [31:0] b = 21;
  reg [31:0] result;
  reg [1:0] aluop;
  
  ALU ar(a,b,aluop,result);
  initial forever #5 clk = ~clk;
initial begin 
	
    #5 aluop = 2'b00;
    #5 aluop = 2'b01;
end

 
  initial forever begin
    #5 $display("a %d b %d resul %d", a, b, result);
  end
  
 
  initial begin
    #70 $finish;
  end
endmodule