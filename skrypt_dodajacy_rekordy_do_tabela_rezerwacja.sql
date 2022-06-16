BEGIN TRY
INSERT INTO tbl_rezerwacja
VALUES
(1,1,1,dbo.getCar(1),1000,dbo.getDataWypozyczenia(1),dbo.getDataZwrotu(1),'2022-06-05',(dbo.uf_czyZwrocicKaucje(1)+CONVERT(money,dbo.getCar(1)*DATEDIFF(day,dbo.getDataWypozyczenia(1),dbo.getDataZwrotu(1))))),
(2,2,2,dbo.getCar(2),1000,dbo.getDataWypozyczenia(2),dbo.getDataZwrotu(2),'2022-05-11',(dbo.uf_czyZwrocicKaucje(2)+CONVERT(money,dbo.getCar(2)*DATEDIFF(day,dbo.getDataWypozyczenia(2),dbo.getDataZwrotu(2))))),
(3,3,4,dbo.getCar(4),1000,dbo.getDataWypozyczenia(3),dbo.getDataZwrotu(3),'2022-03-08',(dbo.uf_czyZwrocicKaucje(3)+CONVERT(money,dbo.getCar(4)*DATEDIFF(day,dbo.getDataWypozyczenia(3),dbo.getDataZwrotu(3))))),
(4,4,5,dbo.getCar(5),1000,dbo.getDataWypozyczenia(4),dbo.getDataZwrotu(4),'2022-02-12',(dbo.uf_czyZwrocicKaucje(4)+CONVERT(money,dbo.getCar(5)*DATEDIFF(day,dbo.getDataWypozyczenia(4),dbo.getDataZwrotu(4))))),
(5,5,6,dbo.getCar(6),1000,dbo.getDataWypozyczenia(5),dbo.getDataZwrotu(5),'2022-01-30',(dbo.uf_czyZwrocicKaucje(5)+CONVERT(money,dbo.getCar(6)*DATEDIFF(day,dbo.getDataWypozyczenia(5),dbo.getDataZwrotu(5))))),
(6,6,7,dbo.getCar(7),1000,dbo.getDataWypozyczenia(6),dbo.getDataZwrotu(6),'2021-12-25',(dbo.uf_czyZwrocicKaucje(6)+CONVERT(money,dbo.getCar(7)*DATEDIFF(day,dbo.getDataWypozyczenia(6),dbo.getDataZwrotu(6))))),
(7,7,8,dbo.getCar(8),1000,dbo.getDataWypozyczenia(7),dbo.getDataZwrotu(7),'2021-12-18',(dbo.uf_czyZwrocicKaucje(7)+CONVERT(money,dbo.getCar(8)*DATEDIFF(day,dbo.getDataWypozyczenia(7),dbo.getDataZwrotu(7))))),
(8,8,10,dbo.getCar(10),1000,dbo.getDataWypozyczenia(8),dbo.getDataZwrotu(8),'2021-12-13',(dbo.uf_czyZwrocicKaucje(8)+CONVERT(money,dbo.getCar(10)*DATEDIFF(day,dbo.getDataWypozyczenia(8),dbo.getDataZwrotu(8))))),
(9,9,11,dbo.getCar(11),1000,dbo.getDataWypozyczenia(9),dbo.getDataZwrotu(9),'2021-12-13',(dbo.uf_czyZwrocicKaucje(9)+CONVERT(money,dbo.getCar(11)*DATEDIFF(day,dbo.getDataWypozyczenia(9),dbo.getDataZwrotu(9))))),
(10,10,9,dbo.getCar(9),1000,dbo.getDataWypozyczenia(10),dbo.getDataZwrotu(10),'2021-12-14',(dbo.uf_czyZwrocicKaucje(10)+CONVERT(money,dbo.getCar(9)*DATEDIFF(day,dbo.getDataWypozyczenia(10),dbo.getDataZwrotu(10))))),
(11,11,12,dbo.getCar(12),1000,dbo.getDataWypozyczenia(11),dbo.getDataZwrotu(11),'2021-12-12',(dbo.uf_czyZwrocicKaucje(11)+CONVERT(money,dbo.getCar(12)*DATEDIFF(day,dbo.getDataWypozyczenia(11),dbo.getDataZwrotu(11))))),
(12,12,13,dbo.getCar(13),1000,dbo.getDataWypozyczenia(12),dbo.getDataZwrotu(12),'2021-11-26',(dbo.uf_czyZwrocicKaucje(12)+CONVERT(money,dbo.getCar(13)*DATEDIFF(day,dbo.getDataWypozyczenia(12),dbo.getDataZwrotu(12))))),
(13,13,14,dbo.getCar(14),1000,dbo.getDataWypozyczenia(13),dbo.getDataZwrotu(13),'2021-12-08',(dbo.uf_czyZwrocicKaucje(13)+CONVERT(money,dbo.getCar(14)*DATEDIFF(day,dbo.getDataWypozyczenia(13),dbo.getDataZwrotu(13))))),
(14,14,15,dbo.getCar(15),1000,dbo.getDataWypozyczenia(14),dbo.getDataZwrotu(14),'2022-04-01',(dbo.uf_czyZwrocicKaucje(14)+CONVERT(money,dbo.getCar(15)*DATEDIFF(day,dbo.getDataWypozyczenia(14),dbo.getDataZwrotu(14))))),
(15,15,1,dbo.getCar(1),1000,dbo.getDataWypozyczenia(15),dbo.getDataZwrotu(15),'2022-03-02',(dbo.uf_czyZwrocicKaucje(15)+CONVERT(money,dbo.getCar(1)*DATEDIFF(day,dbo.getDataWypozyczenia(15),dbo.getDataZwrotu(15))))),
(16,16,2,dbo.getCar(2),1000,dbo.getDataWypozyczenia(16),dbo.getDataZwrotu(16),'2022-06-04',(dbo.uf_czyZwrocicKaucje(16)+CONVERT(money,dbo.getCar(2)*DATEDIFF(day,dbo.getDataWypozyczenia(16),dbo.getDataZwrotu(16))))),
(17,17,22,dbo.getCar(22),1000,dbo.getDataWypozyczenia(17),dbo.getDataZwrotu(17),'2021-11-09',(dbo.uf_czyZwrocicKaucje(17)+CONVERT(money,dbo.getCar(22)*DATEDIFF(day,dbo.getDataWypozyczenia(17),dbo.getDataZwrotu(17))))),
(18,18,20,dbo.getCar(20),1000,dbo.getDataWypozyczenia(18),dbo.getDataZwrotu(18),'2022-05-08',(dbo.uf_czyZwrocicKaucje(18)+CONVERT(money,dbo.getCar(20)*DATEDIFF(day,dbo.getDataWypozyczenia(18),dbo.getDataZwrotu(18))))),
(19,19,18,dbo.getCar(18),1000,dbo.getDataWypozyczenia(19),dbo.getDataZwrotu(19),'2021-10-28',(dbo.uf_czyZwrocicKaucje(19)+CONVERT(money,dbo.getCar(18)*DATEDIFF(day,dbo.getDataWypozyczenia(19),dbo.getDataZwrotu(19))))),
(20,20,16,dbo.getCar(16),1000,dbo.getDataWypozyczenia(20),dbo.getDataZwrotu(20),'2022-06-05',(dbo.uf_czyZwrocicKaucje(20)+CONVERT(money,dbo.getCar(16)*DATEDIFF(day,dbo.getDataWypozyczenia(20),dbo.getDataZwrotu(20)))))
END TRY
BEGIN CATCH
	EXECUTE usp_GetErrorInfo
END CATCH

INSERT INTO tbl_rezerwacja_klient
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20)

