/*
    ChibiOS - Copyright (C) 2006..2015 Giovanni Di Sirio

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

#ifndef _BOARD_H_
#define _BOARD_H_

/*
 * MCU type as defined in the ST header.
 */
#define STM32F030x4
#define STM32F030x6 // temporary definition, see http://www.chibios.com/forum/viewtopic.php?f=35&t=5023

/*
 * IO pins assignments.
 */
#define GPIOA_PWM1_3        10u
#define GPIOA_1             1u

#include "stm32f030_init_io.h"

/*
 * GPIOA setup
 * PA10: PWM1.3 -> AF2 (RM/Table 12)
 */
#define VAL_GPIOA_MODER             (GPIOA_MODER_DEFAULT \
                                        | PIN_MODE_ALTERNATE(GPIOA_PWM1_3) \
                                        )
#define VAL_GPIOA_OTYPER            (PIN_OTYPE_PUSHPULL(GPIOA_PWM1_3) \
                                        )
#define VAL_GPIOA_OSPEEDR           PIN_OSPEED_40M(GPIOA_PWM1_3)
#define VAL_GPIOA_PUPDR             GPIOA_PUPDR_DEFAULT
#define VAL_GPIOA_ODR               GPIOA_ODR_DEFAULT
#define VAL_GPIOA_AFRL              GPIOA_AFRL_DEFAULT
#define VAL_GPIOA_AFRH              PIN_AFIO_AF(GPIOA_PWM1_3, 2u)

#define VAL_GPIOB_MODER             GPIOx_MODER_DEFAULT
#define VAL_GPIOB_OTYPER            GPIOx_OTYPER_DEFAULT
#define VAL_GPIOB_OSPEEDR           GPIOx_OSPEEDR_DEFAULT
#define VAL_GPIOB_PUPDR             GPIOx_PUPDR_DEFAULT
#define VAL_GPIOB_ODR               GPIOx_ODR_DEFAULT
#define VAL_GPIOB_AFRL              GPIOx_AFRL_DEFAULT
#define VAL_GPIOB_AFRH              GPIOx_AFRH_DEFAULT

#define VAL_GPIOC_MODER             GPIOx_MODER_DEFAULT
#define VAL_GPIOC_OTYPER            GPIOx_OTYPER_DEFAULT
#define VAL_GPIOC_OSPEEDR           GPIOx_OSPEEDR_DEFAULT
#define VAL_GPIOC_PUPDR             GPIOx_PUPDR_DEFAULT
#define VAL_GPIOC_ODR               GPIOx_ODR_DEFAULT
#define VAL_GPIOC_AFRL              GPIOx_AFRL_DEFAULT
#define VAL_GPIOC_AFRH              GPIOx_AFRH_DEFAULT

#define VAL_GPIOD_MODER             GPIOx_MODER_DEFAULT
#define VAL_GPIOD_OTYPER            GPIOx_OTYPER_DEFAULT
#define VAL_GPIOD_OSPEEDR           GPIOx_OSPEEDR_DEFAULT
#define VAL_GPIOD_PUPDR             GPIOx_PUPDR_DEFAULT
#define VAL_GPIOD_ODR               GPIOx_ODR_DEFAULT
#define VAL_GPIOD_AFRL              GPIOx_AFRL_DEFAULT
#define VAL_GPIOD_AFRH              GPIOx_AFRH_DEFAULT

#define VAL_GPIOE_MODER             GPIOx_MODER_DEFAULT
#define VAL_GPIOE_OTYPER            GPIOx_OTYPER_DEFAULT
#define VAL_GPIOE_OSPEEDR           GPIOx_OSPEEDR_DEFAULT
#define VAL_GPIOE_PUPDR             GPIOx_PUPDR_DEFAULT
#define VAL_GPIOE_ODR               GPIOx_ODR_DEFAULT
#define VAL_GPIOE_AFRL              GPIOx_AFRL_DEFAULT
#define VAL_GPIOE_AFRH              GPIOx_AFRH_DEFAULT

#define VAL_GPIOF_MODER             GPIOx_MODER_DEFAULT
#define VAL_GPIOF_OTYPER            GPIOx_OTYPER_DEFAULT
#define VAL_GPIOF_OSPEEDR           GPIOx_OSPEEDR_DEFAULT
#define VAL_GPIOF_PUPDR             GPIOx_PUPDR_DEFAULT
#define VAL_GPIOF_ODR               GPIOx_ODR_DEFAULT
#define VAL_GPIOF_AFRL              GPIOx_AFRL_DEFAULT
#define VAL_GPIOF_AFRH              GPIOx_AFRH_DEFAULT

#if !defined(_FROM_ASM_)
#ifdef __cplusplus
extern "C" {
#endif
  void boardInit(void);
#ifdef __cplusplus
}
#endif
#endif /* _FROM_ASM_ */

#endif /* _BOARD_H_ */
