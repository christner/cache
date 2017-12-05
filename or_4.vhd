--------------------------------------------------------------------------------------------------
--
-- Entity: or4
-- Architecture : structural
-- Author: danielc3
-- Created On: 11/11/2017
-- Description: 4 input or gate
--
--------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity or_4 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    input3   : in  std_logic;
    input4   : in  std_logic;
    output   : out std_logic);
end or_4;

architecture structural of or_4 is

  component or_2 port (
      input1: in std_logic;
      input2: in std_logic;
      output: out std_logic);
  end component;

  for or_2_0, or_2_1, or_2_2 : or_2 use entity work.or_2(structural);

  signal tmp_or_2_0, tmp_or_2_1 : std_logic;

begin

  or_2_0 : or_2 port map(input1, input2, tmp_or_2_0);
  or_2_1 : or_2 port map(input3, input4, tmp_or_2_1);
  or_2_2 : or_2 port map(tmp_or_2_0, tmp_or_2_1, output);

end structural;

--------------------------------------------------------------------------------------------------
