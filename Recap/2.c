#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    int pid;
    int pipeCS[2];
    if (pipe(pipeCS) < 0) {
        printf("Error has occurred");
        exit(1);
    }
    int a, b, c;
    printf("Enter the coefficients a, b, c: \n");
    scanf("%d%d%d", &a, &b, &c);
    int array[3] = {a, b, c};
    write(pipeCS[1], &array, 3 * sizeof(int));
    close(pipeCS[1]);
    if ((pid = fork()) < 0) {
        printf("Error has occurred");
        exit(1);
    } else if (pid == 0) {
        close(pipeCS[1]);
        int coeff[3];
        read(pipeCS[0], &coeff, 3*sizeof(int));
        printf("Gleichung :%d * x^2 + %d * x + %d ",coeff[0],coeff[1],coeff[2]);
		int delta = coeff[1] * coeff[1] - 4 * coeff[0] * coeff[2];
		printf("Delta: %d \n", delta);
    }
    return 0;
}
