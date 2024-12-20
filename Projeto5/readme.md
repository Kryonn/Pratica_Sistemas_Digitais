# Praticas em Sistemas Digitais - SSC0108

Projeto 5: 

# Introdução

Versão do Quartus: Quartus Prime 21.1 <br>
Versão ModelSim: ModelSim - Intel FPGA Starter Edition 10.5b <br>

# Resultados

A seguir estão os resultados obtidos e os codigos VHDL utilizados em cada uma das partes do Projeto.

## Part 1
VHDL:
```VHDL
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
```

## Part 4
```VHDL
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity part4 is
	port(letter: in std_logic_vector(2 downto 0);
			b0, b1, clk: in std_logic;
			led: out std_logic);
end part4;

architecture be of part4 is

	
	signal counter: std_logic_vector(26 downto 0) := (others => '0');
	signal counter2: std_logic_vector(3 downto 0) := (others => '0');
	signal clk_05: std_logic;
	signal state: std_logic_vector(3 downto 0) := "0000";
	signal flag: std_logic := '0';
	signal w: std_logic := '0';
	-- sinais: apagado: "000", A: "0001", B: "0010", C: "0011", D: "0100", E: "0101", F: "0110", G: "0111", H:"1000"
	
	signal a: std_logic_vector(11 downto 0) := "010111000000";
	signal b: std_logic_vector(11 downto 0) := "011101010100";
	signal c: std_logic_vector(11 downto 0) := "011101011101";
	signal d: std_logic_vector(11 downto 0) := "011101010000";
	signal e: std_logic_vector(11 downto 0) := "010000000000";
	signal f: std_logic_vector(11 downto 0) := "010101110100";
	signal g: std_logic_vector(11 downto 0) := "011101110100";
	signal h: std_logic_vector(11 downto 0) := "010101010000";
	signal res: std_logic_vector(11 downto 0) := "000000000000";
	
	signal a_b: integer range 0 to 5 := 5;
	signal b_b: integer range 0 to 9 := 9;
	signal c_b: integer range 0 to 12 := 12;
	signal d_b: integer range 0 to 8 := 8;
	signal e_b: integer range 0 to 2 := 2;
	signal f_b: integer range 0 to 10 := 10;
	signal g_b: integer range 0 to 10 := 10;
	signal h_b: integer range 0 to 8 := 8;
	signal res_b: integer range 0 to 12 := 0;
	
begin

	process(clk)
	begin
		if(w = '1') then
			if(rising_edge(clk)) then
				if(unsigned(counter) = 12499999) then
					counter <= (others => '0');
					clk_05 <= not clk_05;
				else
					counter <= std_logic_vector(unsigned(counter)+1);
				end if;
			end if;
		else
			counter<= (others => '0');
		end if;
	end process;
	
	process(letter, b1, b0)
	begin
		if(b0 = '0')then
			state <= "0000";
			flag <= '0';
		elsif (falling_edge(b1) and flag = '0')then
				state <= '0' & letter;
		elsif(rising_edge(b1) and flag = '0') then
				flag <= '1';
				w <= '1';
		elsif(rising_edge(flag)) then
			case(state) is
				when "0000" =>
					res <= "000000000000";
					res_b <= 1;
				when "0001" =>
					res <= a;
					res_b <= a_b;
				when "0010" =>
					res <= b;
					res_b <= b_b;
				when "0011" =>
					res <= c;
					res_b <= c_b;
				when "0100" =>
					res <= d;
					res_b <= d_b;
				when "0101" =>
					res <= e;
					res_b <= e_b;
				when "0110" =>
					res <= f;
					res_b <= f_b;
				when "0111" =>
					res <= g;
					res_b <= g_b;
				when "1000" =>
					res <= h;
					res_b <= h_b;
				when others =>
					res <= h;
					res_b <= h_b;
			end case;
		elsif(flag = '1') then
			if(rising_edge(clk_05)) then
				if(unsigned(counter2) = res_b) then
					counter2 <= (others => '0');
					state <= "0000";
					flag <= '0';
				else
					counter2 <= std_logic_vector(unsigned(counter2)+1);
					res <= std_logic_vector(shift_left(unsigned(res), 1));
				end if;
			end if;
		elsif(falling_edge(flag)) then
			res <= "000000000000";
			w <= '0';
		end if;	
	end process;
	
	
	led <= res(11);


end be;
```
```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity part4 is
    port(sw: in std_logic_vector(2 downto 0);
        key: in std_logic_vector(1 downto 0);
        clk: in std_logic;
        led: out std_logic);
end part4;

architecture morse of part4 is

    signal counter: std_logic_vector(26 downto 0) := (others => '0');
    signal clk_05: std_logic := '0';
    signal a: std_logic_vector(11 downto 0) := "010111000000";
    signal b: std_logic_vector(11 downto 0) := "011101010100";
    signal c: std_logic_vector(11 downto 0) := "011101011101";
    signal d: std_logic_vector(11 downto 0) := "011101010000";
    signal e: std_logic_vector(11 downto 0) := "010000000000";
    signal f: std_logic_vector(11 downto 0) := "010101110100";
    signal g: std_logic_vector(11 downto 0) := "011101110100";
    signal h: std_logic_vector(11 downto 0) := "010101010000";
    signal res: std_logic_vector(11 downto 0) := "000000000000";
    signal a_b: integer range 0 to 5 := 5;
    signal b_b: integer range 0 to 9 := 9;
    signal c_b: integer range 0 to 12 := 12;
    signal d_b: integer range 0 to 8 := 8;
    signal e_b: integer range 0 to 2 := 2;
    signal f_b: integer range 0 to 10 := 10;
    signal g_b: integer range 0 to 10 := 10;
    signal h_b: integer range 0 to 8 := 8;
    signal res_b: integer range 0 to 12 := 0;
    signal enable: std_logic := '0';
    signal load: std_logic := '0';
    signal state: std_logic := '0';
    signal counting: std_logic := '0';

begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(unsigned(counter) = 12500000) then
                counter <= (others => '0');
                clk_05 = not clk_05;
            else
                counter <= std_logic_vector(unsigned(counter)+1);
            end if;
        end if;
    end process;

    process(sw, enable, load)
    begin
        if(enable = '0') then
            res <= "000000000000";
        elsif(load = '1') then
            case(sw) is
                when "000" =>
                    res <= a;
                    res_b <= a_b;
                when "001" =>
                    res <= b;
                    res_b <= b_b;
                when "010" =>
                    res <= c;
                    res_b <= c_b;
                when "011" =>
                    res <= d;
                    res_b <= d_b;
                when "100" =>
                    res <= e;
                    res_b <= e_b;
                when "101" =>
                    res <= f;
                    res_b <= f_b;
                when "110" =>
                    res <= g;
                    res_b <= g_b;
                when "111" =>
                    res <= h;
                    res_b <= h_b;
            end case;
        elsif(counting = '1') then
            case()
    end process;
    
    -- casos: 00 => zerar, 01 => setar valores, 10 => contagem 
    process(key(0), key(1), clk_05)
    begin
        if(key(0) = '0') then
            enable = '0';
            load = '0';
            counting = '0';
        elsif(rising_edge(key(1))) then
            enable = '1';
            load = 1;
            counting = '0';
        elsif(falling_edge(key(1))) then
            enable = '1';
            load = '0';
            counting = '1';
        end if;
    end process;
        




    end process;


end morse;
```

```VHDL

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY morse IS
    PORT (
        sw    : IN  std_logic_vector(2 downto 0); -- Seleção da letra (000 para A, 001 para B, etc.)
        key1  : IN  std_logic;                    -- Botão para iniciar a exibição do Morse
        key0  : IN  std_logic;                    -- Reset assíncrono
        clk   : IN  std_logic;                    -- Clock de 50MHz
        led   : OUT std_logic                     -- LED para exibir o código Morse
    );
END morse;

ARCHITECTURE Behavioral OF morse IS
    TYPE state_type IS (idle, dot, dash, wait_short, wait_long, finished);
    SIGNAL state, next_state : state_type;

    SIGNAL morse_code   : std_logic_vector(12 downto 0); -- Código Morse
    SIGNAL counter      : integer := 0;                   -- Contador para temporização
    SIGNAL bit_index    : integer := 0;                   -- Índice do bit do código Morse
    SIGNAL clk_div      : std_logic := '0';               -- Clock dividido
    CONSTANT dot_time   : integer := 25000000;            -- 0.5 segundos (com base em 50MHz)
BEGIN

    -- Processo para selecionar o código Morse baseado no switch
    PROCESS(sw, key1)
    BEGIN
        IF (key1 = '0') THEN
            CASE sw IS
                WHEN "000" => morse_code <= "0000000111010"; -- Letra A: .-     000000111010
                WHEN "001" => morse_code <= "0001010101110"; -- Letra B: -...   001010101110
                WHEN "010" => morse_code <= "0010111010111"; -- Letra C: -.-.   101110101110
                WHEN "011" => morse_code <= "0000010101110"; -- Letra D: -..    000010101110
                WHEN "100" => morse_code <= "0000000000001"; -- Letra E: .      
                WHEN "101" => morse_code <= "0001011101010"; -- Letra F: ..-.   001011101010
                WHEN "110" => morse_code <= "0001011101110"; -- Letra G: --.    001011101110
                WHEN "111" => morse_code <= "0000010101010"; -- Letra H: ....   000010101010
                WHEN OTHERS => morse_code <= "0000000000000"; -- Código padrão se nada for selecionado
            END CASE;
        END IF;
    END PROCESS;

    -- Processo principal para controle do estado
   PROCESS(clk, key0, key1)
	BEGIN
		 IF (key0 = '0') THEN -- Reset assíncrono
			  state <= idle;
			  counter <= 0;
			  led <= '0';
			  bit_index <= 0;
		 ELSIF rising_edge(clk) THEN
		 IF (key1 = '0') THEN
			  state <= next_state;
			  CASE state IS
					WHEN idle =>
						 IF bit_index < 13 THEN
							  IF morse_code(bit_index) = '1' THEN
									counter <= counter + 1;
									IF counter >= dot_time THEN
										 led <= '1';
										 next_state <= wait_short; -- Mover para o próximo estado
									END IF;

							  ELSIF morse_code(bit_index) = '0' THEN
									counter <= counter + 1;
									IF counter >= dot_time THEN
										 led <= '0';
										 next_state <= wait_short; -- Mover para o próximo estado
									END IF;
							  END IF;

						 ELSE
							  next_state <= finished; -- Acabou o código Morse
							  counter <= 0;
							  bit_index <= 0;
						 END IF;

					WHEN wait_short =>
						 IF counter >= dot_time THEN
							  counter <= 0;
							  bit_index <= bit_index + 1;
							  next_state <= idle;
						 END IF;

					WHEN finished =>
						 led <= '0';
						 next_state <= idle;
						 counter <= 0;
						 bit_index <= 0;

					WHEN OTHERS =>
						 next_state <= idle; -- Para evitar estados indefinidos
			  END CASE;
			END IF;
		 END IF;
	END PROCESS;

END Behavioral;
```
