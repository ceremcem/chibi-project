#define CR_DEFAULT    0x44444444
#define ODR_DEFAULT    0x00000000

#define GPIO_MODE_INPUT             0b00
#define GPIO_MODE_OUTPUT_10MHZ      0b01
#define GPIO_MODE_OUTPUT_2MHZ       0b10
#define GPIO_MODE_OUTPUT_50MHZ      0b11

// valid only GPIO_MODE is 0
#define GPIO_CNF_ANALOG             (0b00 << 2)
#define GPIO_CNF_INPUT_FLOATING     (0b01 << 2)
#define GPIO_CNF_INPUT_PUPD         (0b10 << 2)
// valid only GPIO_MODE > 0
#define GPIO_CNF_OUTPUT_PP          (0b00 << 2)
#define GPIO_CNF_OUTPUT_OD          (0b01 << 2)
#define GPIO_CNF_AF_PP              (0b10 << 2)
#define GPIO_CNF_AF_OD              (0b11 << 2)

// GPIO configurations for device peripherals
#define PWM_CONF_50MHZ              (GPIO_CNF_AF_PP | GPIO_MODE_OUTPUT_50MHZ)

#define PIN_NUM(x)                  (4 * (x % 8)) // 4 bits per pin config,
                                                  // resetting at 8th pin
                                                  // in order to separate LOW and HIGH
                                                  // config registers

/* Example settings:
-----------------------
// Port A setup
#define VAL_GPIOACRL            CR_DEFAULT      // PA7...PA0
#define VAL_GPIOACRH            CR_DEFAULT      // PA15...PA8
#define VAL_GPIOAODR            ODR_DEFAULT


In board.c, do the following:
-------------------------------

void set_cr(GPIO_TypeDef * GPIOx, uint8_t pin_number, uint8_t mode){
    uint32_t c;
    if (pin_number < 8) {
        c = GPIOx->CRL;
    } else {
        c = GPIOx->CRH;
    }
    c &= ~(0xf << PIN_NUM(pin_number)); // clear the tuple
    c |= (mode << PIN_NUM(pin_number));
    if (pin_number < 8) {
        GPIOx->CRL = c;
    } else {
        GPIOx->CRH = c;
    }
}


// Board-specific initialization code.
void boardInit(void) {
    // init IO
    set_cr(GPIOA, GPIOA_PWM1_3, PWM_CONF_50MHZ);
}

*/
