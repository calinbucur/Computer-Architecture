////////////////////////////////////////CONTROL_PATH_MODULE///////////////////////////////////////////////////      
module control_path(input [6:0] opcode,
                    input control_sel,
                    output reg MemRead,MemtoReg,MemWrite,RegWrite,Branch,ALUSrc,
                    output reg [1:0] ALUop);
  
  always@(opcode or control_sel) begin
    if(control_sel == 0) begin
        case(opcode)
            7'b0000011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b11110000; //ld
            7'b0100011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b10001000; //sd
            7'b0110011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00100010; //R-format
            7'b0010011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b10100010; //I-format
            7'b1100011: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000101; //branch instructions
            default: {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000000;
        endcase
    end
    else begin
        {ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUop} <= 8'b00000000;
    end
  end
endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
