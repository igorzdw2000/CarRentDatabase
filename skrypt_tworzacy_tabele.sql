-- skrypt tworz¹cy tabele
USE wypozyczalnia_samochodow
GO

--tabela klient
CREATE TABLE tbl_klient
(
	IdKlienta int NOT NULL PRIMARY KEY,
	Imie varchar(30) NOT NULL,
	Nazwisko varchar(50) NOT NULL,
	Adres varchar(60) NOT NULL,
	Miejscowosc varchar(60) NOT NULL,
	KodPocztowy varchar(6) NOT NULL,
	IdWojewodztwa tinyint NOT NULL,
	IdKraju int NOT NULL,
	Telefon varchar(15) NOT NULL,
	Email varchar(40),
	DataUrodzenia date NOT NULL,
	IdPlci tinyint NOT NULL,
	
	CONSTRAINT FK_Wojewodztwo FOREIGN KEY (IdWojewodztwa) REFERENCES dict.tbl_wojewodztwo(IdWojewodztwa),
	CONSTRAINT FK_klient_plec FOREIGN KEY (IdPlci) REFERENCES dict.tbl_plec(IdPlci),
	CONSTRAINT FK_klient_kraj FOREIGN KEY (IdKraju) REFERENCES dict.tbl_kraj(IdKraju)
);

--tabela samochód
CREATE TABLE tbl_samochod
(
	IdSamochodu int NOT NULL PRIMARY KEY,
	Rejestracja varchar(15),
	IdModelu int NOT NULL,
	IdMarki int NOT NULL,
	IdRodzajuNadwozia tinyint NOT NULL,
	IdSilnika tinyint NOT NULL,
	IdRodzajuSamochodu tinyint NOT NULL,
	Kolor varchar(30) NOT NULL,
	Przebieg int NOT NULL,
	Rocznik int NOT NULL,
	VIN varchar(17) NOT NULL,

	CONSTRAINT FK_samochod_model FOREIGN KEY (IdModelu) REFERENCES dict.tbl_model,
	CONSTRAINT FK_samochod_marka FOREIGN KEY (IdMarki) REFERENCES dict.tbl_marka,
	CONSTRAINT FK_samochod_rodzaj_nadwozia FOREIGN KEY (IdRodzajuNadwozia) REFERENCES dict.tbl_rodzaj_nadwozia,
	CONSTRAINT FK_samochod_silnik FOREIGN KEY (IdSilnika) REFERENCES dict.tbl_silnik,
	CONSTRAINT FK_samochod_rodzaj_samochodu FOREIGN KEY (IdRodzajuSamochodu) REFERENCES dict.tbl_rodzaj_samochodu
);

--tabela ubezpieczenie
CREATE TABLE tbl_ubezpieczenie
(
	IdUbezpieczenia int NOT NULL,
	IdSamochodu int NOT NULL,
	NumerPolisy varchar(16) NOT NULL,
	DataRozpoczeciaUbezpieczenia date NOT NULL,
	DataZakonczeniaUbezpieczenia date NOT NULL,
	FirmaUbezpieczeniowa varchar(50) NOT NULL,
	Cena money NOT NULL,

	PRIMARY KEY(IdUbezpieczenia, IdSamochodu),

	CONSTRAINT FK_ubezpieczenie_samochod FOREIGN KEY (IdSamochodu) REFERENCES tbl_samochod(IdSamochodu)
);

CREATE TABLE tbl_wypozyczenie
(
	IdWypozyczenia int NOT NULL PRIMARY KEY,
	DataWypozyczenia date NOT NULL,
	DataZwrotu date NOT NULL,
	StanTechniczny varchar(100)
);

CREATE TABLE tbl_rezerwacja 
(
	IdRezerwacji int NOT NULL PRIMARY KEY,
	IdWypozyczenia int NOT NULL,
	IdSamochodu int NOT NULL,
	CenaZaDobe money NOT NULL,
	Kaucja money NOT NULL,
	DataRezerwacji date NOT NULL,
	DataKoncaRezerwacji date NOT NULL,
	DataUtworzeniaRezerwacji date NOT NULL,
	LacznaKwotaDoZaplaty money NOT NULL,

	CONSTRAINT FK_rezerwacja_wypozyczenie FOREIGN KEY(IdWypozyczenia) REFERENCES tbl_wypozyczenie(IdWypozyczenia),
	CONSTRAINT FK_rezerwacja_samochod FOREIGN KEY(IdSamochodu) REFERENCES tbl_samochod(IdSamochodu)
);	

CREATE TABLE tbl_faktura
(
	IdFaktury int NOT NULL PRIMARY KEY,
	Tytyl varchar(50) NOT NULL,
	Wydawca varchar(30) NOT NULL,
	DataWystawienia date NOT NULL,
	NIP varchar(11),
	NazwaFirmy varchar(50),
	NrKontaBankowego varchar(28),
	IdRezerwacji int NOT NULL,
	IdWypozyczenia int NOT NULL,
	IdFormyFaktury tinyint NOT NULL,

	CONSTRAINT FK_faktura_rezerwacja FOREIGN KEY(IdRezerwacji) REFERENCES tbl_rezerwacja(IdRezerwacji),
	CONSTRAINT FK_faktura_wypozyczenie FOREIGN KEY(IdWypozyczenia) REFERENCES tbl_wypozyczenie(IdWypozyczenia),
	CONSTRAINT FK_faktura_forma_faktury FOREIGN KEY(IdFormyFaktury) REFERENCES dict.tbl_forma_faktury(IdFormyFaktury)
);

CREATE TABLE tbl_platnosc
(
	IdPlatnosci int NOT NULL PRIMARY KEY,
	Zaplata money NOT NULL,
	IdFaktury int NOT NULL,
	IdFormaPlatnosci tinyint NOT NULL

	CONSTRAINT FK_platnosc_faktura FOREIGN KEY(IdFaktury) REFERENCES tbl_faktura(IdFaktury),
	CONSTRAINT FK_platnosc_forma_platnosci FOREIGN KEY(IdFormaPlatnosci) REFERENCES dict.tbl_forma_platnosci

);

CREATE TABLE tbl_rezerwacja_klient
(
	IdKlienta int NOT NULL,
	IdRezerwacji int NOT NULL,

	CONSTRAINT FK_rezerwacja_klient_klient FOREIGN KEY(IdKlienta) REFERENCES tbl_klient(IdKlienta),
	CONSTRAINT FK_rezerwacja_klient_rezerewacja FOREIGN KEY(IdRezerwacji) REFERENCES tbl_rezerwacja(IdRezerwacji)
);

CREATE TABLE tbl_pozycje_faktury
(
	IdPozycjiFaktury int NOT NULL,
	IdFaktury int NOT NULL,
	IdSamochodu int NOT NULL,
	IdRodzajSamochodu tinyint NOT NULL,
	Ilosc int NOT NULL,
	Cena money NOT NULL,
	NrPozycjiNaFakturze int NOT NULL,

	CONSTRAINT FK_pozycja_faktury_faktura FOREIGN KEY(IdFaktury) REFERENCES tbl_faktura(IdFaktury),
	CONSTRAINT FK_pozycja_faktury_samochod FOREIGN KEY(IdSamochodu) REFERENCES tbl_samochod(IdSamochodu),
	CONSTRAINT FK_pozycja_faktury_rodzajsamochodu FOREIGN KEY(IdRodzajSamochodu) REFERENCES dict.tbl_rodzaj_samochodu(IdRodzajuSamochodu)
	
);

CREATE TABLE tbl_spis_napraw
(
	IdNaprawy int NOT NULL PRIMARY KEY,
	OpisNaprawy varchar(50) NOT NULL,
	DataNaprawy date NOT NULL,
	Cena money NOT NULL,
	IdSamochodu int NOT NULL,

	CONSTRAINT FK_spis_napraw_samochod FOREIGN KEY(IdSamochodu) REFERENCES tbl_samochod(IdSamochodu)
);

CREATE TABLE tbl_przeglad_samochodu
(
	IdPrzegladu int NOT NULL PRIMARY KEY,
	DataZrobieniaPrzegladu date NOT NULL,
	DataWaznosciPrzegladu date NOT NULL,
	Uwagi varchar(60),
	MiejsceWykonaniaPrzegladu varchar(30) NOT NULL,
	Cena money NOT NULL,
	IdSamochodu int NOT NULL,

	CONSTRAINT FK_przeglad_samochod FOREIGN KEY(IdSamochodu) REFERENCES tbl_samochod(IdSamochodu)
);