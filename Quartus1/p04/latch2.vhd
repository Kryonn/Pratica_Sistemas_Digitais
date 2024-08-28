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