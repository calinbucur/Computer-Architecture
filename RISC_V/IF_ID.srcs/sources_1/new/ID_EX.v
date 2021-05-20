
module ID_EX(
    input clk, reset,
    input [31:0] PC_ID,          //adresa PC a instructiunii din etapa ID
    input [31:0] INSTRUCTION_ID, //instructiunea curenta in etapa ID
    input [31:0] IMM_ID,         //valoarea calculata
    input [31:0] REG_DATA1_ID,   //valoarea primului registru sursa citit
    input [31:0] REG_DATA2_ID,   //valoarea celui de-al doilea registru sursa citi               
    input [2:0] FUNCT3_ID,  //funct3 din codificarea instructiunii
    input [6:0] FUNCT7_ID,  //funct7 din codificarea instructiunii
    input [6:0] OPCODE_ID,     //opcode-ul instructiunii
    input [4:0] RD_ID,      //registru destinatie
    input [4:0] RS1_ID,     //registru sursa1
    input [4:0] RS2_ID,
    input [1:0] WB_ID,
    input [2:0] M_ID,
    input [2:0] EX_ID,
    output reg [31:0] PC_EX,          //adresa PC a instructiunii din etapa ID
    output reg [31:0] INSTRUCTION_EX, //instructiunea curenta in etapa ID
    output reg [31:0] IMM_EX,         //valoarea calculata
    output reg [31:0] REG_DATA1_EX,   //valoarea primului registru sursa citit
    output reg [31:0] REG_DATA2_EX,   //valoarea celui de-al doilea registru sursa citit                
    output reg [2:0] FUNCT3_EX,  //funct3 din codificarea instructiunii
    output reg [6:0] FUNCT7_EX,  //funct7 din codificarea instructiunii
    output reg [6:0] OPCODE_EX,     //opcode-ul instructiunii
    output reg [4:0] RD_EX,      //registru destinatie
    output reg [4:0] RS1_EX,     //registru sursa1
    output reg [4:0] RS2_EX,   //registru sursa2     //registru sursa2
    output reg [1:0] WB_EX, 
    output reg [2:0] M_EX,
    output reg [2:0] EX_EX 
    );
    
    always @(posedge clk) begin
        if(reset) begin
            PC_EX = 0;          //adresa PC a instructiunii din etapa ID
            INSTRUCTION_EX = 0; //instructiunea curenta in etapa ID
            IMM_EX = 0;         //valoarea calculata
            REG_DATA1_EX = 0;   //valoarea primului registru sursa citit
            REG_DATA2_EX = 0;   //valoarea celui de-al doilea registru sursa citit                
            FUNCT3_EX = 0;  //funct3 din codificarea instructiunii
            FUNCT7_EX = 0;  //funct7 din codificarea instructiunii
            OPCODE_EX = 0;     //opcode-ul instructiunii
            RD_EX = 0;      //registru destinatie
            RS1_EX = 0;     //registru sursa1
            RS2_EX = 0;   //registru sursa2     //registru sursa2
            WB_EX = 0;
            M_EX = 0;
            EX_EX = 0;
        end
        else begin
            PC_EX = PC_ID;          //adresa PC a instructiunii din etapa ID
            INSTRUCTION_EX = INSTRUCTION_ID; //instructiunea curenta in etapa ID
            IMM_EX = IMM_ID;         //valoarea calculata
            REG_DATA1_EX = REG_DATA1_ID;   //valoarea primului registru sursa citit
            REG_DATA2_EX = REG_DATA2_ID;   //valoarea celui de-al doilea registru sursa citit                
            FUNCT3_EX = FUNCT3_ID;  //funct3 din codificarea instructiunii
            FUNCT7_EX = FUNCT7_ID;  //funct7 din codificarea instructiunii
            OPCODE_EX = OPCODE_ID;     //opcode-ul instructiunii
            RD_EX = RD_ID;      //registru destinatie
            RS1_EX = RS1_ID;     //registru sursa1
            RS2_EX = RS2_ID;   //registru sursa2     //registru sursa2
            WB_EX = WB_ID;
            M_EX = M_ID;
            EX_EX = EX_ID;
        end
    end
endmodule
