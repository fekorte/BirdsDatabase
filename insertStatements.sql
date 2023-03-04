INSERT INTO teilnehmer(vorname, nachname, vorherigeTeilnahme)
	VALUES('Tabea', 'Richter', 'noch nie');

INSERT INTO teilnehmer(vorname, nachname, vorherigeTeilnahme)
	VALUES('Helge', 'Heidenreich', 'mehrfach');

INSERT INTO teilnehmer(vorname, nachname, vorherigeTeilnahme)
	VALUES('Tine', 'Albers', 'einmal');

INSERT INTO teilnehmer(vorname, nachname, vorherigeTeilnahme)
	VALUES('Franz', 'Branntwein', 'einmal');


INSERT INTO beobachtungsort(charakteristika, adresse, landkreisStadt, bundesland)
	VALUES('Dorf', 'Klabundeweg 9, 40878 Ratingen', 'Kreis Mettman', 'Nordrhein-Westfalen');

INSERT INTO beobachtungsort(charakteristika, adresse, landkreisStadt, bundesland)
	VALUES('Innenstadt', 'Ansgaritorstr. 3, 28256 Bremenn', 'Hansestadt Bremen', 'Bremen');

INSERT INTO beobachtungsort(charakteristika, adresse, landkreisStadt, bundesland)
	VALUES('Innenstadt', 'Hohe Luft Chausee 145, 35697 Hamburg', 'Hansestadt Hamburg', 'Hamburg');

INSERT INTO beobachtungsort(charakteristika, adresse, landkreisStadt, bundesland)
	VALUES('Vorstadt', 'Tannenstr. 10, 68276 Mannheim', 'Mannheim', 'Hessen');

INSERT INTO beobachtungsort(charakteristika, adresse, landkreisStadt, bundesland)
	VALUES('Einzelhaus abseits geschlossener Bebauung', 'An der Pforte 7, 17337 Lübbenow', 'Kreis Uckermark', 'Brandenburg');


INSERT INTO vogelart(vogelart)
	VALUES('Amsel');
	
INSERT INTO vogelart(vogelart)
	VALUES('Blaumeise');
	
INSERT INTO vogelart(vogelart)
	VALUES('Buchfink');
	
INSERT INTO vogelart(vogelart)
	VALUES('Elster');
	
INSERT INTO vogelart(vogelart)
	VALUES('Feldsperling');
	
INSERT INTO vogelart(vogelart)
VALUES('Grünfink');
	
INSERT INTO vogelart(vogelart)
	VALUES('Haussperling');
	
INSERT INTO vogelart(vogelart)
	VALUES('Kohlmeise');
	
INSERT INTO vogelart(vogelart)
VALUES('Mauersegler');
	
INSERT INTO vogelart(vogelart)
	VALUES('Mehlschwalbe');
	
INSERT INTO vogelart(vogelart)
	VALUES('Rotkehlchen');
	
INSERT INTO vogelart(vogelart)
	VALUES('Star');
	
	
INSERT INTO jahresergebnis(jahr, vögelInsg, durchschnittVögelBeob, beobachtungsorteInsg)
VALUES(2022, 0, 0, 0);

INSERT INTO jahresergebnis(jahr, vögelInsg, durchschnittVögelBeob, beobachtungsorteInsg)
VALUES(2021, 0, 0, 0);

INSERT INTO jahresergebnis(jahr, vögelInsg, durchschnittVögelBeob, beobachtungsorteInsg)
VALUES(2020, 0, 0, 0);	

INSERT INTO jahresergebnis(jahr, vögelInsg, durchschnittVögelBeob, beobachtungsorteInsg)
VALUES(1998, 0, 0, 0);	


INSERT INTO beobachtung(imJahr, uhrzeit, katzensichtungen, vögelGesamt, vogelfütterung)
VALUES(2022, '12:04','selten', 0, 'f');

INSERT INTO beobachtung(imJahr, uhrzeit, katzensichtungen, vögelGesamt, vogelfütterung)
VALUES(2020, '08:30','oft', 0, 't');

INSERT INTO beobachtung(imJahr, uhrzeit, katzensichtungen, vögelGesamt, vogelfütterung)
VALUES(1998, '11:15','selten', 0, 'f');

INSERT INTO beobachtung(imJahr, uhrzeit, katzensichtungen, vögelGesamt, vogelfütterung)
VALUES(2021, '09:40','nie', 0, 'f');

INSERT INTO beobachtung(imJahr, uhrzeit, katzensichtungen, vögelGesamt, vogelfütterung)
VALUES(2022,'08:10','täglich', 0, 'f');


INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(1,1,5);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(3,1,7);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(4,1,3);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(10,1,10);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(11,1,15);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(8,1,2);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(2,2,4);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(5,2,6);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(6,2,2);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(8,2,7);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(7,2,2);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(1,3,6);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(10,3,2);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(11,3,4);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(1,4,4);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(5,4,2);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(1,5,20);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(10,5,4);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(11,5,4);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(2,5,2);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(8,5,10);

INSERT INTO einzelbeobachtung(gesichteteVogelart, ergibtBeob, höchsteAnzahl)
	VALUES(9,5,8);
	

INSERT INTO durchgeführtVonAmOrt(teilnehmerID, beobachtungsID, beobachtungsortID)
	VALUES(1,1,1);
	
INSERT INTO durchgeführtVonAmOrt(teilnehmerID, beobachtungsID, beobachtungsortID)
	VALUES(2,2,2);
	
INSERT INTO durchgeführtVonAmOrt(teilnehmerID, beobachtungsID, beobachtungsortID)
	VALUES(3,3,3);	

INSERT INTO durchgeführtVonAmOrt(teilnehmerID, beobachtungsID, beobachtungsortID)
	VALUES(4,4,4);	
	
INSERT INTO durchgeführtVonAmOrt(teilnehmerID, beobachtungsID, beobachtungsortID)
	VALUES(4,5,5);	


