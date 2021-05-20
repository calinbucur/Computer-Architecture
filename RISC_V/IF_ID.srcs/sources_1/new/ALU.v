////////////////////////////////////////////ALU_MODULE///////////////////////////////////////////////////////
module ALU(input [3:0] ALUop,
           input [31:0] ina,inb,
           output reg zero,
           output reg [31:0] out);
    
    always @ (ALUop or ina or inb) begin
        if(ALUop == 4'b0000) begin
            out = ina & inb;
            if(out == 0)
                zero = 1;
            else
                zero = 0;
        end
        else if(ALUop == 4'b0001) begin
            out = ina | inb;
            if(out == 0)
                zero = 1;
            else
                zero = 0;
        end
        else if(ALUop == 4'b0010) begin
            out = ina + inb;
            if(out == 0)
                zero = 1;
            else
                zero = 0;
        end
        else if(ALUop == 4'b0110) begin
            out = ina - inb;
            if(out == 0)
                zero = 1;
            else
                zero = 0;
        end
        else begin
            out = 0;
            zero = 1;
        end
    end
endmodule
