BEGIN TRY
INSERT INTO tbl_pozycje_faktury
VALUES
(1,1,dbo.uf_getCarId(1),dbo.uf_getCarType(1),1,dbo.uf_getLacznaKwota(1),1),
(2,2,dbo.uf_getCarId(2),dbo.uf_getCarType(2),1,dbo.uf_getLacznaKwota(2),1),
(3,3,dbo.uf_getCarId(3),dbo.uf_getCarType(3),1,dbo.uf_getLacznaKwota(3),1),
(4,4,dbo.uf_getCarId(4),dbo.uf_getCarType(4),1,dbo.uf_getLacznaKwota(4),1),
(5,5,dbo.uf_getCarId(5),dbo.uf_getCarType(5),1,dbo.uf_getLacznaKwota(5),1),
(6,6,dbo.uf_getCarId(6),dbo.uf_getCarType(6),1,dbo.uf_getLacznaKwota(6),1),
(7,7,dbo.uf_getCarId(7),dbo.uf_getCarType(7),1,dbo.uf_getLacznaKwota(7),1),
(8,8,dbo.uf_getCarId(8),dbo.uf_getCarType(8),1,dbo.uf_getLacznaKwota(8),1),
(9,9,dbo.uf_getCarId(9),dbo.uf_getCarType(9),1,dbo.uf_getLacznaKwota(9),1),
(10,10,dbo.uf_getCarId(10),dbo.uf_getCarType(10),1,dbo.uf_getLacznaKwota(10),1),
(11,11,dbo.uf_getCarId(11),dbo.uf_getCarType(11),1,dbo.uf_getLacznaKwota(11),1),
(12,12,dbo.uf_getCarId(12),dbo.uf_getCarType(12),1,dbo.uf_getLacznaKwota(12),1),
(13,13,dbo.uf_getCarId(13),dbo.uf_getCarType(13),1,dbo.uf_getLacznaKwota(13),1),
(14,14,dbo.uf_getCarId(14),dbo.uf_getCarType(14),1,dbo.uf_getLacznaKwota(14),1),
(15,15,dbo.uf_getCarId(15),dbo.uf_getCarType(15),1,dbo.uf_getLacznaKwota(15),1),
(16,16,dbo.uf_getCarId(16),dbo.uf_getCarType(16),1,dbo.uf_getLacznaKwota(16),1),
(17,17,dbo.uf_getCarId(17),dbo.uf_getCarType(17),1,dbo.uf_getLacznaKwota(17),1),
(18,18,dbo.uf_getCarId(18),dbo.uf_getCarType(18),1,dbo.uf_getLacznaKwota(18),1),
(19,19,dbo.uf_getCarId(19),dbo.uf_getCarType(19),1,dbo.uf_getLacznaKwota(19),1),
(20,20,dbo.uf_getCarId(20),dbo.uf_getCarType(20),1,dbo.uf_getLacznaKwota(20),1)
END TRY
BEGIN CATCH
	EXECUTE dbo.usp_GetErrorInfo
END CATCH