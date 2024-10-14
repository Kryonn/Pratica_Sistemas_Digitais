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
