library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity part2 is
    Port (
        clk    : in  STD_LOGIC;
        enable : in  STD_LOGIC;
        clear  : in  STD_LOGIC;
        seg1   : out STD_LOGIC_VECTOR(6 downto 0);
        seg2   : out STD_LOGIC_VECTOR(6 downto 0);
        seg3   : out STD_LOGIC_VECTOR(6 downto 0);
        seg4   : out STD_LOGIC_VECTOR(6 downto 0) 
    );
end part2;

architecture Behavioral of part2 is
    
    component display
        Port (
            bin   : in  STD_LOGIC_VECTOR(3 downto 0);
            seg   : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    
    signal Q       : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal nibble1 : STD_LOGIC_VECTOR(3 downto 0);
    signal nibble2 : STD_LOGIC_VECTOR(3 downto 0);
    signal nibble3 : STD_LOGIC_VECTOR(3 downto 0);
    signal nibble4 : STD_LOGIC_VECTOR(3 downto 0);

begin
    process(clk, clear)
    begin
        if clear = '1' then
            Q <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                Q <= std_logic_vector(unsigned(Q) + 1);
            end if;
        end if;
    end process;

    
    nibble1 <= Q(3 downto 0);
    nibble2 <= Q(7 downto 4);
    nibble3 <= Q(11 downto 8);
    nibble4 <= Q(15 downto 12);

    
    U1: display port map (bin => nibble1, seg => seg1);
    U2: display port map (bin => nibble2, seg => seg2);
    U3: display port map (bin => nibble3, seg => seg3);
    U4: display port map (bin => nibble4, seg => seg4);

end Behavioral;
