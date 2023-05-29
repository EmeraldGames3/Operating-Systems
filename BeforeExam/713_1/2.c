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

    int value;
    printf("Temperaturwert: ");
    if (scanf("%d", &value) != 1) {
        printf("Invalid input. Please enter a numeric value.\n");
        exit(1);
    }

    char temperature[20];
    printf("Temperature format: ");
    if (scanf("%19s", temperature) != 1) {
        printf("Invalid input. Please enter a string.\n");
        exit(1);
    }

    if (strcmp(temperature, "Celsius") != 0 && strcmp(temperature, "Fahrenheit") != 0) {
        printf("Please enter a valid temperature unit.\n");
        exit(1);
    }

    write(pipeCS[1], &value, sizeof(int));
    write(pipeCS[1], &temperature, BUFFER_SIZE);

    if ((pid = fork()) < 0) {
        printf("Error has occurred");
        exit(1);
    } else if (pid == 0) {
        close(pipeCS[1]);  // Close the write end of the parent-to-child pipe
        close(pipeSC[0]);  // Close the read end of the child-to-parent pipe

        int v;
        char t[BUFFER_SIZE];

        read(pipeCS[0], &v, sizeof(int));
        read(pipeCS[0], &t, BUFFER_SIZE);
        printf("Temperature: %d %s\n", v, t);

        int convertedTemperature;
        if(t[0] == 'C'){
            convertedTemperature = v * 9 / 5 + 32;
        } else{
            convertedTemperature = (v - 32) * 5 / 9;
        }

        printf("%d\n", convertedTemperature);
        write(pipeSC[1], &convertedTemperature, sizeof(int));
        exit(0);
    } else {
        close(pipeCS[0]);  // Close the read end of the parent-to-child pipe
        close(pipeSC[1]);  // Close the write end of the child-to-parent pipe

        int cT;
        read(pipeSC[0], &cT, sizeof(int));

        printf("Received from server: %d %s", cT, temperature);
        wait(NULL);
    }

    return 0;
}