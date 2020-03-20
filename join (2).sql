use Agentie;

SELECT C.nume, C.cod_c, C.ocupatie
FROM Client C
WHERE (C.ocupatie='mecanic' OR C.ocupatie='student' ) AND (cod_c<10)
EXCEPT
SELECT C.nume, C.cod_c, C.ocupatie
FROM Client C
INNER JOIN Sejur S
ON C.cod_c=S.cod_c

SELECT D.nume, D.cod_d
FROM Destinatie D
INNER JOIN Sejur
ON D.cod_d=Sejur.cod_d;

SELECT D.nume,C.nume
FROM Client C
INNER JOIN Sejur S
ON C.cod_c=S.cod_c
INNER JOIN Destinatie D
ON S.cod_d=D.cod_d;

SELECT S.cod_d, C.nume
FROM Sejur S
RIGHT JOIN Client C
ON S.cod_c=C.cod_c;

SELECT DISTINCT C.varsta
FROM Client C
LEFT JOIN Sejur S
ON C.cod_c=S.cod_c;

SELECT ocupatie,
COUNT(cod_c) AS nr_angajati
FROM Client 
GROUP BY ocupatie
ORDER BY nr_angajati DESC;

SELECT ocupatie,
COUNT(cod_c) AS nr_angajati
FROM Client 
GROUP BY ocupatie
HAVING COUNT(cod_c)>1 AND COUNT(cod_c)<5;



SELECT MIN(rating) AS rating_minim_destinatie ,cod_d
FROM Sejur
GROUP BY cod_d;

SELECT AVG(varsta) AS media_varstei, ocupatie
FROM Client
GROUP BY ocupatie;

SELECT varsta,nume
FROM Client
WHERE nume IN (SELECT nume
				FROM Client
				WHERE ocupatie='student');

