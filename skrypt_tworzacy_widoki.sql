CREATE VIEW vw_wszyscy_klienci AS
SELECT * FROM dbo.tbl_klient;

CREATE VIEW vw_klienci_z_wojewodztwami_i_krajami AS
SELECT IdKlienta, Imie, Nazwisko, Adres, Miejscowosc, w.Wojewodztwo, p.Kraj, pl.Plec FROM dbo.tbl_klient k 
INNER JOIN dict.tbl_wojewodztwo w ON w.IdWojewodztwa = k.IdWojewodztwa 
INNER JOIN dict.tbl_kraj p ON p.IdKraju = k.IdKraju
INNER JOIN dict.tbl_plec pl ON pl.IdPlci = k.IdPlci
WITH CHECK OPTION;

CREATE VIEW vw_klienci_z_polski AS
SELECT IdKlienta, Imie, Nazwisko, Adres, Miejscowosc, kraj.Kraj FROM dbo.tbl_klient klient INNER JOIN dict.tbl_kraj kraj ON kraj.IdKraju = klient.IdKraju WHERE kraj.Kraj = 'Polska';

CREATE VIEW vw_marki AS
SELECT * FROM dict.tbl_marka;

CREATE VIEW vw_modele AS 
SELECT * FROM dict.tbl_model;

CREATE VIEW vw_rezerwacje_wszystkie AS
SELECT * FROM dbo.tbl_rezerwacja;

CREATE VIEW vw_rezerwacje_z_obecnego_miesiaca AS
SELECT * FROM dbo.tbl_rezerwacja WHERE MONTH(DataRezerwacji) = MONTH(GETDATE());

CREATE VIEW vw_rezerwacje_z_obecnego_roku AS
SELECT * FROM dbo.tbl_rezerwacja WHERE YEAR(DataRezerwacji) = YEAR(GETDATE());

CREATE VIEW vw_rezerwacje_z_zesz³ego_roku AS
SELECT * FROM dbo.tbl_rezerwacja WHERE YEAR(DataRezerwacji) < YEAR(GETDATE());

CREATE VIEW vw_samochody_wszystkie AS
SELECT * FROM tbl_samochod;

CREATE VIEW vw_samochody_benzynowe AS
SELECT * FROM tbl_samochod samochod INNER JOIN dict.tbl_silnik silnik ON samochod.IdSilnika = silnik.IdSilnika WHERE silnik.TypSilnika = 'benzynowy';

CREATE VIEW vw_samochody_z_dieslem AS
SELECT IdSamochodu, IdMarki, silnik.TypSilnika FROM tbl_samochod samochod INNER JOIN dict.tbl_silnik silnik ON samochod.IdSilnika = silnik.IdSilnika WHERE silnik.TypSilnika = 'diesel';

CREATE VIEW vw_samochody_elektryczne AS
SELECT IdSamochodu, IdMarki, silnik.TypSilnika FROM tbl_samochod samochod INNER JOIN dict.tbl_silnik silnik ON samochod.IdSilnika = silnik.IdSilnika WHERE silnik.TypSilnika = 'elektryczny';

CREATE VIEW vw_samochody_hybrydowe AS
SELECT IdSamochodu, IdMarki, silnik.TypSilnika FROM tbl_samochod samochod INNER JOIN dict.tbl_silnik silnik ON samochod.IdSilnika = silnik.IdSilnika WHERE silnik.TypSilnika = 'hybrydowy';

CREATE VIEW vw_samochody_kombi AS 
SELECT IdSamochodu, IdMarki, nadwozie.RodzajNadwozia FROM tbl_samochod samochod INNER JOIN dict.tbl_rodzaj_nadwozia nadwozie ON samochod.IdRodzajuNadwozia = nadwozie.IdRodzajuNadwozia WHERE nadwozie.RodzajNadwozia = 'kombi';

CREATE VIEW vw_samochody_sedan AS
SELECT IdSamochodu, IdMarki, nadwozie.RodzajNadwozia FROM tbl_samochod samochod INNER JOIN dict.tbl_rodzaj_nadwozia nadwozie ON samochod.IdRodzajuNadwozia = nadwozie.IdRodzajuNadwozia WHERE nadwozie.RodzajNadwozia = 'sedan';

CREATE VIEW vw_samochody_hatchback AS
SELECT IdSamochodu, IdMarki, nadwozie.RodzajNadwozia FROM tbl_samochod samochod INNER JOIN dict.tbl_rodzaj_nadwozia nadwozie ON samochod.IdRodzajuNadwozia = nadwozie.IdRodzajuNadwozia WHERE nadwozie.RodzajNadwozia = 'hatchback';
GO
CREATE VIEW vw_liczba_samochodow_by_rodzaj_silnika AS
SELECT sil.TypSilnika,COUNT(s.IdSilnika) AS 'liczba_samochodów' FROM tbl_samochod s INNER JOIN dict.tbl_silnik sil ON s.IdSilnika = sil.IdSilnika
GROUP BY sil.TypSilnika, s.IdSilnika;
GO

CREATE VIEW vw_faktura AS
SELECT DISTINCT faktura.IdFaktury,faktura.Tytyl,faktura.DataWystawienia, faktura.Wydawca AS 'Wydawca faktury',
tbl_klient.Imie+' '+tbl_klient.Nazwisko AS 'Imie i nazwisko klienta',
tbl_klient.Adres AS 'Adres',
tbl_klient.KodPocztowy AS 'Kod pocztowy klienta',
tbl_klient.Miejscowosc AS 'Miejscowoœæ klienta',
rezerwacja.DataRezerwacji AS 'Data rozpoczêcia rezerwacji',
rezerwacja.DataKoncaRezerwacji AS 'Data koñca rezerwacji',
forma.FormaFaktury AS 'Forma faktury',
(SELECT Ilosc FROM tbl_pozycje_faktury WHERE IdFaktury = faktura.IdFaktury) AS 'Iloœæ',
(SELECT SUM(Cena) AS 'Wartoœæ faktury' FROM tbl_pozycje_faktury WHERE IdFaktury=faktura.IdFaktury GROUP BY Cena) AS 'Wartoœæ faktury',
fp.FormaPlatnosci AS 'Forma p³atnoœci'
FROM tbl_faktura faktura
INNER JOIN tbl_rezerwacja rezerwacja ON rezerwacja.IdRezerwacji = faktura.IdFaktury
INNER JOIN tbl_rezerwacja_klient rk ON rezerwacja.IdRezerwacji = rk.IdRezerwacji
INNER JOIN tbl_klient ON rk.IdKlienta = tbl_klient.IdKlienta
INNER JOIN tbl_pozycje_faktury ON faktura.IdFaktury = faktura.IdFaktury
INNER JOIN dict.tbl_forma_faktury forma ON faktura.IdFormyFaktury = forma.IdFormyFaktury
INNER JOIN tbl_platnosc p ON p.IdFaktury = faktura.IdFaktury
INNER JOIN dict.tbl_forma_platnosci fp ON fp.IdFormyPlatnosci = p.IdFormaPlatnosci;
GO
CREATE VIEW vw_rezerwacja_pelna AS
SELECT r.IdRezerwacji,
k.Imie+' '+k.Nazwisko AS 'Imie i nazwisko klienta',
k.Telefon AS 'Numer telefonu klienta',
s.IdSamochodu AS 'Nr samochodu',
s.Rejestracja AS 'Numer rejestracyjny samochodu',
marka.Marka AS 'Marka samochodu',
model.Model AS 'Model samochodu',
r.DataUtworzeniaRezerwacji AS 'Data utworzenia rezerwacji',
r.DataRezerwacji AS 'Data rozpoczêcia rezerwacji',
r.DataKoncaRezerwacji AS 'Data koñca rezerwacji'
FROM tbl_rezerwacja r
INNER JOIN tbl_samochod s ON s.IdSamochodu = r.IdSamochodu
JOIN dict.tbl_marka marka ON marka.IdMarki = s.IdMarki
JOIN dict.tbl_model model ON model.IdModelu = s.IdModelu
JOIN tbl_rezerwacja_klient rk ON rk.IdRezerwacji = r.IdRezerwacji
JOIN tbl_klient k ON k.IdKlienta = rk.IdKlienta

GO
CREATE VIEW vw_wypozyczenie_pelne AS 
SELECT
w.IdWypozyczenia AS 'Numer wypo¿yczenia',
k.Imie+' '+k.Nazwisko AS 'Imie i nazwisko klienta',
k.Telefon AS 'Numer telefonu klienta',
s.IdSamochodu AS 'Nr samochodu',
s.Rejestracja AS 'Numer rejestracyjny samochodu',
marka.Marka AS 'Marka samochodu',
model.Model AS 'Model samochodu',
w.DataWypozyczenia AS 'Data wypo¿yczenia samochodu',
w.DataZwrotu AS 'Data zwrotu samochodu',
w.StanTechniczny AS 'Stan techniczny pojazdu po zwrocie samochodu'
FROM tbl_wypozyczenie w
INNER JOIN tbl_rezerwacja r ON r.IdWypozyczenia = w.IdWypozyczenia
JOIN tbl_rezerwacja_klient rk ON r.IdRezerwacji = rk.IdRezerwacji
JOIN tbl_klient k ON rk.IdKlienta = k.IdKlienta
JOIN tbl_samochod s ON s.IdSamochodu = r.IdSamochodu
JOIN dict.tbl_marka marka ON marka.IdMarki = s.IdMarki
JOIN dict.tbl_model model ON model.IdModelu = s.IdModelu
GO
CREATE VIEW vw_platnosci AS
SELECT IdPlatnosci, Zaplata, 
IdFaktury AS 'Numer faktury',
fp.FormaPlatnosci AS 'Forma p³atnoœci'
FROM tbl_platnosc p
INNER JOIN dict.tbl_forma_platnosci fp ON fp.IdFormyPlatnosci = p.IdFormaPlatnosci
GO

CREATE VIEW vw_suma_wszystkich_platnosci AS
SELECT SUM(Zaplata) AS 'Suma wszystkich p³atnoœci' FROM tbl_platnosc;
GO

CREATE VIEW vw_ubezpieczenie_pelne AS
SELECT 
u.IdUbezpieczenia AS 'Numer ubezpieczenia',
u.NumerPolisy AS 'Numer polisy',
m.Marka AS 'Marka',
model.Model AS 'Model',
u.DataRozpoczeciaUbezpieczenia AS 'Data rozpoczêcia ubezpieczenia',
u.DataZakonczeniaUbezpieczenia AS 'Data zakoñczenia ubezpieczenia',
u.FirmaUbezpieczeniowa AS 'Firma ubezpieczeniowa',
u.Cena AS 'Kwota do zap³aty za ubezpieczenia'
FROM tbl_ubezpieczenie u
INNER JOIN tbl_samochod s ON s.IdSamochodu = u.IdSamochodu
JOIN dict.tbl_marka m ON s.IdMarki = m.IdMarki
JOIN dict.tbl_model model ON model.IdModelu = s.IdModelu