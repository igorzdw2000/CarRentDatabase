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
	INSERT INTO tbl_wypozyczenie(IdWypozyczenia, DataWypozyczenia, DataZwrotu, StanTechniczny)
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

CREATE SEQUENCE seq_new_id_faktury
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE OR ALTER PROCEDURE up_dodaj_fakture
@tytul varchar(50),
@wydawca varchar(30),
@data_wystawienia date,
@nip varchar(11),
@nazwa_firmy varchar(50),
@nr_konta_bankowego varchar(28),
@id_rezerwacji int,
@id_wypozyczenia int,
@id_formy_faktury int
AS
BEGIN TRY 
	DECLARE @msg varchar(100)
	IF @tytul IS NULL OR
		@wydawca IS NULL OR
		@data_wystawienia IS NULL OR
		@nip IS NULL OR
		@nazwa_firmy IS NULL OR
		@nr_konta_bankowego IS NULL OR
		@id_rezerwacji IS NULL OR
		@id_wypozyczenia IS NULL OR
		@id_formy_faktury IS NULL 
	BEGIN
		SET @msg = 'Kolumny nie przyjmuj¹ wartoœci NULL'
		RAISERROR(@msg,16,1)
	END
	ELSE
		BEGIN
		IF((SELECT COUNT(IdRezerwacji) FROM tbl_rezerwacja WHERE IdRezerwacji = @id_rezerwacji) = 1)
			BEGIN
				IF((SELECT COUNT(IdWypozyczenia) FROM tbl_wypozyczenie WHERE IdWypozyczenia = @id_wypozyczenia) = 1)
				BEGIN
				INSERT INTO tbl_faktura(IdFaktury,Tytyl,Wydawca,DataWystawienia,NIP,NazwaFirmy,NrKontaBankowego,IdRezerwacji,IdWypozyczenia,IdFormyFaktury)
				VALUES(NEXT VALUE FOR dbo.seq_new_id_faktury,@tytul,@wydawca,@data_wystawienia,@nip,@nazwa_firmy,@nr_konta_bankowego,@id_rezerwacji,@id_wypozyczenia,@id_formy_faktury)
				END
			
				ELSE
				BEGIN
				PRINT('Nie znaleziono wypo¿yczenia o podanym ID')
				END
			END
		ELSE
		BEGIN
			PRINT('Nie znaleziono rezerwacji o podanym ID')
		END
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
CREATE OR ALTER PROCEDURE up_mod_fakture
@id_faktury int,
@tytul varchar(50),
@wydawca varchar(30),
@data_wystawienia date,
@nip varchar(11),
@nazwa_firmy varchar(50),
@nr_konta_bankowego varchar(28),
@id_rezerwacji int,
@id_wypozyczenia int,
@id_formy_faktury int
AS
BEGIN TRY 
	IF((SELECT COUNT(IdFaktury) FROM tbl_faktura WHERE IdFaktury = @id_faktury) = 1)
	BEGIN
		UPDATE tbl_faktura
		SET
		Tytyl = @tytul,
		Wydawca = @wydawca,
		DataWystawienia = @data_wystawienia,
		NIP = @nip,
		NazwaFirmy = @nazwa_firmy,
		NrKontaBankowego = @nr_konta_bankowego,
		IdRezerwacji = @id_rezerwacji,
		IdWypozyczenia = @id_wypozyczenia,
		IdFormyFaktury = @id_formy_faktury
		WHERE IdFaktury = @id_faktury
		PRINT('Pomyœlnie zmieniono rekord w tabeli.')
	END
	ELSE
	BEGIN
		PRINT('W bazie nie ma faktury o podanym ID!')
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
CREATE OR ALTER PROCEDURE up_usun_fakture
@id_faktury int
AS
BEGIN TRY 
	IF((SELECT COUNT(IdFaktury) FROM tbl_faktura WHERE IdFaktury = @id_faktury) = 1)
	BEGIN
		DELETE FROM tbl_faktura WHERE IdFaktury = @id_faktury
		PRINT('Pomyœlnie usuniêto rekord w tabeli.')
	END
	ELSE
	BEGIN
		PRINT('Upewnij siê czy poda³eœ dobry ID')
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
CREATE OR ALTER PROCEDURE up_mod_klient
@id_klienta int,
@imie varchar(50),
@nazwisko varchar(50),
@adres varchar(60),
@miejscowsc varchar(60),
@kod_pocztowy varchar(6),
@id_wojewodztwa int,
@id_kraj int,
@telefon varchar(15),
@email varchar(40),
@data_urodzenia date,
@id_plec int
AS
BEGIN TRY
DECLARE @msg varchar(50)
	IF @imie IS NULL OR
	@nazwisko IS NULL OR
	@adres IS NULL OR
	@miejscowsc IS NULL OR
	@kod_pocztowy IS NULL OR
	@id_wojewodztwa IS NULL OR
	@id_kraj IS NULL OR
	@telefon IS NULL OR
	@data_urodzenia IS NULL OR
	@id_plec IS NULL 
	BEGIN 
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœci null'
	RAISERROR(21,@msg,1)
	END
	IF((SELECT COUNT(IdKlienta) FROM tbl_klient WHERE IdKlienta = @id_klienta)=1)
		BEGIN
		UPDATE tbl_klient
		SET
		Imie = @imie,
		Nazwisko = @nazwisko,
		Adres = @adres,
		Miejscowosc = @miejscowsc,
		KodPocztowy = @kod_pocztowy,
		IdWojewodztwa = @id_wojewodztwa,
		IdKraju = @id_kraj,
		Telefon = @telefon,
		Email = @email,
		DataUrodzenia = @data_urodzenia,
		IdPlci = @id_plec
		WHERE
		IdKlienta = @id_klienta
		PRINT('Pomyœlnie zmodyfikowano rekord')
		END
	ELSE
		BEGIN
		PRINT('W bazie nie ma klienta o podanym ID')
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

CREATE OR ALTER PROCEDURE up_mod_samochod
@id_samochodu int,
@rejestracja varchar(15),
@id_model int,
@id_marka int,
@id_rodzaj_nadwozia int,
@id_silnik int,
@id_rodzaj_samochodu int,
@kolor varchar(30),
@przebieg int,
@rocznik int,
@vin varchar(17)
AS
BEGIN TRY
	DECLARE @msg varchar(50)
	IF @rejestracja IS NULL OR
	@id_model IS NULL OR
	@id_marka IS NULL OR
	@id_rodzaj_nadwozia IS NULL OR
	@id_silnik IS NULL OR
	@id_rodzaj_samochodu IS NULL OR
	@kolor IS NULL OR
	@przebieg IS NULL OR
	@rocznik IS NULL OR
	@vin IS NULL 
	BEGIN
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœci NULL'
	END
	ELSE
		IF((SELECT COUNT(IdSamochodu) FROM tbl_samochod WHERE IdSamochodu = @id_samochodu) = 1)
			BEGIN
			UPDATE tbl_samochod 
			SET
			Rejestracja = @rejestracja,
			IdModelu = @id_model,
			IdMarki = @id_marka,
			IdRodzajuNadwozia = @id_rodzaj_nadwozia,
			IdSilnika = @id_silnik,
			IdRodzajuSamochodu = @id_rodzaj_samochodu,
			Kolor = @kolor,
			Przebieg = @przebieg,
			Rocznik = @rocznik,
			VIN = @vin
			WHERE IdSamochodu = @id_samochodu
			PRINT('Pomyœlnie zmodyfikowano rekord w tabeli')
			END
		ELSE
			BEGIN
			PRINT('W bazie nie ma samochodu o podanym ID!')
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

CREATE OR ALTER PROCEDURE up_mod_cena_za_wypozyczenie
@id_rodzaj_samochodu int,
@cena money
AS
BEGIN TRY
	DECLARE @msg varchar(100)
	IF @id_rodzaj_samochodu IS NULL OR
		@cena IS NULL
	BEGIN
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœci NULL'
	RAISERROR(@msg,16,1)
	END
	ELSE
		IF((SELECT COUNT(IdRodzajuSamochodu) FROM dict.tbl_rodzaj_samochodu WHERE IdRodzajuSamochodu = @id_rodzaj_samochodu)=1)
		BEGIN
			UPDATE dict.tbl_rodzaj_samochodu
			SET
			Cena = @cena
			WHERE IdRodzajuSamochodu = @id_rodzaj_samochodu
			PRINT('Pomyœlnie zaktualizowano cene za dobe')
		END
		ELSE
		BEGIN
			PRINT('Upewnij siê czy poda³eœ odpowieni ID!')
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

CREATE SEQUENCE seq_new_id_przeglad_samochod
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE OR ALTER PROCEDURE up_dodaj_przeglad_samochodu
@data_zrobienia_przegladu date,
@data_waznosci_przegladu date,
@uwagi varchar(60),
@miejsce_przegladu varchar(30),
@cena money,
@id_samochodu int
AS
BEGIN TRY
	DECLARE @msg varchar(100)
	IF @data_zrobienia_przegladu IS NULL OR
		@data_waznosci_przegladu IS NULL OR
		@miejsce_przegladu IS NULL OR
		@cena IS NULL OR
		@id_samochodu IS NULL
	BEGIN
		SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœæ NULL'
		RAISERROR(16,@msg,1)
	END
	ELSE
		BEGIN
		IF((SELECT COUNT(IdSamochodu) FROM tbl_samochod WHERE IdSamochodu = IdSamochodu)=1)
			BEGIN
			INSERT INTO tbl_przeglad_samochodu(IdPrzegladu,DataZrobieniaPrzegladu,DataWaznosciPrzegladu,Uwagi,MiejsceWykonaniaPrzegladu,Cena,IdSamochodu)
			VALUES(NEXT VALUE FOR seq_new_id_przeglad_samochod,@data_zrobienia_przegladu,@data_waznosci_przegladu,@uwagi,@miejsce_przegladu,@cena,@id_samochodu)
			PRINT('Pomyœlnie dodano rekord do tabeli')
			END
		ELSE
			BEGIN
			PRINT('W bazie nie ma samochodu o podanym ID!')
			END
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


CREATE SEQUENCE seq_new_id_naprawy_samochod
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE OR ALTER PROCEDURE up_dodaj_naprawe_samochodu
@opis_naprawy varchar(50),
@data_naprawy date,
@cena money,
@id_samochodu int
AS
BEGIN TRY
	DECLARE @msg varchar(100)
	IF @opis_naprawy IS NULL OR
		@data_naprawy IS NULL OR
		@cena IS NULL OR
		@id_samochodu IS NULL
	BEGIN
		SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœæ NULL'
		RAISERROR(16,@msg,1)
	END
	ELSE
		BEGIN
		IF((SELECT COUNT(IdSamochodu) FROM tbl_samochod WHERE IdSamochodu = IdSamochodu)=1)
			BEGIN
			INSERT INTO tbl_spis_napraw(IdNaprawy,OpisNaprawy,DataNaprawy,Cena,IdSamochodu)
			VALUES(NEXT VALUE FOR seq_new_id_naprawy_samochod,@opis_naprawy,@data_naprawy,@cena,@id_samochodu)
			PRINT('Pomyœlnie dodano rekord do tabeli')
			END
		ELSE
			BEGIN
			PRINT('W bazie nie ma samochodu o podanym ID!')
			END
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

CREATE SEQUENCE seq_new_id_ubezpieczenie
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE OR ALTER PROCEDURE up_dodaj_ubezpieczenie
@id_samochodu int,
@nr_polisy varchar(16),
@data_rozp_ubezpieczenia date,
@data_zakon_ubezpieczenia date,
@firma_ubezpieczeniowa varchar(50),
@cena money
AS
BEGIN TRY
	DECLARE @msg varchar(100)
	IF @id_samochodu IS NULL OR
		@nr_polisy IS NULL OR
		@data_rozp_ubezpieczenia IS NULL OR
		@data_zakon_ubezpieczenia IS NULL OR
		@firma_ubezpieczeniowa IS NULL OR
		@cena IS NULL 
	BEGIN
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœæ NULL'
		RAISERROR(16,@msg,1)
	END
	ELSE
		BEGIN
		IF((SELECT COUNT(IdSamochodu) FROM tbl_samochod WHERE IdSamochodu = @id_samochodu)=1)
			BEGIN
			INSERT INTO tbl_ubezpieczenie(IdUbezpieczenia,IdSamochodu,NumerPolisy,DataRozpoczeciaUbezpieczenia,DataZakonczeniaUbezpieczenia,FirmaUbezpieczeniowa,Cena)
			VALUES(NEXT VALUE FOR seq_new_id_ubezpieczenie,@id_samochodu,@nr_polisy,@data_rozp_ubezpieczenia,@data_zakon_ubezpieczenia,@firma_ubezpieczeniowa,@cena)
			PRINT('Pomyœlnie dodano rekord do tabeli')
			END
		ELSE
			BEGIN
			PRINT('W bazie nie ma samochodu o podanym ID!')
			END
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

CREATE SEQUENCE seq_new_id_ubezpieczenie
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE OR ALTER PROCEDURE up_mod_ubezpieczenie
@id_ubezpieczenia int,
@id_samochodu int,
@nr_polisy varchar(16),
@data_rozp_ubezpieczenia date,
@data_zakon_ubezpieczenia date,
@firma_ubezpieczeniowa varchar(50),
@cena money
AS
BEGIN TRY
	DECLARE @msg varchar(100)
	IF  @id_ubezpieczenia IS NULL OR
		@id_samochodu IS NULL OR
		@nr_polisy IS NULL OR
		@data_rozp_ubezpieczenia IS NULL OR
		@data_zakon_ubezpieczenia IS NULL OR
		@firma_ubezpieczeniowa IS NULL OR
		@cena IS NULL 
	BEGIN
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœæ NULL'
		RAISERROR(16,@msg,1)
	END
	ELSE
		BEGIN
		IF((SELECT COUNT(IdUbezpieczenia) FROM tbl_ubezpieczenie WHERE IdUbezpieczenia=@id_ubezpieczenia)=1)
			BEGIN
			IF((SELECT COUNT(IdSamochodu) FROM tbl_samochod WHERE IdSamochodu = @id_samochodu)=1)
				BEGIN
				UPDATE tbl_ubezpieczenie 
				SET
				IdUbezpieczenia = @id_ubezpieczenia,
				IdSamochodu = @id_samochodu,
				NumerPolisy = @nr_polisy,
				DataRozpoczeciaUbezpieczenia = @data_rozp_ubezpieczenia,
				DataZakonczeniaUbezpieczenia = @data_zakon_ubezpieczenia,
				FirmaUbezpieczeniowa = @firma_ubezpieczeniowa,
				Cena = @cena
				WHERE IdUbezpieczenia = @id_ubezpieczenia
				PRINT('Pomyœlnie zmodyfikowano rekord w tabeli')
				END
			ELSE
				BEGIN
				PRINT('W bazie nie ma samochodu o podanym ID!')
				END
			END
			ELSE
				BEGIN
				PRINT('W bazie nie ma ubezpieczenia o podanym ID!')
				END
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



CREATE OR ALTER PROCEDURE up_usun_ubezpieczenie
@id_ubezpieczenia int
AS
BEGIN TRY
	DECLARE @msg varchar(100)
	IF  @id_ubezpieczenia IS NULL
	BEGIN
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœæ NULL'
		RAISERROR(16,@msg,1)
	END
	ELSE
		BEGIN
		IF((SELECT COUNT(IdUbezpieczenia) FROM tbl_ubezpieczenie WHERE IdUbezpieczenia=@id_ubezpieczenia)=1)
			BEGIN
			DELETE FROM tbl_ubezpieczenie WHERE IdUbezpieczenia = @id_ubezpieczenia
			PRINT('Pomyœlnie usuniêto rekord z bazy')
			END
			ELSE
				BEGIN
				PRINT('W bazie nie ma ubezpieczenia o podanym ID!')
				END
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



CREATE OR ALTER PROCEDURE up_usun_ubezpieczenie
@id_ubezpieczenia int
AS
BEGIN TRY
	DECLARE @msg varchar(100)
	IF  @id_ubezpieczenia IS NULL
	BEGIN
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœæ NULL'
		RAISERROR(16,@msg,1)
	END
	ELSE
		BEGIN
		IF((SELECT COUNT(IdUbezpieczenia) FROM tbl_ubezpieczenie WHERE IdUbezpieczenia=@id_ubezpieczenia)=1)
			BEGIN
			DELETE FROM tbl_ubezpieczenie WHERE IdUbezpieczenia = @id_ubezpieczenia
			PRINT('Pomyœlnie usuniêto rekord z bazy')
			END
			ELSE
				BEGIN
				PRINT('W bazie nie ma ubezpieczenia o podanym ID!')
				END
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


CREATE SEQUENCE seq_new_id_platnosci
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE OR ALTER PROCEDURE up_dodaj_platnosc
@zaplata money,
@id_faktury int,
@id_forma_platnosci int
AS
BEGIN TRY
	DECLARE @msg varchar(100)
	IF @zaplata IS NULL OR
		@id_faktury IS NULL OR
		@id_forma_platnosci IS NULL
	BEGIN
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœæ NULL'
		RAISERROR(16,@msg,1)
	END
	ELSE
		BEGIN
		IF((SELECT COUNT(IdFaktury) FROM tbl_faktura WHERE IdFaktury=@id_faktury)=1)
			BEGIN
			INSERT INTO tbl_platnosc(IdPlatnosci,Zaplata,IdFaktury,IdFormaPlatnosci)
			VALUES(NEXT VALUE FOR seq_new_id_platnosci,@zaplata,@id_faktury,@id_forma_platnosci)
			PRINT('Pomyœlnie dodano rekord')
			END
			ELSE
				BEGIN
				PRINT('W bazie nie ma faktury o podanym ID!')
				END
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


CREATE SEQUENCE seq_new_id_pozycji_faktury
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

CREATE OR ALTER PROCEDURE up_dodaj_pozycje_do_faktury
@id_faktury int,
@id_samochodu int,
@id_rodzaj_samochodu int,
@ilosc int,
@cena money,
@nr_pozycji_na_fakturze int
AS
BEGIN TRY
	DECLARE @msg varchar(100)
	IF @id_faktury IS NULL OR
		@id_samochodu IS NULL OR
		@id_rodzaj_samochodu IS NULL OR
		@ilosc IS NULL OR
		@cena IS NULL OR
		@nr_pozycji_na_fakturze IS NULL
	BEGIN
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœæ NULL'
		RAISERROR(16,@msg,1)
	END
	ELSE
		BEGIN
		IF((SELECT COUNT(IdFaktury) FROM tbl_faktura WHERE IdFaktury=@id_faktury)=1)
			BEGIN
				IF((SELECT COUNT(IdSamochodu) FROM tbl_samochod WHERE IdSamochodu=@id_samochodu)=1)
					BEGIN
						INSERT INTO tbl_pozycje_faktury(IdPozycjiFaktury,IdFaktury,IdSamochodu,IdRodzajSamochodu,Ilosc,Cena,NrPozycjiNaFakturze)
						VALUES(NEXT VALUE FOR seq_new_id_pozycji_faktury,@id_faktury,@id_samochodu,@id_rodzaj_samochodu,@ilosc,@cena,@nr_pozycji_na_fakturze)
						PRINT('Pomyœlnie dodano rekord')
					END
				ELSE
				BEGIN
					PRINT('W bazie nie ma samochodu o podanym ID!')
				END
			END
		ELSE
			BEGIN
				PRINT('W bazie nie ma faktury o podanym ID!')
			END
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
go
CREATE OR ALTER PROCEDURE up_mod_rezerwacja
@id_rezerwacji int,
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
	IF ((SELECT COUNT(IdRezerwacji) FROM tbl_rezerwacja WHERE IdRezerwacji = @id_rezerwacji)=1)
	BEGIN
		IF((SELECT COUNT(IdWypozyczenia) FROM tbl_wypozyczenie WHERE IdWypozyczenia = @id_wypozyczenia)=1)
		BEGIN
			IF((SELECT COUNT(IdSamochodu) FROM tbl_samochod WHERE IdSamochodu = @id_samochodu)=1)
			BEGIN
			UPDATE tbl_rezerwacja
			SET
			IdWypozyczenia = @id_wypozyczenia,
			IdSamochodu = @id_samochodu,
			CenaZaDobe = dbo.uf_getCar(@id_samochodu),
			DataRezerwacji = dbo.uf_getDataWypozyczenia(@id_wypozyczenia),
			DataKoncaRezerwacji = dbo.uf_getDataZwrotu(@id_wypozyczenia),
			DataUtworzeniaRezerwacji = @data_utworzenia_rezerwacji,
			LacznaKwotaDoZaplaty = dbo.uf_czyZwrocicKaucje(@id_wypozyczenia)+CONVERT(money,dbo.uf_getCar(@id_samochodu)*DATEDIFF(day,dbo.uf_getDataWypozyczenia(@id_wypozyczenia),dbo.uf_getDataZwrotu(@id_wypozyczenia)))
			PRINT('Pomyœlnie zmodyfikowano rekord')
			END
			ELSE
			BEGIN
			PRINT('W bazie nie ma samochodu o podanym ID!')
			END
		END
		ELSE
		BEGIN
		PRINT('W bazie nie ma wypo¿yczenia o podanym ID!')
		END
	END
	ELSE
	BEGIN
	PRINT('W bazie nie ma rezerwacji o podanym ID')
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


CREATE OR ALTER PROCEDURE up_mod_wypozyczenie
@id_wypozyczenia int,
@data_wypozyczenia date,
@data_zwrotu date,
@stan_techniczny varchar(100)
AS
BEGIN TRY
	DECLARE @msg varchar(70)
	IF @id_wypozyczenia IS NULL OR
	@data_wypozyczenia IS NULL OR
	@data_zwrotu IS NULL OR
	@stan_techniczny IS NULL
	BEGIN
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœæ NULL'
		RAISERROR(16,@msg,1)
	END
	ELSE
	BEGIN
		IF((SELECT COUNT(IdWypozyczenia) FROM tbl_wypozyczenie WHERE IdWypozyczenia = @id_wypozyczenia)=1)
		BEGIN
			UPDATE tbl_wypozyczenie
			SET
			DataWypozyczenia = @data_wypozyczenia,
			DataZwrotu = @data_zwrotu,
			StanTechniczny = @stan_techniczny
			WHERE IdWypozyczenia = @id_wypozyczenia
		END
		ELSE
		BEGIN
			PRINT('W bazie nie ma wypo¿yczenia o podanym ID!')
		END
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


