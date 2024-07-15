module tb_ALU_decoder;
    //also work as a  tb_ALU
    // Inputs
    reg [1:0] aluop;
    reg [5:0] funct;
    
    // Outputs
    wire [2:0] aluControl;

    // Instantiate the ALU_decoder
    ALU_decoder uut (
        .aluop(aluop),
        .funct(funct),
        .aluControl(aluControl)
    );

    reg [31:0] a = 54;
    reg [31:0] b = 23;
    reg zero;
    reg [31:0] aluresult;
    ALU ttb_alu (aluControl,a,b,zero,aluresult);

    parameter ADD = 3'b010;
    parameter SUBT = 3'b110;
    parameter AND = 3'b000;
    parameter OR = 3'b001;
    parameter SETLESSTHAN = 3'b111;


    initial begin

        aluop = 2'b00; funct = 6'b000000; #10;  // ADD (default)
        $display("ADD: aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        $display("a, %d b  %d= %d", a,b,aluresult);
        
        aluop = 2'b01; funct = 6'b000000; #10;  // SUBT (default)
        $display("SUBT aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        $display("a, %d b  %d= %d", a,b,aluresult);
                
        aluop = 2'b10; funct = 6'b100000; #10;  // ADD
        $display("ADDf aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        $display("a, %d b  %d= %d", a,b,aluresult);
                
        aluop = 2'b10; funct = 6'b100010; #10;  // SUBT
        $display("SUBTf aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        $display("a, %d b  %d= %d", a,b,aluresult);
                
        aluop = 2'b10; funct = 6'b100100; #10;  // AND
        $display("ANDf aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        $display("a, %d b  %d= %d", a,b,aluresult);
                
        aluop = 2'b10; funct = 6'b100101; #10;  // OR
        $display("ORf aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        $display("a, %d b  %d= %d", a,b,aluresult);
               
        aluop = 2'b10; funct = 6'b101010; #10;  // SETLESSTHAN
        $display("SLTf aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        $display("a%d, b  %d= %d", a,b,aluresult);
        
        a = 23; b = 34;
        aluop = 2'b10; funct = 6'b101010; #10;  // SETLESSTHAN
        
        $display("SLTf aluop: %b, funct: %b, aluControl: %b", aluop, funct, aluControl);
        $display("a%d, b  %d= %d", a,b,aluresult);
                
        $stop;  
    end
endmodule