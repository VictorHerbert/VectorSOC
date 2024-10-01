module VectorSOC (
	input clk,
	input resetn
);
	localparam SLAVE_COUNT = 3;
    Bus master_bus();
	Bus slave_bus [SLAVE_COUNT-1:0] ();

    Picorv32Wrapper cpu (
		.clk		(clk),
		.resetn		(resetn),
		.bus		(master_bus)
	);

	Interconnect #(
		.SLAVE_COUNT(3),
		.BASE_ADDR({
			32'h00000000,
			32'h40000000,
			32'h80000000
		}),
		.MASK({
			32'hC0000000,
			32'hC0000000,
			32'hC0000000
		})
	) main_interconnect (
		.clk,
		.master(master_bus),
		.slaves(slave_bus)
	);

    Memory #("C:\\Users\\victo\\Desktop\\Workspace\\VectorSOC\\test\\software\\build\\test.mem")
    rom (
        .clk(clk),
        .resetn(resetn),
        .bus(slave_bus[0])
    );

	Memory ram (
        .clk(clk),
        .resetn(resetn),
        .bus(slave_bus[1])
    );

	Memory ram2 (
        .clk(clk),
        .resetn(resetn),
        .bus(slave_bus[2])
    );

endmodule
