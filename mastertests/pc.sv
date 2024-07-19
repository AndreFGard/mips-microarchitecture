module ttB;
    //joins all the components of the computer
    parameter INSTRSIZE = 4;
    reg clk = 0;
  

    //CU wires
    reg PCSrcw = 0;

    // instruction are dealt withj here
    wire [INSTRSIZE:0] PCcommaw; wire [INSTRSIZE:0] PCBranchw; wire [INSTRSIZE:0] PCplus4w; wire [INSTRSIZE:0] PCw;
    wire [INSTRSIZE:0] SignImmw;
    pc_multiplexer pc_multiplexertb(PCplus4w, PCBranchw, PCSrcw, PCcommaw);
    pc pctb (PCcommaw, clk, PCw );
    pcplus4 pcplus4tb (PCw, PCplus4w);
    pc_branch pc_brancht (SignImmw, PCplus4w, PCBranchw);



    reg [31:0] Instrw;
    instruction_memory instruction_memorytb(PCw, Instrw);
  
  initial forever #5 clk = ~clk;
  
      always @(negedge clk) begin
    $display("PCw (curr): %d, plus4w %d, PCBranchw %d", PCw, PCplus4w, PCBranchw);
    end
  
  
  initial begin
    #70 $finish;
  end
  
endmodule
