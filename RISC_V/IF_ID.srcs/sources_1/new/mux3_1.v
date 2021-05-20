`timescale 1ns / 1ps

module mux3_1(
        input[31:0] ina, inb, inc,
        input [1:0] sel,
        output reg[31:0] out
    );
    
    always @(ina or inb or inc or sel) begin
        if(sel == 0)
            out = ina;
        if(sel == 1)
            out = inb;
        if(sel == 2)
            out = inc;
    end
endmodule
