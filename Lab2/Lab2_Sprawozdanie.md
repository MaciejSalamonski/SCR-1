EX_1

Poleceniem ps -l -u $USER | wc -l mozemy pokazac aktualne procesy uzytkownika. Wyswietlona liczbe nalezy pomnijeszyc o 2, poniewaz komenda wc -l jest redundantna i zlicza dodatkowo 
nazwe tabeli procesow oraz przejscie do kolejnej lini

Poleceniem pgrep sshd | wc -l mozmemy pokazac aktualna liczbe procesow sshd. Nie posiadam konta
na panamincie, wiec uzylem komendy pgrep root | wc -l, aby pokazac aktualna liczbe procesow
root'a.

EX_4

Utworzono potok poleceniem mknod fifo p. Nastepnie otworzono cztery terminale. W okienku
pierwszym wydano polecenie pisania do potoku tzn. cat > fifo. W trzech pozostalych do odczytu.
Podczas wpisywania jakis danych do potoku, byly one umieszczane losowo do roznych procesow
do odczytu. Po zakonczeniu okna terminala (zakonczeniu procesu do odczytu), nie wplynelo to
na inne okna terminali. Jesli zakonczono okno do zapisu, wszystkie okna do odczytu rowniez
sie zakonczyly



