module regfile #(
    parameter WIDTH = 32
    )
    (
        input logic clk,
        input logic rst_n,
        input logic reg_write_en,

        input logic [4:0] rs1_addr,
        input logic [4:0] rs2_addr,
        
        input logic [4:0] wr_addr,
        input logic [WIDTH-1:0] wr_data,

        output logic [WIDTH-1:0] rs1_data,
        output logic [WIDTH-1:0] rs2_data
    );

    logic [WIDTH-1:0] registers [31:0];

    always_comb begin
        rs1_data = (rs1_addr == 0) ? '0 : registers[rs1_addr];
        rs2_data = (rs2_addr == 0) ? '0 : registers[rs2_addr];
    end
    
    // Reset and write logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < 32; i++) begin
                registers[i] <= '0;
            end
        end else if (reg_write_en && wr_addr != 5'b00000) begin
            registers[wr_addr] <= wr_data;
        end
    end

endmodule