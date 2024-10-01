module Interconnect #(
    parameter int SLAVE_COUNT,
    parameter [31:0] BASE_ADDR [0 : SLAVE_COUNT-1],
    parameter [31:0] MASK [0 : SLAVE_COUNT-1]
)(
    input clk,
    Bus.Master master,
    Bus.Slave slaves [SLAVE_COUNT-1:0]
);

    logic [SLAVE_COUNT-1:0] slave_select;

    logic [31:0] prev_addr;

    always_ff @(posedge clk) begin
        if(prev_addr !== master.addr) begin
            $display("\nTime: %d", $time);
            for(int i = 0; i < SLAVE_COUNT; i++)
                $display("i: %d ADDR: %h B_ADDR: %h MASK: %h AND: %h VALID: %b", i,
                    master.addr,
                    BASE_ADDR[i], 
                    MASK[i],
                    MASK[i] & master.addr,
                    BASE_ADDR[i] == (MASK[i] & master.addr));
        end
    
        prev_addr = master.addr;
    end

    logic slave_ready [SLAVE_COUNT-1:0];
    logic [31:0] slave_rdata [SLAVE_COUNT-1:0];

    generate
    for(genvar i = 0; i < SLAVE_COUNT; i++) begin
        assign slave_select[i] = (BASE_ADDR[i] == (MASK[i] & master.addr));

        assign slaves[i].valid = master.valid & slave_select[i];
        assign slaves[i].instr = master.instr;            
        assign slaves[i].addr = master.addr;
        assign slaves[i].wdata = master.wdata;
        assign slaves[i].wstrb = {4{slave_select[i]}} & master.wstrb;

        assign slave_ready[i] = slaves[i].ready;
        assign slave_rdata[i] = slaves[i].rdata;
    end
    endgenerate

    always_comb begin
        master.ready = 'x;
        master.rdata = 'x;

        //TODO discard priority
        for(int i = 0; i < SLAVE_COUNT; i++)
            if(slave_select[i]) begin
                master.ready = slave_ready[i];
                master.rdata = slave_rdata[i];
            end
        
        
        /*case (slave_select)
            2'b01: begin
                master.ready = slaves[0].ready;
                master.rdata = slaves[0].rdata;
            end
            2'b10: begin
                master.ready = slaves[1].ready;
                master.rdata = slaves[1].rdata;
            end
            default: begin
                master.ready = 'x;
                master.rdata = 'x;
            end
        endcase*/
    end

        

endmodule