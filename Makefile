
all: gb duck

DIRDUCK=build_duck
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

UPS_PATCHTOOL_PATH=tools/ups_patch

MKDIRS = $(DIRDUCK) $(DIRGB) $(REF_ROM_DIR)


ifeq ($(wildcard $(REFERENCE_ROM)),)
$(error Original ROM not found at "$(REFERENCE_ROM)".)
endif


gb: $(DIRGB)/$(ROMNAME_BASE).gb
duck: $(DIRDUCK)/$(ROMNAME_BASE).duck

clean: cleanduck cleangb


# == Game Boy ==

cleangb:
	rm -f $(DIRGB)/*

$(DIRGB)/$(ROMNAME_BASE).gb: gbgfx $(SRCDIR)/$(SRCNAME)
	rgbasm -Wno-obsolete --preserve-ld --halt-without-nop -i $(INCPATH) -o $(DIRGB)/$(ROMNAME_BASE).o $(SRCDIR)/$(SRCNAME)
	rgblink -n $(DIRGB)/$(ROMNAME_BASE).sym -m $(DIRGB)/$(ROMNAME_BASE).map -n $(DIRGB)/$(ROMNAME_BASE).sym -o $(DIRGB)/$(ROMNAME_BASE).gb $(DIRGB)/$(ROMNAME_BASE).o
#	rgbfix ..TODO..	(is rom header region free of code, or is there any to relocate?)
	@if which md5sum &>/dev/null; then md5sum $@; else md5 $@; fi
	@if which md5sum &>/dev/null; then md5sum $(REFERENCE_ROM); else md5 $(REFERENCE_ROM); fi
#   Overwrite save to ensure it has a working one with some data (sometimes gets reset)
	cp -f $(TEST_SAV) $(DIRGB)/$(TEST_SAVE_NAME)

gbgfx:
#	rgbgfx $(GFXDIR)/megaduck_logo_9x_8x8.png -o src/megaduck_logo_9_tiles.2bpp -c "#FFFFFF,#A0A0A0,#4E4E4E,#000000;"


# == Mega Duck ==

duck: $(DIRDUCK)/$(ROMNAME_BASE).duck

clean: cleanduck

cleanduck:
	rm -f $(DIRDUCK)/*

$(DIRDUCK)/$(ROMNAME_BASE).duck: duckgfx $(SRCDIR)/$(SRCNAME)
	rgbasm -Wno-obsolete -DTARGET_MEGADUCK --preserve-ld --halt-without-nop -i $(INCPATH) -o $(DIRDUCK)/$(ROMNAME_BASE).o $(SRCDIR)/$(SRCNAME)
	rgblink -n $(DIRDUCK)/$(ROMNAME_BASE).sym -m $(DIRDUCK)/$(ROMNAME_BASE).map -n $(DIRGB)/$(ROMNAME_BASE).sym -o $(DIRDUCK)/$(ROMNAME_BASE).duck $(DIRDUCK)/$(ROMNAME_BASE).o
	@if which md5sum &>/dev/null; then md5sum $@; else md5 $@; fi
	@if which md5sum &>/dev/null; then md5sum $(REFERENCE_ROM); else md5 $(REFERENCE_ROM); fi
#   Overwrite save to ensure it has a working one with some data (sometimes gets reset)
	cp -f $(TEST_SAV) $(DIRGB)/$(TEST_SAVE_NAME)

duckgfx:
#	rgbgfx $(GFXDIR)/megaduck_logo_9x_8x8.png -o src/megaduck_logo_9_tiles.2bpp -c "#FFFFFF,#A0A0A0,#4E4E4E,#000000;"


bindiffduck:
	vbindiff $(REFERENCE_ROM) $(DIRDUCK)/$(ROMNAME_BASE).duck

bindiffgb:
	vbindiff $(REFERENCE_ROM) $(DIRGB)/$(ROMNAME_BASE).gb


usage:
	romusage $(DIRDUCK)/$(ROMNAME_BASE).map -g

# Needs stock inside gadgets firmware to work, can use flashgbx ui to swap it out if needed
# Make sure 32K cart is specified
flashduck:
	-cd tools/gbxcart_duck; ./gbxcart_rw_megaduck_32kb_flasher ../../$(DIRDUCK)/$(ROMNAME_BASE).duck &


# rom-first-32k:
#	dd bs=32K count=1 if=$(REFERENCE_ROM) of=$(REFERENCE_ROM)_32k.duck


# create necessary directories after Makefile is parsed but before build
# info prevents the command from being pasted into the makefile
$(info $(shell mkdir -p $(MKDIRS)))

