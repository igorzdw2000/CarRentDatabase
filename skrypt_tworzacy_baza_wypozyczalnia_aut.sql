--skrypt tworz¹cy bazê danych
USE master
GO

CREATE DATABASE wypozyczalnia_samochodow
ON
PRIMARY
(	NAME = wypozyczalnia_samochodow_dat1,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\wypozyczalnia_samochodowdat1.mdf',
	SIZE = 100MB,
	MAXSIZE = 1000MB,
	FILEGROWTH = 10MB
),
(	NAME = wypozyczalnia_samochodow_dat2,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\wypozyczalnia_samochodowdat2.mdf',
	SIZE = 100MB,
	MAXSIZE = 1000MB,
	FILEGROWTH = 10MB
)
LOG ON
(	NAME = wypozyczalnia_samochodow_log1,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\wypozyczalnia_samochodowlog1_ldf',
	SIZE = 50MB,
	MAXSIZE = 100MB,
	FILEGROWTH = 10%
);