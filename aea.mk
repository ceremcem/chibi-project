THIS_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# IMPORTANT: In order to debug, enable the following:
#USE_VERBOSE_COMPILE := yes

HARDWARE_CONF := ./Hardware
ifeq (,$(wildcard $(HARDWARE_CONF)))
  # specify the path to the folder that contains your board.c/h files
  $(error You need to specify your board.c/h files in your $(HARDWARE_CONF) file)
endif

# Define project name here
PROJECT = ch

# Imported source files and paths.
CHIBIOS  := $(HOME)/ChibiOS
# Use any folder name inside hw folder:
MCU_DIR = ./$(shell [ -e $(HARDWARE_CONF) ] && cat $(HARDWARE_CONF) | grep "^[^\#\;]")
CONFDIR := $(shell dirname $(MCU_DIR))
BUILDDIR := ./build
DEPDIR   := ./.dep

# Dynamically import all source files under ./include
SRCEXT := c
SRCDIR := $(THIS_DIR)/include
SRCS   = $(shell find $(SRCDIR) -name '*.$(SRCEXT)')
SRCINC = $(shell find $(SRCDIR) -type d)
ALLCSRC += $(SRCS)
ALLINC += $(SRCINC)

# Dynamically import all source files under PROJECT_ROOT/include
PR_SRCDIR := $(CURDIR)/include
PR_SRCS   = $(shell find $(PR_SRCDIR) -name '*.$(SRCEXT)')
PR_SRCINC = $(shell find $(PR_SRCDIR) -type d)
ALLCSRC += $(PR_SRCS)
ALLINC += $(PR_SRCINC)


# Software level IO configuration
#
APPDIR := $(CURDIR)/app
ALLCSRC += $(APPDIR)/io.c
ALLINC += $(APPDIR)

.DEFAULT_GOAL := all

DEPS_DB := $(CURDIR)/dependencies.txt

BUILD_TARGET := $(shell [ -e Target ] && cat Target | grep "^[^\#\;]")
ifeq ("$(BUILD_TARGET)","Debug")
	OPTIMIZATION_LEVEL = 0
else
	OPTIMIZATION_LEVEL = 2
endif

include $(THIS_DIR)/mcu-debug/main.mk
