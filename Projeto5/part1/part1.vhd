library ieee;
use ieee.std_logic_1164.all;

entity part1 is
    port(w: in std_logic;
       rst: in std_logic;   
       clk: in std_logic;
         z: out std_logic;
       led: out std_logic_vector(8 downto 0));
end part1;

architecture be of part1 is

    signal state: std_logic_vector(8 downto 0) := "000000001";
	 signal cond1: std_logic;
	 signal cond2: std_logic;

begin

    process(clk, rst, w)
    begin
        if(rst = '0') then
            state <= "000000001";
        else
            if(rising_edge(clk)) then
                if(w = '1') then   
                    if(cond1 = '1') then
                        state <= "000100000";
                    else
                        case(state) is
                            when "000100000" =>
                                state <= "001000000";
                            when "001000000" =>
                                state <= "010000000";
                            when "010000000" =>
                                state <= "100000000";
                            when "100000000"  =>
                                state <= "100000000";
									 when others =>
										  state <= "000000001";
                        end case;
                    end if;
                else
                    if(cond2 = '1') then
                        state <= "000000010";
                    else
                        case(state) is
                            when "000000010" =>
                                state <= "000000100";
                            when "000000100" =>
                                state <= "000001000";
                            when "000001000" =>
                                state <= "000010000";
                            when "000010000" =>
                                state <= "000010000";
									 when others =>
										  state <= "000000001";
                        end case;
                    end if;
                end if;
            end if;
        end if;
    end process;

	 cond1 <= state(0) or state(1) or state(2) or state(3) or state(4);
	 cond2 <= state(0) or state(5) or state(6) or state(7) or state(8);
    led <= state;
    z <= state(4) or state(8);
end be;