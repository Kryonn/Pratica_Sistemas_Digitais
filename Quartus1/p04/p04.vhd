LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY p04 IS
	PORT
	(
    	D :  IN  STD_LOGIC;
    	Clk :  IN  STD_LOGIC;
    	Qa :  OUT  STD_LOGIC;
    	NQa :  OUT  STD_LOGIC;
		Qb :  OUT  STD_LOGIC;
    	NQb :  OUT  STD_LOGIC;
		Qc :  OUT  STD_LOGIC;
    	NQc :  OUT  STD_LOGIC
	);
END p04;

ARCHITECTURE bdf_type OF p04 IS

COMPONENT latch1
	PORT(D : IN STD_LOGIC;
     	Clk : IN STD_LOGIC;
     	Q : OUT STD_LOGIC;
     	NQ : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT latch2
	PORT(D : IN STD_LOGIC;
     	Clk : IN STD_LOGIC;
     	Q : OUT STD_LOGIC;
     	NQ : OUT STD_LOGIC
	);
END COMPONENT;


Signal w1: std_logic;


BEGIN


inst1 : latch1
PORT MAP(D => D,
     	Clk => Clk,
     	Q => Qa,
     	NQ => NQa);
		
inst2 : latch2
PORT MAP(D => D,
     	Clk => Clk,
     	Q => Qb,
     	NQ => NQb);
		
inst3 : latch2
PORT MAP(D => D,
     	Clk => w1,
     	Q => Qc,
     	NQ => NQc);


w1 <= NOT(Clk);



END bdf_type;
