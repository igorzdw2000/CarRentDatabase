BEGIN TRY
INSERT INTO tbl_rezerwacja
VALUES
(8,8,8,dbo.getCar(8),1000,dbo.getDataWypozyczenia(8),dbo.getDataZwrotu(8),'2022-12-19',(dbo.uf_czyZwrocicKaucje(8)+CONVERT(money,dbo.getCar(8)*DATEDIFF(day,dbo.getDataWypozyczenia(8),dbo.getDataZwrotu(8)))))
END TRY
BEGIN CATCH
	EXECUTE usp_GetErrorInfo
END CATCH

SELECT dbo.uf_czyZwrocicKaucje(8);

DELETE FROM tbl_rezerwacja;