-- Xây dựng hàm người dùng tự định nghĩa (User Defined Function)
USE [COM2034_SD18317]

-- Case Study 1: Viết hàm loại bỏ khoảng trống ở trái lẫn phải
-- Thay vì: LTRIM(RTRIM([Chuỗi])) -> Viết ngắn hơn MY_TRIM([Chuỗi])
CREATE FUNCTION MY_TRIM -- Định nghĩa Tên hàm
( 
	-- Định nghĩa các tham số của hàm
	@Chuoi	VARCHAR
)
RETURNS VARCHAR -- Định nghĩa kiểu dữ liệu trả về
AS BEGIN
	RETURN LTRIM(RTRIM(@Chuoi))
END
--	Để thực thi hàm
SELECT dbo.MY_TRIM('   Hello   ') -- => Trả về chuỗi rỗng

-- Để sửa hàm, sử dụng từ khóa ALTER
ALTER FUNCTION MY_TRIM
( 
	@Chuoi	VARCHAR(MAX) -- Định nghĩa lại kiểu dữ liệu truyền vào
)
RETURNS VARCHAR(MAX) -- Định nghĩa lại kiểu dữ liệu trả về
AS BEGIN
	RETURN LTRIM(RTRIM(@Chuoi))
END

SELECT dbo.MY_TRIM('   Hello   ') -- => Trả về đầy đủ thông tin

-- Case Study 2: Viết hàm tính tổng từ 2 số truyền vào
--	Hàm: Tinh_Tong([Số thứ nhất], [Số thứ hai])
CREATE FUNCTION Tinh_Tong
(
	@SoThuNhat	INT,
	@SoThuHai	INT
) 
RETURNS INT AS BEGIN
	-- Khai báo biến
	DECLARE @Tong INT;
	-- Gán trị cho biến
	SET @Tong = @SoThuNhat + @SoThuHai;
	-- Trả về giá trị
	RETURN @Tong
END

SELECT dbo.Tinh_Tong(1,2)
-- Excercise: Viết hàm tính hiệu, hàm tính tích, hàm tính thương 
--	từ 2 số truyền vào. Tinh_Tich(), Tinh_Hieu(), Tinh_Thuong()

-- Case Study 3: Viết hàm chuyển đổi đơn vị tiền tệ kèm đơn vị
--	từ USD -> VND. Hàm Usd2Vnd(1) = '23455 VNĐ'
CREATE FUNCTION Usd2Vnd
(
	@TienUsd	MONEY -- Tham số chứa giá tiền ở Usd
)
RETURNS VARCHAR(MAX) AS BEGIN
	-- Khai báo biến lưu tiền ở Vnđ
	DECLARE @TienVnd MONEY
	-- Gán giá trị, quy đổi mệnh giá, 1 usd = 23455 vnđ
	SET @TienVnd = @TienUsd * 23455

	-- Khai báo biến lưu giá trị tiền dạng chuỗi kèm đơn vị
	DECLARE @TienVndKemDonVi VARCHAR(MAX)
	-- Gán giá trị, ép kiểu số sang chữ và cộng chuỗi
	SET @TienVndKemDonVi = CONVERT(VARCHAR, @TienVnd) + ' VNĐ'

	-- Trả kết quả
	RETURN @TienVndKemDonVi
END
SELECT dbo.Usd2Vnd(1)

--	Excercise: Viết hàm chuyển đổi đơn vị tiền tệ từ 
--		Tiền Sing -> Tiền việt, Tiền Trung -> Việt, Tiền Nga -> Tiền Việt
