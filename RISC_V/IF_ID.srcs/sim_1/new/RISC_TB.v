
module RISC_TB();

reg clk;
reg reset;
wire [31:0] PC_EX;
wire [31:0] ALU_OUT_EX;
wire [31:0] PC_MEM;
wire PCSrc;
wire [31:0] DATA_MEMORY_MEM;
wire [31:0] ALU_DATA_WB;
wire [1:0] forwardA, forwardB;
wire pipeline_stall;

RISC_V procesor (clk, reset,
          PC_EX,
          ALU_OUT_EX,
          PC_MEM,
          PCSrc,
          DATA_MEMORY_MEM,
          ALU_DATA_WB,
          forwardA, forwardB,
          pipeline_stall);

initial begin
    clk = 0;
    reset = 1;
    #20 reset = 0;
end

always #10 clk = ~clk;

endmodule
