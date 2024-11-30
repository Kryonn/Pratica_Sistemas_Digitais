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
le do arquivo

```py
# DicionC!rio de instruC'C5es e seus opcodes em binC!rio
instruction_set = {
    "ADD": "0000",
    "SUB": "0001",
    "AND": "0010",
    "OR": "0011",
    "NOT": "0100",
    "CMP": "0101",
    "JMP": "0110",
    "JEQ": "0111",
    "JGR": "1000",
    "LOAD": "1001",
    "STORE": "1010",
    "MOV": "1011",
    "IN": "1100",
    "OUT": "1101",
    "WAIT": "1110",
}

# DicionC!rio para conversC#o dos registradores para binC!rio (2 bits)
register_set = {
    "A": "00",
    "B": "01",
    "R": "10",
    "I": "11",
}

# FunC'C#o para converter uma linha de cC3digo assembly em binC!rio
def assembly_to_binary(assembly_code):
    binary_code = []
    comments = []

    for line in assembly_code.splitlines():
        # Divide a linha em instruC'C5es e operandos
        parts = line.split()
        if not parts:
            continue  # Pula linhas vazias

        instruction = parts[0].upper()
        opcode = instruction_set.get(instruction)

        if opcode is None:
            print(f"InstruC'C#o invC!lida: {instruction}")
            continue

        # Inicia a linha de cC3digo binC!rio com o opcode
        binary_line = opcode
        comment = ""

        # Trata as instruC'C5es com diferentes nC:meros de operandos
        if instruction in ["ADD", "SUB", "AND", "OR", "MOV"]:
            # OperaC'C5es com dois registradores (4 bits para instruC'C#o e 4 bits para dois registradores)
            reg1 = register_set.get(parts[1].rstrip(","), "00")
            reg2 = register_set.get(parts[2], "00")
            binary_line += reg1 + reg2  # Adiciona os registradores (2 bits cada)
            comment = f"-- {instruction} {parts[1]} + {parts[2]}"

        elif instruction in ["NOT", "IN", "OUT"]:
            # OperaC'C5es com um registrador (2 bits para registrador e 2 bits para operaC'C#o)
            reg1 = register_set.get(parts[1], "00")
            binary_line += reg1 + "00"  # OperaC'C5es com um registro
            comment = f"-- {instruction} {parts[1]}"

        elif instruction in ["JMP", "JEQ", "JGR"]:
            # InstruC'C5es de salto (sem registradores, sC3 endereC'o de 8 bits)
            addr = format(
                int(parts[1]), "08b"
            )  # Converte o endereC'o para binC!rio de 8 bits
            binary_line += addr  # Adiciona o endereC'o
            comment = f"-- {instruction} {parts[1]}"

        elif instruction in ["LOAD", "STORE"]:
            # InstruC'C5es de carga/armazenamento (registrador + endereC'o de 8 bits)
            reg1 = register_set.get(parts[1].rstrip(","), "00")
            addr = format(
                int(parts[2]), "08b"
            )  # Converte o endereC'o para binC!rio de 8 bits
            binary_line += reg1 + addr  # Registro + endereC'o de 8 bits
            comment = f"-- {instruction} {parts[1]} {parts[2]}"

        elif instruction == "WAIT":
            # WAIT nC#o possui operandos
            binary_line += "0000"  # WAIT com cC3digo de operaC'C#o de 8 bits
            comment = "-- WAIT"

        # Adiciona a linha convertida para binC!rio e o comentC!rio na lista final
        binary_code.append(f"{binary_line} {comment}")

    return binary_code


# FunC'C#o para gerar o arquivo .mif a partir do cC3digo binC!rio
def generate_mif(binary_code, file_name="program.mif"):
    # Definir as caracterC-sticas da memC3ria
    depth = 256  # NC:mero de endereC'os (deve ser 256 conforme solicitado)
    width = 8  # Cada linha tem 8 bits

    # Criar e abrir o arquivo .mif
    with open(file_name, "w") as mif_file:
        mif_file.write("-- Arquivo de inicializaC'C#o de memC3ria\n")
        mif_file.write(f"DEPTH = {depth};\n")
        mif_file.write(f"WIDTH = {width};\n")
        mif_file.write("ADDRESS_RADIX = HEX;\n")
        mif_file.write("DATA_RADIX = BIN;\n")
        mif_file.write("CONTENT\nBEGIN\n")

        # Escrever cada linha de cC3digo binC!rio no arquivo .mif
        for i, binary_line in enumerate(binary_code):
            # Escreve o endereC'o (em hexadecimal) e a instruC'C#o correspondente
            mif_file.write(f"{format(i, 'X')} : {binary_line};\n")

        mif_file.write("END;\n")
    print(f"Arquivo .mif gerado: {file_name}")


# Exemplo de uso:
assembly_program = """
ADD A, B
SUB A, B
ADD A, I
MOV A, R
IN B
WAIT
"""

# Converte o programa para binC!rio
binary_program = assembly_to_binary(assembly_program)

# Gera o arquivo .mif com o cC3digo binC!rio
generate_mif(binary_program, "program.mif")
```


