LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY tflipflop IS
PORT ( enable, clean, Clk : IN STD_LOGIC ;
Q : OUT STD_LOGIC) ;
END tflipflop ;

ARCHITECTURE Behavior OF tflipflop IS
signal alt_put : STD_LOGIC ;
BEGIN

PROCESS ( enable, clean, Clk )
BEGIN
IF falling_edge(Clk)  THEN
	if clean ='1' then
		alt_put<='0';
	elsif enable='1' then
		alt_put<=not(alt_put);
	else 
		alt_put <= alt_put;
	
END IF ;

		
END IF ;
END PROCESS ;
Q<=alt_put;
END Behavior ;
