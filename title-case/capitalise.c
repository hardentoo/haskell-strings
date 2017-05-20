#include <stdio.h>
#include <unistd.h>

int main(int argc, char **argv) {
    int bread;
    char buf[256 * 1024];
    char *ptr, *end;

    bread = read(0, buf, 256 * 1024);
    int was_space = 1;
    while (bread) {
        ptr = buf;
        end = ptr + bread;
        while (ptr != end) {
            char c = *ptr;
            if ( (c >= 9 && c <=13) || c == 32)
                was_space = 1;
            else if ((c >= 97 && c <= 122) && was_space) {
                *ptr &= ~32;
                was_space = 0;
            }

            else if (was_space)
                was_space = 0;
            ptr++;
        }
        write(1, buf, bread);
        bread = read(0, buf, 256 * 1024);
    }
    return 0;
}
