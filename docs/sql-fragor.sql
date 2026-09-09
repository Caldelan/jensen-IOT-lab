Totala antal mätningar:
SELECT COUNT(*)
FROM measurements;

Medeltemperatur:
SELECT AVG(temperature)
FROM measurements;

Alla mätningar från de senaste 24 timmarna:
SELECT * 
FROM temperature
WHERE created_at >= NOW() - INTERVAL '24 hours';