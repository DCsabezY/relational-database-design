# Relációs adatbázis tervezés — Mezőgazdasági terményker eskedő rendszer

Egyetemi adatbázis-tervezési projekt: egy mezőgazdasági terménykereskedő cég
működésének modellezése relációs adatbázisként, ER-modell tervezéssel és
normalizálással (3NF-ig), SQLite implementációval.

## A modellezett rendszer

A cég gazdáktól vásárol fel terményeket, amiket raktároz, minőségvizsgálatnak
vet alá, majd vevőknek értékesít. Minden be- és kiszállítást egy mérlegjegy
rögzít (gazda vagy vevő, raktár, dátum, bruttó/nettó tömeg), a raktárak
közötti és raktáron belüli mozgásokat pedig külön készletmozgás-nyilvántartás
követi.

**Fő szereplők és táblák:**
- `Gazda`, `Vevo` — a beszállítók és a vásárlók
- `Merlegjegy` — minden be-/kiszállítás rögzítése
- `Raktar` — tárolóhelyek
- `Termeny` — a kereskedett terményfajták
- `MinosegVizsgalat` — a beérkező terményeken végzett vizsgálatok
- `KeszletMozgas` — raktári mozgások nyilvántartása

## ER-modell

![ER-modell](ER_modell.png)

## Relációs-modell

![Relation_modell](Relation_modell.png)

## Normalizálási döntések

**1NF** — A többértékű attribútumok (gazdák email-címei, vevők
telefonszámai) külön táblába kerültek (`Gazda_EmailCim`, `Vevo_TelefonSzam`,
`Vevo_EmailCim`), hogy egy gazdának vagy vevőnek több kapcsolati adata is
lehessen anélkül, hogy egy mezőben több érték keveredne.

**2NF** — A `Tartalmaz` és a `Termeny_mozgas` kapcsolótáblák összetett
primary key-t használnak (`Merlegjegy_ID` + `Termeny_ID`, illetve
`Mozgas_ID` + `Termeny_ID`), mert egy mérlegjegyhez/készletmozgáshoz több
termény is tartozhat, és egy termény is megjelenhet több mérlegjegyben vagy készletmozgásban
így ezek több-több kapcsolatok.

**3NF** — A raktár neve nincs duplikálva a `Merlegjegy` táblában; a
`Raktar_ID` idegen kulcson keresztül, JOIN-nal érjük el a `Raktar` táblából.
Így elkerüljük a tranzitív függést és azt, hogy egy raktár névváltozása
esetén több sort is módosítani kelljen.

## Fájlok

| Fájl | Tartalom |
|---|---|
| `schema.sql` | A táblák létrehozása (`CREATE TABLE`) |
| `data.sql` | Minta adatok feltöltése (`INSERT`) |
| `queries.sql` | Tábla-módosítások és lekérdezések (~25 db) |
| `ER_modell.png` | Az ER-diagram |
| `Relation_modell.png` | A Relációs-diagram |

## Használat

```bash
sqlite3 adatbazis.db
sqlite> .read schema.sql
sqlite> .read data.sql
sqlite> .read queries.sql
```

## Technológia

SQLite