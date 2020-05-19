THIS_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# IMPORTANT: In order to debug, enable the following:
#USE_VERBOSE_COMPILE := yes

CHIBI_PROJECT_CONFIG := ./config.mk
ifeq (,$(wildcard $(CHIBI_PROJECT_CONFIG)))
  # specify the path to the folder that contains your board.c/h files
  $(error No config file can be found. Use config.sample.mk as the template.)
endif
include $(CHIBI_PROJECT_CONFIG)

ifneq (,$(GCC_Path))
	GCC_Path := $(GCC_Path)/
endif

# Define project name here
PROJECT = ch

# Imported source files and paths.
ifeq (,$(ChibiOS_Path))
	ChibiOS_Path := $(HOME)/ChibiOS
endif
CHIBIOS  := ./ChibiOS
ifeq (,$(wildcard $(CHIBIOS)/.))
	_HEY:=$(shell ln -s $(ChibiOS_Path) $(CHIBIOS))
endif

# Use any folder name inside hw folder:
ifeq (,$(Hardware))
$(error Hardware declaration is missing.)
endif
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
ifeq (,$(App))
	App := $(CURDIR)/app
endif
APPDIR := $(App)
ALLCSRC += $(APPDIR)/io.c
ALLINC += $(APPDIR)

# Dynamically import all source files under APP_DIR/deps
APP_DEP_SRCDIR := $(APPDIR)/deps
ifneq ($(wildcard $(APP_DEP_SRCDIR)/.*),)
APP_DEP_SRCS   = $(shell find $(APP_DEP_SRCDIR) -name '*.$(SRCEXT)')
APP_DEP_SRCINC = $(shell find $(APP_DEP_SRCDIR) -type d)
ALLCSRC += $(APP_DEP_SRCS)
ALLINC += $(APP_DEP_SRCINC)
endif

.DEFAULT_GOAL := all

DEPS_DB := $(CURDIR)/dependencies.txt

BUILD_TARGET := $(Target)
ifeq ("$(BUILD_TARGET)","Release")
	OPTIMIZATION_LEVEL = 2
else ifeq ("$(BUILD_TARGET)","Debug")
	OPTIMIZATION_LEVEL = 0
else 
$(error Target must be Debug or Release.)
endif

include $(THIS_DIR)/mcu-debug/main.mk
