-- Created by @(#)$CDS: vhdlin version 6.1.7-64b 09/27/2016 19:46 (sjfhw304) $
-- on Sun Dec  3 17:08:40 2017


architecture structural of dff is
begin

  output: process
  begin

    wait until ( clk'EVENT and clk = '0' );
    q <= d;
    qbar <= not d ;

  end process output;


end structural;