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