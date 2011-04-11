#include <stdio.h>
#include "data.h"

int main() {
    FILE *f;
    int n;
    struct t b;

    // Add some arbitrary data here, who cares what.
    b.g = 50;

    f = fopen("filename.bin", "wb");
    if (f)
    {
            n = fwrite((void *) &b, sizeof(b), 1, f);
    }
    else
    {
            // error opening file
    };
    return 0;
}


    

