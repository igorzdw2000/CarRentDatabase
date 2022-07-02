--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- usp_GetErrorInfo
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Wyœwietla dok³adne informacje na temat przechwyconego b³êdu
---
--- Parametry wejœciowe : brak
---
--- Parametry wyjœciowe : wypisanie na konsole informacji na temat b³êdu
---
--------------------------------------------------------------------------------
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
CREATE SEQUENCE seq_new_id_klient
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_dodaj_klienta(@imie varchar(30),@nazwisko varchar(50),@adres varchar(60),@kod_pocztowy(6),@id_wojewodztwa int,@id_kraju int,@telefon varchar(15), @email varchar(40), @data_urodzenia date, @id_plec int 
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_klient
--- Dodaje nowego klienta do bazy
---
--- Parametry wejœciowe : 
---	imie klienta, jest to varchar
---	nazwisko, jest to varchar
--- adres, jest to varchar
--- kod pocztowy, jest to varchar
--- id województwa, jest to int
--- id kraju, jest to int
--- telefon, jest to varchar
--- email, jest to varchar
--- data urodzenia, jest to date
--- id p³ci, jest to int
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
CREATE PROCEDURE up_dodaj_klienta @imie varchar(30),
@nazwisko varchar(50),
@adres varchar(60),
@miejscowsc varchar(60),
@kod_pocztowy varchar(6),
@id_wojewodztwa int,
@id_kraju int,
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
	@id_kraju IS NULL OR
	@telefon IS NULL OR
	@data_urodzenia IS NULL OR
	@id_plec IS NULL 
	BEGIN 
	SET @msg = 'Kolumny nie mog¹ przyjmowaæ wartoœci null'
	RAISERROR(21,@msg,1)
	END
	BEGIN
	INSERT INTO tbl_klient(IdKlienta,Imie,Nazwisko,Adres,Miejscowosc,KodPocztowy,IdWojewodztwa,IdKraju,Telefon,Email,DataUrodzenia,IdPlci)
	VALUES(NEXT VALUE FOR seq_new_id_klient,@imie,@nazwisko,@adres,@miejscowsc,@kod_pocztowy,@id_wojewodztwa,@id_kraju,@telefon,@email,@data_urodzenia,@id_plec);
	PRINT('Dodano nowego klienta')
	END
END TRY
BEGIN CATCH
	EXECUTE usp_GetErrorInfo 
END CATCH
GO
CREATE SEQUENCE seq_new_id_samochod
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_dodaj_auto(@rejestracja varchar(15),@id_model int,@id_marka int,@id_rodzaj_nadwozia int,@id_silnik int,@id_rodzaj_samochodu int,@kolor varchar(15), @email varchar(30), @przebieg int, @rocznik int,@vin varchar(17) 
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_samochod
--- Dodaje nowy samochód do bazy
---
--- Parametry wejœciowe : 
---	rejestracja samochodu, jest to varchar
---	id modelu, jest to varchar
--- id marki, jest to varchar
--- id rodzaju nadwozia, jest to varchar
--- id silnika, jest to int
--- id rodzaju nadwozia, jest to int
--- kolor samochodu, jest to varchar
--- przebieg samochodu, jest to varchar
--- rocznik, jest to date
--- vin, jest to varchar
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
CREATE PROCEDURE up_dodaj_auto
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
	RAISERROR(21,@msg,1)
	END
	ELSE
	BEGIN
	INSERT INTO tbl_samochod(IdSamochodu,Rejestracja,IdModelu,IdMarki,IdRodzajuNadwozia,IdSilnika,IdRodzajuSamochodu,Kolor,Przebieg,Rocznik,VIN)
	VALUES(NEXT VALUE FOR seq_new_id_samochod,@rejestracja,@id_model,@id_marka,@id_rodzaj_nadwozia,@id_silnik,@id_rodzaj_samochodu,@kolor,@przebieg,@rocznik,@vin)
	PRINT('Pomyœlnie dodano nowy samochód do bazy')
	END
END TRY
BEGIN CATCH
	EXECUTE usp_GetErrorInfo 
END CATCH

GO

	
--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_dodaj_rezerwacje(@id_wypozyczenia int, @id_samochodu int,@data_utworzenia_rezerwacji date) 
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_rezerwacja
--- Rejestracja nowej rezerwacji
---
--- Parametry wejœciowe : 
---	@id_wypozyczenia, typ int
---	@id_samochodu - numer identyfikacyjny samochodu, którego tyczy siê rezerwacja, typ varchar
--- @data_utworzenia_rezerwacji - data z³o¿enia przez klienta rezerwacji, typ date
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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
	VALUES(NEXT VALUE FOR seq_new_id_rezerwacja,@id_wypozyczenia,@id_samochodu,dbo.uf_getCar(@id_samochodu),1000,dbo.uf_getDataWypozyczenia(@id_wypozyczenia),dbo.uf_getDataZwrotu(@id_wypozyczenia),@data_utworzenia_rezerwacji,(dbo.uf_czyZwrocicKaucje(@id_wypozyczenia)+CONVERT(money,dbo.uf_getCar(@id_samochodu)*DATEDIFF(day,dbo.uf_getDataWypozyczenia(@id_wypozyczenia),dbo.uf_getDataZwrotu(@id_wypozyczenia)))))
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

--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_dodaj_wypozyczenie(@data_wypozyczenia date, @data_zwrotu date,@stan_techniczny varchar(100)) 
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_wypozyczenie
--- Rejestracja nowego wypo¿yczenia
---
--- Parametry wejœciowe : 
---	@data_wypozyczenia - data wypo¿yczenia samochodu, typ date
---	@data_zwrotu - data zwrotu samochodu, typ date
--- @stan_techniczny - stan techniczny samochodu po zwrocie, typ date
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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
	VALUES(NEXT VALUE FOR seq_new_id_wypozyczenie,@data_wypozyczenia,@data_zwrotu,@stan_techniczny)
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

--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_dodaj_fakture(@tytul varchar(50),@wydawca varchar(30),@data_wystawienia date,@nip varchar(11),@nazwa_firmy varchar(50),@nr_konta_bankowego varchar(28),@id_rezerwacji int,@id_wypozyczenia int, @id_formy_faktury
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_faktury
--- Dodaje now¹ fakturê do bazy danych
---
--- Parametry wejœciowe : 
---	@tytul - tytu³ faktury, typ varchar
---	@wydawca - podmiot wystawiaj¹cy fakture, typ varchar
--- @data_wystawienia - data wystawienia faktury, typ date
--- @nip - NIP firmy/osoby na któr¹ wystawiana jest faktura , typ varchar
--- @nazwa_firmy - nazwa firmy, typ varchar
--- @nr_konta_bankowego - numer konta bankowego klienta, typ varchar
--- @id_rezerwacji - numer identyfikacyjny rezerwacji, typ int
--- @id_wypozyczenia - numer identyfikacyjny wypo¿yczenia, typ int
--- @id_formy faktury - numer identyfikacyjny formy faktury, typ int
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœæ wypisana na konsoli informuj¹ca o braku wypo¿yczenia o podanym numerze identyfikacyjnym
--- Wiadomoœæ wypisana na konsoli informuj¹ca o braku rezerwacji o podanym numerze identyfikacyjnym
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_mod_fakture(@id_faktury int,@tytul varchar(50),@wydawca varchar(30),@data_wystawienia date,@nip varchar(11),@nazwa_firmy varchar(50),@nr_konta_bankowego varchar(28),@id_rezerwacji int,@id_wypozyczenia int, @id_formy_faktury
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Modyfikuje rekord w tabeli tbl_faktura
--- Modyfikuje fakture o podanym numerze
---
--- Parametry wejœciowe :
--- @id faktury - numer identyfikacyjny faktury, która ma ulec modyfikacji, typ int
---	@tytul - tytu³ faktury, typ varchar
---	@wydawca - podmiot wystawiaj¹cy fakture, typ varchar
--- @data_wystawienia - data wystawienia faktury, typ date
--- @nip - NIP firmy/osoby na któr¹ wystawiana jest faktura , typ varchar
--- @nazwa_firmy - nazwa firmy, typ varchar
--- @nr_konta_bankowego - numer konta bankowego klienta, typ varchar
--- @id_rezerwacji - numer identyfikacyjny rezerwacji, typ int
--- @id_wypozyczenia - numer identyfikacyjny wypo¿yczenia, typ int
--- @id_formy faktury - numer identyfikacyjny formy faktury, typ int
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_usun_fakture(@id_faktury int)
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Usuwa rekord w tabeli tbl_faktura
--- Usuwa fakture o podanym numerze
---
--- Parametry wejœciowe :
--- @id faktury - numer identyfikacyjny faktury, która ma byæ usuniêta, typ int
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_mod_klient(@id_klienta int, @imie varchar(30),@nazwisko varchar(50),@adres varchar(60),@kod_pocztowy(6),@id_wojewodztwa int,@id_kraju int,@telefon varchar(15), @email varchar(40), @data_urodzenia date, @id_plec int 
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_klient
--- Dodaje nowego klienta do bazy
---
--- Parametry wejœciowe : 
--- @id_klienta - numer identyfikacyjny klienta
---	@imie - imie klienta, jest to varchar
---	@nazwisko - nazwisko klienta, jest to varchar
--- @adres - adres klienta, jest to varchar
--- @kod_pocztowy - kod pocztowy klienta, jest to varchar
--- @id_województwa - numer identyfikacyjny województwa z którego pochodzi klient, jest to int
--- @id_kraju - numer identyfikacyjny kraju z którego pochodzi klient, jest to int
--- @telefon - numer telefonu, jest to varchar
--- @email - adres email, jest to varchar
--- @data urodzenia - data urodzenia klienta, jest to date
--- @id_p³ci - p³eæ, jest to int
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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
	RAISERROR(@msg,16,1)
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

--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_mod_samochod(@id_samochodu int, @rejestracja varchar(15),@id_model int,@id_marka int,@id_rodzaj_nadwozia int,@id_silnik int,@id_rodzaj_samochodu int,@kolor varchar(15), @email varchar(30), @przebieg int, @rocznik int,@vin varchar(17) 
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_samochod
--- Dodaje nowy samochód do bazy
---
--- Parametry wejœciowe : 
---	@rejestracja - rejestracja samochodu, jest to varchar
---	@id_model - numer identyfikacyjny modelu, jest to int
--- @id_marka - numer identyfikacyjny marki, jest to int
--- @id_rodzaj_nadwozia - numer identyfikacyjny rodzaju nadwozia, jest to int
--- @id_silnik - numer identyfikacyjny rodzaju silnika, jest to int
--- @id_rodzaj_samochodu -  - numer identyfikacyjny rodzaju samochodu, jest to int
--- @kolor - kolor samochodu, jest to varchar
--- @przebieg - przebieg samochodu, jest to varchar
--- @rocznik - rocznik samochodu, jest to varchar
--- @vin - numer vin samochodu, jest to varchar
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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
	RAISERROR(@msg,16,1)
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
--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_mod_cena_za_wypozyczenie(@id_rodzaj_samochodu int, cena money)
--------------------------------------------------------------------------------
--- Modyfkikuje rekord w tabeli dict.tbl_rodzaj_samochodu
--- Zmienia cena danego typu samochodu
---
--- Parametry wejœciowe : 
--- @id_rodzaj_samochodu - numer identyfikacyjny rodzaju samochodu, jest to int
--- @cena - cena za dobe, typ money
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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

GO
--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_dodaj_przeglad_samochodu(@data_zrobienia_przegladu date, @data_waznosci_przegladu date, @uwagi varchar(60), @miejsce_przegladu varchar(30), @cena money, @id_samochodu int)
--- CREATED BY: Hubert Warcho³
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_przeglad_samochodu
--- Dodaje informacje na temat przegl¹du danego samochodu
---
--- Parametry wejœciowe : 
---	@data_zrobienia_przegladu - data wykonania przegl¹du, typ date
---	@data_waznosci - data wygaœniêcia przegl¹du, typ date
--- @uwagi - uwagi do przegl¹du, typ varchar
--- @miejsce_przegladu - miejsce wykonania przegl¹du, typ varchar
--- @cena - cena za przegl¹d, typ money
--- @id_samochodu - numer identyfikacyjny samochodu, którego tyczy siê przegl¹d, typ int
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœæ wypisana na konsoli informuj¹ca o braku samochodu o podanym numerze identyfikacyjnym
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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


--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_dodaj_naprawe_samochodu(@opis_naprawy varchar(50),@data_naprawy date, @cena money, @id_samochodu int)
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_spis_naprawa
--- Dodaje nowy wpis informuj¹cy o naprawie danego samochodu
---
--- Parametry wejœciowe : 
---	@opis_naprawy - krótki opis naprawy, typ varchar
---	@data_naprawy - data naprawy samochodu, typ date
--- @cena - cena naprawy, typ money
--- @id_samochodu - numer identyfikacyjny samochodu, którego tyczy siê naprawa , typ varchar
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœæ wypisana na konsoli informuj¹ca o braku samochodu o podanym numerze identyfikacyjnym
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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

GO
--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_dodaj_ubezpieczenie(@id_samochodu int, @nr_polisy varchar(16),@data_rozp_ubezpieczenia date, @data_zakon_ubezpieczenia date, @firma_ubezpieczeniowa varchar(50),@cena money) 
--- CREATED BY: Hubert Warcho³
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_ubezpieczenie
--- Dodanie nowego ubezpieczenia do bazy danych
---
--- Parametry wejœciowe : 
---	@id_samochodu - numer identyfikacyjny samochodu którego tyczy siê ubezpieczenie, typ int
---	@nr_polisy - nr polisy ubezpieczeniowej, typ int
--- @data_rozp_ubezpieczenia - data rozpoczêcia czasu trwania ubezpieczenia, typ date
--- @data_zakon_ubezpieczenia - data zakoñczenia trwania ubezpieczenia, typ date
--- @firma_ubepieczeniowa - nazwa firmy ubezpieczeniowej ,typ varchar
--- @cena - cena za ubezpieczenie, typ money
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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


GO
--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_mod_ubezpieczenie(@id_ubezpieczenia int,@id_samochodu int, @nr_polisy varchar(16),@data_rozp_ubezpieczenia date, @data_zakon_ubezpieczenia date, @firma_ubezpieczeniowa varchar(50),@cena money) 
--- CREATED BY: Hubert Warcho³
--------------------------------------------------------------------------------
--- Modyfikuje rekord w tabeli tbl_ubezpieczenie
--- Zmienia wybrane parametry danego ubezpieczenia
---
--- Parametry wejœciowe : 
--- @id_ubezpieczenia - numer identyfikacyjny ubezpieczenia, które ma byæ poddane modyfikacji
---	@id_samochodu - numer identyfikacyjny samochodu którego tyczy siê ubezpieczenie, typ int
---	@nr_polisy - nr polisy ubezpieczeniowej, typ int
--- @data_rozp_ubezpieczenia - data rozpoczêcia czasu trwania ubezpieczenia, typ date
--- @data_zakon_ubezpieczenia - data zakoñczenia trwania ubezpieczenia, typ date
--- @firma_ubepieczeniowa - nazwa firmy ubezpieczeniowej ,typ varchar
--- @cena - cena za ubezpieczenie, typ money
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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

GO
--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_usun_ubezpieczenie(@id_ubezpieczenia int) 
--- CREATED BY: Hubert Warcho³
--------------------------------------------------------------------------------
--- Usuwa rekord w tabeli tbl_ubezpieczenie
--- Usuwa dane ubezpieczenie
---
--- Parametry wejœciowe : 
--- @id_ubezpieczenia - numer identyfikacyjny ubezpieczenia, które ma byæ usuniête
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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

GO
CREATE SEQUENCE seq_new_id_platnosci
INCREMENT BY 11
START WITH 100
NO CYCLE
GO

--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_dodaj_platnosc(@zaplata money,@id_faktury int, @id_forma_platnosci int)
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_platnosc
--- Dodaje now¹ p³atnoœæ do bazy
---
--- Parametry wejœciowe : 
---	@zaplata - kwota do zap³aty, typ money
---	@id_faktury - numer identyfikacyjny faktury, typ int
--- @id_forma_platnosci - numer identyfikacyjny formy p³atnoœci, typ int
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœæ wypisana na konsoli informuj¹ca o braku faktury o podanym numerze identyfikacyjnym
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_dodaj_pozycje_do_faktury(@id_faktury int, @id_samochodu int, @id_rodzaj_samochodu int, @ilosc int, @cena money, @nr_pozycji_na_fakturze int)
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Dodaje rekord do tabeli tbl_pozycje_faktury
--- Dodaje now¹ pozycjê do faktury o danym numerze identyfikacyjnym
---
--- Parametry wejœciowe : 
---	@id_faktury - numer identyfikacyjny faktury, typ int
---	@id_samochodu - numer identyfikacyjny samochodu, typ int
--- @id_rodzaj_samochodu - numer identyfikacyjny rodzaju samochodu, typ int
--- @ilosc - iloœæ, typ int
--- @cena - cena do zap³aty za pozycje, typ money
--- @nr_pozycji_na_fakturze - numer pozycji na danej fakturze
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœæ wypisana na konsoli informuj¹ca o braku faktury o podanym numerze identyfikacyjnym
--- Wiadomoœæ wypisana na konsoli informuj¹ca o braku samochodu o podanym numerze identyfikacyjnym
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_mod_rezerwacja(@id_rezerwacji int,@id_wypozyczenia int, @id_samochodu int,@data_utworzenia_rezerwacji date) 
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Modyfikuje rekord w tabeli tbl_rezerwacja
--- Modyfikuje parametry danej rezerwacji
---
--- Parametry wejœciowe : 
--- @id_rezerwacji - numer identyfikacyjny rezerwacji, która ma byæ zmodyfikowana, typ int
---	@id_wypozyczenia, typ int
---	@id_samochodu - numer identyfikacyjny samochodu, którego tyczy siê rezerwacja, typ varchar
--- @data_utworzenia_rezerwacji - data z³o¿enia przez klienta rezerwacji, typ date
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
--- PROCEDURE DEFINITION
--- up_mod_wypozyczenie(@id_wypozyczenia int,@data_wypozyczenia date, @data_zwrotu date,@stan_techniczny varchar(100)) 
--- CREATED BY: Igor Owczarek
--------------------------------------------------------------------------------
--- Modyfikuje rekord w tabeli tbl_wypozyczenie
--- Modyfikuje parametry danego wypo¿yczenia
---
--- Parametry wejœciowe : 
--- @id_wypozyczenia - numer identyfikacyjny wypo¿yczenia, które ma byæ zmodyfikowane, typ int
---	@data_wypozyczenia - data wypo¿yczenia samochodu, typ date
---	@data_zwrotu - data zwrotu samochodu, typ date
--- @stan_techniczny - stan techniczny samochodu po zwrocie, typ date
---
--- Parametry wyjœciowe : 
--- Wiadomoœæ wypisana na konsoli informuj¹ca o poporawnym wykonaniu procedury
--- Wiadomoœc wypisana na konsoli informuj¹ca o b³êdnym wykonaniu procedury
--------------------------------------------------------------------------------
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


