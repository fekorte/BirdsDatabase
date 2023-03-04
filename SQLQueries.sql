-- einfache Query-Anfragen zum Anzeigen ausgewählter Daten 

select jahr,vögelinsg, durchschnittvögelbeob from jahresergebnis;

select * from beobachtung where vogelfütterung = 'f';

select avg(vögelgesamt) from beobachtung;

select count(*) from teilnehmer;

-- Aggregat und Group-by-Klausel
select imJahr, SUM(vögelGesamt)
from beobachtung
GROUP BY imJahr;

-- geschachteltes Select-Statement
select * from vogelart where vogelartID in (select gesichteteVogelart from einzelbeobachtung);


--Erklärung der Trigger Funktionen
-- Update, das zeigt, dass die Trigger Funktion 1 und 2 funktionieren (Tabelle 'jahresergebnis', Attribut 'vögelInsg' und 'durchschnittvögelbeob')
-- zum Anzeigen der Daten vor dem Update
select * from beobachtung;
select jahr, vögelInsg, durchschnittvögelbeob from jahresergebnis;


UPDATE beobachtung SET vögelgesamt = 60 WHERE beobachtungsID = 1;
select * from beobachtung;
select jahr, vögelInsg, durchschnittvögelbeob from jahresergebnis;


--Update der Tabellenbenennung
ALTER TABLE vogelart
RENAME COLUMN vogelart to vogelsorten;
select * from vogelart;



--Trigger Funktion 3, bei insert on einzelergebnis wird vögelGesamt in der Tabelle 'beobachtung' hochgezählt
--vorher:
select * from beobachtung;

--insert in der Tabelle 'einzelergebnis', in der Beobachtung mit der ID 4 werden 10 neue Vögel beobachtet
INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(3,4,10);

select * from einzelbeobachtung;

--nachher: auch in der Tabelle 'beobachtung' wurde die vögelGesamt Zahl um 10 erhöht
select * from beobachtung;



--Trigger Funktion 5 bei einem neuen Eintrag in der Tabelle 'durchgeführtVonAmOrt', verändert 'beobachtungsorteInsg' in 'jahresergebnis'
--ein Teilnehmer beobachtet an einem Ort, an welchem bisher (hier: im Jahr 2021) keine Beobachtung stattgefunden hat
--vorher
select * from jahresergebnis;

--eine neue Beobachtung wird hinzugefügt, die an einem neuen Ort stattfinden soll
INSERT INTO beobachtung(imJahr, uhrzeit, katzensichtungen, vögelGesamt, vogelfütterung)
	VALUES(2021, '16:30','nie', 30, 'f');
select * from beobachtung;

--der Beobachtungsort mit ID 1 kam bisher nicht im Jahr 2021 vor
INSERT INTO durchgeführtVonAmOrt(teilnehmerID, beobachtungsID, beobachtungsortID)
	VALUES(1,6,1);
select * from durchgeführtVonAmOrt;
	
--die Anzahl der Beobachtungsorte im Jahr 2021 hat sich um Eins erhöht 
select * from jahresergebnis;	


--Trigger Funktion 5: wird einer Beobachtung ein Beobachtungsort hinzugefügt, an dem in dem Jahr bereits beobachtet wurde, 
--wird der Wert 'beobachtungsorteInsg' in 'jahresergebnis' nicht erhöht

--vorher
select * from jahresergebnis;

-- im Jahr 2021 wird eine weitere Beobachtung durchgeführt
INSERT INTO beobachtung(imJahr, uhrzeit, katzensichtungen, vögelGesamt, vogelfütterung)
	VALUES(2021, '7:30','nie', 13, 'f');
select * from beobachtung;

--der Beobachtungsort mit ID 1 im Jahr 2021 bereits vor
INSERT INTO durchgeführtVonAmOrt(teilnehmerID, beobachtungsID, beobachtungsortID)
	VALUES(2,7,1);	
select * from durchgeführtVonAmOrt;

--die Anzahl der Beobachtungsorte im Jahr 2021 hat sich nicht erhöht 
select * from jahresergebnis;



-- Trigger Funktion 4 gewährleistet, dass derselbe Ort nicht noch einmal in der 'beobachtungsort' Tabelle eingetragen werden kann und somit einen anderen key besitzt
-- diese Beobachtungsorte sind bereits eingetragen:
select * from beobachtungsort;

-- dieselben Werte wie diejenigen des Ortes mit der beobachtungsortID 3 sollen eingetragen werden, dies schlägt durch den Trigger fehl
INSERT INTO beobachtungsort(charakteristika, adresse, landkreisStadt, bundesland)
	VALUES('Innenstadt', 'Hohe Luft Chausee 145, 35697 Hamburg', 'Hansestadt Hamburg', 'Hamburg');


-- abgebrochene Transaktion, da not-null constraint der Tabelle 'teilnehmer' verletzt wird
BEGIN TRANSACTION;
UPDATE teilnehmer 
SET vorherigeTeilnahme = 'noch nie' 
WHERE teilnehmerID = 3;
UPDATE beobachtungsort 
SET charakteristika = 'Dorf',
    adresse = 'Bebelstraße 3, 24256 Stoltenberg', 
    landkreisStadt = 'Plön',
    bundesland = 'Schleswig-Holstein'
WHERE beobachtungsortID = 3;
INSERT INTO teilnehmer(nachname, vorherigeTeilnahme)
VALUES('Albers', 'noch nie');
COMMIT TRANSACTION;

-- abgebrochene Transaktion 
BEGIN TRANSACTION;
UPDATE teilnehmer
SET vorherigeTeilnahme = 'noch nie' 
WHERE teilnehmerID = 3;
ROLLBACK;
select * from teilnehmer;

select * from beobachtung;

-- erfolgreiche Transaktion
BEGIN TRANSACTION;
UPDATE beobachtung 
SET vogelfütterung = 't'
WHERE beobachtungsID = 5;
INSERT INTO beobachtung(imJahr, uhrzeit, katzensichtungen, vögelGesamt, vogelfütterung)
	VALUES(2022,'17:01','selten', 40, 't');
COMMIT TRANSACTION;
select * from beobachtung;

-- Inner Join
select * from beobachtung 
INNER JOIN durchgeführtVonAmOrt
USING (beobachtungsID);

-- Left Outer Join
select b.imJahr, b.vögelGesamt, b.vogelfütterung, b.beobachtungsID,
dvao.teilnehmerID, t.vorname, t.nachname, t.teilnehmerID
from beobachtung AS b
left outer join (durchgeführtVonAmOrt dvao
				 left outer join teilnehmer t
on dvao.teilnehmerID = t.teilnehmerID)
on b.beobachtungsID = dvao.beobachtungsID;

-- Delete
DELETE FROM beobachtung WHERE beobachtungsID = 1;
select * from beobachtung;
select * from einzelbeobachtung;

DELETE FROM jahresergebnis;
select * from jahresergebnis;
select * from beobachtung;

