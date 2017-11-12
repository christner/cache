VCC		= run_ncvhdl.bash
VCC_FLAGS	= -messages -linedebug -smartorder 
VELAB		= run_ncelab.bash
VELAB_FLAGS	= -message -access rwc

cache_cell_tb~ : cache_cell~ 
	$(VCC) $(VCC_FLAGS) cache_cell_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_cell_tb
	@touch cache_cell_tb~

.PHONY: cache_cell_tb
cache_cell_tb: cache_cell_tb~

cache_cell~ : tx~ inverter~ dlatch~
	$(VCC) $(VCC_FLAGS) cache_cell.vhd
	@touch cache_cell~

.PHONY: cache_cell
cache_cell: cache_cell~

inverter~ : 
	$(VCC) $(VCC_FLAGS) inv_1.vhd
	@touch inverter~

.PHONY: inveter
inverter: inverter~

dlatch~ : 
	$(VCC) $(VCC_FLAGS) dlatch.vhd
	@touch inverter~

.PHONY: dlatch
dlatch: dlatch~ 

tx~ : 
	$(VCC) $(VCC_FLAGS) tx.vhd
	@touch inverter~

.PHONY: tx
tx: tx~

.PHONY: clean
clean :
	@rm -rf `find . -name "*~*"`
	@rm -rf *.log
