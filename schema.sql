-- Külső kulcsok ellenőrzésének bekapcsolása
PRAGMA FOREIGN_KEYS = ON;

-- Gazda tábla létrehozása
CREATE TABLE Gazda (
    G_id INTEGER PRIMARY KEY,
    Nev TEXT NOT NULL,
    Lakcim TEXT,
    adoszam TEXT UNIQUE,
    TelefonSzam TEXT,
    FaxSzam TEXT
);

-- Gazda email címek táblája
CREATE TABLE Gazda_EmailCim (
    EmailCim TEXT NOT NULL,
    G_id INTEGER,
    FOREIGN KEY (G_id) REFERENCES Gazda(G_id)
);

-- Vevo tábla létrehozása
CREATE TABLE Vevo (
    Vevo_id INTEGER PRIMARY KEY,
    Nev TEXT NOT NULL,
    SzallitasiCim TEXT
);

-- Vevo telefon számok táblája
CREATE TABLE Vevo_TelefonSzam (
    Telefonszam TEXT NOT NULL,
    Vevo_id INTEGER,
    FOREIGN KEY (Vevo_id) REFERENCES Vevo(Vevo_id)
);

-- Vevo email címek táblája
CREATE TABLE Vevo_EmailCim (
    EmailCim TEXT NOT NULL,
    Vevo_id INTEGER,
    FOREIGN KEY (Vevo_id) REFERENCES Vevo(Vevo_id)
);

-- Raktar tábla létrehozása
CREATE TABLE Raktar (
    Raktar_ID INTEGER PRIMARY KEY,
    Nev TEXT NOT NULL,
    Cim TEXT,
    Kapacitas_tonna INTEGER NOT NULL
);

-- Termény tábla létrehozása
CREATE TABLE Termeny (
    Termeny_ID INTEGER PRIMARY KEY,
    Nev TEXT NOT NULL,
    Fajta TEXT,
    Mennyiseg REAL,
    Minoseg_osztaly TEXT
);

-- Merlegjegy tábla létrehozása
CREATE TABLE Merlegjegy (
    Merlegjegy_ID INTEGER PRIMARY KEY,
    datum TEXT NOT NULL,
    J_rendszam TEXT,
    Brutto_kg INTEGER,
    Ures_kg INTEGER,
    Netto_kg AS (Brutto_kg - Ures_kg),
    irany TEXT CHECK (irany IN ('be','ki')),
    G_id INTEGER,
    Vevo_id INTEGER,
    Raktar_ID INTEGER,
    FOREIGN KEY (G_id) REFERENCES Gazda(G_id),
    FOREIGN KEY (Vevo_id) REFERENCES Vevo(Vevo_id),
    FOREIGN KEY (Raktar_ID) REFERENCES Raktar(Raktar_ID)
);

-- MinosegVizsgalat tábla létrehozása
CREATE TABLE MinosegVizsgalat (
    Vizsgalat_ID INTEGER PRIMARY KEY,
    Nedvesseg REAL NOT NULL,
    idegen_anyag REAL,
    Datum TEXT DEFAULT (DATE('now')),
    Laborans_neve TEXT,
    Merlegjegy_ID INTEGER,
    FOREIGN KEY (Merlegjegy_ID) REFERENCES Merlegjegy(Merlegjegy_ID)
);

-- Tartalmaz tábla létrehozása
CREATE TABLE Tartalmaz (
    Merlegjegy_ID INTEGER,
    Termeny_ID INTEGER,
    PRIMARY KEY (Merlegjegy_ID, Termeny_ID),
    FOREIGN KEY (Merlegjegy_ID) REFERENCES Merlegjegy(Merlegjegy_ID),
    FOREIGN KEY (Termeny_ID) REFERENCES Termeny(Termeny_ID)
);

-- KeszletMozgas tábla létrehozása
CREATE TABLE KeszletMozgas (
    Mozgas_ID INTEGER PRIMARY KEY,
    Datum TEXT NOT NULL,
    Irany TEXT,
    Mennyiseg REAL NOT NULL,
    Raktar_ID INTEGER,
    Merlegjegy_ID INTEGER,
    FOREIGN KEY (Raktar_ID) REFERENCES Raktar(Raktar_ID),
    FOREIGN KEY (Merlegjegy_ID) REFERENCES Merlegjegy(Merlegjegy_ID)
);

-- Termeny_mozgas tábla létrehozása
CREATE TABLE Termeny_mozgas (
    Mozgas_ID INTEGER,
    Termeny_ID INTEGER,
    PRIMARY KEY (Mozgas_ID, Termeny_ID),
    FOREIGN KEY (Mozgas_ID) REFERENCES KeszletMozgas(Mozgas_ID),
    FOREIGN KEY (Termeny_ID) REFERENCES Termeny(Termeny_ID)
);