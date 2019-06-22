// taken from:
// https://github.com/LonelyWolf/stm32/blob/c883e581ed53b1e83eb77bf47d1f4ccb91ce0d25/stm32l4-template/periph/spi.h

//
// refer to "Bit definition for SPI_CR1 register" section of MCU header file
// for more 


/* 
 * CR1 settings 
 */
// SPI baud rate prescaler (PCLK/SPI_BR_x)
#define SPI_BR_2                   ((uint32_t)0x00000000U)                      // 2
#define SPI_BR_4                   SPI_CR1_BR_0                                 // 4
#define SPI_BR_8                   SPI_CR1_BR_1                                 // 8
#define SPI_BR_16                  (SPI_CR1_BR_1 | SPI_CR1_BR_0)                // 16
#define SPI_BR_32                  SPI_CR1_BR_2                                 // 32
#define SPI_BR_64                  (SPI_CR1_BR_2 | SPI_CR1_BR_0)                // 64
#define SPI_BR_128                 (SPI_CR1_BR_2 | SPI_CR1_BR_1)                // 128
#define SPI_BR_256                 (SPI_CR1_BR_2 | SPI_CR1_BR_1 | SPI_CR1_BR_0) // 256

/*
 * CR2 settings
 */
#define SPI_DW_4BIT                (SPI_CR2_DS_0 | SPI_CR2_DS_1)                               //  4 bits
#define SPI_DW_5BIT                SPI_CR2_DS_2                                                //  5 bits
#define SPI_DW_6BIT                (SPI_CR2_DS_2 | SPI_CR2_DS_0)                               //  6 bits
#define SPI_DW_7BIT                (SPI_CR2_DS_2 | SPI_CR2_DS_1)                               //  7 bits
#define SPI_DW_8BIT                (SPI_CR2_DS_2 | SPI_CR2_DS_1 | SPI_CR2_DS_0)                //  8 bits
#define SPI_DW_9BIT                SPI_CR2_DS_3                                                //  9 bits
#define SPI_DW_10BIT               (SPI_CR2_DS_3 | SPI_CR2_DS_0)                               // 10 bits
#define SPI_DW_11BIT               (SPI_CR2_DS_3 | SPI_CR2_DS_1)                               // 11 bits
#define SPI_DW_12BIT               (SPI_CR2_DS_3 | SPI_CR2_DS_1 | SPI_CR2_DS_0)                // 12 bits
#define SPI_DW_13BIT               (SPI_CR2_DS_3 | SPI_CR2_DS_2)                               // 13 bits
#define SPI_DW_14BIT               (SPI_CR2_DS_3 | SPI_CR2_DS_2 | SPI_CR2_DS_0)                // 14 bits
#define SPI_DW_15BIT               (SPI_CR2_DS_3 | SPI_CR2_DS_2 | SPI_CR2_DS_1)                // 15 bits
#define SPI_DW_16BIT               (SPI_CR2_DS_3 | SPI_CR2_DS_2 | SPI_CR2_DS_1 | SPI_CR2_DS_0) // 16 bits