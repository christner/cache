--------------------------------------------------------------------------------------------------
--
-- Entity: mux1_2
-- Architecture : structural
-- Author: danielc3
-- Created On:
-- Description: 1 bit 2 input mux
--
--------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity mux1_2 is port (
    input1: in std_logic;
    input2: in std_logic;
    sel   : in std_logic;
    output: out std_logic);
end mux1_2;

architecture structural of mux1_2 is

    component inverter port (
        input : in std_logic;
        output: out std_logic);
    end component;

    component and_2 port (
        input1: in std_logic;
        input2: in std_logic;
        output: out std_logic);
    end component;

    component or_2 port (
        input1: in std_logic;
        input2: in std_logic;
        output: out std_logic);
    end component;

    for inverter_0 : inverter use entity work.inverter(structural);
    for and_2_0, and_2_1 : and_2 use entity work.and_2(structural);
    for or_2_0 : or_2 use entity work.or_2(structural);

    signal selnot, tmp_and_2_0, tmp_and_2_1 : std_logic;

begin

    inverter_0 : inverter port map (sel, selnot);

    and_2_0 : and_2 port map (sel, input1, tmp_and_2_0);
    and_2_1 : and_2 port map (selnot, input2, tmp_and_2_1);

    or_2_0 : or_2 port map (tmp_and_2_0, tmp_and_2_1, output);

end structural;

--------------------------------------------------------------------------------------------------
