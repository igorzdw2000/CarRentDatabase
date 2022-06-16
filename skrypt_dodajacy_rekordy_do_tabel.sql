CREATE SEQUENCE dbo.seq_new_id
INCREMENT BY 10
START WITH 1
NO MINVALUE
NO CYCLE
;
INSERT INTO tbl_samochod
VALUES
(1,'SL61801',1,1,1,1,1,'czarny',170000,2010,'JAE36BLC0PJC92436'),
(2,'CLI2807',2,1,1,3,2,'srebrny',200000,2009,'1GC316C651F701385'),
(3,'ZK60338',3,1,5,1,1,'br¹zowy',30000,2019,'KL1G2ETP1NSTZ5758'),
(4,'SPS4407',4,2,5,1,2,'zielony',150000,2010,'4S3WR1WB2RP8K7761'),
(5,'ZGR2955',5,2,3,1,2,'niebieski',120000,2011,'1GB2NEXJ5RG6F4924'),
(6,'LKS4739',6,3,4,1,2,'czerwony',250000,2007,'7A1EERD60XEET3381'),
(7,'RBR2426',7,3,1,3,3,'bia³y',15000,2020,'WBXMMF0K2VUHV6056'),
(8,'NEB7732',8,4,2,3,2,'srebrny',211000,2009,'1G41T7C535LRW8686'),
(9,'NLI7617',9,4,4,3,2,'ró¿owy',350000,2006,'SCC53U2F940HS5741'),
(10,'PP78938',10,4,4,1,2,'bia³y',100000,2015,'8AW1SP8T11DJ98287'),
(11,'WH49846',11,5,5,2,3,'fioletowy',200000,2011,'4USJFXL764YEN0616'),
(12,'FZA9211',12,5,4,1,2,'czarny',150000,2015,'4S60LFRC1VESD8536'),
(13,'EZD4988',13,6,3,1,1,'szary',10000,2019,'MMBM0WX875ZPG9233'),
(14,'ZST1820',14,7,4,3,2,'bordowy',250000,2008,'9UK0CJH59JF0N9671'),
(15,'SJ06192',15,7,4,3,2,'zielony',150000,2012,'AHTYTTJZ88Y7S1353'),
(16,'LKR1952',16,7,4,2,2,'bia³y',20000,2020,'WP0X2DCD9L4WU2485'),
(17,'GKA9207',17,8,2,3,2,'niebieski',150000,2013,'988CWERM96GBH0269'),
(18,'WGS7088',18,8,5,1,2,'pomarañczowy',150000,2012,'PNVSSUAF4XNNU8513'),
(19,'KNS0026',19,9,4,3,2,'czarny',350000,2006,'JC19HZXU9ZVNF5972'),
(20,'FMI3212',20,9,1,3,1,'czarny',100000,2019,'935GH2TX86VJU0737'),
(21,'BBI7875',21,9,4,3,2,'granatowy',350000,2002,'SHSNAWH58A3JS0331'),
(22,'EWI0098',22,9,4,3,2,'bia³y',200000,2011,'KNKT04H22HPLM3091'),
(23,'PGN4395',23,10,4,1,2,'srebrny',90000,2015,'1NMT7KH68KYUP4978'),
(24,'PCT9078',24,10,2,1,3,'bia³y',9500,2021,'WJR6VEWH2BYBK5375'),
(25,'RST9602',25,10,1,1,1,'czerwony',10000,2021,'PNVWWLY18S4GT5794'),
(26,'DLW3954',26,11,1,3,2,'granatowy',300000,2006,'3NBLR2S19D1A17793'),
(27,'FWS7901',27,12,1,1,1,'bia³y',15000,2020,'2HGVHY1302CA49485'),
(28,'DBA9188',28,12,1,1,1,'srebrny',200000,2009,'1HG4UYE24S9E56519')


INSERT INTO tbl_wypozyczenie
VALUES
(1,'2022-06-06','2022-06-08','dobry'),
(2,'2022-05-12','2022-05-14','zarysowane drzwi pasa¿era'),
(3,'2022-03-11','2022-03-12','dobry'),
(4,'2022-02-22','2022-03-01','dobry'),
(5,'2022-02-14','2022-02-17','uszkodzone prawe lusterko zewnêtrzne'),
(6,'2022-02-01','2022-02-03','dobry'),
(7,'2021-12-29','2022-12-31','urwana klamka od drzwi kierowcy'),
(8,'2021-12-20','2022-12-24','dobry'),
(9,'2021-12-15','2022-12-20','dobry'),
(10,'2021-12-15','2022-12-20','dobry'),
(11,'2021-12-15','2021-12-16','zabrudzona tapiecerka na siedzeniu kierowcy'),
(12,'2021-11-30','2021-12-12','uszkodzona tylna lewa lampa, porysowany tylny zderzak'),
(13,'2021-12-12','2021-12-15','dobry'),
(14,'2022-04-04','2022-04-10','dobry'),
(15,'2022-03-03','2022-03-12','dobry'),
(16,'2022-06-05','2022-06-10','pêkniêta tylna szyba'),
(17,'2021-11-12','2021-12-01','dobry'),
(18,'2022-05-09','2022-06-09','dobry'),
(19,'2021-10-29','2021-11-05','dobry'),
(20,'2022-06-06','2022-06-10','zarysowany przedni lewy b³otnik')



INSERT INTO tbl_ubezpieczenie
VALUES
(NEXT VALUE FOR dbo.seq_new_id,1,'4436503045195625','2022-01-01','2023-01-01','Warta',800),
(NEXT VALUE FOR dbo.seq_new_id,2,'0662675557993847','2022-05-12','2023-05-12','ErgoHestia',800),
(NEXT VALUE FOR dbo.seq_new_id,3,'2737877329385536','2022-04-04','2023-04-04','Warta',899),
(NEXT VALUE FOR dbo.seq_new_id,4,'2099744314252624','2021-12-12','2022-12-12','Generalii',1000),
(NEXT VALUE FOR dbo.seq_new_id,5,'4623306699555827','2021-11-04','2022-11-04','Warta',1000),
(NEXT VALUE FOR dbo.seq_new_id,6,'9166510753280534','2022-01-01','2023-01-01','Warta',1000),
(NEXT VALUE FOR dbo.seq_new_id,7,'1575641647196365','2021-06-30','2022-06-30','Warta',1500),
(NEXT VALUE FOR dbo.seq_new_id,8,'4320528151956208','2022-03-20','2023-03-20','Warta',1500),
(NEXT VALUE FOR dbo.seq_new_id,9,'8834250622586231','2021-07-07','2022-07-07','ErgoHestia',2000),
(NEXT VALUE FOR dbo.seq_new_id,10,'6521803312985063','2022-01-01','2023-01-01','Warta',1000),
(NEXT VALUE FOR dbo.seq_new_id,11,'8981597713686992','2021-06-30','2022-06-30','Warta',1200),
(NEXT VALUE FOR dbo.seq_new_id,12,'5143277307257895','2021-07-01','2022-07-01','AXA',900),
(NEXT VALUE FOR dbo.seq_new_id,13,'8763741978747673','2021-06-26','2022-06-26','AXA',2600),
(NEXT VALUE FOR dbo.seq_new_id,14,'8160944016585544','2022-05-12','2023-05-12','Warta',1000),
(NEXT VALUE FOR dbo.seq_new_id,15,'3080599376753492','2022-01-01','2023-01-01','Warta',1000),
(NEXT VALUE FOR dbo.seq_new_id,16,'6636076142997430','2021-10-12','2022-10-12','Generali',1200),
(NEXT VALUE FOR dbo.seq_new_id,17,'5100103960505421','2021-12-16','2022-12-16','Warta',1000),
(NEXT VALUE FOR dbo.seq_new_id,18,'0670332762736141','2022-06-06','2023-06-06','Warta',1000),
(NEXT VALUE FOR dbo.seq_new_id,19,'2524554269224534','2021-08-01','2022-08-01','Warta',2000),
(NEXT VALUE FOR dbo.seq_new_id,20,'1155583100572995','2022-05-26','2023-05-26','Warta',1000),
(NEXT VALUE FOR dbo.seq_new_id,21,'0873171488970813','2021-09-01','2021-09-01','Warta',870),
(NEXT VALUE FOR dbo.seq_new_id,22,'1498992752251132','2022-12-01','2023-12-01','Warta',760),
(NEXT VALUE FOR dbo.seq_new_id,23,'9160975865574716','2021-11-09','2022-11-09','Warta',1200),
(NEXT VALUE FOR dbo.seq_new_id,24,'1040968581002422','2022-04-04','2023-04-04','Warta',1020),
(NEXT VALUE FOR dbo.seq_new_id,25,'5934692348085146','2021-07-01','2022-07-01','Warta',1000),
(NEXT VALUE FOR dbo.seq_new_id,26,'2972567478502828','2022-05-05','2023-05-05','ErgoHestia',500),
(NEXT VALUE FOR dbo.seq_new_id,27,'7524557938780253','2021-06-25','2022-06-25','Warta',1000),
(NEXT VALUE FOR dbo.seq_new_id,28,'1257832617645923','2022-02-02','2023-02-02','ErgoHestia',1200)

ALTER SEQUENCE dbo.seq_new_id RESTART;

INSERT INTO tbl_spis_napraw
VALUES
(NEXT VALUE FOR dbo.seq_new_id,'Wypolerowano lakier na drzwiach','2022-05-20',350,12),
(NEXT VALUE FOR dbo.seq_new_id,'Wymieniono prawe lusterko na nowe','2022-02-25',450,2),
(NEXT VALUE FOR dbo.seq_new_id,'Wymiana klamki od drzwi kierowcy','2022-01-12',200,3),
(NEXT VALUE FOR dbo.seq_new_id,'Wyprano œrodek samochodu','2021-12-20',150,7),
(NEXT VALUE FOR dbo.seq_new_id,'Wymieniono lampe i zderzak','2021-12-20',900,14),
(NEXT VALUE FOR dbo.seq_new_id,'Wymieniono tyln¹ szybê','2022-06-12',600,11),
(NEXT VALUE FOR dbo.seq_new_id,'Wymieniono lewy przedni b³otnik','2022-06-14',700,11)

ALTER SEQUENCE dbo.seq_new_id RESTART;

INSERT INTO tbl_przeglad_samochodu
VALUES
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=1),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=1),'','S.K.P w Pleszewie',100,1),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=2),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=2),'wyciek z tylnego dyferyncja³u','S.K.P w Pleszewie',100,2),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=3),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=3),'','S.K.P w Pleszewie',100,3),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=4),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=4),'','S.K.P w Pleszewie',100,4),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=5),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=5),'','S.K.P w Pleszewie',100,5),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=6),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=6),'luzy w zawieszeniu','S.K.P w Pleszewie',100,6),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=7),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=7),'','S.K.P w Pleszewie',100,7),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=8),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=8),'','S.K.P w Pleszewie',100,8),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=9),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=9),'','S.K.P w Pleszewie',100,9),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=10),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=10),'hamulce nadaj¹ siê do wymiany','S.K.P w Pleszewie',100,10),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=11),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=11),'','S.K.P w Pleszewie',100,11),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=12),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=12),'','S.K.P w Pleszewie',100,12),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=13),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=13),'wyciek ze skrzyni biegów','S.K.P w Pleszewie',100,13),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=14),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=14),'','S.K.P w Pleszewie',100,14),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=15),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=15),'','S.K.P w Pleszewie',100,15),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=16),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=16),'','S.K.P w Pleszewie',100,16),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=17),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=17),'opony nadaj¹ siê do wymiany','S.K.P w Pleszewie',100,17),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=18),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=18),'','S.K.P w Pleszewie',100,18),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=19),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=19),'','S.K.P w Pleszewie',100,19),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=20),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=20),'','S.K.P w Pleszewie',100,20),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=21),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=21),'luzy w poduszcze silnika','S.K.P w Pleszewie',100,21),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=22),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=22),'','S.K.P w Pleszewie',100,22),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=23),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=23),'','S.K.P w Pleszewie',100,23),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=24),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=24),'','S.K.P w Pleszewie',100,24),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=25),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=25),'','S.K.P w Pleszewie',100,25),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=26),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=26),'nale¿y wymieniæ przedni lewy wahacz','S.K.P w Pleszewie',100,26),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=27),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=27),'','S.K.P w Pleszewie',100,27),
(NEXT VALUE FOR dbo.seq_new_id,(SELECT DataRozpoczeciaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=28),(SELECT DataZakonczeniaUbezpieczenia FROM tbl_ubezpieczenie WHERE IdSamochodu=28),'','S.K.P w Pleszewie',100,28)

ALTER SEQUENCE dbo.seq_new_id RESTART;

INSERT INTO tbl_platnosc 
VALUES 
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(1), 1, 4),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(2), 2, 2),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(3), 3, 2),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(4), 4, 2),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(5), 5, 1),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(6), 6, 3),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(7), 7, 1),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(8), 8, 1),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(9), 9, 2),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(10), 10, 2),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(11), 11, 4),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(12), 12, 4),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(13), 13, 4),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(14), 14, 4),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(15), 15, 3),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(16), 16, 3),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(17), 17, 4),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(18), 18, 4),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(19), 19, 1),
(NEXT VALUE FOR dbo.seq_new_id, dbo.uf_getLacznaKwota(20), 20, 1)