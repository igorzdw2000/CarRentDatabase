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