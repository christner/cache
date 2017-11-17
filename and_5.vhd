----------------------------------------------------------------------------------------------------
--
-- Entity: and5
-- Architecture : structural
-- Author: katieb6
-- Created On: 11/12/2017
-- Description: four input and gate
--
----------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity and_5 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    input3   : in  std_logic;
    input4   : in  std_logic;
    input5   : in  std_logic;
    output   : out std_logic);
end and_5;

architecture structural of and_5 is
begin

  output <= input5 and input4 and input3 and input2 and input1;

end structural;

--------------------------------------------------------------------------------------------------
