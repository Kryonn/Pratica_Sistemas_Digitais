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
![Capturar](https://github.com/user-attachments/assets/aa27b310-7eb5-43c3-9234-c00b2f925c54)

Simulação:

## Part 2

VHDL:
```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity part2 is
	port(address : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock : IN STD_LOGIC := '1';
		data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		wren : IN STD_LOGIC ;
		out0 : out std_logic_vector(6 downto 0);
		out2 : out std_logic_vector(6 downto 0);
		out4 : out std_logic_vector(6 downto 0);
		out5 : out std_logic_vector(6 downto 0));
end part2;

architecture be of part2 is
	
	component ram32x4
		PORT ( address : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
				clock : IN STD_LOGIC := '1';
				data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
				wren : IN STD_LOGIC ;
				q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0) );
	end component;
	
	component display
		port(
			S0 :  IN  STD_LOGIC;
			S1 :  IN  STD_LOGIC;
			S2 :  IN  STD_LOGIC;
			S3 :  IN  STD_LOGIC;
			p0 :  OUT  STD_LOGIC;
			p1 :  OUT  STD_LOGIC;
			p2 :  OUT  STD_LOGIC;
			p3 :  OUT  STD_LOGIC;
			p4 :  OUT  STD_LOGIC;
			p5 :  OUT  STD_LOGIC;
			p6 :  OUT  STD_LOGIC
		);
	end component;
		
	signal q: std_logic_vector(3 downto 0);
	
	
begin

	inst1: ram32x4
	port map(address => address,
				clock => clock,
				data => data,
				wren => wren,
				q => q);
				
	display_ad1: display
	port map(S0 => address(0),
				S1 => address(1),
				S2 => address(2),
				S3 => address(3),
				p0 => out4(0),
				p1 => out4(1),
				p2 => out4(2),
				p3 => out4(3),
				p4 => out4(4),
				p5 => out4(5),
				p6 => out4(6));
				
	display_ad2: display
	port map(S0 => address(4),
				S1 => '0',
				S2 => '0',
				S3 => '0',
				p0 => out5(0),
				p1 => out5(1),
				p2 => out5(2),
				p3 => out5(3),
				p4 => out5(4),
				p5 => out5(5),
				p6 => out5(6));
				
	display_data: display
	port map(S0 => data(0),
				S1 => data(1),
				S2 => data(2),
				S3 => data(3),
				p0 => out2(0),
				p1 => out2(1),
				p2 => out2(2),
				p3 => out2(3),
				p4 => out2(4),
				p5 => out2(5),
				p6 => out2(6));
				
	display_read: display
	port map(S0 => q(0),
				S1 => q(1),
				S2 => q(2),
				S3 => q(3),
				p0 => out0(0),
				p1 => out0(1),
				p2 => out0(2),
				p3 => out0(3),
				p4 => out0(4),
				p5 => out0(5),
				p6 => out0(6));
	

end be;
```




