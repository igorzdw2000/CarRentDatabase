CREATE INDEX idx_klient_nazwisko
ON dbo.tbl_klient(Nazwisko);

CREATE INDEX idx_rezerwacja_cenazadobe
ON dbo.tbl_rezerwacja(CenaZaDobe);

CREATE INDEX idx_klient_credentials
ON dbo.tbl_klient(Imie,Nazwisko);

CREATE INDEX idx_marka_nazwamarki
ON dict.tbl_marka(Marka);

CREATE INDEX idx_model_nazwamodelu
ON dict.tbl_model(Model);

CREATE INDEX idx_wypozyczenie_datawypozyczenia
ON dbo.tbl_wypozyczenie(DataWypozyczenia);

CREATE INDEX idx_ubezpieczenie_nrpolisy
ON dbo.tbl_ubezpieczenie(NumerPolisy);

CREATE INDEX idx_ubezpieczenie_cena
ON dbo.tbl_ubezpieczenie(Cena);

CREATE INDEX idx_klient_miejscowosc
ON dbo.tbl_klient(Miejscowosc)

CREATE INDEX idx_klient_email
ON dbo.tbl_klient(Email)

CREATE INDEX idx_samochod_idmarki
ON dbo.tbl_samochod(IdMarki)

CREATE INDEX idx_faktura_pozycje_faktury
ON dbo.tbl_pozycje_faktury(IdFaktury)

CREATE INDEX idx_faktura_idrezerwacji
ON dbo.tbl_faktura(IdRezerwacji)

CREATE INDEX idx_faktura_data_wystawienia_faktury
ON dbo.tbl_faktura(DataWystawienia)

CREATE INDEX idx_faktura_tytul
ON dbo.tbl_faktura(Tytyl)

CREATE INDEX idx_rezerwacja_idwypozyczenia
ON dbo.tbl_rezerwacja(IdWypozyczenia)

CREATE INDEX idx_klient_kodpocztowy
ON dbo.tbl_klient(KodPocztowy)

CREATE INDEX idx_platnosc_idfaktury
ON dbo.tbl_platnosc(IdFaktury)

CREATE INDEX idx_przeglad_idsamochodu
ON dbo.tbl_przeglad_samochodu(IdSamochodu)

CREATE INDEX idx_rezerwacja_data_rezerwacji
ON dbo.tbl_rezerwacja(DataRezerwacji)

CREATE INDEX idx_rezerwacja_laczna_kwota_do_zaplaty
ON dbo.tbl_rezerwacja(LacznaKwotaDoZaplaty)

CREATE INDEX idx_samochod_rocznik
ON dbo.tbl_samochod(Rocznik)

CREATE INDEX idx_samochod_przebieg
ON dbo.tbl_samochod(Przebieg)

