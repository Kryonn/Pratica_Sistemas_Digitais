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