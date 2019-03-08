include $(CHIBIOS)/os/hal/ports/STM32/STM32F0xx/platform.mk
include $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC/mk/startup_stm32f0xx.mk
include $(CHIBIOS)/os/common/ports/ARMCMx/compilers/GCC/mk/port_v6m.mk
MCU = cortex-m0
LDSCRIPT= $(STARTUPLD)/STM32F030x4.ld

# see Makefile for explanations:
USE_PROCESS_STACKSIZE = 0x200
USE_EXCEPTIONS_STACKSIZE = 0x200
