# List of all the board related files.
THIS_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

BOARDSRC = $(THIS_DIR)/board.c

# Required include directories
BOARDINC = $(THIS_DIR)

# Shared variables
ALLCSRC += $(BOARDSRC)
ALLINC  += $(BOARDINC)

include $(THIS_DIR)/mcuconf.mk
