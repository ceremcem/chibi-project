THIS_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# IMPORTANT: In order to debug, enable the following:
#USE_VERBOSE_COMPILE := yes

CHIBI_PROJECT_CONFIG := ./config.mk
ifeq (,$(wildcard $(CHIBI_PROJECT_CONFIG)))
  # specify the path to the folder that contains your board.c/h files
  $(error No config file can be found. Use config.mk.sample as the template.)
endif
include $(CHIBI_PROJECT_CONFIG)

# Define project name here
PROJECT = ch

# Imported source files and paths.
CHIBIOS  := $(HOME)/ChibiOS
# Use any folder name inside hw folder:
MCU_DIR = ./$(Hardware)
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

BUILD_TARGET := $(Target)
ifeq ("$(BUILD_TARGET)","Debug")
	OPTIMIZATION_LEVEL = 0
else
	OPTIMIZATION_LEVEL = 2
endif

include $(THIS_DIR)/mcu-debug/main.mk
