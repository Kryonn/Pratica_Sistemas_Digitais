# Praticas em Sistemas Digitais - SSC0108

Projeto 4: 

# Introdução

Versão do Quartus: Quartus Prime 21.1 <br>
Versão ModelSim: ModelSim - Intel FPGA Starter Edition 10.5b <br>

# Resultados

A seguir estão os resultados obtidos e os codigos VHDL utilizados em cada uma das partes do Projeto.

## Part 1

VHDL:
```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity part1 is
	port(address : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock : IN STD_LOGIC := '1';
		data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		wren : IN STD_LOGIC ;
		q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0) );
end part1;

architecture be of part1 is
	
	component ram32x4
		PORT ( address : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
				clock : IN STD_LOGIC := '1';
				data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
				wren : IN STD_LOGIC ;
				q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0) );
	end component;
	
begin

	inst1: ram32x4
	port map(address => address,
				clock => clock,
				data => data,
				wren => wren,
				q => q);

end be;
```

Quantidade de blocos de memória:

![Captura de tela 2024-10-02 150334](https://github.com/user-attachments/assets/9241f033-fe86-43d8-9b12-19a32682b78d)

Simulação:




