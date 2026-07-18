
all: allducks gb

# TODO: This is a bit of a mess, could be cleaned up

ifndef DUCK_MBC
	DUCK_MBC=md2
endif

DIRDUCK=build_duck_$(DUCK_MBC)
DIRGB=build_gb
GFXDIR=gfx
SRCDIR=src
INCPATH=$(SRCDIR)

REF_ROM_DIR=reference_rom
REFERENCE_ROM_NAME=workboy.gb
TEST_SAVE_NAME=workboy.sav
REFERENCE_ROM=$(REF_ROM_DIR)/$(REFERENCE_ROM_NAME)
TEST_SAV=$(REF_ROM_DIR)/$(TEST_SAVE_NAME)
ROMNAME_BASE=workboy
SRCNAME=workboy.asm

# DUCK_ROMNAME=$(ROMNAME_BASE)_duck.$(DUCK_MBC)
DUCK_ROMNAME=$(ROMNAME_BASE).$(DUCK_MBC)

UPS_PATCHTOOL_PATH=tools/ups_patch

MKDIRS = $(DIRGB) $(REF_ROM_DIR)
ifdef DUCK_MBC
	MKDIRS += $(DIRDUCK)
endif



ifeq ($(wildcard $(REFERENCE_ROM)),)
$(error Original ROM not found at "$(REFERENCE_ROM)".)
endif


gb: $(DIRGB)/$(ROMNAME_BASE).gb
duck: $(DIRDUCK)/$(DUCK_ROMNAME)

clean: clean-allducks cleangb


# == Game Boy ==

cleangb:
	rm -f $(DIRGB)/*

$(DIRGB)/$(ROMNAME_BASE).gb: gbgfx $(SRCDIR)/$(SRCNAME)
	rgbasm -Wno-obsolete --preserve-ld --halt-without-nop -i $(INCPATH) -o $(DIRGB)/$(ROMNAME_BASE).o $(SRCDIR)/$(SRCNAME)
	rgblink -n $(DIRGB)/$(ROMNAME_BASE).sym -m $(DIRGB)/$(ROMNAME_BASE).map -o $(DIRGB)/$(ROMNAME_BASE).gb $(DIRGB)/$(ROMNAME_BASE).o
#	rgbfix ..TODO..	(is rom header region free of code, or is there any to relocate?)
	@if which md5sum &>/dev/null; then md5sum $@; else md5 $@; fi
	@if which md5sum &>/dev/null; then md5sum $(REFERENCE_ROM); else md5 $(REFERENCE_ROM); fi
#   Overwrite save to ensure it has a working one with some data (sometimes gets reset)
	cp -f $(TEST_SAV) $(DIRGB)/$(TEST_SAVE_NAME)

gbgfx:
#	rgbgfx $(GFXDIR)/megaduck_logo_9x_8x8.png -o src/megaduck_logo_9_tiles.2bpp -c "#FFFFFF,#A0A0A0,#4E4E4E,#000000;"


# == Mega Duck ==

duck: $(DIRDUCK)/$(DUCK_ROMNAME)

duckmbc5:
	${MAKE} duck DUCK_MBC=mbc5 DUCK_BUILD_FLAG=BUILD_USE_DUCK_MBC5
duckmd2:
	${MAKE} duck DUCK_MBC=md2  DUCK_BUILD_FLAG=BUILD_USE_DUCK_MBC_MD2

clean-duckmbc5:
	${MAKE} cleanduck DUCK_MBC=mbc5 DUCK_BUILD_FLAG=BUILD_USE_DUCK_MBC5
clean-duckmd2:
	${MAKE} cleanduck DUCK_MBC=md2  DUCK_BUILD_FLAG=BUILD_USE_DUCK_MBC_MD2


clean-allducks: clean-duckmbc5 clean-duckmd2

allducks: duckmbc5 duckmd2

cleanduck:
	rm -f $(DIRDUCK)/*

$(DIRDUCK)/$(DUCK_ROMNAME): duckgfx $(SRCDIR)/$(SRCNAME)
	rgbasm -Wno-obsolete -DTARGET_MEGADUCK -D$(DUCK_BUILD_FLAG) --preserve-ld --halt-without-nop -i $(INCPATH) -o $(DIRDUCK)/$(ROMNAME_BASE).o $(SRCDIR)/$(SRCNAME)
	rgblink -n $(DIRDUCK)/$(ROMNAME_BASE).sym -m $(DIRDUCK)/$(ROMNAME_BASE).map -o $(DIRDUCK)/$(DUCK_ROMNAME) $(DIRDUCK)/$(ROMNAME_BASE).o
	@if which md5sum &>/dev/null; then md5sum $@; else md5 $@; fi
# 	@if which md5sum &>/dev/null; then md5sum $(REFERENCE_ROM); else md5 $(REFERENCE_ROM); fi
#   Overwrite save to ensure it has a working one with some data (sometimes gets reset)
	cp -f $(TEST_SAV) $(DIRDUCK)/$(TEST_SAVE_NAME)

duckgfx:
#	rgbgfx $(GFXDIR)/megaduck_logo_9x_8x8.png -o src/megaduck_logo_9_tiles.2bpp -c "#FFFFFF,#A0A0A0,#4E4E4E,#000000;"


bindiffduck: bindiffduck-mbc5

bindiffduck-mbc5:
	vbindiff $(REFERENCE_ROM) build_duck_mbc5/$(DUCK_ROMNAME)mbc5

bindiffduck-md2:
	vbindiff $(REFERENCE_ROM) build_duck_md2/$(DUCK_ROMNAME)md2

bindiffgb:
	vbindiff $(REFERENCE_ROM) $(DIRGB)/$(ROMNAME_BASE).gb

runduck: runduckmbc5

# 0x1B 	MBC-5 	SRAM 	BATTERY 
runduckmbc5:
	superjunior_sameduck --force-mbc 0x1B build_duck_mbc5/$(DUCK_ROMNAME)mbc5

runduckmd2:
	superjunior_sameduck --duck-sram-cart build_duck_md2/$(DUCK_ROMNAME)md2


romusage:
	romusage $(DIRDUCK)/$(ROMNAME_BASE).map -g -sRp

# Needs stock inside gadgets firmware to work, can use flashgbx ui to swap it out if needed
# Make sure 32K cart is specified
flashduck:
	-cd tools/gbxcart_duck; ./gbxcart_rw_megaduck_32kb_flasher ../../$(DIRDUCK)/$(DUCK_ROMNAME) &


# rom-first-32k:
#	dd bs=32K count=1 if=$(REFERENCE_ROM) of=$(REFERENCE_ROM)_32k.md2


# create necessary directories after Makefile is parsed but before build
# info prevents the command from being pasted into the makefile
$(info $(shell mkdir -p $(MKDIRS)))

