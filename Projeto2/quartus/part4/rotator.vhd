library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rotator is
    port(clk, rst: in std_logic;
        d: out std_logic_vector(27 downto 0));
end rotator;

architecture rot of rotator is

    component display
        port(s0, s1, s2, s3: in std_logic;
            p0, p1, p2, p3, p4, p5, p6: out std_logic);
    end component;

    signal clk_1sec: std_logic := '0';
    constant ac: integer range 0 to 24999999 := 24999999;
    signal counter1: std_logic_vector(26 downto 0) := (others => '0');
    signal counter2: std_logic_vector(1 downto 0):= (others => '0');
    signal ini: std_logic_vector(15 downto 0) := "1000110111100000";
    signal n1: std_logic_vector(15 downto 0) := "1101111000001000";
    signal n2: std_logic_vector(15 downto 0) := "1110000010001101";
    signal n3: std_logic_vector(15 downto 0) := "0000100011011110";
    signal q: std_logic_vector(15 downto 0) := "0000000000000000";
	 signal nd: std_logic_vector(27 downto 0) := (others => '0');
    
begin
    process(clk)
    begin
        if(rising_edge(clk))then
            if(unsigned(counter1) = ac) then
                clk_1sec <= not clk_1sec;
                counter1 <= (others => '0');
            else
                counter1 <= std_logic_vector(unsigned(counter1) + 1);
            end if;
        end if;
    end process;

    process(clk_1sec, rst)
    begin
        if(rst = '1') then
            counter2 <= (others => '0');
        elsif (rising_edge(clk_1sec)) then
            if(counter2 = "11") then
                counter2 <= (others => '0');
            else
                counter2 <= std_logic_vector(unsigned(counter2) + 1);
            end if;
        end if;
    end process;

    process(counter2)
    begin
        case (counter2) is
            when "00" =>
                q <= ini;
            when "01" =>
                q <= n1;
            when "10" =>
                q <= n2;
            when "11" =>
                q <= n3;
        end case;
    end process;
	 
	 process(q)
	 begin
		if(q(3 downto 0) = "1000") then
			d(6 downto 0) <= not nd(6 downto 0);
		else
			d(6 downto 0) <= nd(6 downto 0);
		end if;
		
		if(q(7 downto 4) = "1000") then
			d(13 downto 7) <= not nd(13 downto 7);
		else
			d(13 downto 7) <= nd(13 downto 7);
		end if;
		
		if(q(11 downto 8) = "1000") then
			d(20 downto 14) <= not nd(20 downto 14);
		else
			d(20 downto 14) <= nd(20 downto 14);
		end if;
		
		if(q(15 downto 12) = "1000") then
			d(27 downto 21) <= not nd(27 downto 21);
		else
			d(27 downto 21) <= nd(27 downto 21);
		end if;
		
	end process;

    inst1: display
    port map(s0 => q(0),
             s1 => q(1),
             s2 => q(2),
             s3 => q(3),
             p0 => nd(0),
             p1 => nd(1),
             p2 => nd(2),
             p3 => nd(3),
             p4 => nd(4),
             p5 => nd(5),
             p6 => nd(6));

    inst2: display
    port map(s0 => q(4),
             s1 => q(5),
             s2 => q(6),
             s3 => q(7),
             p0 => nd(7),
             p1 => nd(8),
             p2 => nd(9),
             p3 => nd(10),
             p4 => nd(11),
             p5 => nd(12),
             p6 => nd(13));

    inst3: display
    port map(s0 => q(8),
             s1 => q(9),
             s2 => q(10),
             s3 => q(11),
             p0 => nd(14),
             p1 => nd(15),
             p2 => nd(16),
             p3 => nd(17),
             p4 => nd(18),
             p5 => nd(19),
             p6 => nd(20));
            
    inst4: display
    port map(s0 => q(12),
             s1 => q(13),
             s2 => q(14),
             s3 => q(15),
             p0 => nd(21),
             p1 => nd(22),
             p2 => nd(23),
             p3 => nd(24),
             p4 => nd(25),
             p5 => nd(26),
             p6 => nd(27));
    
end rot;