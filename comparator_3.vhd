----------------------------------------------------------------------------------------------------
--
-- Entity: comparator_3
-- Architecture : structural
-- Author: cpatel2
-- Created On: 11/15/2017
-- Description: 3 bit wide 2 input comparator
--
----------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity comparator_3 is port (
    input1   : in  std_logic_vector( 2 downto 0 );
    input2   : in  std_logic_vector( 2 downto 0 );
    output   : out std_logic);
end comparator_3;

architecture structural of comparator_3 is

  component and_3 port (
      input1: in std_logic;
      input2: in std_logic;
      input3: in std_logic;
      output: out std_logic);
  end component;

  component xnor_2 port (
      input1: in  std_logic;
      input2: in  std_logic;
      output: out std_logic);
  end component;

    for and_3_0 : and_3 use entity work.and_3(structural);

    for xnor_2_0, xnor_2_1, xnor_2_2 : xnor_2 use entity work.xnor_2(structural);

    signal tmp_0, tmp_1, tmp_2 : std_logic;

begin

    xnor_2_0 : xnor_2 port map (input1(0), input2(0), tmp_0);
    xnor_2_1 : xnor_2 port map (input1(1), input2(1), tmp_1);
    xnor_2_2 : xnor_2 port map (input1(2), input2(2), tmp_2);

    and_3_0 : and_3 port map (tmp_0, tmp_1, tmp_2, output);

end structural;

----------------------------------------------------------------------------------------------------
