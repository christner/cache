----------------------------------------------------------------------------------------------
--
-- Entity: inverter8_1
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/16/2017
-- Description: 8 bit input inverter array
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity inverter8_1 is port (
    input: in std_logic_vector( 7 downto 0 );
    output : out std_logic_vector( 7 downto 0 ));
end inverter8_1;

architecture structural of inverter8_1 is

    component inverter port (
        input : in std_logic;
        output: out std_logic);
    end component;

    for inverter_0, inverter_1, inverter_2, inverter_3, inverter_4, inverter_5, inverter_6, inverter_7 : inverter use entity work.inverter(structural);

begin

  inverter_0 : inverter port map (input(0), output(0));
  inverter_1 : inverter port map (input(1), output(1));
  inverter_2 : inverter port map (input(2), output(2));
  inverter_3 : inverter port map (input(3), output(3));
  inverter_4 : inverter port map (input(4), output(4));
  inverter_5 : inverter port map (input(5), output(5));
  inverter_6 : inverter port map (input(6), output(6));
  inverter_7 : inverter port map (input(7), output(7));

end structural;
