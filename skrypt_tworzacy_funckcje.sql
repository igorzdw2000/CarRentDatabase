--CREATE FUNCTION uf_getCar(@id_samochodu int)
--RETURNS money
--BEGIN
--DECLARE @cena money
--	SET @cena =  (SELECT Cena FROM dict.tbl_rodzaj_samochodu c INNER JOIN tbl_samochod s ON s.IdRodzajuSamochodu = c.IdRodzajuSamochodu WHERE s.IdSamochodu = @id_samochodu)
--RETURN @cena
--END

--CREATE FUNCTION uf_getDataWypozyczenia(@id_wypozyczenia int)
--RETURNS date
--BEGIN
--DECLARE @data_wypozyczenia date
--	SET @data_wypozyczenia = (SELECT DataWypozyczenia FROM tbl_wypozyczenie WHERE IdWypozyczenia = @id_wypozyczenia)
--	RETURN @data_wypozyczenia
--END

--CREATE FUNCTION uf_getDataZwrotu(@id_wypozyczenia int)
--RETURNS date
--BEGIN
--DECLARE @data_zwrotu date
--	SET @data_zwrotu = (SELECT DataZwrotu FROM tbl_wypozyczenie WHERE IdWypozyczenia = @id_wypozyczenia)
--	RETURN @data_zwrotu
--END

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