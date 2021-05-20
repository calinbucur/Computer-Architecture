
module MEM_WB(
    input clk, reset,
    input [31:0] READ_DATA_MEM,
    input [31:0] ALU_OUT_MEM,
    input [1:0] WB_MEM,
    input [4:0] RD_MEM,
    output reg [31:0] READ_DATA_WB,
    output reg [31:0] ALU_OUT_WB,
    output reg [1:0] WB_WB,
    output reg [4:0] RD_WB
    );
    
    always @(posedge clk) begin
        if(reset) begin
            READ_DATA_WB = 0;
            ALU_OUT_WB = 0;
            WB_WB = 0;
            RD_WB = 0;
        end
        else begin
            READ_DATA_WB = READ_DATA_MEM;
            ALU_OUT_WB = ALU_OUT_MEM;
            WB_WB = WB_MEM;
            RD_WB = RD_MEM;
        end
    end
endmodule
