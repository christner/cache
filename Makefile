VCC		= run_ncvhdl.bash
VCC_FLAGS	= -messages -linedebug -smartorder
VELAB		= run_ncelab.bash
VELAB_FLAGS	= -message -access rwc


.PHONY : all
all : cache_cell_tb tag_3_tb cache_byte_tb cache_block_tb cache_set_tb cache_tb set_associative_cache_2_tb state_machine_tb jkff_tb chip chip_2_way

chip_2_way~ : set_associative_cache_2 state_machine cache_byte register8 mux8_2
	$(VCC) $(VCC_FLAGS) chip_2_way.vhd
	@touch chip_2_way~

.PHONY : chip
chip_2_way : chip_2_way~

chip~ : cache state_machine cache_byte register8 mux8_2
	$(VCC) $(VCC_FLAGS) chip.vhd
	@touch chip~

.PHONY : chip
chip : chip~

set_associative_cache_2_tb~ : set_associative_cache_2
	$(VCC) $(VCC_FLAGS) set_associative_cache_2_tb.vhd
	$(VELAB) $(VELAB_FLAGS) set_associative_cache_2_tb
	@touch set_associative_cache_2_tb~

.PHONY : set_associative_cache_2_tb
set_associative_cache_2_tb : set_associative_cache_2_tb~

set_associative_cache_2~ : inverter and_2 or_2 and_8 inverter8_1 and8_2 mux1_2 comparator_3 decoder_3 dlatch  dlatch_3 cache_set
	$(VCC) $(VCC_FLAGS) set_associative_cache_2.vhd
	@touch set_associative_cache_2~

.PHONY : set_associative_cache_2
set_associative_cache_2 : set_associative_cache_2~

cache_tb~ : cache
	$(VCC) $(VCC_FLAGS) cache_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_tb
	@touch cache_tb~

.PHONY : cache_tb
cache_tb : cache_tb~

cache~ : inverter and_2 or_2 comparator_3 dlatch dlatch_3 cache_set
	$(VCC) $(VCC_FLAGS) cache.vhd
	@touch cache~

.PHONY : cache
cache : cache~

cache_set_tb~ : cache_set
	$(VCC) $(VCC_FLAGS) cache_set_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_set_tb
	@touch cache_set_tb~

.PHONY : cache_set_tb
cache_set_tb : cache_set_tb~

cache_set~ : inverter or_2 and_2 decoder_2 decoder_3 cache_block
	$(VCC) $(VCC_FLAGS) cache_set.vhd
	@touch cache_set~

.PHONY : cache_set
cache_set : cache_set~

cache_block_tb~ : cache_block
	$(VCC) $(VCC_FLAGS) cache_block_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_block_tb
	@touch cache_block_tb~
.PHONY : cache_block_tb
cache_block_tb : cache_block_tb~


state_machine_tb~ : state_machine~
	$(VCC) $(VCC_FLAGS) state_machine_tb.vhd
	$(VELAB) $(VELAB_FLAGS) state_machine_tb
	@touch state_machine_tb~


.PHONY : state_machine_tb
state_machine_tb : state_machine_tb~


cache_block~ : and_2 and_4 or_4 tag_3 cache_byte cache_cell
	$(VCC) $(VCC_FLAGS) cache_block.vhd
	@touch cache_block~
.PHONY : cache_clock
cache_block : cache_block~

state_machine~ : and_4 and_3 and_2 or_4 or_3 or_2 nand_2 nand_3 xor_2 xnor_2 jkff dlatch inverter nor_2 and_5 waitCounter
	$(VCC) $(VCC_FLAGS) state_machine.vhd
	@touch state_machine~

.PHONY : state_machine
state_machine : state_machine~

waitCounter : and_2 and_3 and_4 xor_2 or_2 or_3 xnor_2 jkff inverter
	$(VCC) $(VCC_FLAGS) waitCounter.vhd
	@touch waitCounter~

.PHONY : waitCounter
state_machine : waitCounter~

cache_byte_tb~ : cache_byte
	$(VCC) $(VCC_FLAGS) cache_byte_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_byte_tb
	@touch cache_byte_tb~

.PHONY : cache_byte_tb
cache_byte_tb : cache_byte_tb~

cache_byte~ : cache_cell
	$(VCC) $(VCC_FLAGS) cache_byte.vhd
	@touch cache_byte~

.PHONY : cache_byte
cache_byte : cache_byte~

tag_3_tb~ : tag_3
	$(VCC) $(VCC_FLAGS) tag_3_tb.vhd
	$(VELAB) $(VELAB_FLAGS) tag_3_tb
	@touch tag_3_tb~

.PHONY : tag_3_tb
tag_3_tb : tag_3_tb~

tag_3~ : cache_cell
	$(VCC) $(VCC_FLAGS) tag_3.vhd
	@touch tag_3~

.PHONY : tag_3
tag_3 : tag_3~

cache_cell_tb~ : cache_cell
	$(VCC) $(VCC_FLAGS) cache_cell_tb.vhd
	$(VELAB) $(VELAB_FLAGS) cache_cell_tb
	@touch cache_cell_tb~

.PHONY : cache_cell_tb
cache_cell_tb : cache_cell_tb~

cache_cell~ : tx inverter dlatch
	$(VCC) $(VCC_FLAGS) cache_cell.vhd
	@touch cache_cell~

.PHONY : cache_cell
cache_cell : cache_cell~

jkff_tb~ : jkff~
	$(VCC) $(VCC_FLAGS) jkff_tb.vhd
	$(VELAB) $(VELAB_FLAGS) jkff_tb
	@touch jkff_tb~

.PHONY : jkff_tb
jkff_tb : jkff_tb~


decoder_3~ : inverter and_3
	$(VCC) $(VCC_FLAGS) decoder_3.vhd
	@touch decoder_3~

.PHONY : decoder_3
decoder_3 : decoder_3~

decoder_2~ : inverter and_2
	$(VCC) $(VCC_FLAGS) decoder_2.vhd
	@touch decoder_2~

.PHONY : decoder_2
decoder_2 : decoder_2~

and8_2~ :
	$(VCC) $(VCC_FLAGS) and8_2.vhd
	@touch and8_2~

.PHONY : and8_2
and8_2 : and8_2~

inverter8_1~ :
	$(VCC) $(VCC_FLAGS) inverter8_1.vhd
	@touch inverter8_1~

.PHONY : inverter8_1
inverter8_1 : inverter8_1~

inverter~ :
	$(VCC) $(VCC_FLAGS) inverter.vhd
	@touch inverter~

.PHONY : inverter
inverter : inverter~

nor_2~ :
	$(VCC) $(VCC_FLAGS) nor_2.vhd
	@touch nor_2~

.PHONY : nor_2
nor_2 : nor_2~

register8~ : dff
	$(VCC) $(VCC_FLAGS) register8.vhd
	@touch register8~

.PHONY : register8
register8 : register8~

dff~ :
	$(VCC) $(VCC_FLAGS) dff.vhd
	@touch dff~

.PHONY : dff
dff : dff~

dlatch_3~ :
	$(VCC) $(VCC_FLAGS) dlatch_3.vhd
	@touch dlatch_3~

.PHONY : dlatch_3
dlatch_3 : dlatch_3~

dlatch~ :
	$(VCC) $(VCC_FLAGS) dlatch.vhd
	@touch dlatch~

.PHONY : dlatch
dlatch : dlatch~

comparator_3~ : and_3 xnor_2
	$(VCC) $(VCC_FLAGS) comparator_3.vhd
	@touch comparator_3~

.PHONY : comparator_3
comparator_3 : comparator_3~

mux8_2~ : mux1_2
	$(VCC) $(VCC_FLAGS) mux8_2.vhd
	@touch mux8_2~

.PHONY : mux8_2
mux8_2: mux8_2~

mux1_2~ : inverter and_2 or_2
	$(VCC) $(VCC_FLAGS) mux1_2.vhd
	@touch mux1_2~

.PHONY : mux1_2
mux1_2: mux1_2~

tx~ :
	$(VCC) $(VCC_FLAGS) tx.vhd
	@touch tx~
.PHONY : tx
tx: tx~

.PRECIOUS : and_%~
and_%~  :
	$(VCC) $(subst ~,,$@).vhd
	@touch $@

.PHONY : and_%
and_% : and_%~
	@echo -n

.PRECIOUS : or_%~
or_%~ :
	$(VCC) $(subst ~,,$@).vhd
	@touch $@

.PHONY : or_%
or_% : or_%~
	@echo -n

.PRECIOUS : xnor_%~
xnor_%~ : xor_% inverter
	$(VCC) $(subst ~,,$@).vhd
	@touch $@

.PHONY : xnor_%
xnor_% : xnor_%~
	@echo -n

.PRECIOUS : xor_%~
xor_%~ :
	$(VCC) $(subst ~,,$@).vhd
	@touch $@

.PHONY : xor_%
xor_% : xor_%~
	@echo -n

or_3~ :
	$(VCC) $(VCC_FLAGS) or_3.vhd
	@touch or_3~

.PHONY : or_3
or_3 : or_3~

or_2~ :
	$(VCC) $(VCC_FLAGS) or_2.vhd
	@touch or_2~

.PHONY : or_2
or_2 : or_2~

nand_2~ :
	$(VCC) $(VCC_FLAGS) nand_2.vhd
	@touch nand_2~

.PHONY : nand_2
nand_2 : nand_2~

nand_3~ :
	$(VCC) $(VCC_FLAGS) nand_3.vhd
	@touch nand_3~

.PHONY : nand_3
nand_3 : nand_3~

xor_2~ :
	$(VCC) $(VCC_FLAGS) xor_2.vhd
	@touch xor_2~

.PHONY : xor_2
xor_2 : xor_2~

xnor_2~ : xor_2
	$(VCC) $(VCC_FLAGS) xnor_2.vhd
	@touch xnor_2~

.PHONY : xnor_2
xnor_2 : xnor_2~

jkff~ :
	$(VCC) $(VCC_FLAGS) jkff.vhd
	@touch jkff~

.PHONY : jkff
jkff : jkff~

.PHONY : clean
clean :
	@rm -rf `find . -name "*~*"`
	@rm -rf *.log
	@rm -rf INCA_libs
