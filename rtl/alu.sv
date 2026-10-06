module alu #(
    parameter WIDTH = 32
)
(
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    input logic [3:0] alu_op,

    output logic [WIDTH-1:0] result,
    output logic zero
);
    localparam SHAMT_WIDTH = $clog2(WIDTH);

    always_comb begin
        case (alu_op)
            4'b0000: result = a + b; // ADD
            4'b0001: result = a - b; // SUBTRACT
            4'b0010: result = a & b; // AND
            4'b0011: result = a | b; // OR
            4'b0100: result = a ^ b; // XOR
            4'b0101: result = a << b[SHAMT_WIDTH-1:0]; // SLL
            4'b0110: result = a >> b[SHAMT_WIDTH-1:0]; // SRL
            4'b0111: result = $signed(a) >>> b[SHAMT_WIDTH-1:0]; // SRA
            4'b1000: result = ($signed(a) < $signed(b)) ? 1 : 0; // SLT
            4'b1001: result = (a < b) ? 1 : 0; // SLTU
            default: result = '0; // Default case
        endcase

        zero = (result == '0); // Set zero flag if result is zero
    end
endmodule
