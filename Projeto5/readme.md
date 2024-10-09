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

entity fms is
    port(w: in std_logic;
       rst: in std_logic;   
       clk: in std_logic;
         z: out std_logic;
       led: out std_logic_vector(8 downto 0));
end fms;

architecture be of fms is

    signal state: std_logic_vector(8 downto 0) := "000000001";

begin

    process(clk, rst, w)
    begin
        if(rst = '0') then
            state <= "000000001";
        else
            if(rising_edge(clk)) then
                if(w = '1') then   
                    if(state(0) or state(1) or state(2) or state(3) or state(4)) then
                        state <= "000100000";
                    else
                        case(state)
                            when => "000100000"
                                state <= "001000000";
                            when => "001000000"
                                state <= "010000000";
                            when => "010000000"
                                state <= "100000000";
                            when => "100000000"
                                state <= "100000000";
                        end case;
                    end if;
                else
                    if(state(0) or state(5) or state(6) or state(7) or state(8)) then
                        state <= "000000010";
                    else
                        case(state)
                            when => "000000010"
                                state <= "001000100";
                            when => "000000100"
                                state <= "000001000";
                            when => "000001000"
                                state <= "000010000";
                            when => "000010000"
                                state <= "000100000";
                        end case;
                    end if;
                end if;
            end if;
        end if;
    end process;

    led <= state;
    z <= state(4) or state(8);
end be;
```

## Part 4
