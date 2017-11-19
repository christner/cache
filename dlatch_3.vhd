--------------------------------------------------------------------------------------------------
--
-- Entity: dlatch
-- Architecture : structural
-- Author: cpatel2
-- Created On:
-- Description:
--
--------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity dlatch_3 is port (
    data      : in std_logic_vector( 2 downto 0 );
    clk       : in std_logic;
    rst       : in std_logic;
    output    : out std_logic_vector( 2 downto 0 );
    output_bar: out std_logic_vector( 2 downto 0 ));
end dlatch_3;

architecture structural of dlatch_3 is

    component dlatch port (
        d   : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        q   : out std_logic;
        qbar: out std_logic);
    end component;

    for dlatch_0, dlatch_1, dlatch_2 : dlatch use entity work.dlatch(structural);

begin

    dlatch_0 : dlatch port map (data(0), clk, rst, output(0), output_bar(0));
    dlatch_1 : dlatch port map (data(1), clk, rst, output(1), output_bar(1));
    dlatch_2 : dlatch port map (data(2), clk, rst, output(2), output_bar(2));

end structural;

--------------------------------------------------------------------------------------------------
