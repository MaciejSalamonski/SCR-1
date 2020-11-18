EX_1

Poleceniem ps -l -u $USER | wc -l mozemy pokazac aktualne procesy uzytkownika. Wyswietlona 
liczbe nalezy pomnijeszyc o 2, poniewaz komenda wc -l jest redundantna i zlicza dodatkowo 
nazwe tabeli procesow oraz przejscie do kolejnej lini

Poleceniem pgrep sshd | wc -l mozmemy pokazac aktualna liczbe procesow sshd. Nie posiadam konta
na panamincie, wiec uzylem komendy pgrep root | wc -l, aby pokazac aktualna liczbe procesow
root'a.

EX_2

Uruchomiony zostal skrypt firstScript.sh, ktory spowodowal wywolanie
skryptu secondScript.sh, ktory to z kolei uruchomil skrypt thirdScript.sh.
Trzeci skrypt w hierarchi czekal na wpisanie danych od uzytkownika.
W nowym okienku terminala sprawdzono stan procesow poleceniem ps -ef.

UID          PID    PPID  C STIME TTY          TIME CMD
maciej      4627    3456  0 22:51 pts/0    00:00:00 bash firstScript.sh
maciej      4628    4627  0 22:51 pts/0    00:00:00 bash secondScript.sh
maciej      4629    4628  0 22:51 pts/0    00:00:00 bash thirdScript.sh
maciej      4631    3948  0 22:51 pts/1    00:00:00 ps -ef

Nastepnie zabito proces srodkowy w hierarchi poleceniem kill 4628

UID          PID    PPID  C STIME TTY          TIME CMD
maciej      4629    1196  0 22:51 pts/0    00:00:00 bash thirdScript.sh
maciej      4635    3948  0 22:53 pts/1    00:00:00 ps -ef

Spowodowalo to, ze zginal proces srodkowy oraz proces rodzic.
Osierocony proces otrzymal PIDD 1196

EX_3

Utworzono potok trzech proces procesow poleceniem
: ./ex3.sh | wc -l | cat > file.txt

Nastepnie wywolano komende: ps -l -u maciej

F S   UID     PID    PPID  C PRI  NI ADDR SZ WCHAN  TTY          TIME CMD
0 S  1000    5903    5525  0  80   0 -  3417 do_wai pts/1    00:00:00 bash
0 S  1000    6337    5903  0  80   0 -  3006 do_wai pts/1    00:00:00 ex3.sh
0 S  1000    6338    5903  0  80   0 -  2656 pipe_w pts/1    00:00:00 wc
0 S  1000    6339    5903  0  80   0 -  2688 pipe_w pts/1    00:00:00 cat
0 S  1000    6340    6337  0  80   0 -  2652 hrtime pts/1    00:00:00 sleep
0 R  1000    6341    5533  0  80   0 -  3504 -      pts/0    00:00:00 ps

Procesy uruchomione przez potok maja ten sam numer PPID. Jest to PID powloki z 
ktorej zostaly uruchomione

EX_4

Utworzono potok poleceniem mknod fifo p. Nastepnie otworzono cztery terminale. W okienku
pierwszym wydano polecenie pisania do potoku tzn. cat > fifo. W trzech pozostalych do odczytu.
Podczas wpisywania jakis danych do potoku, byly one umieszczane losowo do roznych procesow
do odczytu. Po zakonczeniu okna terminala (zakonczeniu procesu do odczytu), nie wplynelo to
na inne okna terminali. Jesli zakonczono okno do zapisu, wszystkie okna do odczytu rowniez
sie zakonczyly

EX_5

Program jest oodporny na cztery sygnaly wymienione w zadaniu: SIGINT, SIGQUIT, SIGFPE, SIGILL.
Wywolanie sygnalu SIGINT mozliwe jest tylko z termina, w ktorym uruchomiony jest biezacy proces.
Dla skryptu za pomoca skrotu klawiszowego ctrl c. Program nie moze byc odporny na sygnal
SIGKILL.

EX_6

Uruchomiono skrypt ex6.sh, ktorego zadaniem jest nieskonczone wypisywanie
aktualnej godziny co 10 sekund.

Output skryptu:

Script PID 7836

 01:44:38
 01:44:48

Nastepnie wcisnieto kombinacje CTRL + Z, ktora zawiesila skrypt.
[1]+  Stopped                 ./ex6.sh

Nastepnie przywrocono proces komenda kill -18 7836
Wydano komende: jobs
[1]+  Running                 ./ex6.sh &

Nastepnie zawieszono proces sygnalem SIGSTOP.
Wydano komende: kill -19 7836
[1]+  Stopped                 ./ex6.sh

Nastepnie przywrocono proces
Wydano komende: fg 1

Output:

./ex6.sh
 01:47:25
 01:47:36

Skrypt zostal przywrocony zgodnie z nazwa komendy fg - forground. Logi z programu wypisywane sa cyklicznie co 10 sekund do okna terminala. Mozemy
zawiesic skrypt CTRL + Z. Nie mozemy korzystac z terminala i wydawac kolejnych komend (dopoki nie zawiesimy programu)

[1]+  Stopped                 ./ex6.sh

Nastepnie przywrocono skrypt w tle (bg - background)
komenda: bg 1

Output: 

[1]+ ./ex6.sh &
maciej@maciej-VirtualBox:~/Documents/SCR/SCR-1/Lab2/ex6$  01:47:50
 01:48:00

Mozemy korzystac z terminala i wydawac kolejne komendy. Logi z programu
wciaz cyklicznie sa wyswietlane na ekran terminala. Nie mozemy zawiesic program kombinacaj CTRL + Z. Mozemy go zabic wydajac komende kill 7836

EX_7

Utworzono skrypt ex7.sh, ktorego zadaniem jest intkrementowanie licznika.
Uruchomiono skrypt poleceniem taskset -c 0 ./ex7.sh w dwoch terminalach. Wydano polecenie top, aby zaobserwowac obciazenie procesora.

PID  USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND 
9589 maciej    20   0   12024   3352   3108 R  20,9   0,2   0:17.08 ex7.sh   
9590 maciej    20   0   12024   3428   3196 R  20,6   0,2   0:13.21 ex7.sh

Zmieniono priorytet procesu 9590.
Wydano komende: renice 10 9590

9590 (process ID) old priority 0, new priority 10

PID  USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
9589 maciej    20   0   12024   3352   3108 R  20,9   0,2   0:51.73 ex7.sh
9590 maciej    30  10   12024   3428   3196 R  20,9   0,2   0:47.86 ex7.sh

Po zwiekszeniu priorytetu dla prcoesu o PID 9590 nie zaobserowano znaczacej roznicy
w obciazeniu procesora miedzy blizniaczymi procesami.

Zmiana priorytetu procesu 9590 na mniejszy np. 29 skutkowala komunikatem:

Wydana komenda: renice 9 9590
Output: renice: failed to set priority for 9590 (process ID): Permission denied

Mozliwe jest obnizenie priorytetu na roocie.

Wydane komendy:
sudo su
renice 9 9590

Output: 9590 (process ID) old priority 10, new priority 9

Efekt:

PID  USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
9589 maciej    20   0   12024   3352   3108 R  20,9   0,2   1:49.21 ex7.sh
9590 maciej    29   9   12024   3428   3196 R  20,9   0,2   1:45.34 ex7.sh


