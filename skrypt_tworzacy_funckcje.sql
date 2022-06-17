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