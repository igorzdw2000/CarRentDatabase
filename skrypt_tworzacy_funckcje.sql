CREATE FUNCTION getCar(@id_samochodu int)
RETURNS money
BEGIN
DECLARE @cena money
	SET @cena =  (SELECT Cena FROM dict.tbl_rodzaj_samochodu c INNER JOIN tbl_samochod s ON s.IdRodzajuSamochodu = c.IdRodzajuSamochodu WHERE s.IdSamochodu = @id_samochodu)
RETURN @cena
END
