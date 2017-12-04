-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of jkff is

signal temp : std_logic;

begin
  Q <= temp;
  jk_flipflop: process (J, K, Clk)
  begin
    if (rst = '1') then
      temp <= '0';
    elsif  falling_edge(Clk) then
     if    (J='0' and K='0') then
       temp <= temp;
     elsif (J='0' and K='1') then
       temp <= '0';
     elsif (J='1' and K='1') then
       temp <= not (temp);
     elsif (J='1' and K='0') then
       temp <= '1';
     end if;
   end if;
 end process jk_flipflop;


end structural;
