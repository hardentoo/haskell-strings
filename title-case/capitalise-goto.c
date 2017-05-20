//
// From https://gist.github.com/Syzygies/3969330
//

#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {
    int bread;
    char c, buf[256 * 1024];
    char *ptr, *end;
    FILE *file = fopen("input.txt", "r");

    bread = fread(buf, 1, 256 * 1024, file);
    while (bread) {
        ptr = buf;
        end = ptr + bread;
    
    one:
        if (ptr == end) goto done;
        c = *ptr;
        if ((c >= 9 && c <=13) || c == 32) {
            ++ptr;
            goto one;
        }
        if (c >= 97 && c <= 122) *ptr &= ~32;
        ++ptr;
    
    two:
        if (ptr == end) goto done;
        c = *ptr;
        ++ptr;
        if ((c >= 9 && c <=13) || c == 32) goto one;
        goto two;

    done:
        write(1, buf, bread);
        bread = fread(buf, 1, 256 * 1024, file);
    }
    fclose(file);
    return 0;
}
