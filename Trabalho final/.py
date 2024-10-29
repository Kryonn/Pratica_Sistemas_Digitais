

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
