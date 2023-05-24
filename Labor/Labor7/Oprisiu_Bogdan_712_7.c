#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

// Function to calculate the sum of cubes for a given range of numbers
int sumOfCubes(int start, int end, char *argv[]) {
    int sum = 0;
    for (int i = start; i <= end; i++) {
        int num = atoi(argv[i]);
        int cube = num * num * num;
        sum += cube;
    }
    return sum;
}

int main(int argc, char *argv[]) {
    // Check if command-line arguments are provided
    if (argc < 2) {
        printf("Please provide numbers as command line parameters.\n");
        return 1;
    }

    int numElements = argc - 1;
    int range = numElements / 4;
    int remainingElements = numElements % 4;

    int pipefd[2];
    // Create a pipe to communicate between parent and child processes
    if (pipe(pipefd) == -1) {
        printf("Error occurred while creating a pipe.\n");
        return 1;
    }

    // Fork four child processes
    for (int i = 0; i < 4; i++) {
        pid_t pid = fork();
        if (pid == 0) {
            // Child process

            // Calculate the start and end indices of the range for each child
            int start = i * range + 1;
            int end = start + range - 1;
            
            // If it's the last child, assign it any remaining elements
            if (i == 3) {
                end += remainingElements;
            }

            // Calculate the sum of cubes for the assigned range
            int result = sumOfCubes(start, end, argv);

            // Close the read end of the pipe as the child only writes to it
            close(pipefd[0]);
            
            // Write the result to the pipe
            write(pipefd[1], &result, sizeof(int));
            
            // Close the write end of the pipe
            close(pipefd[1]);
            
            // Terminate the child process
            exit(0);
        } else if (pid < 0) {
            printf("Error occurred while forking.\n");
            exit(1);
        }
    }

    int totalSum = 0;
    int childSum = 0;
    
    // Close the write end of the pipe in the parent process
    close(pipefd[1]);

    // Read the results from each child process and calculate the total sum
    for (int i = 0; i < 4; i++) {
        read(pipefd[0], &childSum, sizeof(int));  // Read the result from the pipe
        totalSum += childSum;
    }

    // Close the read end of the pipe in the parent process
    close(pipefd[0]);

    // Print the final sum of the cubes
    printf("Final sum of the cubes: %d\n", totalSum);

    // Wait for all child processes to finish
    for (int i = 0; i < 4; i++) {
        wait(NULL);
    }

    return 0;
}
