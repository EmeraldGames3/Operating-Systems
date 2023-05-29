#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    int pid;
    int pipeCS[2];
    if (pipe(pipeCS) < 0) {
        printf("Error has occurred");
        exit(1);
    }

    int price;
    float discount;
    printf("Enter the price: ");
    if (scanf("%d", &price) != 1) {
        printf("Invalid input for price. Please enter a numeric value.\n");
        exit(1);
    }

    printf("Enter the discount: ");
    if (scanf("%f", &discount) != 1) {
        printf("Invalid input for discount. Please enter a numeric value.\n");
        exit(1);
    }

    if (discount < 0 || discount > 100) {
        printf("Discount must be between 0 and 100.\n");
        exit(1);
    }

    write(pipeCS[1], &price, sizeof(int));
    write(pipeCS[1], &discount, sizeof(float));
    if ((pid = fork()) < 0) {
        printf("Error has occurred");
        exit(1);
    } else if (pid == 0) {
        int p;
        float d;
        read(pipeCS[0], &p, sizeof(int));
        read(pipeCS[0], &d, sizeof(float));

        printf("Price: %d\n", p);
        printf("Discount: %.2f\n", d);

        int newPrice = (p * (100 - d)) / 100;

		printf("Endpreis nach Anwendung des Rabatts zurück: %d\n", newPrice);

        write(pipeCS[1], &newPrice, sizeof(int));

        exit(0);
    } else {
        wait(NULL);
        int nP;
        read(pipeCS[0], &nP, sizeof(int));
        printf("Empfang vom Server: %d\n", nP);
    }

    return 0;
}
