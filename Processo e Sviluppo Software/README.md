# Assignment 1 - Implementazione di una pipeline

prodotto da:

- Pievaioli Stefano, matricola 816592
- Presot Federico Davide, matricola 817290
- Bryan Ivan Zighui Guerrero, matricola 816335

# Repository

https://gitlab.com/IvanGuerrero/2020_assignment1_userregistration

# Stato attuale del progetto

La nostra applicazione in Angular è divisa in due parti: in una di esse, è possibile utilizzare un piccolo tool per generare un indirizzo mail; nella seconda è possibile caricare nome, cognome, e info aggiuntive su di una persona. Per questa applicazione sono stati implementati i seguenti passaggi della pipeline:

- Build: Durante la fase di build, vengono installati tutti i pacchetti all'interno della cache nel path angular10/node_modules/; Successivamente viene compilata l'app tramite ng build e i file generati vengono salvati in cache nel path angular10/dist/.
- Verify: Durante la fase di verify, viene controllata la qualità del progetto Angular tramite le funzionalità di lint già presenti nella CLI di angular
- Unit-test: Durante la fase relativa agli unit test, vengono effettuati dei test utilizzando Karma-Jasmine tramite browser ChromeHeadless
- Integration-test: Durante la fase di integration test, viene effettuato un test di integrazione per verificare il corretto funzionamento della nostra applicazione; viene di conseguenza effettuata una GET per verificare la corretta implementazione del nostro database
- Package: durante la fase di package, viene utilizzato Docker per generare un container nel quale è presente il nostro progetto; questa immagine viene poi salvata e taggata con il proprio valore in codifica SHA
- Release: Durante la fase di Release, inizialmente viene effettuato il login sulla piattaforma Docker; successivamente, il pachetto generato durante la fase di package viene taggata come latest release, e viene pushata nel docker container registry; infine, la stessa immagine viene pushata nel container registry di Heroku
- Deploy: Durante la fase di deploy, viene effettuato il deploy dell'immagine pushata nella fase di release. Il deploy viene effettuato sulla piattaforma Heroku utilizzando la sua API

l'applicazione è disponibile sul sito: https://prova-dot-net.herokuapp.com
(Essendo hostata su Heroku tramite un account gratuito, l'applicazione impiega 15 secondi per partire nel caso non sia stata effettuata una richiesta nell'ultima mezz'ora)

# Assignment 2 - Elicitation Strategy

prodotto da:

- Pievaioli Stefano, matricola 816592
- Presot Federico Davide, matricola 817290
- Zhigui Guerrero Bryan Ivan, matricola 816335

# Repository

https://gitlab.com/FPresot/2020_assignment2_gymapp

# Assignment 3 - Implementazione di una WebApp per la Palestra

prodotto da:

- Pievaioli Stefano, matricola 816592
- Presot Federico Davide, matricola 817290
- Bryan Ivan Zighui Guerrero, matricola 816335

# Repository

https://gitlab.com/Steeee97/2020_assignment3_loginapp

## Descrizione dell'applicazione

Per il terzo progetto abbiamo deciso di creare una applicazione da utilizzare per la palestra; Questa applicazione è stata da noi pensata come supporto elettronico nella gestione degli allenamenti dei clienti iscritti alla palestra stessa, e di conseguenza è stata data una maggiore priorità alla gestione dell’allenamento stesso. L’applicazione presenta diversi tipi di utenti (receptionist, personal trainer e clienti) e a ciascuno di essi vengono fornite diverse funzionalità dell’applicazione stessa. Il riconoscimento del ruolo di ciascun utente viene effettuato tramite una funzione di login, che permette a ciascun utente di avere a disposizione solo i propri dati.

Per quanto riguarda la parte di front-end, abbiamo considerato l'utilizzo di Thymeleaf, mentre abbiamo considerato per la parte di back-end l'utilizzo di Hibernate e di Spring JPA per la generazione del database e per implementare la permanenza dei dati; inoltre, essi saranno estremamente utili per l'implementazione delle funzionalità CRUD nella nostra applicazione.

Per quanto riguarda lo schema della nostra applicazione, abbiamo già generato un possibile schema ER, in modo da avere già una possibile idea su come possa essere implementata la nostra applicazione; questa verrà poi modificata nel momento in cui l'Applicazione sarà effettivamente completata.

Maggiori informazioni sono disponibili all'interno della nostra relazione.

## Credenziali per l'accesso

Poiché abbiamo inserito una parte iniziale di login all'interno della nostra applicazione, si è resa necessaria la generazione di account iniziali disponibili popolando subito il database, in modo non solo da poter accedere all'applicazione stessa, ma anche per raggiungere più velocemente le funzionalità disponibili per ogni account. Per questo motivo, all'inizio dell'esecuzione dell'applicazione verrà popolato il database con tre account differenti, ciascuno con un ruolo diverso (da Customer, da Receptionist o da Personal Trainer). Per poter accedere, sono presenti le seguenti credeniali:

- Customer

```bash
Username: userCliente
Password: passCliente
```

- Receptionist

```bash
Username: userReceptionist
Password: passReceptionist
```

- Personal Trainer

```bash
Username: userPersonal
Password: passPersonal
```

## Installazione

Per fare partire l'applicazione, abbiamo pensato all'utilizzo di Docker; ciò è stato pensato per gestire con facilità il deploy della applicazione. Di conseguenza, è necessario che l'utente abbia Docker Compose installato sul proprio computer. Per far partire l'applicazione, sarebbe necessario di conseguenza effettuare il processo di build

```bash
docker-compose build
```

Per fare poi partire l'applicazione, basterà digitare

```bash
docker-compose up
```

Una volta fatta partire l'applicazione, essa sarà disponibile a http://localhost:8080
Durante la prima esecuzione delle fasi di build e di up l'applicazione potrebbe richiedere un po di tempo; ciò è da considerarsi normale. In particolar modo, la prima esecuzione della applicazione potrebbe richiedere una quantità maggiore di tempo, in quanto non solo deve essere generato il database, ma esso deve essere anche popolato.
