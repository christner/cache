--------------------------------------------------------------------------------------------------
--
-- Entity: dlatch8
-- Architecture : structural
-- Author: cpatel2
-- Created On:
-- Description: 8 bit high level latch
--
--------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity dlatch8 is port (
    data      : in std_logic_vector( 2 downto 0 );
    clk       : in std_logic;
    rst       : in std_logic;
    output    : out std_logic_vector( 2 downto 0 );
    output_bar: out std_logic_vector( 2 downto 0 ));
end dlatch8;

architecture structural of dlatch8 is

    component dlatch port (
        d   : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        q   : out std_logic;
        qbar: out std_logic);
    end component;

    for dlatch_0, dlatch_1, dlatch_2, dlatch_3, dlatch_4, dlatch_5, dlatch_6, dlatch_7, dlatch_8 : dlatch use entity work.dlatch(structural);

begin

    dlatch_0 : dlatch port map (data(0), clk, rst, output(0), output_bar(0));
    dlatch_1 : dlatch port map (data(1), clk, rst, output(1), output_bar(1));
    dlatch_2 : dlatch port map (data(2), clk, rst, output(2), output_bar(2));
    dlatch_3 : dlatch port map (data(3), clk, rst, output(3), output_bar(2));
    dlatch_4 : dlatch port map (data(4), clk, rst, output(4), output_bar(2));
    dlatch_5 : dlatch port map (data(5), clk, rst, output(5), output_bar(2));
    dlatch_6 : dlatch port map (data(6), clk, rst, output(6), output_bar(2));
    dlatch_7 : dlatch port map (data(7), clk, rst, output(7), output_bar(2));

end structural;

--------------------------------------------------------------------------------------------------
