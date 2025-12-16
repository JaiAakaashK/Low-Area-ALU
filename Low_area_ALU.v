module Low_area_ALU #(parameter width = 8) (
    input  wire [width-1:0] A,
    input  wire [width-1:0] B,
    input  wire [2:0] opt,
    input  wire load,
    input  wire clk,
    input  wire rst,
    output reg  [width-1:0] Dout,
	 output done
);

    reg  [width-1:0] x, y;
    wire [width-1:0] b;
    wire [width-1:0] sum;

    always @(posedge clk) begin
        if (rst) begin
            x <= 0;
            y <= 0;
        end else if (load) begin
            x <= A;
            y <= B;
        end

    end

    assign b= (opt == 3'b001 || opt == 3'b111) ? ~y : y;
    assign sum= x + b + ((opt == 3'b001 || opt == 3'b111) ? 1'b1 : 1'b0);

    always @(*) begin
        case (opt)
            3'b000: Dout = sum;                        
            3'b001: Dout = sum;                        
            3'b010: Dout = x & y;                     
            3'b011: Dout = x | y;                      
            3'b100: Dout = x ^ y;                      
            3'b101: Dout = x << 1;                     
            3'b110: Dout = x >> 1;                     
            3'b111: Dout = {{(width-1){1'b0}}, sum[width-1]}; 
            default: Dout = 0;
        endcase
    end
	 assign done=1;

endmodule


