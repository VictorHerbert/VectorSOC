module Picorv32Wrapper (
    input  logic        clk,
    input  logic        resetn,

    // Bus Interface instantiation
    Bus.Master master_bus
);

    // Instantiation of the picorv32 CPU
    picorv32 cpu (
        .clk         (clk),
        .resetn      (resetn),
        
        // Connecting the CPU's memory bus interface to the Master bus
        .mem_valid   (master_bus.valid),
        .mem_instr   (master_bus.instr),
        .mem_ready   (master_bus.ready),
        .mem_addr    (master_bus.addr),
        .mem_wdata   (master_bus.wdata),
        .mem_wstrb   (master_bus.wstrb),
        .mem_rdata   (master_bus.rdata)
    );

endmodule