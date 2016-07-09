#include "lib.h"

#include <stdio.h>

void lib(void) {
    printf("%s:%s called\n", __FILE__, __func__);
}
