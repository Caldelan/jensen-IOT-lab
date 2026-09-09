Totala antal mätningar:
SELECT COUNT(*)
FROM measurements;

Medeltemperatur:
SELECT AVG(temperature)
FROM measurements;

Alla mätningar från de senaste 34 timmarna:
SELECT * 
FROM temperature
WHERE tidskolumn >= NOW() - INTERVAL '24 hours';