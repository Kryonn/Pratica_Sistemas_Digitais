# Praticas em Sistemas Digitais - SSC0108

Projeto 2: 

# Introdução

Versão do Quartus: Quartus Prime 21.1 <br>
Versão ModelSim: ModelSim - Intel FPGA Starter Edition 10.5b <br>

# Resultados

A seguir estão os resultados obtidos e os codigos VHDL utilizados em cada uma das partes do Projeto.

## Part 1

### Flip flop T:
```VHDL
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY tflipfliop IS
PORT ( enable, clean, Clk : IN STD_LOGIC ;
Q : OUT STD_LOGIC) ;
END tflipfliop ;

ARCHITECTURE Behavior OF tflipfliop IS
signal output : STD_LOGIC ;
BEGIN

PROCESS ( enable, clean, Clk )
BEGIN
IF falling_edge(Clk)  THEN
	if clean='1' then
		output <='0';
	elsif enable ='1' then
		output <=not(output);
	else 
		output <= output ;
	
END IF ;

		
END IF ;
END PROCESS ;
Q<=output ;
END Behavior ;
```
### Contador de 8 bits(sem display):
```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity part1 is
	port(en, clear, clk: in std_logic;
    	q1,q2,q3,q4,q5,q6,q7,q8: out std_logic);
end part1;

    
architecture counter of part1 is

component tflipflop
	port(enable, clean, clk: in std_logic;
        	q: out std_logic);
end component;

signal w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15: std_logic;

begin
	int1: tflipflop
	port map(enable => en,
            	clean => clear,
            	clk => clk,
            	q => w1);
           	 
    
    
	int2: tflipflop
	port map(enable => w2,
            	clean => clear,
            	clk => clk,
            	q => w3);
    
    
    
	int3: tflipflop
	port map(enable => w4,
            	clean => clear,
            	clk => clk,
            	q => w5);
           	 
    
    
	int4: tflipflop
	port map(enable => w6,
            	clean => clear,
            	clk => clk,
            	q => w7);
    
    
    
	int5: tflipflop
	port map(enable => w8,
            	clean => clear,
            	clk => clk,
            	q => w9);
           	 
    
    
	int6: tflipflop
	port map(enable => w10,
            	clean => clear,
            	clk => clk,
            	q => w11);
    
    
    
	int7: tflipflop
	port map(enable => w12,
            	clean => clear,
            	clk => clk,
            	q => w13);
           	 
    
    
	int8: tflipflop
	port map(enable => w14,
            	clean => clear,
            	clk => clk,
            	q => w15);
           	 
	w2 <= w1 AND en;
	w4 <= w2 AND w3;
	w6 <= w5 AND w4;
	w8 <= w6 AND w7;
	w10 <= w8 AND w9;
	w12 <= w10 AND w11;
	w14 <= w12 AND w13;
           	  
	q1 <= w1;
	q2 <= w3;
	q3 <= w5;
	q4 <= w7;
	q5 <= w9;
	q6 <= w11;
	q7 <= w13;
	q8 <= w15;

end counter;
```
RTL Viewer:


Codigo VHDL:
	
## Part 2

RTL Viewer:

Codigo VHDL:

## Part 3

RTL Viewer:

Codigo VHDL:

## Part 4

RTL Viewer:

Codigo VHDL Principal:
