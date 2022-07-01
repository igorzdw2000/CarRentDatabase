CREATE RULE rl_kod_pocztowy as @kodPocztowy
LIKE '[0-9][0-9]-[0-9][0-9][0-9]';
GO
EXEC sp_bindrule rl_kod_pocztowy, 'tbl_klient.KodPocztowy';
GO

CREATE RULE rl_email as @email 
LIKE '%[A-Z0-9][@][A-Z0-9]%[.][A-Z0-9]%' OR @email LIKE NULL;
GO
EXEC sp_bindrule rl_email, 'tbl_klient.Email'
GO

CREATE RULE rl_data_urodzenia AS
(@dataUrodzenia < CAST(GETDATE() AS DATE));
GO
EXEC sp_bindrule rl_data_urodzenia, 'tbl_klient.DataUrodzenia'
GO

CREATE RULE rl_data_wystawienia_fk AS
(@dataWystawieniaFk <= CAST(GETDATE() AS DATE));
GO
EXEC sp_bindrule rl_data_wystawienia_fk, 'tbl_faktura.DataWystawienia'
GO

CREATE RULE rl_data_utworzenia_rezerwacji AS
(@dataUtwRezerwacji <= CAST(GETDATE() AS DATE));
GO
EXEC sp_bindrule rl_data_utworzenia_rezerwacji, 'tbl_rezerwacja.DataUtworzeniaRezerwacji'
GO

CREATE RULE rl_data_rezerwacji AS
(@dataRezerwacji <= CAST(GETDATE() AS DATE));
GO
EXEC sp_bindrule rl_data_rezerwacji, 'tbl_rezerwacja.DataRezerwacji'
GO


