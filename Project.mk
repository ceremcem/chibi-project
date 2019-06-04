THIS_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

##############################################################################
# Include Aktos Electronics settings

include $(THIS_DIR)/aea.mk

# Aktos Electronics settings
##############################################################################

##############################################################################
# Build global options
# NOTE: Can be overridden externally.
#

# Compiler options here.
ifeq ($(USE_OPT),)
  USE_OPT = -O$(OPTIMIZATION_LEVEL) -ggdb -fomit-frame-pointer -falign-functions=16
endif

# C specific options here (added to USE_OPT).
ifeq ($(USE_COPT),)
  USE_COPT =
endif

# C++ specific options here (added to USE_OPT).
ifeq ($(USE_CPPOPT),)
  USE_CPPOPT = -fno-rtti
endif

# Enable this if you want the linker to remove unused code and data
ifeq ($(USE_LINK_GC),)
  USE_LINK_GC = yes
endif

# Linker extra options here.
ifeq ($(USE_LDOPT),)
  USE_LDOPT =
endif

# Enable this if you want link time optimizations (LTO)
ifeq ($(USE_LTO),)
  USE_LTO = yes
endif

# If enabled, this option allows to compile the application in THUMB mode.
ifeq ($(USE_THUMB),)
  USE_THUMB = yes
endif

# Enable this if you want to see the full log while compiling.
ifeq ($(USE_VERBOSE_COMPILE),)
  USE_VERBOSE_COMPILE = no
endif

# If enabled, this option makes the build process faster by not compiling
# modules not used in the current configuration.
ifeq ($(USE_SMART_BUILD),)
  USE_SMART_BUILD = yes
endif

#
# Build global options
##############################################################################

##############################################################################
# Architecture or project specific options
#

# Stack size to be allocated to the Cortex-M process stack. This stack is
# the stack used by the main() thread.
ifeq ($(USE_PROCESS_STACKSIZE),)
  USE_PROCESS_STACKSIZE = 0x400
endif

# Stack size to the allocated to the Cortex-M main/exceptions stack. This
# stack is used for processing interrupts and exceptions.
ifeq ($(USE_EXCEPTIONS_STACKSIZE),)
  USE_EXCEPTIONS_STACKSIZE = 0x400
endif

# Enables the use of FPU (no, softfp, hard).
ifeq ($(USE_FPU),)
  USE_FPU = no
endif

#
# Architecture or project specific options
##############################################################################

##############################################################################
# Project, sources and paths
#

# Licensing files.
include $(CHIBIOS)/os/license/license.mk
# HAL-OSAL files (optional).
include $(CHIBIOS)/os/hal/hal.mk
include $(CHIBIOS)/os/hal/osal/rt/osal.mk
include $(MCU_DIR)/board.mk



# RTOS files (optional).
include $(CHIBIOS)/os/rt/rt.mk
# Other files (optional).
include $(CHIBIOS)/test/lib/test.mk
include $(CHIBIOS)/test/rt/rt_test.mk
include $(CHIBIOS)/test/oslib/oslib_test.mk

# C sources that can be compiled in ARM or THUMB mode depending on the global
# setting.
CSRC = $(ALLCSRC) \
       $(TESTSRC) \
       $(APPDIR)/main.c

# C++ sources that can be compiled in ARM or THUMB mode depending on the global
# setting.
CPPSRC = $(ALLCPPSRC)

# C sources to be compiled in ARM mode regardless of the global setting.
# NOTE: Mixing ARM and THUMB mode enables the -mthumb-interwork compiler
#       option that results in lower performance and larger code size.
ACSRC =

# C++ sources to be compiled in ARM mode regardless of the global setting.
# NOTE: Mixing ARM and THUMB mode enables the -mthumb-interwork compiler
#       option that results in lower performance and larger code size.
ACPPSRC =

# C sources to be compiled in THUMB mode regardless of the global setting.
# NOTE: Mixing ARM and THUMB mode enables the -mthumb-interwork compiler
#       option that results in lower performance and larger code size.
TCSRC =

# C sources to be compiled in THUMB mode regardless of the global setting.
# NOTE: Mixing ARM and THUMB mode enables the -mthumb-interwork compiler
#       option that results in lower performance and larger code size.
TCPPSRC =

# List ASM source files here
ASMSRC = $(ALLASMSRC)
ASMXSRC = $(ALLXASMSRC)

INCDIR = $(ALLINC) $(TESTINC) $(CONFDIR)

#
# Project, sources and paths
##############################################################################

##############################################################################
# Compiler settings
#

#TRGT = arm-elf-
TRGT = $(GCC_Path)arm-none-eabi-
CC   = $(TRGT)gcc
CPPC = $(TRGT)g++
# Enable loading with g++ only if you need C++ runtime support.
# NOTE: You can use C++ even without C++ support if you are careful. C++
#       runtime support makes code size explode.
LD   = $(TRGT)gcc
#LD   = $(TRGT)g++
CP   = $(TRGT)objcopy
AS   = $(TRGT)gcc -x assembler-with-cpp
AR   = $(TRGT)ar
OD   = $(TRGT)objdump
SZ   = $(TRGT)size
HEX  = $(CP) -O ihex
BIN  = $(CP) -O binary

# ARM-specific options here
AOPT =

# THUMB-specific options here
TOPT = -mthumb -DTHUMB

# Define C warning options here
CWARN = -Wall -Wextra -Wundef -Wstrict-prototypes

# Define C++ warning options here
CPPWARN = -Wall -Wextra -Wundef

#
# Compiler settings
##############################################################################

##############################################################################
# Start of user section
#

# List all user C define here, like -D_DEBUG=1
UDEFS =

# Define ASM defines here
UADEFS =

# List all user directories here
UINCDIR =

# List the user directory to look for the libraries here
ULIBDIR =

# List all user libraries here
ULIBS =

#
# End of user defines
##############################################################################

RULESPATH = $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC
include $(RULESPATH)/rules.mk

#
# Common rules
##############################################################################

##############################################################################
# Custom rules
#

ifeq ($(CC),)
	$(error No C Compiler can be found. PATH: $(PATH))
endif

# Take a note for the dependencies
CHIBIOS_BRANCH := $(shell cd ${CHIBIOS} && git branch | grep \* | cut -d ' ' -f2)
CHIBIOS_COMMIT := $(shell cd ${CHIBIOS} && git rev-parse HEAD)
GCC_VERSION := $(shell $(CC) -dumpversion)
GCC_MAJOR := $(shell echo $(GCC_VERSION) | cut -d'.' -f1)

PRE_MAKE_ALL_RULE_HOOK:
	@true > $(DEPS_DB)
	@echo "ChibiOS/$(CHIBIOS_BRANCH) $(CHIBIOS_COMMIT)" >> $(DEPS_DB)
	@echo "GCC $(GCC_VERSION)" >> $(DEPS_DB)

POST_MAKE_ALL_RULE_HOOK:
	@if [ $(OPTIMIZATION_LEVEL) -lt 2 ]; then \
		echo "------------------------------------------------------"; \
		echo -n "WARNING: Optimization level is: $(OPTIMIZATION_LEVEL)"; \
		echo " [Target: $(Target)]"; \
		echo "------------------------------------------------------"; \
	fi

CLEAN_RULE_HOOK:
	@echo "Cleanup hook..."
	@echo
	@find $(CURDIR) -iname '*.gch' -exec rm {} \;
	@rm $(CURDIR)/_breakpoints.txt 2> /dev/null || true
	@rm $(CURDIR)/core 2> /dev/null || true


GCC_M0_LIMIT := 5 # https://github.com/ceremcem/chibi-project/issues/1
__FAMILY = $(shell echo $(MCU) | grep cortex-m0 > /dev/null && echo M0)
#$(info Family is: $(__FAMILY))
ifeq ($(__FAMILY),M0)
ifeq ($(shell test $(GCC_MAJOR) -gt $(GCC_M0_LIMIT); echo $$?),0)
$(error GCC > v$(GCC_M0_LIMIT).x.x ($(GCC_VERSION)) is known to have a bug with Cortex-M0. Prepend custom \
	version of GCC to the PATH environment variable.)
endif
endif

#
# Custom rules
##############################################################################
