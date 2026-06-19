--Táblaszerkezet és adatmódosítások
--Új oszlop hozzáadása a Gazda táblához
ALTER TABLE Gazda
ADD COLUMN Aktiv INTEGER DEFAULT 1;

--kijavítja azoknak a mérlegjegyeknek az irányát ALTER TABLE Termeny
UPDATE Merlegjegy
SET irany = 'be'
WHERE Brutto_kg IS NULL 
AND irany = 'ki';


--Adat módosítása – a vevő címének javítása
UPDATE Vevo
SET SzallitasiCim = 'Budapest, Központi Logisztikai Park 12.'
WHERE Vevo_id = 2;

--Adat törlése – töröljük az egyik felesleges telefonszámot
DELETE FROM Vevo_TelefonSzam
WHERE Telefonszam = '06707778888';

--Sql lekérdezések
--Minden „be” irányú mérlegjegy listázása
SELECT * 
FROM Merlegjegy
WHERE irany = 'be';

--Összes gazda, akik rendelkeznek telefonszámmal
SELECT * 
FROM Gazda
WHERE TelefonSzam IS NOT NULL;

--Azok a mérlegjegyek, ahol bruttó súly > 18000 és irány = 'ki'
SELECT *
FROM Merlegjegy
WHERE Brutto_kg >= 18000 AND irany = 'ki';

--Gazdák, akiknek nincs adószámuk ÉS van telefonszámuk
SELECT *
FROM Gazda
WHERE adoszam IS NULL AND TelefonSzam IS NOT NULL;

--Mérlegjegyek dátum szerint csökkenő sorrendben
SELECT *
FROM Merlegjegy
ORDER BY datum DESC;

--Termények minőségi osztály szerint, majd név szerint
SELECT *
FROM Termeny
ORDER BY Minoseg_osztaly ASC, Nev ASC;

--Hány gazda tartozik egyes településekhez
SELECT Lakcim, COUNT(*) AS Gazdak_szama
FROM Gazda
GROUP BY Lakcim;

--Melyik raktárhoz hány mérlegjegy tartozik
SELECT Raktar_ID, COUNT(*) AS Merlegjegyek_szama
FROM Merlegjegy
GROUP BY Raktar_ID;

--A beérkezett bruttó súly összesen
SELECT SUM(Brutto_kg) AS Osszes_brutto
FROM Merlegjegy
WHERE irany = 'be';

--A termények átlagos mennyisége
SELECT AVG(Mennyiseg) AS Atlag_mennyiseg
FROM Termeny;

--Minden mérlegjegy nettó tömege (AS oszlopból)
SELECT Merlegjegy_ID, Brutto_kg, Ures_kg, Netto_kg
FROM Merlegjegy;

--Nettó tömeg alapján növekvő rendezés
SELECT Merlegjegy_ID, Netto_kg
FROM Merlegjegy
ORDER BY Netto_kg ASC;

--Mérlegjegyek gazdákkal összekapcsolva
SELECT M.Merlegjegy_ID, M.datum, G.Nev
FROM Merlegjegy M
INNER JOIN Gazda G ON M.G_id = G.G_id;

--Mérlegjegyek vevővel és raktárral együtt
SELECT M.Merlegjegy_ID, V.Nev AS VevoNev, R.Nev AS RaktarNev
FROM Merlegjegy M
INNER JOIN Vevo V ON M.Vevo_id = V.Vevo_id
INNER JOIN Raktar R ON M.Raktar_ID = R.Raktar_ID;

--Termények, amik szerepelnek mérlegjegyben
SELECT T.Nev, T.Fajta, A.Merlegjegy_ID
FROM Termeny T
INNER JOIN Tartalmaz A ON T.Termeny_ID = A.Termeny_ID;

--Minden gazda email-címei – akkor is, ha nincs email
SELECT G.Nev, E.EmailCim
FROM Gazda G
LEFT JOIN Gazda_EmailCim E ON G.G_id = E.G_id;

--Minden vevő telefonszámmal – akkor is, ha nincs telefonszám
SELECT V.Nev, T.Telefonszam
FROM Vevo V
LEFT JOIN Vevo_TelefonSzam T ON V.Vevo_id = T.Vevo_id;

--Mérlegjegy → Gazda → Vevő → Raktár teljes összekapcsolása
SELECT M.Merlegjegy_ID, G.Nev AS Gazda, V.Nev AS Vevo, R.Nev AS Raktar
FROM Merlegjegy M
INNER JOIN Gazda G ON M.G_id = G.G_id
INNER JOIN Vevo V ON M.Vevo_id = V.Vevo_id
INNER JOIN Raktar R ON M.Raktar_ID = R.Raktar_ID;

--Készletmozgás + Termény + Mérlegjegy + Gazda
SELECT K.Mozgas_ID, T.Nev AS Termeny, G.Nev AS Gazda, K.Mennyiseg
FROM KeszletMozgas K
INNER JOIN Termeny_mozgas TM ON K.Mozgas_ID = TM.Mozgas_ID
INNER JOIN Termeny T ON TM.Termeny_ID = T.Termeny_ID
INNER JOIN Merlegjegy M ON K.Merlegjegy_ID = M.Merlegjegy_ID
INNER JOIN Gazda G ON M.G_id = G.G_id;

--Alselect – azok a gazdák, akik szerepelnek mérlegjegyben
SELECT *
FROM Gazda
WHERE G_id IN (SELECT G_id FROM Merlegjegy);

--NULL érték kezelése – ahol hiányzik a bruttó súly
SELECT Merlegjegy_ID, datum, J_rendszam
FROM Merlegjegy
WHERE Brutto_kg IS NULL;

--HAVING – csak azok a raktárak, ahol 2-nél több mérlegjegy van
SELECT Raktar_ID, COUNT(*)
FROM Merlegjegy
GROUP BY Raktar_ID
HAVING COUNT(*) > 2;

--Függvényhasználat – rendszám kisbetűssé alakítása
SELECT Merlegjegy_ID, LOWER(J_rendszam) AS RendszamKisbetu
FROM Merlegjegy;

-- „NINCS” keresése – Olyan gazdák, akiknek NINCS adószáma
SELECT *
FROM Gazda
WHERE adoszam IS NULL;