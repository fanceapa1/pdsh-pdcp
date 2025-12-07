# pdsh/pdcp
## Ghid de configurare
Pentru a testa/folosi aceste script-uri, trebuie să aveți Docker instalat si configurat pe sistemul vostru.

Clonați local acest repository și urmăriți următorii pași pentru a configura rețeaua de containere necesară testării comenzilor.<br>
`git clone git@github.com:fanceapa1/pdsh-pdcp.git`

Navigați în cadrul folder-ului `config` și creați un nou folder `keys`, în care veți genera o cheie ssh, pe care o vom folosi ca instanțele de virtualizare să poată interacționa între ele:<br>
`mkdir keys`<br>
`cd keys`<br>
`ssh-keygen -t rsa -b 4096 -f ./keys/id_rsa -N ""`
<br><br>

Navigați înapoi în folderul `config` și activați containerele:<br>
`cd ..`<br>
`docker compose up -d --build`

Rulați următoarea comandă pentru a verifica dacă inițializarea a avut succes:<br>
`docker ps`<br>

Ar trebui să vedeți cele 3 containere: `foo1, foo2, foo3` active.<br><br>

O comandă de testare:<br>
`docker exec foo1 pdsh -w foo[1-3] hostname`<br><br>
Ar trebui să returneze un output de tipul:<br>
`"foo3: foo3
foo2: foo2
foo1: foo1"`<br><br>

Pentru a accesa terminalul uneia dintre virtualizări, folosiți:<br>
`docker exec -it foo1 bash`<br>

Reveniți la propriul sistem cu comanda `exit`<br><br>

Opriți funcționarea containerelor prin comanda:<br>
`docker compose down`
