USE [SDB_01_Order]

----- TRIGGER AFTER
-- Tạo trigger
CREATE TRIGGER TG_AfterInsert
	ON Product
	AFTER INSERT
AS BEGIN
	PRINT N'Trigger được chạy sau khi insert vào bảng Product'
END

-- Sau khi INSERT, thực hiện thêm lệnh in
INSERT INTO Product VALUES('Hihi', 123, 213)

-- Cập nhập trigger
ALTER TRIGGER TG_AfterInsert
	ON Product AFTER INSERT 
AS BEGIN
	-- Đếm số lượng bản ghi được thêm mới
	DECLARE @soBanGhi INT
	SELECT @soBanGhi = COUNT(1) FROM inserted
	PRINT CONVERT(VARCHAR, @soBanGhi) + N' bản ghi đã được thêm!'
END
INSERT INTO Product VALUES
	('Hihi', 123, 213), ('Haha', 123, 213), ('Hehe', 123, 213)


------- TRIGGER Instead Of
CREATE TRIGGER TG_InsteadOfInsert
	ON [Order] INSTEAD OF INSERT
AS BEGIN
	PRINT N'Thay vì thêm hóa đơn mới, in ra dòng này'
END
INSERT INTO [Order] VALUES(GETDATE(), '098312873')
SELECT * FROM [Order] ORDER BY OrderId DESC

ALTER TRIGGER TG_InsteadOfInsert
	ON [Order] INSTEAD OF INSERT
AS BEGIN
	DECLARE @ngayLapDon DATE
	SELECT @ngayLapDon = CreatedDate FROM inserted
	IF @ngayLapDon > GETDATE() BEGIN
		PRINT N'Ngày lập đơn điêu!'
	END
	ELSE BEGIN
		DECLARE @soDienThoai VARCHAR
		SELECT @soDienThoai = CustomerNumber FROM inserted
		INSERT INTO [Order] VALUES(@ngayLapDon, @soDienThoai)
	END
END
INSERT INTO [Order] VALUES('2023-01-01', 'Success') -- Thêm thành công
INSERT INTO [Order] VALUES('2024-01-01', 'Fail') -- Thêm thất bại
SELECT * FROM [Order] ORDER BY OrderId DESC


---- TRANSACTION
INSERT INTO Product VALUES
	('Hihi', 123, 213), ('Hihi', 123, 213), ('Hihi', 123, 213),
	('Hihi', 123, 213), ('Hihi', 123, 213), ('Hihi', 123, 213)
BEGIN TRANSACTION -- Lưu trạng thái 
	DELETE FROM Product WHERE ProductName LIKE 'Hihi'
	SELECT * FROM Product ORDER BY ProductId DESC
ROLLBACK -- Quay lại trạng thái ban đầu
	SELECT * FROM Product ORDER BY ProductId DESC

BEGIN TRANSACTION -- Lưu trạng thái 
	DELETE FROM Product WHERE ProductName LIKE 'Hihi'
	SELECT * FROM Product ORDER BY ProductId DESC
COMMIT -- Kết thúc transaction, lưu mọi thay đổi
	SELECT * FROM Product ORDER BY ProductId DESC
