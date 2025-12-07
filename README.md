# pdsh/pdcp
## Ghid de configurare
Pentru a testa/folosi aceste script-uri, trebuie sa aveti Docker instalat si configurat pe sistemul vostru.

Clonati local acest repository si urmariti urmatorii pasi pentru a configura reteaua de containere necesara testarii comenzilor.
`git clone git@github.com:fanceapa1/pdsh-pdcp.git`

Navigati in cadrul folder-ului `config` si creati un nou folder `keys`, in care veti genera o cheie ssh, pe care o vom folosi ca instantele de virtualizare sa poata interactiona intre ele:<br>
`mkdir keys`<br>
`cd keys`<br>
`ssh-keygen -t rsa -b 4096 -f ./keys/id_rsa -N ""`
<br><br>

Navigati inapoi in folderul config si activati containerele:<br>
`cd ..`<br>
`docker compose up -d --build`

Rulati urmatoarea comanda pentru a verifica daca initializarea a avut succes:<br>
`docker ps`<br>

Ar trebui sa vedeti cele 3 containere: `foo1, foo2, foo3` active.<br><br>

O comanda de testare:<br>
`docker exec foo1 pdsh -w foo[1-3] hostname`<br><br>
Ar trebui sa returneze un output de tipul:<br>
`"foo3: foo3
foo2: foo2
foo1: foo1"`<br><br>

Pentru a accesa terminalul uneia dintre virtualizari, folositi:<br>
`docker exec -it foo1 bash`<br>

Reveniti la propriul sistem cu comanda `exit`<br><br>

Opriti functionarea containerelor prin comanda:<br>
`docker compose down`