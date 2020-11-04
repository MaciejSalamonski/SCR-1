EX_1

Poleceniem ps -l -u $USER | wc -l mozemy pokazac aktualne procesy uzytkownika. Wyswietlona liczbe nalezy pomnijeszyc o 2, poniewaz komenda wc -l jest redundantna i zlicza dodatkowo 
nazwe tabeli procesow oraz przejscie do kolejnej lini

Poleceniem pgrep sshd | wc -l mozmemy pokazac aktualna liczbe procesow sshd. Nie posiadam konta
na panamincie, wiec uzylem komendy pgrep root | wc -l, aby pokazac aktualna liczbe procesow
root'a.

EX_2


