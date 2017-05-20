// script.c

#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main(void) {
    static const char filename[] = "input.txt";
    FILE *file = fopen(filename, "r");

    if (file != NULL) {
        char line[1024];
        while(fgets(line, sizeof line, file) != NULL) {
        line[strcspn (line, "\n")] = '\0';

        int lengthOfLine = strlen(line);
        int word = 0;
        int i;

        for (i = 0; i < lengthOfLine; i++) {
            if (isalpha(line[i])) {
            if (!word) {
                line[i] = (char) toupper (line[i]);
                word = 1;
            }
            } else {
            word = 0;
            }
        }

        printf ("%s\n", line);
        }

        fclose(file);
    } else {
        perror(filename);
    }

    return 0;
}
