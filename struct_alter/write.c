#include <stdio.h>
struct t {
   int g;
   char m[50];
};

int main() {
    FILE *f;
    int n;
    struct t b;

    b.g = 50;

    f = fopen("filename.bin", "wb");
    if (f)
    {
            //n = fread(buffer, MAX_FILE_SIZE, 1, f);
            n = fwrite((void *) &b, sizeof(b), 1, f);
    }
    else
    {
            // error opening file
    };
    return 0;
}


    

