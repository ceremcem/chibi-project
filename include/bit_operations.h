#ifndef BIT_OPERATIONS_H
#define BIT_OPERATIONS_H

// These macros doesn't change the src variable
#define _SET_BIT(src, n)                    (src | 1UL << n)      
#define _CLEAR_BIT(src, n)                  (src & ~(1UL << n))   
#define _TOGGLE_BIT(src, n)                 (src ^ 1UL << n)
#define _CHANGE_BIT(src, n, value)          ((src & ~(1UL << n)) | (value << n))

#endif // BIT_OPERATIONS_H
