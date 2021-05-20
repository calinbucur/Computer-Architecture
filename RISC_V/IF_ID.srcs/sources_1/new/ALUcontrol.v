//////////////////////////////////////////ALU_CONTROL_MODULE/////////////////////////////////////////////////
module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);
    
    always @(ALUop or funct7 or funct3) begin
        casex ({ALUop, funct7, funct3})
            12'b100000000000: ALUinput <= 4'b0010; //add
            12'b100100000000: ALUinput <= 4'b0110; //sub
            12'b100000000111: ALUinput <= 4'b0000; //and
            12'b100000000110: ALUinput <= 4'b0001; //or
            12'b100000000100: ALUinput <= 4'b0011; //xor
            12'b100000000101: ALUinput <= 4'b0101; //srl, srli
            12'b100000000001: ALUinput <= 4'b0100; //sll, slli
            12'b100100000101: ALUinput <= 4'b1001; //sra, srai
            12'b100000000011: ALUinput <= 4'b0111; //sltu
            12'b100000000010: ALUinput <= 4'b1000; //slt
        endcase
        casex ({ALUop, funct3})
            5'b00010: ALUinput <= 4'b0010; //ld, sd
            5'b01000: ALUinput <= 4'b0110; //beq
            5'b01001: ALUinput <= 4'b0110; //bne
            5'b01100: ALUinput <= 4'b1000; //blt
            5'b01101: ALUinput <= 4'b1000; //bge
            5'b01110: ALUinput <= 4'b0111; //bltu
            5'b01111: ALUinput <= 4'b0111; //bgeu
        endcase
    end
endmodule
