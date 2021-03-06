--------------------------------------------------------------------------------------------------
--
-- Entity: or2
-- Architecture : structural
-- Author: danielc3
-- Created On: 9/24/2017
-- Description:
--
--------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity or_2 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end or_2;

architecture structural of or_2 is
begin

  output <= input2 or input1;

end structural;

---------------------------------------------------------------------------------------------
