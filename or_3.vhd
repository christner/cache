--------------------------------------------------------------------------------------------------
--
-- Entity: or3
-- Architecture : structural
-- Author: cpatel2
-- Created On: 11/11/2003
-- Description:
--
--------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity or_3 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    input3   : in  std_logic;
    output   : out std_logic);
end or_3;

architecture structural of or_3 is
begin

  output <= input3 or input2 or input1;

end structural;

--------------------------------------------------------------------------------------------------
