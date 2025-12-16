module tb;

    parameter width = 8;

    reg  clk, rst, start;
    reg  [width-1:0] A, B;
    reg  [2:0] opt;
    reg load;
	 wire done;
    wire [width-1:0] Dout;

    initial clk = 0;
    always #5 clk = ~clk;

    Low_area_ALU #(width) alu (
        .A(A),
        .B(B),
        .opt(opt),
        .load(load),
        .clk(clk),
        .rst(rst),
        .Dout(Dout),
		  .done(done)
    );


    initial begin
      
        rst   = 1;
        start = 0;
        A = 0; B = 0; opt = 0;

        #12 rst = 0;
		  #8	load=1;
		
        // ADD
        A = 8'd12; B = 8'd5; opt = 3'b000;
        start = 1; #10 start = 0;
        #20;

        // SUB
        A = 8'd12; B = 8'd5; opt = 3'b001;
        start = 1; #10 start = 0;
        #20;

        // AND
        opt = 3'b010;
        start = 1; #10 start = 0;
        #20;

        // OR
        opt = 3'b011;
        start = 1; #10 start = 0;
        #20;

        // XOR
        opt = 3'b100;
        start = 1; #10 start = 0;
        #20;

        // SHL
        opt = 3'b101;
        start = 1; #10 start = 0;
        #20;

        // SHR
        opt = 3'b110;
        start = 1; #10 start = 0;
        #20;

        // SLT
        opt = 3'b111;
        start = 1; #10 start = 0;
        #20;

        $finish;
    end

endmodule
