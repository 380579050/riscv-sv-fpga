`timescale 1ns/1ps

module alu_tb;
    parameter WIDTH = 32;
    //declare signals for the ALU inputs and outputs
    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;
    logic [3:0] alu_op;
    logic [WIDTH-1:0] result;
    logic zero;


    //implement the ALU module
    alu #(.WIDTH(WIDTH)) dut(
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result),
        .zero(zero)
    );

    //testbench starts
    initial begin
        //initialize inputs
        a = 0;
        b = 0;  
        alu_op = 0;
        
        //ADD
        a = 32'd10;
        b = 32'd20;
        alu_op = 4'b0000; // ADD

        #10;

        if(result !== 32'd30) begin
            $display("Test ADD failed: expected 30, got %0d", result);
        end else begin
            $display("Test ADD passed: expected 30, got %0d", result);
        end

        //SUBTRACT
        a = 32'd20;
        b = 32'd10;
        alu_op = 4'b0001; // SUBTRACT

        #10;

        if(result !== 32'd10) begin
            $display("Test SUBTRACT failed: expected 10, got %0d", result);
        end else begin
            $display("Test SUBTRACT passed: expected 10, got %0d", result);
        end

        //AND
        a = 32'b10101010;
        b = 32'b11010101;
        alu_op = 4'b0010; // AND

        #10;

        if(result !== 32'b10000000) begin
            $display("Test AND failed: expected 32'b10000000, got %0b", result);
        end else begin
            $display("Test AND passed: expected 32'b10000000, got %0b", result);
        end

        //OR
        a = 32'b10101010;
        b = 32'b11010101;
        alu_op = 4'b0011; // OR

        #10;
        if(result !== 32'b11111111) begin
            $display("Test OR failed: expected 32'b11111111, got %0b", result);
        end else begin
            $display("Test OR passed: expected 32'b11111111, got %0b", result);
        end


        //XOR
        a = 32'b10101010;
        b = 32'b11111111;
        alu_op = 4'b0100; // XOR    

        #10;
        if(result !== 32'b01010101) begin
            $display("Test XOR failed: expected 32'b01010101, got %0b", result);
        end else begin
            $display("Test XOR passed: expected 32'b01010101, got %0b", result);
        end

        //SLL
        a = 32'b00000001;
        b = 32'd2;
        alu_op = 4'b0101; // SLL

        #10;
        if(result !== 32'b00000100) begin
            $display("Test SLL failed: expected 32'b00000100, got %0b", result);
        end else begin
           $display("Test SLL passed: expected 32'b00000100, got %0b", result); 
        end

        //SRL
        a = 32'b00000100;
        b = 32'd2;    
        alu_op = 4'b0110; // SRL   

        #10;
        if(result !== 32'b00000001) begin
            $display("Test SRL failed: expected 32'b00000001, got %0b", result);
        end else begin
            $display("Test SRL passed: expected 32'b00000001, got %0b", result);
        end

        //SRA
        a = 32'b11111000; // -8 in signed
        b = 32'd2;
        alu_op = 4'b0111; // SRA

        #10;
        if(result !== 32'b11111110) begin
            $display("Test SRA failed: expected 32'b11111110, got %0b", result);
        end else begin
            $display("Test SRA passed: expected 32'b11111110, got %0b", result);
        end

        //SLT
        a = -32'd1;
        b = 32'd1;
        alu_op = 4'b1000; // SLT

        #10;
        if(result !== 32'd1) begin
            $display("Test SLT failed: expected 1, got %0d", result);
        end else begin
            $display("Test SLT passed: expected 1, got %0d", result);
        end

        //SLTU
        a = 32'd10;
        b = 32'd5;
        alu_op = 4'b1001; // SLTU
        
        #10;
        if(result !== 32'd0) begin
            $display("Test SLTU failed: expected 0, got %0d", result);
        end else begin
            $display("Test SLTU passed: expected 0, got %0d", result);
        end
    end   
    
endmodule