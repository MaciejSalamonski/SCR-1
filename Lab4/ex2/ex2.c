#include <fcntl.h>  /* open() */
#include <stdio.h>  /*scanf()*/
#include <stdlib.h> /* exit() */
#include <unistd.h> /* pipe(), fork() */

#define fileSize 128   /*Maksymalna dlugosc nazwy pliku*/
#define bufferSize 512 /*Rozmiar Buforu obrazu*/

int main(void) {
    /*======================Rodzic========================*/

    int somePipe[2];              /*somePipe[0] - odczyt, somePipe[1] - zapis*/
    char fileName[fileSize];      /*Nazwa wczytywanego pliku*/
    int descriptor;               /*Deskrpytor pliku*/
    char imageBuffer[bufferSize]; /*Bufor obrazu*/
    pid_t childp;
    int bytesCounter; /*Licznik zczytanych bajtow*/

    if (pipe(somePipe) < 0) /*Tworzenie potoku, w przypadku błędu, wyjdz z programu*/
        exit(1);

    printf("Type the name of the image you want to view\n");
    scanf("%s", fileName);
    descriptor = open(fileName, O_RDONLY);

    if (descriptor != -1) /*Jesli udalo sie otworzyc plik*/
    {
        childp = fork(); /*Klonowanie procesu*/
        if (childp < 0)  /*Nie udalo sie utworzyc podprocesu - konczy program*/
        {
            printf("Subprocess creation failed!\n");
            exit(1);
        } else if (childp == 0) /*========Dziecko========*/
        {
            printf("I'm child \n");
            close(0);                           /*Zamkniecie stdin*/
            dup(somePipe[0]);                   /*Duplikowanie czytania na stdin*/
            close(somePipe[0]);                 /*Zamkniecie potoku do czytania*/
            close(somePipe[1]);                 /*Zamkniecie do pisania*/
            execlp("display", "display", NULL); /*Wyswietlenie z stdin*/
            exit(0);
        } else /*===========Rodzic===========*/
        {
            printf("I'm parent\n");
            close(somePipe[0]);                                                    /*Zamkniecie potoku do czytania*/
            while ((bytesCounter = read(descriptor, imageBuffer, bufferSize)) > 0) /*Czytanie bufora*/
            {
                write(somePipe[1], imageBuffer, bytesCounter); /*Wysylanie bufora do potoku*/
            }
            close(somePipe[1]); /*Zamknij potok do pisania*/
                                //close(descriptor); /*Zamknij plik*/
        }
    } else /*Jesli nie udalo sie otworzyc pliku - zakoncz program*/
    {
        printf("Failed to open the file\n");
    }

    close(descriptor); /*Zamknij otwarty plik*/

    return 0;
}
