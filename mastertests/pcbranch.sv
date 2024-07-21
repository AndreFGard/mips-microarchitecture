module ttB;
    //joins all the components of the computer
    parameter INSTRSIZE = 4;
    reg clk = 0;
  

    //CU wires
    reg PCSrcw = 0;

    // instruction are dealt withj here
    wire [INSTRSIZE:0] PCcommaw; wire [INSTRSIZE:0] PCBranchw; wire [INSTRSIZE:0] PCplus4w; wire [INSTRSIZE:0] PCw;
    reg [INSTRSIZE:0] SignImmw = 0;
    pc_mux pc_multiplexertb(PCplus4w, PCBranchw, PCSrcw, PCcommaw);
    pc pctb (PCcommaw, clk, PCw );
    pcplus4 pcplus4tb (PCw, PCplus4w);
    pc_branch pc_brancht (SignImmw, PCplus4w, PCBranchw);



    reg [31:0] Instrw;
    instruction_memory instruction_memorytb(PCw, Instrw);
  
  
  wire [5:0] opw;
  wire [4:0] A1w;
  wire [4:0] instr_20_16; wire [4:0] instr_15_11; wire [4:0] writeregw;
  wire regdstw;
  reg_dst_mux reg_dst_muxt(regdstw, instr_20_16, instr_15_11, writeregw);
  
  
  initial forever #5 clk = ~clk;
  
      always @(negedge clk) begin
    $display("PCw (curr): %d, plus4w %d, PCBranchw %d", PCw, PCplus4w, PCBranchw);
    end
  
  
  initial begin
    #70 $finish;
  end
  
endmodule
