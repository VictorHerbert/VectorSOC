interface Bus;

    logic valid;
    logic instr;
    logic ready;
    logic [31:0] addr;
    logic [31:0] wdata;
    logic [3:0] wstrb;
    logic [31:0] rdata;

    modport Master (
        output valid,
        output instr,
        input ready,
        output addr,
        output wdata,
        output wstrb,
        input rdata
    );

    modport Slave (
        input valid,
        input instr,
        output ready,
        input addr,
        input wdata,
        input wstrb,
        output rdata
    );

endinterface;