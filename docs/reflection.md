# Reflektionsdokument – obligatorisk leverabel


1. API:t fungerar som ett mellanlager mellan sensorerna och databasen. I lösningen ansvarar API för validering av sensordata och för att kontrollera att sensorn finns innan data sparas.

2. Felaktig data gör historiken opålitlig och leder till fel resultat om man skulle använda värdena. I projectet valideras mätningen innan den sparas och API:t returnerar '400 Bad Request' om datan inte är giltig.

3. passar bra då mätvärden behöver lagras permanent och kunna hämtas som historik. 

4. Skulle Redis försvinna finns all data ändå kvar i PostgreSQL och därifrån sparas till cache igen

5. Om PostgreSQL försvinner förloras all historik, Redis kan inte användas som backup då den enbart inehåller den senaste mätningen

6. Docker Compose gör det enkelt att starta projektets olika tjänster tillsammans.

7. CI-pipeline körs via push / pull requests, ceckar ut koden, installerar API dependencies, kör tester i pytest och bygger docker image. Den kontrollerar automatiskt ändringar.

8. När en pod raderades såg kubernetes att antaled som fanns kvar va mindre än vad configurationen sa och skapade därefter en ny Pod 

9. Flera replicas gör att detta API fortsätter att fungera om en Pod går ner, trafiken kan då tas över av andra Pods medans kubernetes återskapar den som gick ner. Fler replicas minskar risken att ett fel gör API otillgängligt

10. Kubernetes hade varit overkill för ett litet projekt med låg trafik och få tjänster. I ett litet project kan Docker Compose vara lättare att använda, configurera och underhålla
