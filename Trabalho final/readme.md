.VHDL

```VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entidade principal do Processador
entity Processor is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        switches : in  STD_LOGIC_VECTOR(7 downto 0);  -- Entrada (chaves do FPGA)
        leds     : out STD_LOGIC_VECTOR(7 downto 0)   -- Saída (LEDs do FPGA)
    );
end Processor;

architecture Behavioral of Processor is
    -- Barramentos principais
    signal addr_bus    : STD_LOGIC_VECTOR(7 downto 0); -- Barramento de Endereço
    signal data_bus    : STD_LOGIC_VECTOR(7 downto 0); -- Barramento de Dados
    signal control_bus : STD_LOGIC_VECTOR(3 downto 0); -- Barramento de Controle

    -- Registradores e sinais internos da CPU
    signal A, B, R, PC : STD_LOGIC_VECTOR(7 downto 0); -- Registradores principais
    signal ALUop       : STD_LOGIC_VECTOR(2 downto 0); -- Operação da ALU
    signal ZeroFlag    : STD_LOGIC;                    -- Flag Zero da ALU
begin

    -- Unidade de Controle
    ControlUnit: process(control_bus)
    begin
        case control_bus is
            when "0000" => control_bus <= "1000"; -- Exemplo: LOAD
            when "0001" => control_bus <= "0100"; -- Exemplo: STORE
            when "0010" => control_bus <= "0010"; -- Exemplo: ADD
            when "0011" => control_bus <= "0001"; -- Exemplo: SUB
            when others => control_bus <= (others => '0');
        end case;
    end process;

    -- ALU (Unidade Lógica e Aritmética)
    ALU: process(A, B, ALUop)
    begin
        case ALUop is
            when "000" => R <= A + B;                  -- ADD
            when "001" => R <= A - B;                  -- SUB
            when "010" => R <= A and B;                -- AND
            when "011" => R <= A or B;                 -- OR
            when "100" => R <= not A;                  -- NOT
            when others => R <= (others => '0');
        end case;

        -- Atualiza a flag Zero se o resultado for zero
        ZeroFlag <= '1' when R = "00000000" else '0';
    end process;

    -- CPU principal
    CPU: process(clk, reset)
    begin
        if reset = '1' then
            PC <= (others => '0');
            A <= (others => '0');
            B <= (others => '0');
            R <= (others => '0');
        elsif rising_edge(clk) then
            -- Controle de fluxo e execução das instruções
            if control_bus(3) = '1' then  -- LOAD
                A <= data_bus;
            elsif control_bus(2) = '1' then  -- STORE
                addr_bus <= PC;
                data_bus <= A;
            end if;
        end if;
    end process;

    -- Memória Simples
    Memory: process(clk)
        type memory_array is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
        signal memory : memory_array := (others => (others => '0'));
    begin
        if control_bus(3) = '1' then  -- Leitura de Memória
            data_bus <= memory(to_integer(unsigned(addr_bus)));
        elsif control_bus(2) = '1' then  -- Escrita de Memória
            memory(to_integer(unsigned(addr_bus))) <= data_bus;
        end if;
    end process;

end Behavioral;
```

.py

```py
# Dicionário de instruções e seus opcodes em binário
instruction_set = {
    'ADD': '0001',
    'SUB': '0010',
    'AND': '0011',
    'OR':  '0100',
    'NOT': '0101',
    'CMP': '0110',
    'JMP': '0111',
    'JEQ': '1000',
    'JGR': '1001',
    'LOAD': '1010',
    'STORE': '1011',
    'MOV': '1100',
    'IN': '1101',
    'OUT': '1110',
    'WAIT': '1111'
}

# Dicionário para conversão dos registradores para binário
register_set = {
    'A': '000',
    'B': '001',
    'R': '010',
    'PC': '011',
    'IR': '100'
}

# Função para converter uma linha de código assembly em binário
def assembly_to_binary(assembly_code):
    binary_code = []
    
    for line in assembly_code.splitlines():
        # Divide a linha em instruções e operandos
        parts = line.split()
        if not parts:
            continue  # Pula linhas vazias
        
        instruction = parts[0].upper()
        opcode = instruction_set.get(instruction)
        
        if opcode is None:
            print(f"Instrução inválida: {instruction}")
            continue

        # Inicia a linha de código binário com o opcode
        binary_line = opcode
        
        # Trata as instruções com diferentes números de operandos
        if instruction in ['ADD', 'SUB', 'AND', 'OR', 'MOV']:
            reg1 = register_set.get(parts[1].rstrip(','), '000')
            reg2 = register_set.get(parts[2], '000')
            binary_line += reg1 + reg2 + '0000'  # Usando 8 bits para registros

        elif instruction in ['NOT', 'IN', 'OUT']:
            reg1 = register_set.get(parts[1], '000')
            binary_line += reg1 + '00000000'  # Operações de um registro

        elif instruction in ['JMP', 'JEQ', 'JGR']:
            addr = format(int(parts[1]), '08b')
            binary_line += addr  # Adiciona o endereço de 8 bits
        
        elif instruction in ['LOAD', 'STORE']:
            reg1 = register_set.get(parts[1].rstrip(','), '000')
            addr = format(int(parts[2]), '08b')
            binary_line += reg1 + addr  # Registro + endereço de 8 bits

        elif instruction == 'WAIT':
            binary_line += '00000000'  # WAIT não possui operandos

        # Adiciona a linha convertida para binário na lista final
        binary_code.append(binary_line)
    
    return binary_code


# Teste com um programa de exemplo em assembly
assembly_program = """
LOAD A, 5
ADD A, B
STORE A, 10
JMP 20
WAIT
"""

# Converte o programa para binário
binary_program = assembly_to_binary(assembly_program)

# Imprime cada instrução em binário
for binary_line in binary_program:
    print(binary_line)
```


