class alu_transaction_object;
	
	rand bit [7:0] A,B;
	rand bit [2:0] opt;
	bit [7:0] dut_dout;
	bit [7:0] exp_dout;
	
	function void print(string tag="");
		 $display("[%s] A=%0h B=%0h opt=%0h EXP=%0h DUT=%0h",tag, A, B, opt, exp_dout, dut_dout);
	endfunction
endclass

class alu_driver;

	virtual inf vif;
	mailbox drv_mbx;
	
	task run();
		@(negedge vif.rst);
		
		forever begin
			alu_transaction_object item;
			drv_mbx.get(item);
			item.print("Driver");
			
			@(posedge vif.clk);
			vif.A=item.A;
			vif.B=item.B;
			vif.opt=item.opt;
			vif.load=1;
			
			@(posedge vif.clk);
			vif.load=0;
		end
	 endtask
endclass

class alu_monitor;
	
	virtual inf vif;
	mailbox sco_mbx;
	bit [7:0] last_A,last_B;
	bit [2:0] last_opt;
	
	task run();
		@(negedge vif.rst);
		
		forever begin
      @(posedge vif.clk);
      if (vif.load) begin
        last_A   = vif.A;
        last_B   = vif.B;
        last_opt = vif.opt;
      end
		
		@(posedge vif.clk);
		alu_transaction_object item;
		item=new();
		item.A=last_A;
		item.B=last_B;
		item.opt=last_opt;
		item.dut_dout=vif.dout;
		
		sco_mbx.put(item);
		end
	endtask
endclass

class alu_scoreboard;
  mailbox sco_mbx;

  function new(mailbox mbx);
    sco_mbx = mbx;
  endfunction

  function automatic bit [7:0] alu_ref(
    bit [7:0] x,
    bit [7:0] y,
    bit [2:0] opt
  );
    bit [7:0] b;
    bit [8:0] sum;

    b   = (opt == 3'b001 || opt == 3'b111) ? ~y : y;
    sum = x + b + ((opt == 3'b001 || opt == 3'b111) ? 1'b1 : 1'b0);

    case (opt)
      3'b000: alu_ref = sum[7:0];
      3'b001: alu_ref = sum[7:0];
      3'b010: alu_ref = x & y;
      3'b011: alu_ref = x | y;
      3'b100: alu_ref = x ^ y;
      3'b101: alu_ref = x << 1;
      3'b110: alu_ref = x >> 1;
      3'b111: alu_ref = {{7{1'b0}}, sum[7]};
      default: alu_ref = 0;
    endcase
  endfunction

  task run();
    forever begin
      alu_transaction_object item;
      sco_mbx.get(item);

      item.exp_dout = alu_ref(item.A, item.B, item.opt);

      if (item.dut_dout !== item.exp_dout) begin
        $error("ALU MISMATCH!");
        item.print("SCOREBOARD");
      end else begin
        $display("ALU PASS");
        item.print("SCOREBOARD");
      end
    end
  endtask
endclass


class environment;

	alu_driver d0;
	alu_monitor m0;
	alu_scoreboard s0;
	
	virtual inf vif;
	
	mailbox sco_mbx;
	mailbox drv_mbx;
	
	function new;
		d0=new;
		m0=new;
		sco_mbx=new();
		drv_mbx=new();
		s0=new(sco_mbx);
	endfunction
	
	task run();
		d0.vif=vif;
		m0.vif=vif;
		d0.drv_mbx = drv_mbx;
		m0.sco_mbx=sco_mbx;
		
		fork
			d0.run();
			m0.run();
			s0.run();
		join_none
	endtask
endclass
	
class alu_test;
	environment env;

  function new();
    env = new();
  endfunction

  task run();
    env.run();
    send_txn(8'h05, 8'h03, 3'b000); 
    send_txn(8'h05, 8'h03, 3'b001); 
    send_txn(8'hF0, 8'h0F, 3'b010); 

    repeat (20) begin
      alu_transaction_object item = new();
      assert(item.randomize());
      env.drv_mbx.put(item);
    end
  endtask

  task send_txn(bit [7:0] A, B, bit [2:0] opt);
    alu_transaction_object item = new();
    item.A   = A;
    item.B   = B;
    item.opt = opt;
    env.drv_mbx.put(item);
  endtask
  
endclass

interface inf(input bit clk)
	logic [7:0] A,B;
	logic [2:0] opt;
	logic [7:0] dout;
	logic load,done;
	logic rst;
endinterface

module tb;
	reg clk;
	
	
	always #10 clk=~clk;
	inf a1(clk);
	Low_area_ALU(
		.clk(a1.clk),
		.rst(a1.rst),
		.A(a1.A),
		.B(a1.B),
		.opt(a1.opt),
		.load(a1.load),
		.Dout(a1.dout),
		.done(a1.done));
		
	initial begin
		clk=0;
		a1.rst=1;
		a1.load=0;
		#40;
		a1.rst=0;
		
		alu_test t0=new();
		t0.env.vif=a1;
		t0.run();
		#200 $finish;
	end
endmodule

		
	