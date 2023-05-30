#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    int pid;
    int pipeCS[2];  // Pipe for parent to child communication
    int pipeSC[2];  // Pipe for child to parent communication

    if (pipe(pipeCS) < 0 || pipe(pipeSC) < 0) {
        printf("Error has occurred");
        exit(1);
    }

    float price;
    char inputBuffer[256];

    printf("Enter the price: ");
    fgets(inputBuffer, sizeof(inputBuffer), stdin);

    if (inputBuffer[0] != '0' && inputBuffer[0] != '1' && inputBuffer[0] != '2' && inputBuffer[0] != '3' &&
        inputBuffer[0] != '4' && inputBuffer[0] != '5' && inputBuffer[0] != '6' && inputBuffer[0] != '7' &&
        inputBuffer[0] != '8' && inputBuffer[0] != '9') {
        price = -1;
        write(pipeCS[1], &price, sizeof(float));
    }

    if(inputBuffer[0] == '-'){
        price = -1;
        write(pipeCS[1], &price, sizeof(float));
    }

    for(int i = 0; i < 256; i++){
        if(inputBuffer[i] == '\n'){
            break;
        }
        if(inputBuffer[i] == ','){
            continue;
        }

        if (inputBuffer[i] != '0' && inputBuffer[i] != '1' && inputBuffer[i] != '2' && inputBuffer[i] != '3' &&
            inputBuffer[i] != '4' && inputBuffer[i] != '5' && inputBuffer[i] != '6' && inputBuffer[i] != '7' &&
            inputBuffer[i] != '8' && inputBuffer[i] != '9') {
            price = -1;
            write(pipeCS[1], &price, sizeof(float));
        }
    }

    price = atof(inputBuffer);

    if (price <= 0) {
        price = -1;
        write(pipeCS[1], &price, sizeof(float));
    }

    write(pipeCS[1], &price, sizeof(float));
    if ((pid = fork()) < 0) {
        printf("Error has occurred");
        exit(1);
    } else if (pid == 0) {
        close(pipeCS[1]);  // Close the write end of the parent-to-child pipe
        close(pipeSC[0]);  // Close the read end of the child-to-parent pipe

        float p;
        read(pipeCS[0], &p, sizeof(float));

        if(p < 0){
            printf("Bitte geben Sie einen gultigen Wert\n");
			p = -1;
            write(pipeSC[1], &p, sizeof(float));
            exit(0);
        }

        printf("Price: %f\n", p);

        float newPrice = (p * 110) / 100;

        printf("Preis mit Servicebuhr: %f\n", newPrice);
        write(pipeSC[1], &newPrice, sizeof(float));

        exit(0);
    } else {
        close(pipeCS[0]);  // Close the read end of the parent-to-child pipe
        close(pipeSC[1]);  // Close the write end of the child-to-parent pipe

        wait(NULL);
        float nP;
        read(pipeSC[0], &nP, sizeof(float));

        if(nP < 0){
            printf("Ungultige Eingabe\n");
        } else{
            printf("Empfang vom Server: %f\n", nP);
        }
    }

    return 0;
}
