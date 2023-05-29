#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define BUFFER_SIZE 256

int main() {
    int pid;
    int pipeCS[2];  // Pipe for parent to child communication
    int pipeSC[2];  // Pipe for child to parent communication

    if (pipe(pipeCS) < 0 || pipe(pipeSC) < 0) {
        printf("Error has occurred");
        exit(1);
    }

    int steps;
    printf("Enter the amount of steps: ");
    if (scanf("%d", &steps) != 1) {
        printf("Invalid input for steps. Please enter a numeric value.\n");
        exit(1);
    }

    if (steps < 0) {
        printf("Steps must be a positive integer.\n");
        exit(1);
    }

    write(pipeCS[1], &steps, sizeof(int));

    if ((pid = fork()) < 0) {
        printf("Error has occurred");
        exit(1);
    } else if (pid == 0) {
        close(pipeCS[1]);  // Close the write end of the parent-to-child pipe
        close(pipeSC[0]);  // Close the read end of the child-to-parent pipe

        int s;
        read(pipeCS[0], &s, sizeof(int));
        printf("Steps: %d\n", s);

        printf("Output serve: ");
        if (s < 5000) {
            printf("Bewegungsmangel\n");
            write(pipeSC[1], "Bewegungsmangel", strlen("Bewegungsmangel")+1);
        } else if (s < 10000) {
            printf("Leichte Aktivitat\n");
            write(pipeSC[1], "Leichte Aktivitat", strlen("Leichte Aktivitat")+1);
        } else if (s < 15000) {
            printf("Massige Aktivitat\n");
            write(pipeSC[1], "Massige Aktivitat", strlen("Massige Aktivitat")+1);
        } else if (s < 20000) {
            printf("Aktiv\n");
            write(pipeSC[1], "Aktiv", strlen("Aktiv")+1);
        } else {
            printf("Sehr Aktiv\n");
            write(pipeSC[1], "Sehr Aktiv", strlen("Sehr Aktiv")+1);
        }

        exit(0);
    } else {
        close(pipeCS[0]);  // Close the read end of the parent-to-child pipe
        close(pipeSC[1]);  // Close the write end of the child-to-parent pipe

        char buffer[BUFFER_SIZE];
        int num_bytes = read(pipeSC[0], buffer, BUFFER_SIZE);
        if (num_bytes > 0) {
            printf("Message from child: %s\n", buffer);
        }

        wait(NULL);
    }

    return 0;
}