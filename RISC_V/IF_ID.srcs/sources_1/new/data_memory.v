////////////////////////////////////////////DATA_MEMORY///////////////////////////////////////////////////////
module data_memory(input clk,       
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data
                   );
                   
    reg [31:0] memory [0:1023];
    integer i;
    
    initial begin
        for(i = 0; i < 1024; i = i + 1) begin
            memory[i] = 0;
        end
    end
    
    always @(posedge clk) begin
        if(mem_write == 1) begin
            memory[address >> 2] = write_data;
        end
    end
    
    always @(address or mem_read) begin
        if(mem_read == 1) begin
            read_data = memory[address >> 2];
        end
    end
endmodule
