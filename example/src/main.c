#include <stdio.h>

#include "foo.h"

int main(void) {
    printf("%s:%s called\n", __FILE__, __func__);
    foo();
}
