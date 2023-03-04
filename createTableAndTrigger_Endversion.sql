CREATE TABLE IF NOT EXISTS teilnehmer
(
	teilnehmerID 		serial PRIMARY KEY,
	vorname 			VARCHAR (30) NOT NULL,
	nachname 			VARCHAR (30) NOT NULL,
	vorherigeTeilnahme 	VARCHAR (10) CHECK (vorherigeTeilnahme IN ('noch nie', 'einmal', 'mehrfach'))
);

CREATE TABLE IF NOT EXISTS beobachtungsort
(
	beobachtungsortID 	serial PRIMARY KEY,
	charakteristika 		VARCHAR (45) CHECK (charakteristika IN ('Innenstadt', 'Vorstadt', 'Dorf', 'Einzelhaus abseits geschlossener Bebauung')),
	adresse 			VARCHAR NOT NULL,
	landkreisStadt 		VARCHAR NOT NULL,
	bundesland			VARCHAR (50) CHECK (bundesland IN ('Baden-Württemberg', 'Bayern', 'Berlin', 'Brandenburg', 'Bremen', 'Hamburg', 'Hessen', 'Mecklenburg-Vorpommern', 'Niedersachsen', 'Nordrhein-Westfalen', 'Rheinland-Pfalz', 'Saarland', 'Sachsen-Anhalt', 'Sachsen', 'Schleswig-Holstein', 'Thüringen'))
);

CREATE TABLE IF NOT EXISTS vogelart
(
	vogelartID			serial PRIMARY KEY,
	vogelart			VARCHAR(30) CHECK(vogelart IN ('Amsel', 'Blaumeise', 'Buchfink', 'Elster', 'Feldsperling', 'Grünfink', 'Haussperling', 'Kohlmeise', 'Mauersegler', 'Mehlschwalbe', 'Rotkehlchen', 'Star'))

);

CREATE TABLE IF NOT EXISTS jahresergebnis
(
	jahr				INTEGER PRIMARY KEY,
	vögelInsg			INTEGER,
	durchschnittVögelBeob	INTEGER,
	beobachtungsorteInsg	INTEGER

);

CREATE TABLE IF NOT EXISTS beobachtung
(
	beobachtungsID 		serial PRIMARY KEY,
	imJahr			INT REFERENCES jahresergebnis ON UPDATE CASCADE ON DELETE SET NULL,
	uhrzeit 			TIME,
	katzensichtungen 		VARCHAR (10) CHECK (katzensichtungen IN ('nie', 'selten', 'oft', 'täglich')),
	vögelGesamt 		INTEGER,
	vogelfütterung 		BOOLEAN
);

CREATE TABLE IF NOT EXISTS einzelbeobachtung
(
	einzelbeobachtungsID	serial PRIMARY KEY,
	gesichteteVogelart	INTEGER REFERENCES vogelart ON UPDATE CASCADE ON DELETE CASCADE,
	ergibtBeob			INTEGER REFERENCES beobachtung ON UPDATE CASCADE ON DELETE CASCADE,
	höchsteAnzahl		INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS durchgeführtVonAmOrt
(
	teilnehmerID		INTEGER REFERENCES teilnehmer ON UPDATE CASCADE ON DELETE CASCADE,
	beobachtungsID		INTEGER REFERENCES beobachtung ON UPDATE CASCADE ON DELETE CASCADE,
	beobachtungsortID	INTEGER REFERENCES beobachtungsort ON UPDATE CASCADE ON DELETE CASCADE
);

-- Trigger Funktionen


--Trigger 1 für das Attribut durchschnittVögelBeob von 'jahresergebnis'
CREATE FUNCTION updateJahresergebnisDurchschnittVogelBeob() RETURNS TRIGGER AS 
$updateJahresergebnisDurchschnittVogelBeob$
DECLARE 
    avgVogelBeobachtung INTEGER;
BEGIN
    SELECT AVG(vögelGesamt) INTO avgVogelBeobachtung FROM beobachtung WHERE imJahr = NEW.imJahr;
    UPDATE jahresergebnis
    SET durchschnittVögelBeob = avgVogelBeobachtung
    WHERE jahr = NEW.imJahr;
    RETURN NEW;
END;
$updateJahresergebnisDurchschnittVogelBeob$ LANGUAGE plpgsql;

CREATE TRIGGER updateJahresergebnisDurchschnittVogelBeob
AFTER INSERT OR UPDATE ON beobachtung
FOR EACH ROW
EXECUTE PROCEDURE updatejahresergebnisdurchschnittVogelBeob();


--Trigger 2 für das Attribut vögelInsg von 'jahresergebnis'
 CREATE FUNCTION updateVögelInsg() RETURNS TRIGGER AS
$updateVögelInsg$
BEGIN
    UPDATE jahresergebnis SET vögelInsg = (SELECT SUM(vögelGesamt) FROM beobachtung WHERE imJahr = NEW.imJahr)
    WHERE jahr = NEW.imJahr;
  RETURN NULL;
END;
$updateVögelInsg$ LANGUAGE plpgsql;

CREATE TRIGGER updateVögelInsg
AFTER INSERT OR UPDATE ON beobachtung
FOR EACH ROW
EXECUTE PROCEDURE updateVögelInsg();

--Trigger 3 für das Attribut vögelGesamt von 'beobachtung'
CREATE OR REPLACE FUNCTION update_beobachtungVögelGesamt()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE beobachtung
  SET vögelGesamt = vögelGesamt + NEW.höchsteAnzahl
  WHERE beobachtungsID = NEW.ergibtBeob;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_beobachtungVögelGesamt_trigger
AFTER INSERT ON einzelbeobachtung
FOR EACH ROW
EXECUTE PROCEDURE update_beobachtungVögelGesamt();

--Trigger 4 welcher checked, ob ein neuer Eintrag für Beobachtungsort eine bekannte Adresse enthält

CREATE OR REPLACE FUNCTION check_existing_beobachtungsort() RETURNS TRIGGER AS $checkExistingBeobachtungsort$
BEGIN
    IF EXISTS (SELECT 1 FROM beobachtungsort WHERE adresse = NEW.adresse) THEN
        NEW.beobachtungsortID = (SELECT beobachtungsortID FROM beobachtungsort WHERE adresse = NEW.adresse);
    END IF;
    RETURN NEW;
END;
$checkExistingBeobachtungsort$ LANGUAGE plpgsql;

CREATE TRIGGER check_existing_beobachtungsort_trigger
BEFORE INSERT ON beobachtungsort
FOR EACH ROW
EXECUTE FUNCTION check_existing_beobachtungsort();

--Trigger 5 für das Attribut beobachtungsorteInsg in 'jahresergebnis'

CREATE OR REPLACE FUNCTION update_beobachtungsort_count()
RETURNS TRIGGER AS $updateBeobachtungsortCount$
DECLARE
    var_beobachtungsIDs INTEGER[];
    var_beobachtungsort_count INTEGER;
    var_imJahr INTEGER;
BEGIN
   IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        -- wähle aus der Relation beobachtung den Wert imJahr bei welchem die beobachtungsID derjenigen des neuen Eintrages in durchgeführtVonAmOrt entspricht.
        SELECT imJahr INTO var_imJahr FROM beobachtung WHERE beobachtungsID = NEW.beobachtungsID;
       
        -- wähle aus der Relation beobachtung alle Einträge, welche als Wert für imJahr denselben Wert haben wie die neu hinzugefügte beobachtungsID in durchgeführtVonAmOrt
        SELECT ARRAY_AGG(beobachtungsID) INTO var_beobachtungsIDs FROM beobachtung WHERE imJahr = var_imJahr;
      
        --Prüfe die Länge des Arrays, summiere die Anzahl der Einträge der zu der BeobachtungsID des richtigen Jahres passenden BeobachtungsortIDs
        IF array_length(var_beobachtungsIDs, 1) = 1 THEN
            var_beobachtungsort_count := (SELECT COUNT(DISTINCT beobachtungsortID) FROM durchgeführtVonAmOrt WHERE beobachtungsID = var_beobachtungsIDs[1]);
        ELSE
            var_beobachtungsort_count := (SELECT COUNT(DISTINCT beobachtungsortID) FROM durchgeführtVonAmOrt WHERE beobachtungsID = ANY(var_beobachtungsIDs));
        END IF;
	    -- Update die Relation jahresergebnis mit dem errechneten Wert       
   	   UPDATE jahresergebnis SET beobachtungsorteInsg = var_beobachtungsort_count
   	   WHERE jahr = var_imJahr;
   END IF;
   RETURN NEW;
END;
$updateBeobachtungsortCount$ LANGUAGE plpgsql;

CREATE TRIGGER update_beobachtungsort_count
AFTER INSERT OR UPDATE ON durchgeführtVonAmOrt
FOR EACH ROW
EXECUTE FUNCTION update_beobachtungsort_count();