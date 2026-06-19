--Adatok feltöltése a táblákba
--Gazda tábla feltöltése
INSERT INTO Gazda VALUES
(1,'Kiss Ferenc','Mezőcsát, Fő út 12','12345678-1-12','06701234567',NULL),
(2,'Nagy József','Mezőkövesd, Zrínyi u. 4','22345678-2-22','06705554444','0648111222'),
(3,'Szabó László','Tiszapalkonya',NULL,'06707778888',NULL),
(4,'Tóth Gábor','Miskolc',NULL,NULL,NULL),
(5,'Bíró Lilla','Mezőcsát','33445566-1-33','06701239876',NULL),
(6,'Horváth Csaba','Miskolc',NULL,'06704321234','06704329987'),
(7,'Varga Luca','Eger','55446677-1-55',NULL,NULL),
(8,'Kovács Péter','Tiszaújváros',NULL,'06701119999',NULL);

--Gazda email címek feltöltése
INSERT INTO Gazda_EmailCim VALUES
('gazda1@gmail.com',1),
('ferenc.kiss@t-mail.hu',1),
('nagy.j@freemail.hu',2),
('szabo.laszlo@gmail.com',3),
('lilla.biro@yahoo.com',5);

--Vevő tábla feltöltése
INSERT INTO Vevo VALUES
(1,'AgroFeed Kft','Debrecen, Ipari park'),
(2,'Terményker Zrt','Budapest, Logisztikai központ'),
(3,'Gabonatrade Bt','Miskolc'),
(4,'Hungrain Kft','Eger'),
(5,'GabonaMix Kft','Tiszaújváros'),
(6,'TakarmányPlusz Kft',NULL),
(7,'Feedyard Zrt','Nyíregyháza'),
(8,'FarmerMarket Kft','Kazincbarcika');

--Vevő telefonszámok feltöltése
INSERT INTO Vevo_TelefonSzam VALUES
('0612345678',1),
('06702223333',2),
('06704445555',3),
('06707778888',4),
('06701234000',5);

--Vevő email címek feltöltése
INSERT INTO Vevo_EmailCim VALUES
('info@agrofeed.hu',1),
('rendeles@terményker.hu',2),
('contact@gabonatrade.hu',3),
('office@hunggrain.hu',4);

--Raktár tábla feltöltése
INSERT INTO Raktar VALUES
(1,'Fő raktár','Mezőcsát, Raktár utca 1',500),
(2,'Hátsó raktár','Mezőcsát, Tanya út 8',300),
(3,'Siló #1','Mezőcsát',800),
(4,'Siló #2','Mezőkövesd',1000),
(5,'Export raktár','Tiszaújváros',600);

--Termény tábla feltöltése
INSERT INTO Termeny VALUES
(1,'Búza','Őszi',NULL,'A'),
(2,'Kukorica','Takarmány',100,'B'),
(3,'Árpa','Sörárpa',50,'A'),
(4,'Napraforgó','Olaj',NULL,'B'),
(5,'Repce','Hibrid',80,'A'),
(6,'Szója','GMO-mentes',40,'A'),
(7,'Rozs','Vetőmag',NULL,'C'),
(8,'Tritikálé','Takarmány',120,'B');

--Mérlegjegy tábla feltöltése
INSERT INTO Merlegjegy (Merlegjegy_ID,datum,J_rendszam,Brutto_kg,Ures_kg,irany,G_id,Vevo_id,Raktar_ID) VALUES
(1,'2024-01-05','ABC-123',15000,5000,'be',1,1,1),
(2,'2024-01-06','XYZ-777',18000,6000,'ki',2,2,2),
(3,'2024-01-06','KLM-999',20000,7000,'be',3,3,1),
(4,'2024-01-08','WWW-555',NULL,4000,'be',4,NULL,3),
(5,'2024-01-10','AAA-111',16000,NULL,'ki',1,4,1),
(6,'2024-01-11','BBB-222',17000,6000,'be',5,5,2),
(7,'2024-01-12','CCC-333',NULL,NULL,'ki',6,6,3),
(8,'2024-01-13','DDD-444',22000,8000,'be',7,7,4);

--Tartalmaz tábla feltöltése
INSERT INTO Tartalmaz VALUES
(1,1),(1,2),
(2,2),
(3,3),(3,4),
(4,1),
(5,5),
(6,6),
(7,7),
(8,8);

--Készletmozgás tábla feltöltése
INSERT INTO KeszletMozgas VALUES
(1,'2024-01-05','be',5000,1,1),
(2,'2024-01-06','ki',2000,2,2),
(3,'2024-01-06','be',6000,1,3),
(4,'2024-01-08','be',3000,3,4),
(5,'2024-01-10','ki',4000,1,5),
(6,'2024-01-11','be',7000,2,6),
(7,'2024-01-12','ki',2000,3,7),
(8,'2024-01-13','be',9000,4,8);

--Termény_mozgas tábla feltöltése
INSERT INTO Termeny_mozgas VALUES
(1,1),
(1,2),
(2,2),
(3,3),
(3,4),
(4,1),
(5,5),
(6,6),
(7,7),
(8,8);