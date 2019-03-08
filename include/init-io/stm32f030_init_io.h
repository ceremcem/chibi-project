/*
 * I/O ports initial setup, this configuration is established soon after reset
 * in the initialization code.
 * Please refer to the STM32 Reference Manual for details.
 */
#define PIN_MODE_INPUT(n)           (0U << ((n) * 2U))
#define PIN_MODE_OUTPUT(n)          (1U << ((n) * 2U))
#define PIN_MODE_ALTERNATE(n)       (2U << ((n) * 2U))
#define PIN_MODE_ANALOG(n)          (3U << ((n) * 2U))
#define PIN_ODR_LOW(n)              (0U << (n))
#define PIN_ODR_HIGH(n)             (1U << (n))
#define PIN_OTYPE_PUSHPULL(n)       (0U << (n))
#define PIN_OTYPE_OPENDRAIN(n)      (1U << (n))
#define PIN_OSPEED_2M(n)            (0U << ((n) * 2U))
#define PIN_OSPEED_10M(n)           (1U << ((n) * 2U))
#define PIN_OSPEED_40M(n)           (3U << ((n) * 2U))
#define PIN_PUPDR_FLOATING(n)       (0U << ((n) * 2U))
#define PIN_PUPDR_PULLUP(n)         (1U << ((n) * 2U))
#define PIN_PUPDR_PULLDOWN(n)       (2U << ((n) * 2U))
#define PIN_AFIO_AF(n, mode)        ((mode) << (((n) % 8U) * 4U))

// Important pins
#define GPIOA_SWDIO                 13u
#define GPIOA_SWCLK                 14u

// defaults, see Reference Manual, 8.4
#define GPIOA_MODER_DEFAULT                 (PIN_MODE_ALTERNATE(GPIOA_SWDIO) \
                                                | PIN_MODE_ALTERNATE(GPIOA_SWCLK) \
                                                )
#define GPIOx_MODER_DEFAULT                 0
#define GPIOA_OTYPER_DEFAULT                0
#define GPIOx_OTYPER_DEFAULT                0
#define GPIOA_OSPEEDR_DEFAULT               PIN_OSPEED_40M(GPIOA_SWDIO)
#define GPIOx_OSPEEDR_DEFAULT               0
#define GPIOA_PUPDR_DEFAULT                 (PIN_PUPDR_PULLDOWN(GPIOA_SWCLK) \
                                                | PIN_PUPDR_PULLUP(GPIOA_SWDIO) \
                                                )
#define GPIOx_PUPDR_DEFAULT                 0
#define GPIOA_ODR_DEFAULT                   0
#define GPIOx_ODR_DEFAULT                   0
#define GPIOA_AFRL_DEFAULT                  0
#define GPIOA_AFRH_DEFAULT                  0
#define GPIOx_AFRL_DEFAULT                  0
#define GPIOx_AFRH_DEFAULT                  0

/* Example Initialization:
---------------------------------

#define VAL_GPIOA_MODER             (GPIOA_MODER_DEFAULT \
                                        | PIN_MODE_ALTERNATE(GPIOA_PWM1_3))
#define VAL_GPIOA_OTYPER            PIN_OTYPE_PUSHPULL(GPIOA_PWM1_3)
#define VAL_GPIOA_OSPEEDR           PIN_OSPEED_40M(GPIOA_PWM1_3)
#define VAL_GPIOA_PUPDR             GPIOA_PUPDR_DEFAULT
#define VAL_GPIOA_ODR               GPIOA_ODR_DEFAULT
#define VAL_GPIOA_AFRL              GPIOA_AFRL_DEFAULT
#define VAL_GPIOA_AFRH              PIN_AFIO_AF(GPIOA_PWM1_3, 2u)

*/
