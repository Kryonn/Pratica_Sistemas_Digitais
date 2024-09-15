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
	
	
	
	
	
	
	