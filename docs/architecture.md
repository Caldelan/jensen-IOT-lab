[Diagram](Diagram.png)

Diagrammen visar systemets arkitektur, sensorer skickar data via HTTP till API som använder postgreSQL för permanent lagring och Redis som cache för den senaste mätningen. Github actions kan användas för att automatisera tester och docker vid push/pull requests.

Kubernetes kör API bakom en service med por replicas

viktigt:

PostgreSQL databasen lagrar permanent så att all data/historik finns kvar

Redis som en cache för att ge en snabb årkomst av senaste datan, kan återskapas från PostgreSQL vid behov'

Kubernetes för att skala API och skydda med self-healing

Github Actions för CI så att tester och docker-build automatiskt kontrolleras vid ändringar

Flask-API används som ett mellanlager mellan mätvärden och datalagret och ansvarar för validering och HTTP-statuskoder