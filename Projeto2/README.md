# Praticas em Sistemas Digitais - SSC0108

Projeto 2: 

# Introdução

Versão do Quartus: Quartus Prime 21.1 <br>
Versão ModelSim: ModelSim - Intel FPGA Starter Edition 10.5b <br>

# Resultados

A seguir estão os resultados obtidos e os codigos VHDL utilizados em cada uma das partes do Projeto.

## Part 1

RTL Viewer:

Codigo VHDL:
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
> obs: é necessário o arquivo do flip flop T.
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
### Display de 7 segmentos:
```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity display is
    port(s: in std_logic_vector(3 downto 0);
        p: out std_logic_vector(6 downto 0));
end display;

architecture behavior of display is
    begin
        process(s)
        begin
            case (s) is
                when "0000" =>
                    p <= "0000001";
                when "0001" =>
                    p <= "1001111";
                when "0010" =>
                    p <= "0010010";
                when "0011" =>
                    p <= "0000110";
                when "0100" =>
                    p <= "1001100";
                when "0101" =>
                    p <= "0100100";
                when "0110" =>
                    p <= "0100000";
                when "0111" =>
                    p <= "0001111";
                when "1000" =>
                    p <= "0000000";
                when "1001" =>
                    p <= "0000100";
                when "1010" =>
                    p <= "0001000";
                when "1011" =>
                    p <= "1100000";
                when "1100" =>
                    p <= "0110001"; 
                when "1101" =>
                    p <= "1000010";
                when "1110" =>
                    p <= "0110000";
                when "1111" =>
                    p <= "0111000";
            end case;
        end process;
    end behavior;
```

### Contador de 8 bits(com display):
> obs: é necessário os arquivos do flip flop T e do display.
```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity part1 is
	port(en, clear, clk: in std_logic;
    	q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14: out std_logic);
end part1;

    
architecture counter of part1 is

component tflipflop
	port(enable, clean, clk: in std_logic;
        	q: out std_logic);
end component;

component p004_2
	port(S0,S1,S2,S3: in std_logic;
    	P0,P1,P2,P3,P4,P5,P6: out std_logic);
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
           	 
	int9: p004_2
	port map(S0 => w1,
            	S1 => w3,
            	S2 => w5,
            	S3 => w7,
            	P0 => q1,
            	P1 => q2,
            	P2 => q3,
            	P3 => q4,
            	P4 => q5,
            	P5 => q6,
            	P6 => q7);
           	 
	int10: p004_2
	port map(S0 => w9,
            	S1 => w11,
            	S2 => w13,
            	S3 => w15,
            	P0 => q8,
            	P1 => q9,
            	P2 => q10,
            	P3 => q11,
            	P4 => q12,
            	P5 => q13,
            	P6 => q14);
           	 
	w2 <= w1 AND en;
	w4 <= w2 AND w3;
	w6 <= w5 AND w4;
	w8 <= w6 AND w7;
	w10 <= w8 AND w9;
	w12 <= w10 AND w11;
	w14 <= w12 AND w13;
    	 
end counter;
```
	
## Part 2

RTL Viewer:

Codigo VHDL:
### Contador de 1 segundo(sem display):
```VHDL
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_1sec is
    port(clk, rst: in std_logic;
        q: out std_logic_vector(3 downto 0));
end counter_1sec;

architecture behavior of counter_1sec is

    signal counter: std_logic_vector(26 downto 0) := (others => '0');
    signal counter_q: std_logic_vector(3 downto 0) := (others => '0');
    signal clk_1sec: std_logic := '0';
    constant max: unsigned(26 downto 0) := to_unsigned(25000000-1, 27);

begin
    process(clk)
    begin
        if(falling_edge(clk)) then 
            if(unsigned(counter) = max) then
                counter <= (others => '0');
                clk_1sec <= not clk_1sec;
            else
                counter <= std_logic_vector(unsigned(counter)+1);
            end if;
        end if;
    end process;
    
    process(clk_1sec, rst)
    begin
        if(rst = '1') then
            counter_q <= (others => '0');
        elsif(rising_edge(clk_1sec)) then
            if(counter_q = "1001") then
                counter_q <= (others => '0');
            else
                counter_q <= std_logic_vector(unsigned(counter_q) + 1);
            end if;
        end if;
    end process;
    q <= counter_q;
end behavior;
```

## Part 3

RTL Viewer:

Codigo VHDL:

## Part 4

RTL Viewer:

Codigo VHDL Principal:
