# TODO

1. Add the "MCU Family list" location which is to be used in board.h
2. Add MCU family swap procedure for a project

# Peripheral and physical pin connections

See https://electronics.stackexchange.com/a/422280/20285

Configuring IO: There are 2 levels of IO configuration:

1. Physical configuration: An IO might be connected to a circuit physically and its configuration can not be altered. (Eg. debounce input, mosfet output, CAN connection). This type of permanent settings should be handled in `board` configuration.
2. Application configuration: An IO might be configured to fit application needs and nothing to do with the hardware design, such as its speed selection, its registered callback function, etc.


# Abstraction Files

1. board
2. chconf
3. halconf
4. mcuconf

### board.c/board.h

Settings directly related to the physical board. `boardInit()` function is for
initialization of external IC(s). Make the following settings in this file:

* Declare MCU family (eg. STM32F103xB)
* Define IO pins' hardware names (out0, in1, pwm0 etc.)
* Configure hardware level IO pin modes (refer to PROJECT/io.c for software level IO configuration)

### chconf.h

Responsible for operating system abstraction (RT or NIL) settings, such as

* Frequency,
* Enable/disable semaphores, mailbox, dynamic threads
* etc.

### halconf.h

Responsible for "Hardware Abstraction Layer" settings. You need to enable/disable
appropriate driver (PAL (+callbacks?), ADC, CAN, PWM, SERIAL, etc.) to use
them in the app code.

### mcuconf.h

Settings for the exact model of the MCU:

* Select internal/external clock
* Enable/disable on-chip peripherals (ADC, CAN, I2C, USART, PWM, ...)
* etc.
