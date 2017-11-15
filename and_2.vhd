----------------------------------------------------------------------------------------------------
--
-- Entity: and2
-- Architecture : structural
-- Author: cpatel2
-- Created On: 11/11/2003
-- Description:
--
----------------------------------------------------------------------------------------------------

library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity and_2 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end and_2;

architecture structural of and_2 is
begin

  output <= input2 and input1;

end structural;

--------------------------------------------------------------------------------------------------
