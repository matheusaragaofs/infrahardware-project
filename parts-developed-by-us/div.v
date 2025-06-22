module Div (
    input wire clk,                    // Sinal de clock para sincronização
    input wire reset_total,           // Reset assíncrono global
    input wire reset_local,           // Reset local para reiniciar a operação
    input wire [31:0] dividend_in,    // O valor do dividendo
    input wire [31:0] divisor_in,     // O valor do divisor
    output reg zero_division_flag,    // Flag que indica divisão por zero
    output reg [31:0] remainder_out,  // Resultado do resto da divisão (Hi)
    output reg [31:0] quotient_out    // Resultado do quociente da divisão (Lo)
);

    // Registradores internos para o algoritmo de divisão
    reg [31:0] reg_abs_divisor;       // Armazena o valor absoluto do divisor
    reg [31:0] reg_abs_dividend;      // Armazena o valor absoluto do dividendo
    reg [31:0] reg_quotient_calc;     // Registrador temporário para o cálculo do quociente
    reg [31:0] reg_remainder_calc;    // Registrador temporário para o cálculo do resto
    reg [5:0] current_bit_index;      // Contador para as 32 iterações (de 31 a 0)

    // Bloco always sensível à borda de subida do clock
    always @ (posedge clk) begin
        // Condição de reset: inicializa os registradores e flags
        if (reset_total == 1'b1 || reset_local == 1'b1) begin
            remainder_out = 32'b0;            // Inicializa a saída do resto
            quotient_out = 32'b0;             // Inicializa a saída do quociente
            zero_division_flag = 1'b0;        // Inicializa a flag de divisão por zero
            current_bit_index = 6'd32;        // Configura o contador para 32 iterações
            reg_quotient_calc = 32'b0;        // Limpa o registrador de quociente temporário
            reg_remainder_calc = 32'b0;       // Limpa o registrador de resto temporário

            // Verifica se o divisor é zero
            if (divisor_in == 32'b0) begin
                zero_division_flag = 1'b1;    // Ativa a flag de divisão por zero
            end else begin
                // Calcula o valor absoluto do divisor
                if (divisor_in[31] == 1'b1) begin // Se for negativo
                    reg_abs_divisor = ~divisor_in + 1'b1; // Complemento de dois
                end else begin
                    reg_abs_divisor = divisor_in;         // Se for positivo
                end

                // Calcula o valor absoluto do dividendo
                if (dividend_in[31] == 1'b1) begin // Se for negativo
                    reg_abs_dividend = ~dividend_in + 1'b1; // Complemento de dois
                end else begin
                    reg_abs_dividend = dividend_in;         // Se for positivo
                end
            end
        end
        // Se não houver reset e ainda houver iterações a serem feitas e não houver divisão por zero
        else if (current_bit_index != 6'd0 && !zero_division_flag) begin
            // Desloca o resto para a esquerda e adiciona o próximo bit do dividendo
            reg_remainder_calc = reg_remainder_calc << 1;
            reg_remainder_calc[0] = reg_abs_dividend[current_bit_index - 1];

            // Subtrai o divisor do resto se o resto for maior ou igual
            if (reg_remainder_calc >= reg_abs_divisor) begin
                reg_remainder_calc = reg_remainder_calc - reg_abs_divisor;
                reg_quotient_calc[current_bit_index - 1] = 1'b1; // Define o bit correspondente no quociente
            end

            current_bit_index = current_bit_index - 1'b1; // Decrementa o contador

            // Quando todas as iterações estiverem completas
            if (current_bit_index == 6'd0) begin
                // Ajusta o sinal do quociente final
                if (dividend_in[31] != divisor_in[31]) begin // Se os sinais forem diferentes, quociente é negativo
                    quotient_out = -(reg_quotient_calc + 1'b1); // Complemento de dois e nega
                end else begin
                    quotient_out = reg_quotient_calc;           // Quociente positivo
                end

                // Ajusta o sinal do resto final
                if (dividend_in[31] != divisor_in[31]) begin // Se os sinais forem diferentes
                    if (divisor_in[31] == 1'b1) begin // Se o divisor original for negativo
                        remainder_out = -(reg_abs_divisor - reg_remainder_calc); // Ajusta o sinal do resto
                    end else begin
                        remainder_out = reg_abs_divisor - reg_remainder_calc;    // Ajusta o sinal do resto
                    end
                end else begin // Se os sinais forem iguais
                    if (divisor_in[31] == 1'b1) begin // Se o divisor original for negativo
                        remainder_out = -reg_remainder_calc; // Nega o resto
                    end else begin
                        remainder_out = reg_remainder_calc;  // Resto positivo
                    end
                end
            end
        end
    end
endmodule