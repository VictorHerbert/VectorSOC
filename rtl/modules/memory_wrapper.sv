module Memory #(
    parameter string FILE = ""
)(
    input wire clk,
    input wire resetn,
    Bus.Slave bus
);
    localparam DEPTH = 8;
    reg [31:0] memory [0:2**DEPTH-1]; // Simple 256-word memory

    initial begin    
        foreach(memory[i]) memory[i] = 8'hFF;
        if(FILE != "") $readmemh(FILE, memory);
    end

    wire [DEPTH:0] word_addr;
    assign word_addr = bus.addr[DEPTH+1:2];
    

    always @(posedge clk) begin
        if (!resetn) begin
            bus.ready <= 0;
        end else if (bus.valid) begin
            bus.ready <= 1;
            if (bus.wstrb) begin
                if (bus.wstrb[0]) memory[word_addr][7:0] <= bus.wdata[7:0];
                if (bus.wstrb[1]) memory[word_addr][15:8] <= bus.wdata[15:8];
                if (bus.wstrb[2]) memory[word_addr][23:16] <= bus.wdata[23:16];
                if (bus.wstrb[3]) memory[word_addr][31:24] <= bus.wdata[31:24];
            end else begin
                bus.rdata <= memory[word_addr];
            end
        end else begin
            bus.ready <= 0;
        end
    end

endmodule
