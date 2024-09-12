-- Copyright (C) 2021  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 21.1.0 Build 842 10/21/2021 SJ Lite Edition"
-- CREATED		"Mon Aug 26 23:25:45 2024"

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