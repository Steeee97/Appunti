# ChessBook ![Version](https://img.shields.io/badge/Version-v2.0.0-green)

- Stefano Pievaioli 816592
- Federico Davide Presot 817290
- Alessandro Il Grande 054883
- Bryan Ivan Zighui Guerrero 816335

## Link Repo

https://gitlab.com/Steeee97/chessbook

## Architettura del progetto

L'architettura della nostra applicazione segue i principi dei microservizi. Abbiamo deciso di realizzare il backend tramite dei microservizi in python i quali, secondo uno dei pattern archittetturali dei microservizi, hanno ognuno un database dedicato. Tutti microservizi utilizzano delle REST API per la comunicazione con la webapp in Angular che farà da Frontend. Abbiamo deciso di utilizzare dei container Docker per i vari microservizi e webapp in modo da avere un deploy più semplice e flessibile.

## Installazione

1. Verificare come prima operazione che Docker sia avviato sul proprio dispositivo. (Scaricare gratuitamente da https://www.docker.com/products/docker-desktop/)
2. Scaricare nella propria cartella il contenuto della repository o utilizzare il comando:
   ```
   https://gitlab.com/Steeee97/chessbook.git
   ```
3. Avviare il progetto con il usando il comando `docker-compose up`
4. Una volta avviato, <a href="http://localhost:4200" target="_blank">cliccare qui</a> oppure digitare sul proprio browser:
   ```
   http://localhost:4200
   ```

## Documentazione

- [Login](./_docs/login.md)
- [Import board](./\_docs/import board.md)
- [Personalizza la scacchiera](./_docs/customBoard.md)
- [Chessboard service](./_docs/chessboardservice.md)
- [Tutor service](./_docs/tutorservice.md)
