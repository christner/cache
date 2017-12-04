-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of tx is
begin

  txprocess: process (sel, selnot, input)
  begin
    if (sel = '1' and selnot = '0')
    then

      output <= input;

    else

      output <= 'Z';

    end if;
  end process txprocess;

end structural;
