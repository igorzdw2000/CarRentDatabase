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


