# Optimization level 
# Default: None, required.
# Value: "Debug" or "Release"
Target          := Debug

# Hardware configuration files path
# Default: None, required. 
# 
# NOTICE: Kernel configuration files (chconf, halconf) must be placed 
# inside the parent folder of $(HARDWARE) folder
Hardware        := hw/f030

# GCC Path 
# Default: System wide installation
GCC_Path        := $(HOME)/gcc/gcc-arm-none-eabi-5_3-2016q1/bin

# ChibiOS Path 
# Default: $(HOME)/ChibiOS
ChibiOS_Path    := /path/to/ChibiOS

# Application Path 
# Default: ./app
App             := ./app/some-variant

# GDB address 
# Default: localhost:4242
GDB_Addr 		:=