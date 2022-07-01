CREATE DEFAULT df_data_wystawienia
AS CAST(GETDATE() AS DATE)
GO
EXEC sp_bindefault df_data_wystawienia, 'tbl_faktura.DataWystawienia';
GO

CREATE DEFAULT df_data_rezerwacji
AS GETDATE()
GO
EXEC sp_bindefault df_data_rezerwacji, 'tbl_rezerwacja.DataRezerwacji'
GO

CREATE DEFAULT df_data_utworzenia_rezerwacji
AS GETDATE();
GO
EXEC sp_bindefault df_data_rezerwacji, 'tbl_rezerwacja.DataUtworzeniaRezerwacji'
GO

CREATE DEFAULT df_data_wypozyczenia
AS GETDATE()
GO
EXEC sp_bindefault df_data_wypozyczenia, 'tbl_wypozyczenie.DataWypozyczenia'
GO

CREATE DEFAULT df_telefon
AS '+000-000-000-00'
GO
EXEC sp_bindefault df_telefon, 'tbl_klient.Telefon'
GO

CREATE DEFAULT df_email
AS 'default.mail@default.com'
GO
EXEC sp_bindefault df_email, 'tbl_klient.Email'
GO
