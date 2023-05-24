#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <ctype.h>
#include <string.h>
#include <sys/errno.h>
#include <sys/wait.h>

#define FIFO_1_2 "fifo_1_2"
#define FIFO_1_3 "fifo_1_3"
#define FIFO_2_4 "fifo_2_4"

extern int errno;

#define MAX_NUM_LINES 100
#define MAX_LINE_LENGTH 1000

int main()
{
    // 1. Create named pipes
    if((mkfifo(FIFO_1_2, 0600)) && (errno != EEXIST)){
        perror("Error creating FIFO 1_2");
        exit(1);
    }

    if(mkfifo(FIFO_1_3, 0600) && (errno != EEXIST)){
        perror("Error creating FIFO 1_3");
        exit(1);
    }

    if(mkfifo(FIFO_2_4, 0600) && (errno != EEXIST)){
        perror("Error creating FIFO 2_4");
        exit(1);
    }

    pid_t pid2, pid3, pid4;

    //Create process 1, that reads that from the keyboard and writes it to FIFO 1_2 and FIFO 1_3
    int fd1;
    fd1 = open(FIFO_1_2, O_RDWR);

    int fd2;
    fd2 = open(FIFO_1_3, O_RDWR);

    int fd3;
    fd3 = open(FIFO_2_4, O_RDWR);

    if(fd1 < 0)
    {
        perror("Error opening FIFO 1_2");
        exit(1);
    }

    char inputBuffer[MAX_LINE_LENGTH];
    char lines[MAX_NUM_LINES][MAX_LINE_LENGTH + 1];
    int numLines = 0;

    printf("Enter the number of lines to be processed: ");
    fgets(inputBuffer, sizeof(inputBuffer), stdin);
    numLines = atoi(inputBuffer);

    if (numLines <= 0 || numLines > MAX_NUM_LINES){
        printf("Invalid number of lines. Exiting.\n");
        return 1;
    }

    printf("Enter text to be processed:\n");
    for (int i = 0; i < numLines; i++){
        fgets(inputBuffer, sizeof(inputBuffer), stdin);
        int bufferLength = strlen(inputBuffer);

        // Remove the newline character if it exists
        if (bufferLength > 0 && inputBuffer[bufferLength - 1] == '\n'){
            inputBuffer[bufferLength - 1] = '\0';
        }

        strncpy(lines[i], inputBuffer, MAX_LINE_LENGTH);
    }

    // Process the lines
    for (int i = 0; i < numLines; i++){
        int lineLength = strlen(lines[i]);

        bool writeTo2 = true, writeTo3 = true;
        for (int j = 0; j < lineLength; j++){
            if (isalpha(lines[i][j])){
                writeTo3 = false;
            }

            if (!(isalnum(lines[i][j]) || isspace(lines[i][j]))){
                writeTo2 = false;
            }
        }

        lines[i][lineLength] = '\n';
        lineLength += 1;  

        if (writeTo2){
            printf("Writing to FIFO 1_2: %s", lines[i]);
            if(write(fd1, &lines[i], lineLength) < 0){
                perror("Error writing to FIFO 1_2");
                exit(1);
            }
        }

        if (writeTo3){
            printf("Writing to FIFO 1_3: %s", lines[i]);
            if (write(fd2, &lines[i], lineLength) < 0){
                perror("Error writing to FIFO 1_3");
                exit(1);
            }
        }
    }

    char tempBuffer[1] = {0};
    write(fd2, &tempBuffer[0], 1);
    write(fd3, &tempBuffer[0], 1);
    

    if((pid2 = fork()) < 0) {
        printf("Error creating process 2\n");
        exit(1);
    } else if (pid2 == 0) {
        char buffer2[100] = {0};

        if(read(fd1, buffer2, 100) < 0){
            perror("Error reading from FIFO 1_2");
            exit(1);
        }

        for(int i = 0; i < strlen(buffer2); i++){
            if(isdigit(buffer2[i])){
                buffer2[i] = '_';
            }
        }

        close(fd1);

        if(write(fd3, buffer2, strlen(buffer2)) < 0){
            perror("Error writing to FIFO 2_4");
            exit(1);
        }

        printf("String written to FIFO 2_4: %s", buffer2);
        exit(0);
    }

    waitpid(pid2, NULL, 0);

    if ((pid3 = fork()) < 0) {
        printf("Error creating process 3\n");
        exit(1);
    } else if (pid3 == 0) {
        printf("Process 3:\n");
        char buffer3[100];

        if (read(fd2, buffer3, 100) < 0) {
            perror("Error reading from FIFO 1_3");
            exit(1);
        }

        printf("%s", buffer3);

        close(fd2);
        exit(0);
    }

    waitpid(pid3, NULL, 0);

    if ((pid4 = fork()) < 0) {
        printf("Error creating process 4\n");
        exit(1);
    } else if (pid4 == 0) {
        printf("Process 4:\n");
        char buffer4[100] = {0};

        if (read(fd3, buffer4, 100) < 0) {
            perror("Error reading from FIFO 2_4");
            exit(1);
        }

        close(fd3);

        printf("%s", buffer4);
        exit(0);
    }

    close(fd1);
    close(fd2);
    close(fd3);

    waitpid(pid4, NULL, 0);

    return 0;
}
