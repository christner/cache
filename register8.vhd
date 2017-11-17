----------------------------------------------------------------------------------------------
--
-- Entity: cache_byte
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/10/2017
-- Description: logical grouping of 8 cache cells into a single r/w enablable byte
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity register8 is port (
    clk   :
    input : in std_logic_vector(7 downto 0);
    output: in std_logic_vector( 7 downto 0 );
    data_r: out std_logic_vector( 7 downto 0 ));
end register8;

architecture structural of register8 is
    component dff port (
        d   : in  std_logic;
        clk : in  std_logic;
        q   : out std_logic;
        qbar: out std_logic);
    end component;

    for bit_0, bit_1, bit_2, bit_3, bit_4, bit_5, bit_6, bit_7 : dff use entity work.dff(structural);

    signal tmp : std_logic_vector( 7 downto 0);

begin

    bit_0: dff port map (input(0), clk, output(0), tmp(0));
    bit_1: dff port map (input(0), clk, output(1), tmp(1));
    bit_2: dff port map (input(0), clk, output(2), tmp(2));
    bit_3: dff port map (input(0), clk, output(3), tmp(3));
    bit_4: dff port map (input(0), clk, output(4), tmp(4));
    bit_5: dff port map (input(0), clk, output(5), tmp(5));
    bit_6: dff port map (input(0), clk, output(6), tmp(6));
    bit_7: dff port map (input(0), clk, output(7), tmp(7));

end structural;

----------------------------------------------------------------------------------------------
