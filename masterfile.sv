module ttB;
    //joins all the components of the computer
    parameter INSTRSIZE = 4;
    reg clk;
  

    //CU wires
    wire PCSrcw;

    // instruction are dealt withj here
    wire [INSTRSIZE:0] PCcommaw; wire [INSTRSIZE:0] PCBranchw; wire [INSTRSIZE:0] PCplus4w; wire [INSTRSIZE:0] PCw;
    wire [INSTRSIZE:0] SignImmw;
    pc_multiplexer pc_multiplexertb(PCplus4w, PCBranchw, PCSrcw, PCcommaw);
    pc pctb (PCcommaw, clk, PCw );
    pcplus4 pcplus4tb (PCw, PCplus4w);
    pc_branch(SignImmw, PCplus4w, PCBranchw);



    reg [31:0] Instrw;
    instruction_memory instruction_memorytb(PCw, Instrw);
endmodule