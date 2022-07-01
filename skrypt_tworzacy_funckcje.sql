CREATE FUNCTION uf_getCar(@id_samochodu int)
RETURNS money
BEGIN
DECLARE @cena money
	SET @cena =  (SELECT Cena FROM dict.tbl_rodzaj_samochodu c INNER JOIN tbl_samochod s ON s.IdRodzajuSamochodu = c.IdRodzajuSamochodu WHERE s.IdSamochodu = @id_samochodu)
RETURN @cena
END
GO

CREATE FUNCTION uf_getDataWypozyczenia(@id_wypozyczenia int)
RETURNS date
BEGIN
DECLARE @data_wypozyczenia date
	SET @data_wypozyczenia = (SELECT DataWypozyczenia FROM tbl_wypozyczenie WHERE IdWypozyczenia = @id_wypozyczenia)
	RETURN @data_wypozyczenia
END
GO

CREATE FUNCTION uf_getDataZwrotu(@id_wypozyczenia int)
RETURNS date
BEGIN
DECLARE @data_zwrotu date
	SET @data_zwrotu = (SELECT DataZwrotu FROM tbl_wypozyczenie WHERE IdWypozyczenia = @id_wypozyczenia)
	RETURN @data_zwrotu
END
GO

CREATE OR ALTER FUNCTION uf_czyZwrocicKaucje(@id_wypozyczenia int)
RETURNS money
BEGIN 
DECLARE @kaucja money
	IF (SELECT StanTechniczny FROM tbl_wypozyczenie WHERE IdWypozyczenia = @id_wypozyczenia) = 'dobry'
		SET @kaucja = 0
	ELSE
		SET @kaucja = 1000
RETURN @kaucja
END
GO

CREATE OR ALTER FUNCTION uf_getCarId(@id_faktury int)
RETURNS int
BEGIN
DECLARE @id int
	SET @id = (SELECT IdSamochodu FROM tbl_rezerwacja r INNER JOIN tbl_faktura f ON r.IdRezerwacji = f.IdRezerwacji WHERE IdFaktury=@id_faktury) 
RETURN @id
END
GO

CREATE OR ALTER FUNCTION uf_getCarType(@id_faktury int)
RETURNS tinyint
BEGIN
	DECLARE @id int
	SET @id = (SELECT IdRodzajuSamochodu FROM tbl_samochod s INNER JOIN tbl_rezerwacja r ON r.IdSamochodu = s.IdSamochodu INNER JOIN tbl_faktura f ON f.IdRezerwacji = r.IdRezerwacji WHERE IdFaktury = @id_faktury)
RETURN @id
END
GO

CREATE OR ALTER FUNCTION uf_getLacznaKwota(@id_faktury int)
RETURNS money
BEGIN
DECLARE @laczna_kwota money
	SET @laczna_kwota = (SELECT LacznaKwotaDoZaplaty FROM tbl_rezerwacja r INNER JOIN tbl_faktura f ON r.IdRezerwacji = f.IdRezerwacji WHERE IdFaktury=@id_faktury) 
RETURN @laczna_kwota
END
GO

CREATE OR ALTER FUNCTION uf_czy_wolny_samochod(@id_samochodu int)
RETURNS bit
BEGIN
	DECLARE @czy_wolny bit
	IF (SELECT DataZwrotu FROM tbl_wypozyczenie w INNER JOIN tbl_rezerwacja r ON r.IdWypozyczenia = w.IdWypozyczenia WHERE IdSamochodu=@id_samochodu AND DataZwrotu>=GETDATE())>=GETDATE()
	SET @czy_wolny =0
	ELSE
	SET @czy_wolny=1
RETURN @czy_wolny
END
CREATE FUNCTION uf_wyszukaj_marke_po_nazwie
(@marka varchar(30))
RETURNS TABLE
AS
RETURN(
SELECT * FROM dict.tbl_marka
WHERE LOWER(Marka) LIKE LOWER('%'+@marka+'%'))
GO

CREATE FUNCTION uf_wyszukaj_model_po_nazwie
(@model varchar(50))
RETURNS TABLE
AS
RETURN(
SELECT * FROM dict.tbl_model
WHERE LOWER(Model) LIKE LOWER('%'+@model+'%'))
GO

CREATE FUNCTION uf_wyszukaj_klienta_po_imieniu_nazwisku
(@imieLubNazwisko varchar(60))
RETURNS TABLE
AS
RETURN(
SELECT * FROM tbl_klient
WHERE LOWER(Imie)+' '+LOWER(Nazwisko) LIKE LOWER('%'+@imieLubNazwisko+'%'))
GO

CREATE OR ALTER FUNCTION uf_wyszukaj_samochod_po_marce
(@model varchar(50))
RETURNS TABLE
AS
RETURN(
SELECT s.IdSamochodu,s.Rejestracja,m.Marka,model.Model FROM tbl_samochod s INNER JOIN dict.tbl_marka m ON s.IdMarki = m.IdMarki
INNER JOIN dict.tbl_model model ON model.IdModelu = s.IdModelu
WHERE LOWER(m.Marka) LIKE LOWER('%'+@model+'%'))
GO

CREATE OR ALTER FUNCTION uf_ile_rezerwacji_ma_klient
(@imieLubNazwisko varchar(50))
RETURNS TABLE
AS
RETURN(
SELECT k.Imie,k.Nazwisko, COUNT(rk.IdKlienta) AS 'Liczba rezerwacji klienta' FROM tbl_rezerwacja_klient rk INNER JOIN tbl_klient k ON rk.IdKlienta = k.IdKlienta
WHERE LOWER(k.Imie) + ' '+LOWER(k.Nazwisko) LIKE LOWER('%'+@imieLubNazwisko+'%')
GROUP BY rk.IdKlienta,k.Imie,k.Nazwisko)
GO

CREATE OR ALTER FUNCTION uf_wyswietl_dane_z_kursora_rezerwacje()
RETURNS @kursor TABLE(wartosc varchar(255))
AS
BEGIN
DECLARE @imie varchar(50);
DECLARE @nazwisko varchar(50);
DECLARE @model varchar(50);
DECLARE @marka varchar(50);
DECLARE crs_rezerwacje_klienta CURSOR FOR
SELECT k.Imie, k.Nazwisko, m.Marka,model.Model FROM tbl_klient k
INNER JOIN tbl_rezerwacja_klient rk ON rk.IdKlienta = k.IdKlienta
INNER JOIN tbl_rezerwacja r ON r.IdRezerwacji = rk.IdRezerwacji
INNER JOIN tbl_samochod s ON r.IdSamochodu = s.IdSamochodu
INNER JOIN dict.tbl_marka m ON m.IdMarki = s.IdMarki
INNER JOIN dict.tbl_model model ON model.IdModelu = s.IdSamochodu;
OPEN crs_rezerwacje_klienta;
FETCH NEXT FROM crs_rezerwacje_klienta INTO @imie,@nazwisko,@marka,@model;
WHILE @@FETCH_STATUS=0
BEGIN
INSERT INTO @kursor(wartosc) VALUES('Klient '+@imie+' '+@nazwisko+' wypo¿yczy³\a '+@marka+' '+@model);
FETCH NEXT FROM crs_rezerwacje_klienta INTO @imie,@nazwisko,@marka,@model;
END
CLOSE crs_rezerwacje_klienta;
DEALLOCATE crs_rezerwacje_klienta;
RETURN 
END
GO

CREATE OR ALTER FUNCTION uf_wyswietl_dane_z_kursora_faktury()
RETURNS @kursor TABLE( wartosc varchar(255))
AS
BEGIN
DECLARE @id int;
DECLARE @tytul varchar(50);
DECLARE @calkowita_wartosc int;
DECLARE crs_wartosc_faktury CURSOR FOR
SELECT f.IdFaktury,f.Tytyl,SUM(pf.Cena) FROM tbl_faktura f INNER JOIN tbl_pozycje_faktury pf ON f.IdFaktury = pf.IdFaktury
GROUP BY f.IdFaktury,f.Tytyl;
OPEN crs_wartosc_faktury;
FETCH NEXT FROM crs_wartosc_faktury into @id,@tytul,@calkowita_wartosc;
WHILE @@FETCH_STATUS = 0
BEGIN
INSERT INTO @kursor(wartosc) VALUES('Ca³kowita wartoœæ faktury '+@tytul+' wynosi '+CONVERT(varchar(50),@calkowita_wartosc)+' z³')
FETCH NEXT FROM crs_wartosc_faktury into @id,@tytul,@calkowita_wartosc;
END
CLOSE crs_wartosc_faktury;
DEALLOCATE crs_wartosc_faktury;
RETURN 
END
GO
CREATE FUNCTION uf_wyszukaj_fakture_po_nr
(@nr_faktury int)
RETURNS TABLE
AS
RETURN(
SELECT * FROM tbl_faktura
WHERE IdFaktury = @nr_faktury)
GO
CREATE FUNCTION uf_wyszukaj_wojewodztwo_po_nazwie
(@wojewodztwo varchar(25))
RETURNS TABLE
AS
RETURN(
SELECT IdWojewodztwa,Wojewodztwo FROM dict.tbl_wojewodztwo
WHERE LOWER(Wojewodztwo) LIKE LOWER('%'+@wojewodztwo+'%'))

go

CREATE FUNCTION uf_wyszukaj_ubezpieczenie_po_nr_polisy
(@nr_polisy varchar(16))
RETURNS TABLE
AS
RETURN(
SELECT * FROM tbl_ubezpieczenie 
WHERE LOWER(NumerPolisy) LIKE LOWER('%'+@nr_polisy+'%'))
GO
CREATE FUNCTION uf_wyszukaj_platnosci_po_tytule_faktury
(@tytul varchar(50))
RETURNS TABLE
AS
RETURN(
SELECT p.IdPlatnosci, p.IdFaktury,f.Tytyl,p.Zaplata,p.IdFormaPlatnosci FROM tbl_platnosc p 
INNER JOIN tbl_faktura f
ON p.IdFaktury = f.IdFaktury
WHERE LOWER(f.Tytyl) LIKE LOWER('%'+@tytul+'%'))
GO
CREATE FUNCTION uf_wyszukaj_klienta_po_wojewodztwie
(@wojewodztwo varchar(19))
RETURNS TABLE
AS
RETURN(
SELECT IdKlienta,Imie,Nazwisko,Adres,Miejscowosc,KodPocztowy,w.Wojewodztwo,IdKraju,Telefon,Email,DataUrodzenia,IdPlci FROM tbl_klient k 
INNER JOIN dict.tbl_wojewodztwo w  
ON k.IdWojewodztwa = w.IdWojewodztwa
WHERE LOWER(w.Wojewodztwo) LIKE LOWER('%'+@wojewodztwo+'%'))
GO
CREATE OR ALTER FUNCTION uf_ile_klientek()
RETURNS TABLE
AS
RETURN(
SELECT COUNT(IdKlienta) AS 'Liczba klientek' FROM tbl_klient WHERE IdPlci = 1 GROUP BY IdPlci);
GO
CREATE OR ALTER FUNCTION uf_ile_klientow()
RETURNS TABLE
AS
RETURN(
SELECT COUNT(IdKlienta) AS 'Liczba klientow' FROM tbl_klient WHERE IdPlci = 2 GROUP BY IdPlci);

GO
CREATE OR ALTER FUNCTION uf_wyswietl_dane_z_kursora_klienta()
RETURNS @kursor TABLE(wartosc varchar(255))
AS
BEGIN
DECLARE @imie varchar(30);
DECLARE @nazwisko varchar(50);
DECLARE @telefon varchar(15);
DECLARE @email varchar(40);
DECLARE crs_kontakt_klienci CURSOR FOR
SELECT Imie,Nazwisko,Telefon,Email FROM tbl_klient
OPEN crs_kontakt_klienci;
FETCH NEXT FROM crs_kontakt_klienci INTO @imie,@nazwisko,@telefon,@email;
WHILE @@FETCH_STATUS = 0
BEGIN
INSERT INTO @kursor(wartosc) VALUES('Kontakt do klienta: '+@imie+' '+@nazwisko+' | '+@telefon+' | '+@email)
FETCH NEXT FROM crs_kontakt_klienci INTO @imie,@nazwisko,@telefon,@email;
END
CLOSE crs_kontakt_klienci;
DEALLOCATE crs_kontakt_klienci;
RETURN
END