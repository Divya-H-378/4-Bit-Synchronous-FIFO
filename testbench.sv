`timescale 1ns/1ps

module tb_sync_fifo;

    reg clk = 0;
    reg rst = 1;
    reg wr_en = 0;
    reg rd_en = 0;
    reg [3:0] data_in = 0;

    wire [3:0] data_out;
    wire full, empty;

    integer i;

    sync_fifo dut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, tb_sync_fifo);

        // Reset
        repeat (2) @(negedge clk);
        rst = 0;

        // Write all 16 values: 0 to F
        for (i = 0; i < 16; i = i + 1) begin
            @(negedge clk);
            wr_en = 1;
            data_in = i;
        end

        @(negedge clk);
        wr_en = 0;
        #1;
        $display("FULL flag = %b (expected 1)", full);

        // Try one extra write
        @(negedge clk);
        wr_en = 1;
        data_in = 4'hA;

        @(negedge clk);
        wr_en = 0;
        #1;
        $display("FULL after extra write = %b (expected 1)", full);

        // Read all 16 values in FIFO order
        for (i = 0; i < 16; i = i + 1) begin
            @(negedge clk);
            rd_en = 1;

            @(negedge clk);
            #1;
            $display("Read data = %h", data_out);
        end

        rd_en = 0;
        #1;
        $display("EMPTY flag = %b (expected 1)", empty);

        // Try an invalid read when empty
        @(negedge clk);
        rd_en = 1;

        @(negedge clk);
        rd_en = 0;
        #1;
        $display("EMPTY after invalid read = %b (expected 1)", empty);

        $display("Simulation completed.");
        $finish;
    end

endmodule
