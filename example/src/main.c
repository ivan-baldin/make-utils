#include <stdio.h>

#include "lib.h"

int main(void) {
    printf("%s:%s called\n", __FILE__, __func__);
    lib();
}
