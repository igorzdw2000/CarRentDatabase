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



