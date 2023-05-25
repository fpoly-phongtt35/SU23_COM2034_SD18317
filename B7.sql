SELECT COUNT(1) FROM Product -- Chứa danh sách sản phẩm của cửa hàng
SELECT COUNT(1) FROM [Order] -- Chứa danh sách hóa đơn của cửa hàng

-- Chứa thông tin chi tiết của hóa đơn: 
--	sản phẩm gì? số lượng mua bao nhiêu? mua giá bao nhiêu
SELECT OrderId AS 'Hóa đơn',
		ProductId AS 'Sản phẩm',
		PurchasedQuantity AS 'Số lượng mua',
		PurchasedMoney AS 'Đơn giá lúc mua'
 FROM OrderDetail 

-- Làm thế nào để biết trong Hóa đơn số 1 có những sản phẩm gì???
SELECT OrderId, ProductId FROM OrderDetail
	WHERE OrderId = 1
	-- Tên những sản phẩm đó là gì????
SELECT od.OrderId, od.ProductId, p.ProductName, 
	od.PurchasedMoney AS 'Giá lúc mua',
	p.Price AS 'Giá hiện hành'
	FROM OrderDetail od 
	LEFT JOIN Product p ON od.ProductId = p.ProductId
	WHERE OrderId = 1
	-- Thời điểm mua sản phẩm là lúc nào???
SELECT od.OrderId, od.ProductId, p.ProductName, 
	od.PurchasedMoney AS 'Giá lúc mua',
	o.CreatedDate AS 'Ngày mua',
	p.Price AS 'Giá hiện hành',
	GETDATE() AS 'Ngày hiện tại',
	IIF(od.PurchasedMoney < p.Price, N'Hời', N'Hớ') AS 'Kết luận'
	FROM OrderDetail od
	LEFT JOIN Product p ON od.ProductId = p.ProductId
	LEFT JOIN [Order] o ON od.OrderId = o.OrderId
	WHERE od.OrderId = 1

-- Lưu trữ vào thủ tục
CREATE PROCEDURE SP_PhanTichHoaDon
	@MaHoaDon INT -- Tham số truyền vào
AS BEGIN
	SELECT od.OrderId, od.ProductId, p.ProductName, 
		od.PurchasedMoney AS 'Giá lúc mua',
		o.CreatedDate AS 'Ngày mua',
		p.Price AS 'Giá hiện hành',
		GETDATE() AS 'Ngày hiện tại',
		IIF(od.PurchasedMoney < p.Price, N'Hời', N'Hớ') AS 'Kết luận'
		FROM OrderDetail od
		LEFT JOIN Product p ON od.ProductId = p.ProductId
		LEFT JOIN [Order] o ON od.OrderId = o.OrderId
		WHERE od.OrderId = @MaHoaDon
END

EXEC SP_PhanTichHoaDon 543 -- Thực thi thủ tục

-- Ví dụ Thêm hóa đơn mới
INSERT INTO [Order](CreatedDate, CustomerNumber) 
	VALUES(GETDATE(), '0912345678')
SELECT * FROM [Order] ORDER BY OrderId DESC

CREATE PROCEDURE SP_ThemHoaDon
	@Sdt VARCHAR(15)
AS BEGIN
	INSERT INTO [Order](CreatedDate, CustomerNumber) 
		VALUES(GETDATE(), @Sdt)
END

EXEC SP_ThemHoaDon '0923467123'

-- Ví dụ Thêm sản phẩm
INSERT INTO Product(ProductName, Price, Quantity)
	VALUES(N'Sản phẩm 1', 10000, 100)
SELECT * FROM Product ORDER BY ProductId DESC

CREATE PROCEDURE SP_ThemSanPham
	@TenSanPham		NVARCHAR(50),
	@GiaHienHanh	MONEY,
	@SoLuongTon		INT
AS BEGIN
	INSERT INTO Product(ProductName, Price, Quantity)
		VALUES(@TenSanPham, @GiaHienHanh, @SoLuongTon)
END

EXEC SP_ThemSanPham N'Sản phẩm 2', 98923, 8
