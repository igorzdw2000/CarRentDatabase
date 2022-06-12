--skrypt tworz¹cy tabele s³ownikowe

CREATE TABLE dict.tbl_wojewodztwo
(
	IdWojewodztwa tinyint NOT NULL PRIMARY KEY,
	Wojewodztwo varchar(25) NOT NULL
);

CREATE TABLE dict.tbl_plec
(
	IdPlci tinyint NOT NULL PRIMARY KEY,
	Plec varchar(15) NOT NULL,
	SymbolPlci char(1) NOT NULL
);

CREATE TABLE dict.tbl_kraj
(
	IdKraju int NOT NULL PRIMARY KEY,
	Kraj varchar(50)
);

CREATE TABLE dict.tbl_silnik
(
	IdSilnika tinyint NOT NULL PRIMARY KEY,
	TypSilnika varchar(50) NOT NULL,
);

CREATE TABLE dict.tbl_rodzaj_nadwozia
(
	IdRodzajuNadwozia tinyint NOT NULL PRIMARY KEY,
	RodzajNadwozia varchar(25) NOT NULL
);

CREATE TABLE dict.tbl_marka
(
	IdMarki int NOT NULL PRIMARY KEY,
	Marka varchar(50)
);

CREATE TABLE dict.tbl_model
(
	IdModelu int NOT NULL PRIMARY KEY,
	Model varchar(50)
);

CREATE TABLE dict.tbl_rodzaj_samochodu
(
	IdRodzajuSamochodu tinyint NOT NULL PRIMARY KEY,
	RodzajSamochodu varchar(25) NOT NULL
);

CREATE TABLE dict.tbl_forma_faktury
(
	IdFormyFaktury tinyint NOT NULL PRIMARY KEY,
	FormaFaktury varchar(15)
);

CREATE TABLE dict.tbl_forma_platnosci
(
	IdFormyPlatnosci tinyint NOT NULL PRIMARY KEY,
	FormaPlatnosci varchar(25)
);

