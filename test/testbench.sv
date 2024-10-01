`timescale 1ns/1ns

module testbench;

    localparam CLK_PERIOD = 10;
    localparam CLK_HALF_PERIOD = CLK_PERIOD/2;
    localparam CLK_CYCLES = 400;

    logic clk = 0;
    logic resetn = 0;

    VectorSOC dut(
        .clk,
        .resetn
    );

    task wait_ticks(integer n); repeat(n) @(posedge clk); endtask

    task reset_data; begin
        resetn <= 1'b0;
        wait_ticks(3);
        resetn <= 1'b1;
    end
    endtask

    always #CLK_HALF_PERIOD clk = ~clk;
  
    initial begin
        reset_data();
        #(1000*CLK_PERIOD) $finish;
    end

endmodule