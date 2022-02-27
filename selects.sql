SELECT DISTINCT WYKONAWCA 
FROM OBSERWACJE 
WHERE TELESKOP = 'Teleskop nr2';

SELECT TOP 10 PLANETY.NAZWA, OKRES_ORBITALNY 
FROM PLANETY INNER JOIN GWIAZDY ON PLANETY.GWIAZDA = GWIAZDY.NAZWA 
WHERE GWIAZDY.TYP = '��ty karze�' 
ORDER BY OKRES_ORBITALNY;

SELECT CIALO_NIEBIESKIE, DATA_ODKRYCIA, OKRES_OBROTU FROM ODKRYCIA 
INNER JOIN PLANETY ON PLANETY.NAZWA = ODKRYCIA.CIALO_NIEBIESKIE 
WHERE DATA_ODKRYCIA >= '2000-01-01' 
ORDER BY PLANETY.OKRES_OBROTU DESC;

SELECT KSIEZYCE.NAZWA, CIALA_NIEBIESKIE.PROMIEN, KSIEZYCE.OKRES_OBROTU, KSIEZYCE.NACHYLENIE_OSI, PLANETA
FROM KSIEZYCE 
INNER JOIN CIALA_NIEBIESKIE ON CIALA_NIEBIESKIE.NAZWA = KSIEZYCE.NAZWA 
WHERE OKRES_OBROTU > 2 AND NACHYLENIE_OSI < 80 AND (PLANETA = 'Saturn' OR PLANETA = 'Mars')
ORDER BY CIALA_NIEBIESKIE.PROMIEN DESC;

SELECT TOP 5 ODKRYCIA.CIALO_NIEBIESKIE, DATA_ODKRYCIA, TELESKOP
FROM ODKRYCIA
WHERE (TELESKOP = 'Teleskop nr3' OR TELESKOP = 'Teleskop nr2') AND DATA_ODKRYCIA >= '2020-02-02' ORDER BY DATA_ODKRYCIA DESC;

SELECT GWIAZDY.NAZWA, CIALA_NIEBIESKIE.PROMIEN, GWIAZDY.JASNOSC, GWIAZDY.KONSTELACJA, OBSERWACJE.WYKONAWCA
FROM GWIAZDY
INNER JOIN OBSERWACJE ON OBSERWACJE.CIALO_NIEBIESKIE = GWIAZDY.NAZWA
INNER JOIN CIALA_NIEBIESKIE ON CIALA_NIEBIESKIE.NAZWA = GWIAZDY.NAZWA
WHERE KONSTELACJA = 'Wodnik' AND JASNOSC > 0.00071 AND OBSERWACJE.WYKONAWCA = 'Isaac Newton'
ORDER BY CIALA_NIEBIESKIE.PROMIEN;


/*Utworzenie widoku do zapytania o 15 najciezszych cial niebieskich*/
GO
CREATE VIEW MASY_CIAL_NIEBIESKICH AS
SELECT CIALA_NIEBIESKIE.NAZWA, CIALA_NIEBIESKIE.MASA
FROM CIALA_NIEBIESKIE;
GO

SELECT TOP 15 NAZWA, MASA
FROM MASY_CIAL_NIEBIESKICH
ORDER BY MASA DESC

/*�redni rozmiar planet typu skalistego w uk�adzie s�onecznym*/
SELECT AVG(CIALA_NIEBIESKIE.PROMIEN) AS SREDNI_PROMIEN
FROM PLANETY
INNER JOIN CIALA_NIEBIESKIE ON CIALA_NIEBIESKIE.NAZWA = PLANETY.NAZWA
WHERE PLANETY.GWIAZDA = 'S�o�ce' AND TYP = 'Skalista';

/*Suma mas czarnych dziur w r�nych galaktykach*/
SELECT SUM(CIALA_NIEBIESKIE.MASA) AS SUMA_MAS, GALAKTYKA
FROM CZARNE_DZIURY
INNER JOIN CIALA_NIEBIESKIE ON CIALA_NIEBIESKIE.NAZWA = CZARNE_DZIURY.NAZWA
INNER JOIN GALAKTYKI ON GALAKTYKI.NAZWA = CZARNE_DZIURY.GALAKTYKA
GROUP BY GALAKTYKA
ORDER BY SUM(CIALA_NIEBIESKIE.MASA) DESC;

/*Ile ksiezycy maja planety w ukladzie slonecznym*/
SELECT COUNT(*) AS LICZBA_KSIEZYCY, PLANETA
FROM KSIEZYCE
INNER JOIN PLANETY ON PLANETY.NAZWA = PLANETA
WHERE PLANETY.GWIAZDA = 'S�o�ce'
GROUP BY PLANETA;