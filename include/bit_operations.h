#ifndef BIT_OPERATIONS_H
#define BIT_OPERATIONS_H

#include "cassert.h"

/*
 * These macros doesn't change the src variable
 */
#define _SET_BIT(src, n)                    (src | 1UL << n)      
#define _CLEAR_BIT(src, n)                  (src & ~(1UL << n))   
#define _TOGGLE_BIT(src, n)                 (src ^ 1UL << n)

#define _CHANGE_BIT(src, n, value)          ((src & ~(1UL << n)) | (value << n))
#define _CHANGE_2BIT(src, n, value)         ((src & ~(0b11UL << n)) | (value << n))
#define _CHANGE_3BIT(src, n, value)         ((src & ~(0b111UL << n)) | (value << n))
#define _CHANGE_4BIT(src, n, value)         ((src & ~(0x0fUL << n)) | (value << n))
#define _CHANGE_8BIT(src, n, value)         ((src & ~(0xffUL << n)) | (value << n))

#define _GET_BIT(src, n)                    ((src >> n) & 0b1)
#define _GET_4BIT(src, n)                    ((src >> n) & 0x0f)
#define _GET_8BIT(src, n)                    ((src >> n) & 0xff)

// --------------------------------------------------------
// TESTS 
// --------------------------------------------------------
CASSERT(_CHANGE_2BIT(0x1234, 3, 0b01) == 0x122c, bit_operations_h)
CASSERT(_GET_BIT(0b000100110, 5) == 1, bit_operations_h)
CASSERT(_GET_BIT(0x8020, 5) == 1, bit_operations_h)

#endif // BIT_OPERATIONS_H
