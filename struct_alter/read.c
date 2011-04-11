#include <stdio.h>
#include "data.h"

int main() {
    FILE *f;
    int n;
    struct t b;

    f = fopen("filename.bin", "rb");
    if (f)
    {
            n = fread((void *) &b, sizeof(b), 1, f);
            printf("%i", b.g);
    }
    else
    {
            // error opening file
    };
    return 0;
}


    

