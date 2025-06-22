module Mult (
    input wire clk,                    // Sinal de clock para sincronização
    input wire reset_total,           // Reset assíncrono global
    input wire reset_local,           // Reset local para reiniciar a operação
    input wire [31:0] operand_A_in,   // Primeiro operando (multiplicando)
    input wire [31:0] operand_B_in,   // Segundo operando (multiplicador)
    output reg [31:0] product_Hi_out, // Parte alta do resultado da multiplicação
    output reg [31:0] product_Lo_out  // Parte baixa do resultado da multiplicação
);

    // Registradores internos para o algoritmo de Booth
    reg [31:0] reg_M;                // Armazena o multiplicando (operand_A_in)
    reg [31:0] reg_A;                // Acumulador para o resultado parcial
    reg [31:0] reg_Q;                // Armazena o multiplicador (operand_B_in) e o resultado parcial
    reg bit_Q0;                      // Bit auxiliar Q-1 para o algoritmo de Booth
    reg [5:0] iteration_count;       // Contador para as 32 iterações
    reg [31:0] M_complement_two;     // Armazena o complemento de dois de reg_M

    // Bloco always sensível à borda de subida do clock
    always @ (posedge clk) begin
        // Condição de reset: inicializa os registradores para uma nova operação
        if (reset_total == 1'b1 || reset_local == 1'b1) begin
            reg_M = operand_A_in;               // Carrega o multiplicando
            reg_Q = operand_B_in;               // Carrega o multiplicador
            reg_A = 32'b0;                      // Inicializa o acumulador com zero
            bit_Q0 = 1'b0;                      // Inicializa Q-1 com zero
            iteration_count = 6'd32;            // Configura o contador para 32 iterações
            M_complement_two = ~reg_M + 1'b1;   // Pré-calcula o complemento de dois de M
            product_Hi_out = 32'b0;             // Inicializa a saída product_Hi_out
            product_Lo_out = 32'b0;             // Inicializa a saída product_Lo_out
        end 
        // Se não houver reset e ainda houver iterações a serem feitas
        else if (iteration_count != 6'd0) begin
            // Lógica principal do algoritmo de Booth (baseado em reg_Q[0] e bit_Q0)
            if (bit_Q0 == 1'b1 && reg_Q[0] == 1'b0) begin
                // Caso Q[0]Q-1 = 01: A = A + M
                reg_A = reg_A + reg_M;
            end else if (bit_Q0 == 1'b0 && reg_Q[0] == 1'b1) begin
                // Caso Q[0]Q-1 = 10: A = A - M (A = A + complemento de dois de M)
                reg_A = M_complement_two + reg_A;
            end
            
            // Deslocamento aritmético à direita de {reg_A, reg_Q, bit_Q0}
            // O bit mais significativo de reg_A é replicado durante o deslocamento
            {reg_A, reg_Q, bit_Q0} = {reg_A, reg_Q, bit_Q0} >>> 1'b1;
            
            // Certifica-se de que o bit de sinal de reg_A seja estendido corretamente
            // (Esta linha pode ser redundante dependendo da síntese, mas mantém a lógica original)
            if (reg_A[30] == 1'b1) begin
                reg_A[31] = 1'b1;
            end
            
            iteration_count = iteration_count - 1'b1; // Decrementa o contador de iterações
            
            // Quando o contador chega a zero, a multiplicação está completa
            if (iteration_count == 6'd0) begin
                product_Hi_out = reg_A;     // O resultado final Hi está em reg_A
                product_Lo_out = reg_Q;     // O resultado final Lo está em reg_Q
            end
        end
    end
endmodule