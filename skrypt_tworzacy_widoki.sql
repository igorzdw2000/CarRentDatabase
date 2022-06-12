CREATE VIEW vw_wszyscy_klienci AS
SELECT * FROM dbo.tbl_klient;

CREATE VIEW vw_klienci_z_wojewodztwami_i_krajami AS
SELECT IdKlienta, Imie, Nazwisko, Adres, Miejscowosc, w.Wojewodztwo, p.Kraj, pl.Plec FROM dbo.tbl_klient k 
INNER JOIN dict.tbl_wojewodztwo w ON w.IdWojewodztwa = k.IdWojewodztwa 
INNER JOIN dict.tbl_kraj p ON p.IdKraju = k.IdKraju
INNER JOIN dict.tbl_plec pl ON pl.IdPlci = k.IdPlci
WITH CHECK OPTION;

CREATE VIEW vw_klienci_z_polski AS
SELECT IdKlienta, Imie, Nazwisko, Adres, Miejscowosc, kraj.Kraj FROM dbo.tbl_klient klient INNER JOIN dict.tbl_kraj kraj ON kraj.IdKraju = klient.IdKraju WHERE kraj.Kraj = 'polska';

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


