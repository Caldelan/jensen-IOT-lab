Milstolpe 1 SQL-frågor:
frågorna finns i [Frågor](docs/sql-fragor.sql)


resultat från frågorna:
antal mätningar: <br>
<img width="348" height="78" alt="image" src="https://github.com/user-attachments/assets/4d939174-4428-4058-b000-f73e19ec31d8" />

Medeltemperatur: <br>
<img width="401" height="89" alt="image" src="https://github.com/user-attachments/assets/953e4028-7ba3-45bb-900a-d5046ba1c258" />

mätningar inom en viss tidsram: <br>
<img width="623" height="731" alt="image" src="https://github.com/user-attachments/assets/bd78a8e5-9a98-4b06-9fc5-33a06fd33600" />



Milstolpe 2 reflektion:

Historiken sparas i postgreSQL då databasen passar bra för att spara löpande mätningar och senare kunna söka igenom och använda datan till olika beräkningar (frågorna i milstople 1).

Den senaste mätningen kan passa till redis om den hämtas ofta och om vi bara behöver det senaste värdet, Redis lagras i minnet och går snabbare att hämta då den inte behöver gå igenom alla lagrade värden.

Skulle redis försvinna finns fortfarande alla sensorvärden kvar i postgreSQL databasen och skulle senaste mätningen efterfrågas sparas värdet ner från databasen till redis efter anropet.

Om PostgreSQL går ner kan API inte längre hämta datan, även om det senaste värdet finns sparat i redis kan resten inte återskapas.


Milstople 3, reflektion:

När en pod raderades såg kubernetes att antalet pods var lägre än vad configurationen i deployment.yaml filen angav och skapade då en ny pod. Kubernetes self healing.

Flera replicas gör att ett API inte är beroende av en enda pod. Om en slutar fungera kan andra replicas ta över medans kubernetes skapar en ny.

Kubernetes kan öka antalet replicas vid behov och minska om belastningen gör det. Men verkar vara mycket svårare att hantera än t.ex. docker om det bara handlar om ett litet projekt med låg trafik.