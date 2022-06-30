CREATE TRIGGER trgtbl_klient ON tbl_klient
FOR DELETE
AS SET NOCOUNT ON
BEGIN
	ROLLBACK TRANSACTION
	PRINT('Nie mo¿na usuwac klientów z bazy!')
END 
GO

CREATE TRIGGER trgtbl_klient_kod ON tbl_klient
FOR INSERT, UPDATE
AS
UPDATE tbl_klient
SET KodKlienta=(SELECT REPLICATE ('0',(4-(DATALENGTH(CONVERT(varchar(15),i.IdKlienta))))) + CONVERT(varchar(10),i.IdKlienta)+SUBSTRING(i.Nazwisko,1,3)+SUBSTRING(i.Imie,1,1) 
FROM tbl_klient k INNER JOIN inserted i ON i.IdKlienta = k.IdKlienta)
FROM tbl_klient k INNER JOIN inserted i ON i.IdKlienta = k.IdKlienta
GO

CREATE TRIGGER trgtbl_faktura ON tbl_faktura
FOR DELETE
AS SET NOCOUNT ON
BEGIN
	DECLARE @currentYear int = CONVERT(int, YEAR(GETDATE()))
	DECLARE @yearOfInvoice int = CONVERT(int, YEAR((SELECT DataWystawienia FROM deleted)))

	IF(@yearOfInvoice = @currentYear)
	BEGIN
		PRINT('Nie mo¿na usun¹æ rezerwacji')
		ROLLBACK TRANSACTION
	END
	ELSE
		PRINT('Pomyœlnie usuniêto rezerwacjê z bazy')
END
GO

CREATE TRIGGER trgdb_tworzenie_tbl
ON DATABASE    
AFTER CREATE_TABLE 
AS 
BEGIN 
	PRINT 'Tabela zosta³a utworzona!' 
END 
GO

CREATE TRIGGER trgsrv_tworzenie_bd  
ON ALL SERVER 
AFTER CREATE_DATABASE 
AS 
BEGIN 
PRINT 'Stworzono baze danych' 
END 
GO

CREATE TRIGGER trgdb_drop_i_alter  
ON DATABASE    
FOR DROP_TABLE, ALTER_TABLE    
AS    
BEGIN 
   PRINT 'Nie mo¿na wykonaæ zapytañ DROP i ALTER'    
   ROLLBACK; 
END 
GO

CREATE TRIGGER trgtbl_wojewodztwa ON dict.tbl_wojewodztwo
FOR INSERT
AS
DECLARE @ile int
SET @ile=(SELECT COUNT(*) FROM dict.tbl_wojewodztwo)
IF @ile>16
	BEGIN
		RAISERROR ('Nie mo¿esz dodaæ kolejnego województwa',10,1)
		ROLLBACK TRANSACTION
	END
GO

