`timescale 1ns/1ps

module alu_tb;

    parameter WIDTH = 32;

    // Declare signals for the ALU inputs and outputs
    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;
    logic [3:0]       alu_op;
    logic [WIDTH-1:0] result;
    logic             zero;


    // Instantiate the ALU module
    alu #(
        .WIDTH(WIDTH)
    ) dut (
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result),
        .zero(zero)
    );


    // Testbench starts
    initial begin

        // Initialize inputs
        a      = '0;
        b      = '0;
        alu_op = '0;

        #10;


        // =========================================================
        // ADD
        // =========================================================
        a      = WIDTH'(10);
        b      = WIDTH'(20);
        alu_op = 4'b0000;

        #10;

        if (result !== WIDTH'(30) || zero !== 1'b0) begin
            $display(
                "Test ADD failed: expected 30, got %0d",
                result
            );
        end else begin
            $display(
                "Test ADD passed: expected 30, got %0d",
                result
            );
        end


        // =========================================================
        // SUBTRACT
        // =========================================================
        a      = WIDTH'(20);
        b      = WIDTH'(10);
        alu_op = 4'b0001;

        #10;

        if (result !== WIDTH'(10) || zero !== 1'b0) begin
            $display(
                "Test SUBTRACT failed: expected 10, got %0d",
                result
            );
        end else begin
            $display(
                "Test SUBTRACT passed: expected 10, got %0d",
                result
            );
        end


        // =========================================================
        // AND
        // =========================================================
        a      = WIDTH'(8'b1010_1010);
        b      = WIDTH'(8'b1101_0101);
        alu_op = 4'b0010;

        #10;

        if (result !== WIDTH'(8'b1000_0000) || zero !== 1'b0) begin
            $display(
                "Test AND failed: expected 10000000, got %0b",
                result
            );
        end else begin
            $display(
                "Test AND passed: expected 10000000, got %0b",
                result
            );
        end


        // =========================================================
        // OR
        // =========================================================
        a      = WIDTH'(8'b1010_1010);
        b      = WIDTH'(8'b1101_0101);
        alu_op = 4'b0011;

        #10;

        if (result !== WIDTH'(8'b1111_1111) || zero !== 1'b0) begin
            $display(
                "Test OR failed: expected 11111111, got %0b",
                result
            );
        end else begin
            $display(
                "Test OR passed: expected 11111111, got %0b",
                result
            );
        end


        // =========================================================
        // XOR
        // =========================================================
        a      = WIDTH'(8'b1010_1010);
        b      = WIDTH'(8'b1111_1111);
        alu_op = 4'b0100;

        #10;

        if (result !== WIDTH'(8'b0101_0101) || zero !== 1'b0) begin
            $display(
                "Test XOR failed: expected 01010101, got %0b",
                result
            );
        end else begin
            $display(
                "Test XOR passed: expected 01010101, got %0b",
                result
            );
        end


        // =========================================================
        // SLL
        // =========================================================
        a      = WIDTH'(1);
        b      = WIDTH'(2);
        alu_op = 4'b0101;

        #10;

        if (result !== WIDTH'(4) || zero !== 1'b0) begin
            $display(
                "Test SLL failed: expected 4, got %0d",
                result
            );
        end else begin
            $display(
                "Test SLL passed: expected 4, got %0d",
                result
            );
        end


        // =========================================================
        // SRL
        // =========================================================
        a      = WIDTH'(4);
        b      = WIDTH'(2);
        alu_op = 4'b0110;

        #10;

        if (result !== WIDTH'(1) || zero !== 1'b0) begin
            $display(
                "Test SRL failed: expected 1, got %0d",
                result
            );
        end else begin
            $display(
                "Test SRL passed: expected 1, got %0d",
                result
            );
        end


        // =========================================================
        // SRA
        // -8 >>> 2 = -2
        // =========================================================
        a      = WIDTH'(-8);
        b      = WIDTH'(2);
        alu_op = 4'b0111;

        #10;

        if (result !== WIDTH'(-2) || zero !== 1'b0) begin
            $display(
                "Test SRA failed: expected -2, got %0d",
                $signed(result)
            );
        end else begin
            $display(
                "Test SRA passed: expected -2, got %0d",
                $signed(result)
            );
        end


        // =========================================================
        // SLT True case
        // -1 < 1 = true
        // =========================================================
        a      = WIDTH'(-1);
        b      = WIDTH'(1);
        alu_op = 4'b1000;

        #10;

        if (result !== WIDTH'(1) || zero !== 1'b0) begin
            $display(
                "Test SLT true failed: expected 1, got %0d",
                result
            );
        end else begin
            $display(
                "Test SLT true passed: expected 1, got %0d",
                result
            );
        end


        // =========================================================
        // SLT False case
        // 5 < -5 = false
        // =========================================================
        a      = WIDTH'(5);
        b      = WIDTH'(-5);
        alu_op = 4'b1000;

        #10;

        if (result !== WIDTH'(0) || zero !== 1'b1) begin
            $display(
                "Test SLT false failed: expected 0, got %0d",
                result
            );
        end else begin
            $display(
                "Test SLT false passed: expected 0, got %0d",
                result
            );
        end


        // =========================================================
        // SLTU True case
        // 5 < 10 = true
        // =========================================================
        a      = WIDTH'(5);
        b      = WIDTH'(10);
        alu_op = 4'b1001;

        #10;

        if (result !== WIDTH'(1) || zero !== 1'b0) begin
            $display(
                "Test SLTU true failed: expected 1, got %0d",
                result
            );
        end else begin
            $display(
                "Test SLTU true passed: expected 1, got %0d",
                result
            );
        end


        // =========================================================
        // SLTU False case
        //
        // WIDTH'(-1) gives all 1s.
        //
        // For WIDTH = 32:
        // 0xFFFFFFFF = 4294967295 unsigned
        //
        // Therefore:
        // 4294967295 < 1 = false
        // =========================================================
        a      = WIDTH'(-1);
        b      = WIDTH'(1);
        alu_op = 4'b1001;

        #10;

        if (result !== WIDTH'(0) || zero !== 1'b1) begin
            $display(
                "Test SLTU false failed: expected 0, got %0d",
                result
            );
        end else begin
            $display(
                "Test SLTU false passed: expected 0, got %0d",
                result
            );
        end


        // =========================================================
        // SLT Equality case
        // 5 < 5 = false
        // =========================================================
        a      = WIDTH'(5);
        b      = WIDTH'(5);
        alu_op = 4'b1000;

        #10;

        if (result !== WIDTH'(0) || zero !== 1'b1) begin
            $display(
                "Test SLT equality failed: expected 0, got %0d",
                result
            );
        end else begin
            $display(
                "Test SLT equality passed: expected 0, got %0d",
                result
            );
        end


        $finish;

    end



    task test_alu(
    input logic [WIDTH-1:0] test_a,
    input logic [WIDTH-1:0] test_b,
    input logic [3:0]       test_op,
    input logic [WIDTH-1:0] expected_result,
    input logic             expected_zero
    );
    begin
        a = test_a;
        b = test_b;
        alu_op = test_op;
        
        #10;

        if (result !== expected_result || zero !== expected_zero) begin
            $display(
                "FAILED: a=%0d b=%0d result=%0d expected=%0d",
                test_a, test_b, result, expected_result
            );
            end else begin
                $display(
                "PASSED: a=%0d b=%0d result=%0d",
                test_a, test_b, result
            );
    end
    end
    endtask

    // Testbench starts
    initial begin
        // ADD   |   a     |    b        |    op  |  result |   zero
        test_alu(WIDTH'(10), WIDTH'(20), 4'b0000, WIDTH'(30), 1'b0);
        // SUBTRACT
        test_alu(WIDTH'(20), WIDTH'(10), 4'b0001, WIDTH'(10), 1'b0);
        // AND
        test_alu(WIDTH'(8'b1010_1010), WIDTH'(8'b1101_0101), 4'b0010, WIDTH'(8'b1000_0000), 1'b0);
        // OR
        test_alu(WIDTH'(8'b1010_1010), WIDTH'(8'b1101_0101), 4'b0011, WIDTH'(8'b1111_1111), 1'b0);
        // XOR
        test_alu(WIDTH'(8'b1010_1010), WIDTH'(8'b1111_1111), 4'b0100, WIDTH'(8'b0101_0101), 1'b0);
        // SLL
        test_alu(WIDTH'(1), WIDTH'(2), 4'b0101, WIDTH'(4), 1'b0);
        // SRL
        test_alu(WIDTH'(4), WIDTH'(2), 4'b0110, WIDTH'(1), 1'b0);
        // SRA
        test_alu(WIDTH'(-8), WIDTH'(2), 4'b0111, WIDTH'(-2), 1'b0);
        // SLT True case
        test_alu(WIDTH'(-1), WIDTH'(1), 4'b1000, WIDTH'(1), 1'b0);
        //SLT equality case
        test_alu(WIDTH'(5), WIDTH'(5), 4'b1000, WIDTH'(0), 1'b1);
        // SLT False case
        test_alu(WIDTH'(5), WIDTH'(-5), 4'b1000, WIDTH'(0), 1'b1);
        // SLTU True case
        test_alu(WIDTH'(5), WIDTH'(10), 4'b1001, WIDTH'(1), 1'b0);
        // SLTU False case
        test_alu(WIDTH'(-1), WIDTH'(1), 4'b1001, WIDTH'(0), 1'b1);

        $finish;
    end
endmodule