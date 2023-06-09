USE [SDB_01_Order]

-- Câu lệnh thực thi thủ tục
EXEC SP_PhanTichHoaDon 275

EXEC SP_ThemHoaDon '0912345678' -- Thêm hóa đơn mới
SELECT * FROM [Order] ORDER BY OrderId DESC

EXEC SP_ThemSanPham @SoLuongTon = 100
					, @TenSanPham = N'Ahihi'
					, @GiaHienHanh = 998275
SELECT * FROM Product ORDER BY ProductId DESC

-- Câu lệnh tạo thủ tục???
CREATE PROCEDURE SP_TenThuTuc
	@ThamSo1	KIEU_DU_LIEU,
	@ThamSo2	KIEU_DU_LIEU,
	...
AS BEGIN
	
END

-- Bổ sung validate vào Thủ tục
--	Sửa thủ tục đã tồn tại bằng cú pháp ALTER
-- Bài tập: Viết thủ tục thêm mới sản phẩm vào bảng Product
--	Yêu cầu: Số lượng > 0, Giá > 0, Tên không được để trống
--	BONUS: Số lượng là số tự nhiên

-- Cách viết 1
ALTER PROCEDURE SP_ThemSanPham
	@TenSanPham		NVARCHAR(50),
	@GiaHienHanh	MONEY,
	@SoLuongTon		INT
AS BEGIN
	IF @GiaHienHanh < 0 BEGIN
		PRINT N'Giá không được nhỏ hơn 0'
	END
	ELSE BEGIN
		IF @SoLuongTon < 0 BEGIN
			PRINT N'Số lượng phải lớn hơn 0'
		END
		ELSE BEGIN
			IF LEN(@TenSanPham) = 0 BEGIN
				PRINT N'Tên sản phẩm không được để trống'
			END
			ELSE BEGIN
				INSERT INTO Product(ProductName, Price, Quantity)
					VALUES(@TenSanPham, @GiaHienHanh, @SoLuongTon)
				PRINT N'Thêm sản phẩm mới thành công!!'
			END
		END
	END
END

-- Cách viết 2
ALTER PROCEDURE SP_ThemSanPham
	@TenSanPham		NVARCHAR(50),
	@GiaHienHanh	MONEY,
	@SoLuongTon		INT
AS BEGIN
	-- Kiểm tra về Giá > 0
	IF @GiaHienHanh < 0 BEGIN
		PRINT N'Giá không được nhỏ hơn 0'
		RETURN -- Dừng chương trình, không thực hiện câu phía sau
	END
	
	-- Kiểm tra về Số lượng > 0
	IF @SoLuongTon < 0 BEGIN
		PRINT N'Số lượng phải lớn hơn 0'
		RETURN -- Dừng chương trình, không thực hiện câu phía sau
	END

	-- Kiểm tra về Tên không được để trống
	SET @TenSanPham = LTRIM(@TenSanPham) -- Xóa khoảng trống bên trái
	SET @TenSanPham = RTRIM(@TenSanPham) -- Xóa khoảng trống bên phải
	IF LEN(@TenSanPham) = 0 BEGIN
		PRINT N'Tên sản phẩm không được để trống'
		RETURN -- Dừng chương trình, không thực hiện câu phía sau
	END

	-- Đi qua các IF mà OK, tức là tham số đầu vào thỏa mãn điều kiện
	--		Vậy thì INSERT thôi
	INSERT INTO Product(ProductName, Price, Quantity)
		VALUES(@TenSanPham, @GiaHienHanh, @SoLuongTon)
	PRINT N'Thêm sản phẩm mới thành công!!'
END

EXEC SP_ThemSanPham @SoLuongTon = 101
					, @TenSanPham = N''
					, @GiaHienHanh = 123
SELECT * FROM Product ORDER BY ProductId DESC
