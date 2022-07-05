-- PROCEDURY

EXEC up_dodaj_auto
	'EL8534H', 12,1, 2, 1, 1, 'bia³y', 100000, 2010, '123GS4GY7G4L45BM6';
GO
EXEC up_dodaj_fakture
	'Faktura nr 21/0442/2022', 'Wypo¿yczalnia S.A', '2022-07-04', '55343001033', 'Prime', 'PL98124010116906418084353804', 21, 21, 2;
GO
EXEC up_dodaj_klienta
	'Kamil', 'Kowalski', 'ul. Bia³a 48', 'Warszawa', '80-240', 7, 20, '+48-839-341-430', 'k.kowalski@mail.net', '1994-12-23', 2;
GO
-- EXEC up_dodaj_naprawe_samochodu 'Wymiana wachaczy', '2022-06-28', 750, 3;
GO
EXEC up_dodaj_platnosc 450, 100, 3;
GO
-- EXEC up_dodaj_przeglad_samochodu '2022-07-01', '2023-07-01', '', 'S.K.P w £odzi', 100, 100;
GO
EXEC up_dodaj_wypozyczenie '2022-07-04', '2022-07-20', 'dobry';
GO
EXEC up_dodaj_rezerwacje 100, 20, '2022-07-04'
GO	
EXEC up_dodaj_ubezpieczenie 100, '34040412030593435542', '2022-02-24', '2023-02-25', 'AXA', 900;
GO
EXEC up_mod_cena_za_wypozyczenie 2, 110.0
GO
EXEC up_mod_fakture 100, 'Faktura nr 21/0443/2022', 'Wypo¿yczalnia S.A', '2022-07-04', '55343001033', 'Prime', 'PL98124010116906418084353804', 21, 21, 2;
GO
EXEC up_mod_klient 100, 'Maciej', 'Kowalski', 'ul. Bia³a 48', 'Warszawa', '80-240', 7, 20, '+48-839-341-430', 'k.kowalski@mail.net', '1994-12-23', 2;
GO
EXEC up_mod_rezerwacja  100, 100, 100, '2022-07-05';
GO
EXEC up_mod_samochod 100, 'EL8534H', 12,1, 2, 1, 1, 'bia³y', 100000, 2010, '123GS4GY7G4L45BM6';
GO 
EXEC up_mod_ubezpieczenie 100, 100, '34040412030593435542', '2022-03-24', '2023-03-25', 'AXA', 900;
GO
EXEC up_mod_wypozyczenie 100, '2022-06-30', '2022-07-25', 'dobry';
GO
EXEC up_powiazanie_klienta_z_rezerwacja 100, 100;
GO
-- konfilikt z constraint FK_platnosc_faktura
-- EXEC up_usun_fakture 100;
GO
EXEC up_usun_ubezpieczenie 100;

-- FUNKCJE

SELECT * FROM uf_ile_klientek();
SELECT * FROM uf_ile_klientow();
SELECT * FROM uf_ile_rezerwacji_ma_klient('Maciej');
SELECT * FROM uf_wyswietl_dane_z_kursora_faktury();
SELECT * FROM uf_wyswietl_dane_z_kursora_klienta();
SELECT * FROM uf_wyswietl_dane_z_kursora_rezerwacje(); -- pusty select, nie wiem czy tak ma byæ
SELECT * FROM uf_wyszukaj_fakture_po_nr(100);
SELECT * FROM uf_wyszukaj_klienta_po_imieniu_nazwisku('Maciej');
SELECT * FROM uf_wyszukaj_klienta_po_nipie('9328981251');
SELECT * FROM uf_wyszukaj_klienta_po_wojewodztwie('mazowieckie');
SELECT * FROM uf_wyszukaj_marke_po_nazwie('Fiat');
SELECT * FROM uf_wyszukaj_model_po_nazwie('A4');
SELECT * FROM uf_wyszukaj_platnosci_po_tytule_faktury('Faktura nr 13/7623/2021');
SELECT * FROM uf_wyszukaj_samochod_po_marce('Fiat');
SELECT * FROM uf_wyszukaj_samochod_po_vinie('JAE36BLC0PJC92436');
SELECT * FROM uf_wyszukaj_ubezpieczenie_po_nr_polisy('5143277307257895');
SELECT * FROM uf_wyszukaj_wojewodztwo_po_nazwie('³ódzkie');
