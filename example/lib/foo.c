#include "foo.h"

#include <stdio.h>

void foo(void) {
    printf("%s:%s called\n", __FILE__, __func__);
}
