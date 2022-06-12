--dodanie grupy plikowej DICTIONARIES
ALTER DATABASE wypozyczalnia_samochodow
ADD FILEGROUP DICTIONARIES;
GO
--dodanie pliku danych do nowej grupy plikowej
ALTER DATABASE wypozyczalnia_samochodow
ADD FILE
(	NAME = wypozyczalnia_samochodow_dat3,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\wypozyczalnia_samochodowdat3.ndf',
	SIZE = 100MB,
	MAXSIZE = 500MB,
	FILEGROWTH = 5MB
)
TO FILEGROUP DICTIONARIES;
GO

--tworzenie schematu u¿ytkownika
CREATE SCHEMA dict;
GO



