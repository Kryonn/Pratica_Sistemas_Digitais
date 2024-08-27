# Praticas em Sistemas Digitais - SSC0108

Projeto 1: Latches, Flip-flops, and Registers.

# Introdução

Versão do Quartus: Quartus Prime 21.1 <br>
Versão ModelSim: ModelSim - Intel FPGA Starter Edition 10.5b <br>

# Resultados

A seguir estão os resultados obtidos e os codigos VHDL utilizados em cada uma das partes do Projeto.

## Part 1

RTL Viewer:

<div align ="center">
    <img src ="imgs/Part1_Img1.png" style="max-width: 100%;" alt="img1">
</div>

Technology Map Viewer:

<div align ="center">
    <img src ="imgs/Part1_Img2.png" style="max-width: 100%;" alt="img1">
</div>

Gráfico de ondas da simulação(Modelsim):

<div align ="center">
    <img src ="imgs/Part1_Img3.png" style="max-width: 100%;" alt="img1">
</div>

Codigo VHDL:

```
LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part1 IS
PORT ( Clk, R, S : IN STD_LOGIC;
Q : OUT STD_LOGIC);
END part1;
ARCHITECTURE Structural OF part1 IS
SIGNAL R_g, S_g, Qa, Qb : STD_LOGIC ;
ATTRIBUTE KEEP : BOOLEAN;
ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;
BEGIN
R_g <= R AND Clk;
S_g <= S AND Clk;
Qa <= NOT (R_g OR Qb);
Qb <= NOT (S_g OR Qa);
Q <= Qa;
END Structural;

```
<a href = "Block1.bdf">Link</a>
	
## Part 2

RTL Viewer:

<div align ="center">
    <img src ="imgs/Part2_Img1.png" style="max-width: 100%;" alt="img1">
</div>

Technology Map Viewer:

<div align ="center">
    <img src ="imgs/Part2_Img2.png" style="max-width: 100%;" alt="img1">
</div>

Gráfico de ondas da simulação(Modelsim):

<div align ="center">
    <img src ="imgs/Part2_Img3.png" style="max-width: 100%;" alt="img1">
</div>

Codigo VHDL:

```
LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part2 IS
PORT ( Clk, D : IN STD_LOGIC;
Q, NQ : OUT STD_LOGIC);
END part2;
ARCHITECTURE Structural OF part2 IS
SIGNAL R_g, S_g, Qa, Qb : STD_LOGIC ;
ATTRIBUTE KEEP : BOOLEAN;
ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;
BEGIN
R_g <= (NOT D) NAND Clk;
S_g <= D NAND Clk;
Qa <= S_g NAND Qb;
Qb <= R_g NAND Qa;
Q <= Qa;
NQ <= Qb;
END Structural;

```

## Part 3

RTL Viewer:

<div align ="center">
    <img src ="imgs/Part3_Img1.png" style="max-width: 100%;" alt="img1">
</div>

Technology Map Viewer:

<div align ="center">
    <img src ="imgs/Part3_Img2.png" style="max-width: 100%;" alt="img1">
</div>


Codigo VHDL:

```
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY work;

ENTITY p02 IS
	PORT
	(
    	D :  IN  STD_LOGIC;
    	Clk :  IN  STD_LOGIC;
    	Q :  OUT  STD_LOGIC;
    	NQ :  OUT  STD_LOGIC
	);
END p02;

ARCHITECTURE bdf_type OF p02 IS

COMPONENT p01
	PORT(D : IN STD_LOGIC;
     	Clk : IN STD_LOGIC;
     	Qa : OUT STD_LOGIC;
     	Qb : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;


BEGIN

b2v_inst : p01
PORT MAP(D => D,
     	Clk => SYNTHESIZED_WIRE_0,
     	Qa => SYNTHESIZED_WIRE_1);


b2v_inst1 : p01
PORT MAP(D => SYNTHESIZED_WIRE_1,
     	Clk => Clk,
     	Qa => Q,
     	Qb => NQ);


SYNTHESIZED_WIRE_0 <= NOT(Clk);

END bdf_type;

```

## Part 4

RTL Viewer:

<div align ="center">
    <img src ="imgs/Part4_Img1.png" style="max-width: 100%;" alt="img1">
</div>

Gráfico de ondas da simulação(Modelsim):

<div align ="center">
    <img src ="imgs/Part4_Img2.png" style="max-width: 100%;" alt="img1">
</div>

Codigo VHDL Principal:

```
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
```

Codigo Latch 1:

```
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY latch1 IS
PORT ( D, Clk : IN STD_LOGIC ;
Q, NQ : OUT STD_LOGIC) ;
END latch1 ;
ARCHITECTURE Behavior OF latch1 IS
BEGIN
PROCESS ( D, Clk )
BEGIN
IF Clk = '1' THEN
Q <= D ;
NQ <= NOT(D);
END IF ;
END PROCESS ;
END Behavior ;

```

Codigo Latch 2:

```
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
ENTITY latch2 IS
PORT ( D, Clk : IN STD_LOGIC ;
Q, NQ : OUT STD_LOGIC) ;
END latch2 ;
ARCHITECTURE Behavior OF latch2 IS
BEGIN
PROCESS ( D, Clk )
BEGIN
IF rising_edge(Clk) THEN
Q <= D ;
NQ <= NOT(D) ;
END IF ;
END PROCESS ;
END Behavior ;

```
