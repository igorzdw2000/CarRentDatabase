INSERT INTO dict.tbl_forma_faktury(IdFormyFaktury,FormaFaktury)
     VALUES (1, 'papierowa'), (2, 'elektroniczna');

INSERT INTO dict.tbl_forma_platnosci(IdFormyPlatnosci, FormaPlatnosci)
	VALUES (1, 'gotówka'), (2, 'przelew'), (3, 'BLIK'), (4, 'karta');

INSERT INTO dict.tbl_kraj(IdKraju, Kraj)
	VALUES (1, 'Austria'),
	(2, 'Belgia'),
	(3, 'Bu³garia'),
	(4, 'Chorwacja'),
	(5, 'Cypr'),
	(6, 'Czechy'),
	(7, 'Dania'),
	(8, 'Estonia'),
	(9, 'Finlandia'),
	(10, 'Francja'),
	(11, 'Grecja'),
	(12, 'Hiszpania'),
	(13, 'Holandia'),
	(14, 'Irlandia'),
	(15, 'Litwa'),
	(16, 'Luksemburg'),
	(17, '£otwa'),
	(18, 'Malta'),
	(19, 'Niemcy'),
	(20, 'Polska'),
	(21, 'Portugalia'),
	(22, 'Rumunia'),
	(23, 'S³owacja'),
	(24, 'S³owenia'),
	(25, 'Szwecja'),
	(26, 'Wêgry'),
	(27, 'W³ochy');

INSERT INTO dict.tbl_marka(IdMarki, Marka)
	VALUES(1, 'Audi'),
	(2, 'BMW'),
	(3, 'Chevrolet'),
	(4, 'Fiat'),
	(5, 'Peugeot'),
	(6, 'Porsche'),
	(7, 'Seat'),
	(8, 'Dacia'),
	(9, 'Volkswagen'),
	(10, 'Skoda'),
	(11, 'Saab'),
	(12, 'Mercedes-Benz');

INSERT INTO dict.tbl_model(IdModelu, Model)
	VALUES(1, 'A6'), (2, 'A4'), (3, 'Q3'), (4,'X3'), (5, 'Z3'), (6, 'Aveo'), (7, 'Cruze'), (8, 'Tipo'), (9, 'Panda City Life'), (10, '500'),
	(11, '2008'), (12, '208'), (13, '911'), (14, 'Leon'), (15, 'Ateca'), (16, 'Ibiza'), (17, 'Logan'), (18, 'Sandero'), (19, 'Golf'), (20, 'Passat'), (21, 'Polo'),
	(22, 'Scirocco'), (23, 'Fabia'), (24, 'Yeti'), (25, 'Octavia'), (26, '9-3'), (27, 'S205'), (28, 'W247');

INSERT INTO dict.tbl_wojewodztwo
	VALUES
(1,'dolnoœl¹skie'),
(2,'kuajwsko-pomorksie'),
(3,'lubelskie'),
(4,'lubuskie'),
(5,'³ódzkie'),
(6,'ma³opolskie'),
(7,'mazowieckie'),
(8,'opolskie'),
(9,'podkarpackie'),
(10,'podlaskie'),
(11,'pomorskie'),
(12,'œl¹skie'),
(13,'œwiêtokrzyskie'),
(14,'warmiñsko-mazurskie'),
(15,'wielkopolskie'),
(16,'zachodniopomorskie');

INSERT INTO dict.tbl_plec 
VALUES
(1, 'kobieta','K'),
(2,'mê¿czyzna','M'),
(3,'inna','I');

INSERT INTO dict.tbl_rodzaj_nadwozia
VALUES
(1, 'sedan'),
(2, 'kombi'),
(3, 'coupe'),
(4, 'hatchback');

INSERT INTO dict.tbl_rodzaj_samochodu
VALUES 
(1,'premium'),
(2,'standard'),
(3,'business');

INSERT INTO dict.tbl_silnik
VALUES
(1,'benzynowy'),
(2,'elektryczny'),
(3,'diesel'),
(4,'hybrydowy');