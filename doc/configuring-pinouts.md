# Peripheral and physical pin connections

## Configuration 
> From https://electronics.stackexchange.com/a/422280/20285

Procedural way to assign peripherals to physical pins is as follows: 

1. You may use any pin whose `Pinout.Type is I/O` as GPIO. [Configure][2] in/out selection by "GPIO Configuration Register (GPIO_CR = GPIOx_CR{H+L})".
2. You may use any GPIO pin as ADC input if "ADCx_INy" is listed in its "Alternate Functions" column. Configure "Analog mode" by GPIO_CR.
3. You may connect an on-chip peripheral to its dedicated pins. To do so:
  1. Decide which peripheral to use (USARTx, SPIx, PWMx/y (=TIMx_CHy)). 
  2. Decide whether if you want to use the peripheral with its default pinouts or alternative pinouts. (A peripheral might have optional physical connections inside MCU. Refer to REMAP (or similar) column of Pinouts Table)
  3. Wire the peripheral's input(s) and/or output(s) to the physical pins you have chosen in the previous step. (see "GPIO configurations of the device peripherals" section in the RM.)
      1. Inputs: Enable the "Alternate Function Output" (despite the confusing word "output") in GPIO_CR.
      2. Outputs: Enable the "Alternate Function Output" in GPIO_CR. 
      3. If more than one on-chip peripheral outputs are listed in the same physical pin column, then **you have to** refer to further registers  to select which peripheral to enable (or see the default peripheral). Specific alternate function (peripheral) is selected via:
          1. AFIO_MAPR register for STM32F1xx
          2. AFR_x register for STM32F03x


### Notes for connecting a peripheral: 

The developer (or the RTOS library is) responsible for generating the compiler errors if two or more conflicting peripheral (which needs use the same physical pin) is mistakenly enabled at the same time. However, as we are able to change the peripheral setup in the runtime, it's unlikely to expect such a compile-time error.

  [2]: https://i.stack.imgur.com/J5v8P.png
  [3]: https://i.stack.imgur.com/hlBTv.png


## Explanation of Abstraction Levels

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

# TODO

1. Add the "MCU Family list" location which is to be used in board.h
2. Add MCU family swap procedure for a project
