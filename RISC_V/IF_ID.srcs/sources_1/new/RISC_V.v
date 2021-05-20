//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
module RISC_V(input clk,
              input reset,
          
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall
             );

wire IF_ID_write;       //semnal de scriere pentru registrul de pipeline IF_ID
wire PC_write;    //semnale de control pentru PC
wire [31:0] PC_Branch;  //PC-ul calculat in etapa EX pentru instructiunile de salt
wire RegWrite_WB;       //semnal de activare a scrierii in bancul de registri
wire [31:0] ALU_DATA_W;//rezultatul calculat de ALU
wire [4:0] RD_WB;       //registrul rezultat in care se face scrierea
wire [31:0] PC_ID;          //adresa PC a instructiunii din etapa ID
wire [31:0] INSTRUCTION_ID; //instructiunea curenta in etapa ID
wire [31:0] IMM_ID;         //valoarea calculata
wire [31:0] REG_DATA1_ID;   //valoarea primului registru sursa citit
wire [31:0] REG_DATA2_ID;   //valoarea celui de-al doilea registru sursa citit
wire [2:0] FUNCT3_ID;  //funct3 din codificarea instructiunii
wire [6:0] FUNCT7_ID;  //funct7 din codificarea instructiunii
wire [6:0] OPCODE_ID;     //opcode-ul instructiunii
wire [4:0] RD_ID;      //registru destinatie
wire [4:0] RS1_ID;     //registru sursa1
wire [4:0] RS2_ID;    //registru sursa2 

RISC_V_IF_ID ifid(clk,   //semnalul de ceas global
                  reset,
                  IF_ID_write,       //semnal de scriere pentru registrul de pipeline IF_ID
                  PCSrc,PC_write,    //semnale de control pentru PC
                  PC_Branch,  //PC-ul calculat in etapa EX pentru instructiunile de salt
                  WB_WB[1],       //semnal de activare a scrierii in bancul de registri
                  ALU_DATA_WB,//rezultatul calculat de ALU
                  RD_WB,       //registrul rezultat in care se face scrierea
                  PC_ID,          //adresa PC a instructiunii din etapa ID
                  INSTRUCTION_ID, //instructiunea curenta in etapa ID
                  IMM_ID,         //valoarea calculata
                  REG_DATA1_ID,   //valoarea primului registru sursa citit
                  REG_DATA2_ID,   //valoarea celui de-al doilea registru sursa citit
                  FUNCT3_ID,  //funct3 din codificarea instructiunii
                  FUNCT7_ID,  //funct7 din codificarea instructiunii
                  OPCODE_ID,     //opcode-ul instructiunii
                  RD_ID,      //registru destinatie
                  RS1_ID,     //registru sursa1
                  RS2_ID);    //registru sursa2 );

wire MemRead,MemtoReg,MemWrite,Branch,ALUSrc,RegWrite;
wire [1:0] ALUop;
control_path control (OPCODE_ID,
                    pipeline_stall,
                    MemRead,MemtoReg,MemWrite,RegWrite,Branch,ALUSrc,
                    ALUop);

//wire [31:0] PC_EX;          //adresa PC a instructiunii din etapa ID
wire [31:0] INSTRUCTION_EX; //instructiunea curenta in etapa ID
wire [31:0] IMM_EX;         //valoarea calculata
wire [31:0] REG_DATA1_EX;   //valoarea primului registru sursa citit
wire [31:0] REG_DATA2_EX;   //valoarea celui de-al doilea registru sursa citit                
wire [2:0] FUNCT3_EX;  //funct3 din codificarea instructiunii
wire [6:0] FUNCT7_EX;  //funct7 din codificarea instructiunii
wire [6:0] OPCODE_EX;     //opcode-ul instructiunii
wire [4:0] RD_EX;      //registru destinatie
wire [4:0] RS1_EX;     //registru sursa1
wire [4:0] RS2_EX;   //registru sursa2     //registru sursa2
wire [1:0] WB_EX; 
wire [2:0] M_EX;
wire [2:0] EX_EX;

ID_EX idex(clk, reset,
    PC_ID,          //adresa PC a instructiunii din etapa ID
    INSTRUCTION_ID, //instructiunea curenta in etapa ID
    IMM_ID,         //valoarea calculata
    REG_DATA1_ID,   //valoarea primului registru sursa citit
    REG_DATA2_ID,   //valoarea celui de-al doilea registru sursa citi               
    FUNCT3_ID,  //funct3 din codificarea instructiunii
    FUNCT7_ID,  //funct7 din codificarea instructiunii
    OPCODE_ID,     //opcode-ul instructiunii
    RD_ID,      //registru destinatie
    RS1_ID,     //registru sursa1
    RS2_ID,
    {RegWrite, MemtoReg},
    {MemRead, MemWrite, Branch},
    {ALUSrc, ALUop},
    PC_EX,          //adresa PC a instructiunii din etapa ID
    INSTRUCTION_EX, //instructiunea curenta in etapa ID
    IMM_EX,         //valoarea calculata
    REG_DATA1_EX,   //valoarea primului registru sursa citit
    REG_DATA2_EX,   //valoarea celui de-al doilea registru sursa citit                
    FUNCT3_EX,  //funct3 din codificarea instructiunii
    FUNCT7_EX,  //funct7 din codificarea instructiunii
    OPCODE_EX,     //opcode-ul instructiunii
    RD_EX,      //registru destinatie
    RS1_EX,     //registru sursa1
    RS2_EX,   //registru sursa2     //registru sursa2
    WB_EX, 
    M_EX,
    EX_EX);

wire [1:0] forwardA,forwardB;
          
//wire [31:0] ALU_DATA_WB;
wire [31:0] ALU_OUT_MEM;
          
wire ZERO_EX;
//wire [31:0] ALU_OUT_EX;
wire [31:0] PC_Branch_EX;
wire [31:0] REG_DATA2_EX_FINAL;

EX ex (IMM_EX,         
       REG_DATA1_EX,
       REG_DATA2_EX,
       PC_EX,
       FUNCT3_EX,
       FUNCT7_EX,
       RD_EX,
       RS1_EX,
       RS2_EX,
       WB_EX[1],
       WB_EX[0],
       M_EX[2],
       M_EX[1],
       EX_EX[1:0],
       EX_EX[2],
       M_EX[0],
       forwardA,forwardB,
         
       ALU_DATA_WB,
       ALU_OUT_MEM,
         
       ZERO_EX,
       ALU_OUT_EX,
       PC_Branch_EX,
       REG_DATA2_EX_FINAL);

wire ZERO_MEM;
//wire ALU_OUT_MEM;
wire [31:0]PC_Branch_MEM;
wire [31:0]REG_DATA2_MEM_FINAL;
wire [1:0]WB_MEM;
wire [2:0]M_MEM;
wire [4:0] RD_MEM;

EX_MEM exmem(clk, reset,
    ZERO_EX,
    ALU_OUT_EX,
    PC_Branch_EX,
    REG_DATA2_EX_FINAL,
    WB_EX,
    M_EX,
    RD_EX,
    ZERO_MEM,
    ALU_OUT_MEM,
    PC_Branch,
    REG_DATA2_MEM_FINAL,
    WB_MEM,
    M_MEM,
    RD_MEM);
    
assign PC_MEM = PC_Branch;

wire [31:0] READ_DATA_MEM;

data_memory mem(clk,       
                M_MEM[2],
                M_MEM[1],
                ALU_OUT_MEM,
                REG_DATA2_MEM_FINAL,
                READ_DATA_MEM);
                
assign DATA_MEMORY_MEM = READ_DATA_MEM;

assign PCSrc = M_MEM[0] & ZERO_MEM;

wire[31:0] READ_DATA_WB;
wire[31:0] ALU_OUT_WB;
wire[1:0] WB_WB;
wire[4:0] RD_WB;

MEM_WB memwb (clk, reset,
    READ_DATA_MEM,
    ALU_OUT_MEM,
    WB_MEM,
    RD_MEM,
    READ_DATA_WB,
    ALU_OUT_WB,
    WB_WB,
    RD_WB);

mux2_1 muxwb(ALU_OUT_WB, READ_DATA_WB, WB_WB[0], ALU_DATA_WB);

hazard_detection hzd(RD_EX,
                 RS1_ID,
                 RS2_ID,
                 M_EX[2],
                 PC_write,
                 IF_ID_write,
                 pipeline_stall);

forwarding fwd(RS1_EX,
               RS2_EX,
               RD_MEM,
               RD_WB,
               WB_MEM[1],
               WB_WB[1],
               forwardA,forwardB); 
    
endmodule