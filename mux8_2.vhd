--------------------------------------------------------------------------------------------------
--
-- Entity: mux8_2
-- Architecture : structural
-- Author: danielc3
-- Created On:
-- Description: 8 bit 2 input mux
--
--------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity mux8_2 is port (
    input1: in std_logic_vector( 7 downto 0 );
    input2: in std_logic_vector( 7 downto 0 );
    sel   : in std_logic;
    output: out std_logic_vector( 7 downto 0 ));
end mux8_2;

architecture structural of mux8_2 is

    component mux1_2 port (
        input1: in std_logic;
        input2: in std_logic;
        sel   : in std_logic;
        output: out std_logic);
    end component;

    for mux1_2_0, mux1_2_1, mux1_2_2, mux1_2_3, mux1_2_4, mux1_2_5, mux1_2_6, mux1_2_7 : mux1_2 use entity work.mux1_2(structural);


begin

    mux1_2_0 : mux1_2  port map(input1(0), input2(0), sel, output(0));
    mux1_2_1 : mux1_2  port map(input1(1), input2(1), sel, output(1));
    mux1_2_2 : mux1_2  port map(input1(2), input2(2), sel, output(2));
    mux1_2_3 : mux1_2  port map(input1(3), input2(3), sel, output(3));
    mux1_2_4 : mux1_2  port map(input1(4), input2(4), sel, output(4));
    mux1_2_5 : mux1_2  port map(input1(5), input2(5), sel, output(5));
    mux1_2_6 : mux1_2  port map(input1(6), input2(6), sel, output(6));
    mux1_2_7 : mux1_2  port map(input1(7), input2(7), sel, output(7));

end structural;

--------------------------------------------------------------------------------------------------
