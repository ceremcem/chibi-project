#define SPI_CR2_DATASIZE_8BIT         SPI_CR2_DS_0
#define SPI_CR2_DATASIZE_16BIT        SPI_CR2_DS_1 
#define SPI_CR2_DATASIZE_24BIT        (SPI_CR2_DS_0 \
                                            | SPI_CR2_DS_1 \
                                            )
