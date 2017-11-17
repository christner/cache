----------------------------------------------------------------------------------------------
--
-- Entity: and8_2
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/16/2017
-- Description: 8 bit 2 input and gate
--
----------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity and8_2 is port (
    input1: in std_logic_vector( 7 downto 0 );
    input2: in std_logic_vector( 7 downto 0 );
    output : out std_logic_vector( 7 downto 0 ));
end and8_2;

architecture structural of and8_2 is

    component and_2 port (
        input1 : in std_logic;
        input2 : in std_logic;
        output: out std_logic);
    end component;

    for and_2_0, and_2_1, and_2_2, and_2_3, and_2_4, and_2_5, and_2_6, and_2_7 : and_2 use entity work.and_2(structural);

begin

  and_2_0 : and_2 port map (input1(0), input2(0), output(0));
  and_2_1 : and_2 port map (input1(1), input2(1), output(1));
  and_2_2 : and_2 port map (input1(2), input2(2), output(2));
  and_2_3 : and_2 port map (input1(3), input2(3), output(3));
  and_2_4 : and_2 port map (input1(4), input2(4), output(4));
  and_2_5 : and_2 port map (input1(5), input2(5), output(5));
  and_2_6 : and_2 port map (input1(6), input2(6), output(6));
  and_2_7 : and_2 port map (input1(7), input2(7), output(7));

end structural;
