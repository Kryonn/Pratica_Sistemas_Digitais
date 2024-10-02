library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part4 is
	port(wraddress : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock : IN STD_LOGIC;
		data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		wren : IN STD_LOGIC ;
		rst  : in std_logic;
		out0 : out std_logic_vector(6 downto 0);
		out1 : out std_logic_vector(6 downto 0);
		out2 : out std_logic_vector(6 downto 0);
		out3 : out std_logic_vector(6 downto 0);
		out4 : out std_logic_vector(6 downto 0);
		out5 : out std_logic_vector(6 downto 0));
end part4;

architecture be of part4 is
	
	component ram32x4
		PORT ( wraddress : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
				 rdaddress : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
				clock : IN STD_LOGIC := '1';
				data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
				wren : IN STD_LOGIC ;
				q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0) );
	end component;
	
	component display
		port(
			S0 :  IN  STD_LOGIC;
			S1 :  IN  STD_LOGIC;
			S2 :  IN  STD_LOGIC;
			S3 :  IN  STD_LOGIC;
			p0 :  OUT  STD_LOGIC;
			p1 :  OUT  STD_LOGIC;
			p2 :  OUT  STD_LOGIC;
			p3 :  OUT  STD_LOGIC;
			p4 :  OUT  STD_LOGIC;
			p5 :  OUT  STD_LOGIC;
			p6 :  OUT  STD_LOGIC
		);
	end component;
		
	signal q: std_logic_vector(3 downto 0);
	signal counter: std_logic_vector(27 downto 0) := (others => '0');
	signal counter1: std_logic_vector(4 downto 0) := (others => '0');
	signal clk_1sec: std_logic := '0';
	
	
begin

	process(clock)
	begin
		if(rising_edge(clock)) then
			if(unsigned(counter) = 25000000) then
				counter <= (others => '0');
				clk_1sec <= not clk_1sec;
			else
				counter <= std_logic_vector(unsigned(counter)+1);
			end if;
		end if;
	end process;
	
	process(clk_1sec, rst)
	begin
		if(rst = '0') then
			counter1 <= (others => '0');
		elsif(rising_edge(clk_1sec)) then
			if(unsigned(counter1) = 31) then
				counter1 <= (others =>'0');
			else
				counter1 <= std_logic_vector(unsigned(counter1)+1);
			end if;
		end if;
	end process;
			

	inst1: ram32x4
	port map(wraddress => wraddress,
				rdaddress => counter1,
				clock => clock,
				data => data,
				wren => wren,
				q => q);
				
	display_ad1: display
	port map(S0 => wraddress(0),
				S1 => wraddress(1),
				S2 => wraddress(2),
				S3 => wraddress(3),
				p0 => out4(0),
				p1 => out4(1),
				p2 => out4(2),
				p3 => out4(3),
				p4 => out4(4),
				p5 => out4(5),
				p6 => out4(6));
				
	display_ad2: display
	port map(S0 => wraddress(4),
				S1 => '0',
				S2 => '0',
				S3 => '0',
				p0 => out5(0),
				p1 => out5(1),
				p2 => out5(2),
				p3 => out5(3),
				p4 => out5(4),
				p5 => out5(5),
				p6 => out5(6));
				
	display_data: display
	port map(S0 => data(0),
				S1 => data(1),
				S2 => data(2),
				S3 => data(3),
				p0 => out1(0),
				p1 => out1(1),
				p2 => out1(2),
				p3 => out1(3),
				p4 => out1(4),
				p5 => out1(5),
				p6 => out1(6));
				
	display_read: display
	port map(S0 => q(0),
				S1 => q(1),
				S2 => q(2),
				S3 => q(3),
				p0 => out0(0),
				p1 => out0(1),
				p2 => out0(2),
				p3 => out0(3),
				p4 => out0(4),
				p5 => out0(5),
				p6 => out0(6));
				
	display_read_ad1: display
	port map(S0 => counter1(0),
				S1 => counter1(1),
				S2 => counter1(2),
				S3 => counter1(3),
				p0 => out2(0),
				p1 => out2(1),
				p2 => out2(2),
				p3 => out2(3),
				p4 => out2(4),
				p5 => out2(5),
				p6 => out2(6));
	
	display_read_ad2: display
	port map(S0 => counter1(4),
				S1 => '0',
				S2 => '0',
				S3 => '0',
				p0 => out3(0),
				p1 => out3(1),
				p2 => out3(2),
				p3 => out3(3),
				p4 => out3(4),
				p5 => out3(5),
				p6 => out3(6));
	

end be;