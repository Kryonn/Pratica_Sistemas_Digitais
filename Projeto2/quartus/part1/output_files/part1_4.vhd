library ieee;
use ieee.std_logic_1164.all;

entity part1_4 is
	port(en, clear, clk: in std_logic;
		q1,q2,q3,q4: out std_logic);
end part1_4;

	
architecture counter of part1_4 is

component tflipflop
	port(enable, clean, clk: in std_logic;
			q: out std_logic);
end component;


signal w1,w2,w3,w4,w5,w6,w7: std_logic;

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
				
				
	w2 <= w1 AND en;
	w4 <= w2 AND w3;
	w6 <= w5 AND w4;
	
	q1 <= w1;
	q2 <= w3;
	q3 <= w5;
	q4 <= w7;
	
	
	
--	q1 w1;
--	q2 w3;
--	q3 w5;
--	q4 w7;
--	q5 w9;
--	q6 w11;
--	q7 w13;
--	q8 w15;
				
end counter;
	
	
	
	
	
	
	