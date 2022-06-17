CREATE OR ALTER PROCEDURE usp_GetErrorInfo  
AS  
    SELECT   
         ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_LINE () AS ErrorLine  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;  

GO
CREATE SEQUENCE new_id_klient
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE PROCEDURE up_DodajKlienta @imie varchar(30),
@nazwisko varchar(50),
@adres varchar(60),
@miejscowsc varchar(60),
@kod_pocztowy varchar(6),
@wojewodztwo varchar(25),
@kraj varchar(50),
@telefon varchar(15),
@email varchar(40),
@data_urodzenia date,
@plec varchar(15)
AS
BEGIN TRY
DECLARE @msg varchar(50)
	IF @imie IS NULL OR
	@nazwisko IS NULL OR
	@adres IS NULL OR
	@miejscowsc IS NULL OR
	@kod_pocztowy IS NULL OR
	@wojewodztwo IS NULL OR
	@kraj IS NULL OR
	@telefon IS NULL OR
	@data_urodzenia IS NULL OR
	@plec IS NULL 
	BEGIN 
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœci null'
	RAISERROR(21,@msg,1)
	END
	BEGIN
	DECLARE @id_wojewodztwa int, @id_plci int, @id_kraju int
	SET @id_wojewodztwa = (SELECT IdWojewodztwa FROM dict.tbl_wojewodztwo WHERE Wojewodztwo = @wojewodztwo)
	SET @id_plci = (SELECT IdPlci FROM dict.tbl_plec WHERE Plec = @plec)
	SET @id_kraju = (SELECT IdKraju FROM dict.tbl_kraj WHERE Kraj = @kraj)
	INSERT INTO tbl_klient(IdKlienta,Imie,Nazwisko,Adres,Miejscowosc,KodPocztowy,IdWojewodztwa,IdKraju,Telefon,Email,DataUrodzenia,IdPlci)
	VALUES(NEXT VALUE FOR new_id_klient,@imie,@nazwisko,@adres,@miejscowsc,@kod_pocztowy,@id_wojewodztwa,@id_kraju,@telefon,@email,@data_urodzenia,@id_plci);
	END
END TRY
BEGIN CATCH
	EXECUTE usp_GetErrorInfo 
END CATCH
GO
CREATE SEQUENCE new_id_samochod
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE PROCEDURE up_dodaj_auto
@rejestracja varchar(15),
@model varchar(50),
@marka varchar(50),
@rodzaj_nadwozia varchar(25),
@silnik varchar(50),
@rodzaj_samochodu varchar(25),
@kolor varchar(30),
@przebieg int,
@rocznik int,
@vin varchar(17)
AS
BEGIN TRY
	DECLARE @msg varchar(50)
	IF @rejestracja IS NULL OR
	@model IS NULL OR
	@marka IS NULL OR
	@rodzaj_nadwozia IS NULL OR
	@silnik IS NULL OR
	@rodzaj_samochodu IS NULL OR
	@kolor IS NULL OR
	@przebieg IS NULL OR
	@rocznik IS NULL OR
	@vin IS NULL 
	BEGIN
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœci NULL'
	RAISERROR(21,@msg,1)
	END
	BEGIN
	DECLARE @id_model int, @id_marka int, @id_rodzaj_nadwozia int, @id_rodzaj_samochodu int, @id_silnika int
	SET @id_model = (SELECT IdModelu FROM dict.tbl_model WHERE Model = @model)
	SET @id_marka = (SELECT IdMarki FROM dict.tbl_marka WHERE Marka = @marka)
	SET @id_rodzaj_nadwozia = (SELECT IdRodzajuNadwozia FROM dict.tbl_rodzaj_nadwozia WHERE RodzajNadwozia = @rodzaj_nadwozia)
	SET @id_rodzaj_samochodu = (SELECT IdRodzajuSamochodu FROM dict.tbl_rodzaj_samochodu WHERE RodzajSamochodu = @rodzaj_samochodu)
	SET @id_silnika = (SELECT IdSilnika FROM dict.tbl_silnik WHERE TypSilnika=@silnik)
	INSERT INTO tbl_samochod(IdSamochodu,Rejestracja,IdModelu,IdMarki,IdRodzajuNadwozia,IdSilnika,IdRodzajuSamochodu,Kolor,Przebieg,Rocznik,VIN)
	VALUES(NEXT VALUE FOR new_id_samochod,@rejestracja,@id_model,@id_marka,@id_rodzaj_nadwozia,@id_silnika,@id_rodzaj_samochodu,@kolor,@przebieg,@rocznik,@vin)
	END
END TRY
BEGIN CATCH
	EXECUTE usp_GetErrorInfo 
END CATCH

GO

--CREATE OR ALTER PROCEDURE up_usun_auto
--@id_samochodu int
--AS
--BEGIN TRY
--	DECLARE @msg varchar(50)
--	IF @id_samochodu IS NULL
--	BEGIN
--	SET @msg = 'Podaj wartoœæ id samochodu'
--	RAISERROR(21,@msg,1)
--	END
--	BEGIN
--	DECLARE @id_rezerwacji int
--	SET @id_rezerwacji = (SELECT IdRezerwacji FROM tbl_rezerwacja WHERE IdSamochodu=@id_samochodu)
--	DELETE FROM tbl_ubezpieczenie WHERE IdSamochodu = @id_samochodu
--	DELETE FROM tbl_przeglad_samochodu WHERE IdSamochodu = @id_samochodu
--	DELETE FROM tbl_rezerwacja WHERE IdSamochodu = @id_samochodu;
--	DELETE FROM tbl_rezerwacja_klient WHERE IdRezerwacji = @id_rezerwacji
--	DELETE FROM tbl_faktura WHERE IdRezerwacji = @id_rezerwacji
--	DELETE FROM tbl_spis_napraw WHERE IdSamochodu = @id_samochodu
--	DELETE FROM tbl_samochod WHERE IdSamochodu=@id_samochodu
--	END
--END TRY
--BEGIN CATCH
--	EXECUTE usp_GetErrorInfo
--END CATCH
	
CREATE SEQUENCE new_id_rezerwacja
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE OR ALTER PROCEDURE up_dodaj_rezerwacje
@id_wypozyczenia int,
@id_samochodu int,
@data_utworzenia_rezerwacji date
AS
BEGIN TRY
	DECLARE @msg varchar(70)
	IF @id_wypozyczenia IS NULL OR
	@id_samochodu IS NULL OR
	@data_utworzenia_rezerwacji IS NULL
	BEGIN
	SET @msg = 'Wartoœci nie mog¹ przyjmowaæ NULL'
	RAISERROR(@msg,16,1)
	END
	IF (SELECT IdWypozyczenia FROM tbl_wypozyczenie WHERE IdWypozyczenia = @id_wypozyczenia) IS NULL
	BEGIN
	SET @msg = 'Brak wypo¿yczenia o podanym numerze, dodaj nowe wypo¿yczenie'
	RAISERROR(@msg,16,1)
	END
	IF (SELECT dbo.uf_czy_wolny_samochod(@id_samochodu)) = 1
	BEGIN
	INSERT INTO tbl_rezerwacja(IdRezerwacji,IdWypozyczenia,IdSamochodu,CenaZaDobe,Kaucja,DataRezerwacji,DataKoncaRezerwacji,DataUtworzeniaRezerwacji,LacznaKwotaDoZaplaty)
	VALUES(NEXT VALUE FOR new_id_rezerwacja,@id_wypozyczenia,@id_samochodu,dbo.uf_getCar(@id_samochodu),1000,dbo.uf_getDataWypozyczenia(@id_wypozyczenia),dbo.uf_getDataZwrotu(@id_wypozyczenia),@data_utworzenia_rezerwacji,(dbo.uf_czyZwrocicKaucje(@id_wypozyczenia)+CONVERT(money,dbo.uf_getCar(@id_samochodu)*DATEDIFF(day,dbo.uf_getDataWypozyczenia(@id_wypozyczenia),dbo.uf_getDataZwrotu(@id_wypozyczenia)))))
	END
	ELSE
	BEGIN
	SET @msg = 'Podany samochód jest niedostêpny'
	RAISERROR(@msg,16,1)
	END
END TRY
BEGIN CATCH
DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  
  
    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
	RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState)
END CATCH
GO

CREATE SEQUENCE new_id_wypozyczenie
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE OR ALTER PROCEDURE up_dodaj_wypozyczenie
@data_wypozyczenia date,
@data_zwrotu date,
@stan_techniczny varchar(100)
AS
BEGIN TRY
	DECLARE @msg varchar(70)
	IF @data_wypozyczenia IS NULL OR
	@data_zwrotu IS NULL OR
	@stan_techniczny IS NULL 
	BEGIN 
	SET @msg = 'Wartoœci nie mog¹ przyjmowaæ wartoœci NULL'
	RAISERROR(@msg,16,1)
	END
	ELSE
	BEGIN
	INSERT INTO tbl_wypozyczenia(IdWypozyczenia, DataWypozyczenia, DataZwrotu, StanTechniczny)
	VALUES(NEXT VALUE FOR new_id_wypozyczenie,@data_wypozyczenia,@data_zwrotu,@stan_techniczny)
	END
END TRY
BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  
  
    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
	RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState)
END CATCH