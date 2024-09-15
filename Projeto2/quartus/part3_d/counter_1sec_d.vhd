library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_1sec_d is
    port(clk, rst: in std_logic;
        q: out std_logic_vector(6 downto 0));
end counter_1sec_d;

architecture behavior of counter_1sec_d is

    component display
    port(s0, s1, s2, s3: in std_logic;
        p0, p1, p2, p3, p4, p5, p6: out std_logic);
    end component;

    signal counter: std_logic_vector(26 downto 0) := (others => '0');
    signal counter_q: std_logic_vector(3 downto 0) := (others => '0');
    signal clk_1sec: std_logic := '0';
    constant max: unsigned(26 downto 0) := to_unsigned(25000000-1, 27);

begin
    process(clk)
    begin
        if(falling_edge(clk)) then 
            if(unsigned(counter) = max) then
                counter <= (others => '0');
                clk_1sec <= not clk_1sec;
            else
                counter <= std_logic_vector(unsigned(counter)+1);
            end if;
        end if;
    end process;
    
    process(clk_1sec, rst)
    begin
        if(rst = '1') then
            counter_q <= (others => '0');
        elsif(rising_edge(clk_1sec)) then
            if(counter_q = "1001") then
                counter_q <= (others => '0');
            else
                counter_q <= std_logic_vector(unsigned(counter_q) + 1);
            end if;
        end if;
    end process;
    
    inst: display
    port map(s0 => counter_q(0),
             s1 => counter_q(1),
             s2 => counter_q(2),
             s3 => counter_q(3),
             p0 => q(0),
             p1 => q(1),
             p2 => q(2),
             p3 => q(3),
             p4 => q(4),
             p5 => q(5),
             p6 => q(6));

end behavior;