THIS_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))


# IMPORTANT: In order to debug, enable the following:
#USE_VERBOSE_COMPILE := yes

# Define project name here
PROJECT = ch

# Imported source files and paths.
CHIBIOS  := $(HOME)/ChibiOS
# Use any folder name inside ./hw/ folder:
CONFDIR  := $(CURDIR)/hw/f030x4-custom-breakout
BUILDDIR := ./build
DEPDIR   := ./.dep

# Dynamically import all source files under ./include
SRCEXT := c
SRCDIR := $(THIS_DIR)/include
SRCS   := $(shell find $(SRCDIR) -name '*.$(SRCEXT)')
SRCINC := $(shell find $(SRCDIR) -type d)
ALLCSRC += $(SRCS)
ALLINC += $(SRCINC)

# Dynamically import all source files under PROJECT_ROOT/include
PR_SRCDIR := $(CURDIR)/include
PR_SRCS   := $(shell find $(PR_SRCDIR) -name '*.$(SRCEXT)')
PR_SRCINC := $(shell find $(PR_SRCDIR) -type d)
ALLCSRC += $(PR_SRCS)
ALLINC += $(PR_SRCINC)


# Software level IO configuration
#
APPDIR := $(CURDIR)/app
ALLCSRC += $(APPDIR)/io.c
ALLINC += $(APPDIR)

.DEFAULT_GOAL := all

# Take a note for the dependencies
CHIBIOS_BRANCH := $(shell cd ${CHIBIOS} && git branch | grep \* | cut -d ' ' -f2)
CHIBIOS_COMMIT := $(shell cd ${CHIBIOS} && git rev-parse HEAD)
GCC_VERSION := $(shell gcc --version | grep ^gcc | sed 's/^.* //g')

DEPS_DB := $(CURDIR)/dependencies.txt

BUILD_TARGET := $(shell [ -e Target ] && cat Target | grep "^[^\#\;]")
ifeq ("$(BUILD_TARGET)","Debug")
	OPTIMIZATION_LEVEL = 0
else
	OPTIMIZATION_LEVEL = 2
endif

PRE_MAKE_ALL_RULE_HOOK:
	@true > $(DEPS_DB)
	@echo "ChibiOS/$(CHIBIOS_BRANCH) $(CHIBIOS_COMMIT)" >> $(DEPS_DB)
	@echo "GCC $(GCC_VERSION)" >> $(DEPS_DB)
	@if [ ! -f Target ]; then echo "Release" > Target; fi

POST_MAKE_ALL_RULE_HOOK:
	@if [ $(OPTIMIZATION_LEVEL) -lt 2 ]; then \
		echo "------------------------------------------------------"; \
		echo -n "WARNING: Optimization level is: $(OPTIMIZATION_LEVEL)"; \
		echo " [Target: Debug]"; \
		echo "------------------------------------------------------"; \
	fi

CLEAN_RULE_HOOK:
	@echo "Cleanup hook..."
	@echo
	@find $(CURDIR) -iname '*.gch' -exec rm {} \;
	@rm $(CURDIR)/_breakpoints.txt 2> /dev/null || true
	@rm $(CURDIR)/core 2> /dev/null || true

include $(THIS_DIR)/mcu-debug/main.mk
