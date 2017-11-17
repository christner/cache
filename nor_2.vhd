library STD;
library IEEE;

use IEEE.std_logic_1164.all;

entity nor_2 is port (
    input1   : in  std_logic;
    input2   : in  std_logic;
    output   : out std_logic);
end nor_2;

architecture structural of nor_2 is
begin

  output <= not(input2 or input1);

end structural;
