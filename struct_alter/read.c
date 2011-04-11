#include <stdio.h>
struct t {
   int g;
   char m[50];
};

int main() {
    FILE *f;
    int n;
    struct t b;

    //b.g = 50;
    //b.m = *"1234512345123451234512345123451234512345123451233";

    f = fopen("filename.bin", "rb");
    if (f)
    {
            n = fread((void *) &b, sizeof(b), 1, f);
            printf("%i", b.g);
            //n = fwrite((void *) &b, sizeof(b), 1, f);
    }
    else
    {
            // error opening file
    };
    return 0;
}


    

