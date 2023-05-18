USE [master] -- Chuyển qua master
DROP DATABASE COM2034_SD18317 -- Xóa db 

CREATE DATABASE COM2034_SD18317 -- Tạo db
USE COM2034_SD18317 -- Dùng db vừa tạo

CREATE TABLE NhanVien(
	MaNhanVien	VARCHAR(10) PRIMARY KEY,
	TenNhanVien	NVARCHAR(50),
	DiaChi		NVARCHAR(MAX),
	SoDienThoai	VARCHAR(15),
	LuongCoBan	MONEY,
	HeSoLuong	FLOAT
);

-- Insert kiểu 1: Đầy đủ
INSERT INTO NhanVien
		(MaNhanVien, TenNhanVien, DiaChi, SoDienThoai, LuongCoBan, HeSoLuong)
	VALUES
		('DungNA29', N'Nguyễn Anh Dũng', N'Hà Nội', '0912345678', 5000000, 1.5),
		('TienNH21', N'Nguyễn Hoàng Tiến', N'Hà Nội', '0812345678', 4500000, 1.3)

-- Insert kiểu 2: Đầy đủ ngầm định
INSERT INTO NhanVien
	VALUES
		('LinhTD15', N'Trịnh Dương Linh', NULL, '0812345678', 4500000, 1.5)

-- Insert kiểu 3: Một phần
INSERT INTO NhanVien
		(MaNhanVien, TenNhanVien, SoDienThoai)
	VALUES
		('HangNT169', N'Nguyễn Thúy Hằng', '0312456789'),
		('NguyenVV4', N'Vũ Văn Nguyên', NULL)

-- Cập nhật thông tin
UPDATE NhanVien
	SET DiaChi = N'Thái Bình'
	WHERE MaNhanVien LIKE 'NguyenVV4'

-- Case Study 1: Hiển thị Thu nhập của từng nhân viên biết:
--	Thu nhập = Lương cơ bản * Hệ số lương
SELECT MaNhanVien AS 'Mã nhân viên', 
	LuongCoBan * HeSoLuong AS 'Thu nhập'
	 FROM NhanVien
-- BONUS 1: Làm thế nào hiển thị Thu nhập có giá trị NULL bằng 'Chưa biết'

-- Case Study 2: Thêm hậu tố 'VNĐ' đằng sau thông tin Lương cơ bản
--	Luong Co Ban (MONEY) + 'VNĐ' (VARCHAR) -> Không được
--	Ép kiểu: MONEY -> VARCHAR => OK
-- Ép kiểu Kiểu 1: Dùng hàm CONVERT([Kiểu dữ liệu], [Giá trị])
SELECT 'FPL ' + MaNhanVien,
	CONVERT(VARCHAR, LuongCoBan) + ' VNĐ'
	FROM NhanVien
-- Ép kiểu Kiểu 2: ... (BONUS 2)

-- Case Study 3: Hiển thị Nhà mạng viễn thông mà Nhân viên đang sử dụng dịch vụ
--	Biết: Đầu số '08' của VNPT, '03' của Viettel, '09' của FPT
-- Hint: Cắt chuỗi -> Lấy 2 ký tự đầu tiên -> Switch case
SELECT MaNhanVien, 
	CASE 
		WHEN LEFT(SoDienThoai, 2) LIKE '03' THEN 'Viettel'
		WHEN SUBSTRING(SoDienThoai, 1, 2) LIKE '08' THEN 'VNPT'
		WHEN LEFT(SoDienThoai, 2) LIKE '09' THEN 'FPT'
		ELSE N'Chịu'
	END AS 'Nhà mạng'
	FROM NhanVien

-- Thay đổi cấu trúc bảng, thêm cột ngày tháng năm sinh
ALTER TABLE NhanVien ADD SinhNhat DATE;
UPDATE NhanVien SET SinhNhat = '2005-01-31' WHERE MaNhanVien LIKE 'DungNA29'
UPDATE NhanVien SET SinhNhat = '2000-06-22' WHERE MaNhanVien LIKE 'TienNH21'
UPDATE NhanVien SET SinhNhat = '2004-9-3' WHERE MaNhanVien LIKE 'LinhTD15'
UPDATE NhanVien SET SinhNhat = '2003-10-11' WHERE MaNhanVien LIKE 'HangNT169'
UPDATE NhanVien SET SinhNhat = '2001-12-31' WHERE MaNhanVien LIKE 'NguyenVV4'

-- Case Study 4: Hiển thị nhân viên và số tuổi hiện tại tương ứng
--	Hàm YEAR([Giá trị kiểu DATE]) -> Lấy năm
--	Hàm GETDATE() -> Lấy thời gian hiện tại của hệ thống
--		=> Năm hiện tại = YEAR(GETDATE())
--	Số tuổi = Năm hiện tại - Năm sinh
SELECT MaNhanVien,
	 YEAR(SinhNhat) AS 'Năm sinh',
	 GETDATE() AS 'Thời gian hiện tại',
	 YEAR(GETDATE()) AS 'Năm hiện tại'
	FROM NhanVien

-- Excercise 4.1: Hiển thị danh sách nhân viên sinh nhật tháng này
--	Hàm MONTH([Giá trị kiểu DATE]) -> Lấy tháng sinh

-- Excercise 4.2: Hiển thị danh sách nhân viên sinh vào thứ 2
--	Hàm DATENAME ???

-- Excercise 5: Hiển thị Thu nhập của từng nhân viên bằng đơn vị Triệu VNĐ
--	Ví dụ: 5000000 -> 5 triệu VNĐ, 834134324 -> 834,134324 triệu VNĐ
--	BONUS: Hiển thị đúng thu nhập
