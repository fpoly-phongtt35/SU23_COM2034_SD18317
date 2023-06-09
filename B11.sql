USE SDB_01_Order

CREATE PROCEDURE SP_ThemSanPhamVaoHoaDon
	@MaHoaDon INT,
	@MaSanPham INT,
	@SoLuongMua INT
AS BEGIN 
	--Lấy đơn giá hiện tại của sản phẩm
	DECLARE @GiaHienHanh MONEY
	SELECT @GiaHienHanh = Price FROM Product
		WHERE ProductId = @MaSanPham 

	--Thêm sản phẩm vào hóa đơn 
	INSERT INTO OrderDetail(OrderId,ProductId,PurchasedQuantity,PurchasedMoney)
		VALUES(@MaHoaDon,@MaSanPham,@SoLuongMua,@GiaHienHanh)
END

EXEC SP_ThemSanPhamVaoHoaDon
	@MaHoaDon = 317, @MaSanPham = 17, @SoLuongMua = 5

SELECT * FROM OrderDetail WHERE OrderId = 317
SELECT * FROM Product WHERE ProductId = 17

--Bổ sung phần kiểm tra dữ liệu đầu vào 
ALTER PROCEDURE SP_ThemSanPhamVaoHoaDon
	@MaHoaDon INT,
	@MaSanPham INT,
	@SoLuongMua INT
AS BEGIN 
	--Kiểm tra số lượng mua lớn hơn  0 
	IF @SoLuongMua < 0 BEGIN
		PRINT N'Số lượng mua phải lớn hơn  0 '
		RETURN
	END 

	--Kiểm tra hóa đơn có tồn tại hay không ? 
	DECLARE @DemHoaDon INT
	SELECT @DemHoaDon = COUNT(1) FROM [Order]  -- Đặt vào [ ] để không trùng keyword
		WHERE OrderId = @MaHoaDon
	IF @DemHoaDon = 0 BEGIN 
		PRINT N'Hóa đơn không tồn tại !'
		RETURN
	END

	--Kiểm tra sản phẩm có tồn tại không ?
	DECLARE @DemSanPham INT
	SELECT @DemSanPham = COUNT(1) FROM Product 
		WHERE ProductId = @MaSanPham
	IF @DemSanPham = 0 BEGIN 
		PRINT N'Sản phẩm không tồn tại'
		RETURN
	END
	
	--Kiểm tra số lượng mua nhỏ hơn số lượng tồn
	DECLARE @SoLuongTon INT
	SELECT @SoLuongTon = Quantity FROM Product
		WHERE ProductId = @MaSanPham
	IF @SoLuongMua > @SoLuongTon BEGIN
		PRINT N'Mua ít thôi !'
		RETURN
	END

	--Lấy đơn giá hiện tại của sản phẩm
	DECLARE @GiaHienHanh MONEY
	SELECT @GiaHienHanh = Price FROM Product
		WHERE ProductId = @MaSanPham 

	--Thêm sản phẩm vào hóa đơn 
	INSERT INTO OrderDetail(OrderId,ProductId,PurchasedQuantity,PurchasedMoney)
		VALUES(@MaHoaDon,@MaSanPham,@SoLuongMua,@GiaHienHanh)
END

EXEC SP_ThemSanPhamVaoHoaDon
	@MaHoaDon = 1, @MaSanPham = 9990, @SoLuongMua = 231

--Kiểm tra sản phẩm tồn tại hay không ?
DECLARE @Dem INT
SELECT @Dem = COUNT(1) FROM Product WHERE ProductId = 18
IF @Dem = 0 BEGIN
	PRINT N'Sản phẩm không tồn tại !'
END 
ELSE BEGIN
	PRINT N'Sản phẩm tồn tại !'
END


DECLARE @DemHoaDon INT
SELECT @DemHoaDon = COUNT(1) FROM  WHERE  = 18
IF @DemHoaDon = 0 BEGIN
	PRINT N'Sản phẩm không tồn tại !'
END 
ELSE BEGIN
	PRINT N'Sản phẩm tồn tại !'
END
