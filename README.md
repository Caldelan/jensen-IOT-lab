Milstople 4:

## Om projektet:

Projektet är ett IoT projekt med sensorer som skickar temperatur, luftfuktighet, batterimätningar till ett REST API byggt med FLASK som i sin tur validerar och lagrar mätningsdatan i PostgreSQL och med Redis som en cache för den senaste mätningen.
    Kan även hämta historik av värden för specifika sensorer

PostgreSQL används för permanent lagring av mätningar och
historik. Redis används som cache för den senaste mätningen. Skulle mätningen i cache inte finnas hämtas den från PostgreSQL databasen.

Arkitekturdiagram finns i:
[docs/architecture.md](docs/architecture.md)

för att köra projektet krävs:
- Docker
- Docker compose
- Git

Har även använt:
- Minikube
- kubectl

Projectet startas med:

```bash
docker compose up --build -d
```

Tester körs med:
```bash
docker compose exec api python -m pytest -q
```

CI:
Projectet använder Github Actions för kontinuerlig integration.

vid push / pull requests 
-installeras API dependencies
-körs pytest
-byggs API Docker image

kubernetes:

API:t har även körts i Minikube med en Kubernetes Deployment och Service.

Deploymenten kör API:t med 3 Pod-replicas. 

Self-healing och att byta mellan 3-5 replicas är testat







Milstolpe 1 SQL-frågor:
frågorna finns i [Frågor](docs/sql-fragor.sql)


resultat från frågorna:
antal mätningar: <br>
<img width="348" height="78" alt="image" src="https://github.com/user-attachments/assets/4d939174-4428-4058-b000-f73e19ec31d8" /> <br>

Medeltemperatur: <br>
<img width="401" height="89" alt="image" src="https://github.com/user-attachments/assets/953e4028-7ba3-45bb-900a-d5046ba1c258" /> <br>

mätningar inom en viss tidsram: <br>
<img width="623" height="731" alt="image" src="https://github.com/user-attachments/assets/bd78a8e5-9a98-4b06-9fc5-33a06fd33600" /> <br>



Milstolpe 2 reflektion:

Historiken sparas i postgreSQL då databasen passar bra för att spara löpande mätningar och senare kunna söka igenom och använda datan till olika beräkningar (frågorna i milstople 1).

Den senaste mätningen kan passa till redis om den hämtas ofta och om vi bara behöver det senaste värdet, Redis lagras i minnet och går snabbare att hämta då den inte behöver gå igenom alla lagrade värden.

Skulle redis försvinna finns fortfarande alla sensorvärden kvar i postgreSQL databasen och skulle senaste mätningen efterfrågas sparas värdet ner från databasen till redis efter anropet.

Om PostgreSQL går ner kan API inte längre hämta datan, även om det senaste värdet finns sparat i redis kan resten inte återskapas.


Milstople 3, reflektion:

När en pod raderades såg kubernetes att antalet pods var lägre än vad configurationen i deployment.yaml filen angav och skapade då en ny pod. Kubernetes self healing.

Flera replicas gör att ett API inte är beroende av en enda pod. Om en slutar fungera kan andra replicas ta över medans kubernetes skapar en ny.

Kubernetes kan öka antalet replicas vid behov och minska om belastningen gör det. Men verkar vara mycket svårare att hantera än t.ex. docker om det bara handlar om ett litet projekt med låg trafik.

Scaling: <br>
<img width="753" height="137" alt="kubectl_scaling" src="https://github.com/user-attachments/assets/ea0a325b-2474-4da7-b5b7-7b04e5eaa622" /> <br>




