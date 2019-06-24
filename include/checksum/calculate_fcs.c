#include "ch.h"

uint8_t calculateFCS(uint8_t *buffer, uint8_t count)
{
    uint8_t val, i;
    val = 0;
    for(i = 0; i < count; i++)
    {
        val = val ^ buffer[i];
    }
    return val;
}
