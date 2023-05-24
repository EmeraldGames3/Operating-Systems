#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>
#include <sys/types.h>

#define MAX_LINE_LENGTH 30
#define MAX_NUM_LINES 100

int main() {
    int pipe_process_1_to_2[2], pipe_process_1_to_3[2];
    pid_t pid2, pid3;

    // Create the pipes and check if there is an error when creating them
    if (pipe(pipe_process_1_to_2) < 0 || pipe(pipe_process_1_to_3) < 0) {
        printf("Error by creating pipes\n");
        exit(1);
    }

    char inputBuffer[1000];
    char lines[MAX_NUM_LINES][MAX_LINE_LENGTH + 1];
    int numLines = 0;

    printf("Enter the number of lines to be processed: ");
    fgets(inputBuffer, sizeof(inputBuffer), stdin);
    numLines = atoi(inputBuffer);

    if (numLines <= 0 || numLines > MAX_NUM_LINES) {
        printf("Invalid number of lines. Exiting.\n");
        exit(1);
    }

    printf("Enter text to be processed:\n");
    for (int i = 0; i < numLines; i++) {
        fgets(inputBuffer, sizeof(inputBuffer), stdin);
        int bufferLength = strlen(inputBuffer);

        // Remove the newline character if it exists
        if (bufferLength > 0 && inputBuffer[bufferLength - 1] == '\n') {
            inputBuffer[bufferLength - 1] = '\0';
        }

        strncpy(lines[i], inputBuffer, MAX_LINE_LENGTH);
    }

    // Process the lines
    for (int i = 0; i < numLines; i++) {
        int lineLength = strlen(lines[i]);
        char *line = lines[i];

        for (int j = 0; j < lineLength; j++) {
            if (line[j] == '\n' || j == lineLength - 1) {
                // Write the non-empty contents of buf to the respective pipes
                for (int k = 0; k <= j; k++) {
                    if (isdigit(line[k])) {
                        // Write to process 2
                        write(pipe_process_1_to_2[1], &line[k], 1);
                    }
                    if (isalpha(line[k])) {
                        // Write to process 3
                        write(pipe_process_1_to_3[1], &line[k], 1);
                    }
                }
                // Reset line length
                lineLength -= (j + 1);
                line += (j + 1);
                j = -1;  // Reset j to process the next line segment
            }
        }
    }

    // Close the write ends of the pipes
    close(pipe_process_1_to_2[1]);
    close(pipe_process_1_to_3[1]);

    // Create process 2
    if ((pid2 = fork()) < 0) {
        printf("Error at creating process 2\n");
        exit(1);
    } else if (pid2 == 0) {
        close(pipe_process_1_to_3[0]);

        char receivedText[1000];
        ssize_t bytes_read;

        // Read from pipe 1 to 2
        while ((bytes_read = read(pipe_process_1_to_2[0], receivedText, sizeof(receivedText))) > 0) {
            // Process the received text in process 2
            // Display the characters to standard output
            for (int i = 0; i < bytes_read; i++) {
                char c = receivedText[i];
                putchar(c);
            }
        }

        close(pipe_process_1_to_2[0]);

        exit(0);
    }

    // Create process 3
    if ((pid3 = fork()) < 0) {
        printf("Error at creating process 3\n");
        exit(1);
    } else if (pid3 == 0) {
        close(pipe_process_1_to_2[0]);

        char receivedText[1000];
        ssize_t bytes_read;

        // Read from pipe 1 to 3
        while ((bytes_read = read(pipe_process_1_to_3[0], receivedText, sizeof(receivedText))) > 0) {
            // Process the received text in process 3
            // Convert lowercase letters to uppercase and display them to standard output
            for (int i = 0; i < bytes_read; i++) {
                char c = receivedText[i];
                if (islower(c)) {
                    c = toupper(c);
                }
                putchar(c);
            }
        }

        close(pipe_process_1_to_3[0]);

        exit(0);
    }

    waitpid(pid2, NULL, 0);
    waitpid(pid3, NULL, 0);
    putchar('\n');
    return 0;
}

