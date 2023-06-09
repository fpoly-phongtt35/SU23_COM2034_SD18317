-- Các loại hàm đã biết:
-- 1. Ép kiểu (tường minh): CONVERT([Kiểu dữ liệu], [Giá trị])
SELECT 'FPL ' + ' SD18317' -- Chuỗi + Chuỗi = OK
SELECT 5000 + ' VNĐ' -- Số + Chuỗi = NOT OK
SELECT 5000 + '000' -- Ép kiểu ngầm định = 5000 + 0 = 5000
SELECT '5000' + 1 
SELECT CONVERT(VARCHAR, 5000) + ' VNĐ'

-- 2. Xử lý thời gian
--	Lấy thời gian hiện tại: GETDATE()
SELECT GETDATE()
--	Lấy năm của thời gian: YEAR([Giá trị thời gian])
SELECT YEAR(GETDATE()) -- Lấy năm hiện tại
SELECT YEAR('2004-05-31')
--	Lấy tháng - MONTH(), ngày - DAY(), thứ - WEEKDAY()
--	Q: Liệu có thể lấy được giờ? phút? giây?
--	Lấy tên của thời gian truyền vào DATENAME([Khoảng thời gian], [Giá trị thời gian])
--		[Khoảng thời gian]: YEAR, MONTH, DAY, WEEK, WEEKDAY, HOUR, SECOND, MINUTE,...
--		Hàm DATENAME trả về CHUỖI
SELECT DATENAME(MONTH, GETDATE()) -- Tên tháng hiện tại (Dạng chuỗi)
SELECT MONTH(GETDATE()) -- Giá trị tháng hiện tại (Dạng số)

-- 3. Xử lý chuỗi
--	Độ dài chuỗi LEN([Chuỗi])
SELECT LEN('Hello, SD18317')
--	Cắt chuỗi SUBSTRING([Chuỗi], [Điểm bắt đầu], [Độ dài cắt])
SELECT SUBSTRING('Hello, SD18317', 1, 5)
--	Cắt chuỗi từ bên trái LEFT([Chuỗi], [Độ dài cắt])
SELECT LEFT('Hello, SD18317', 5) -- = SUBSTRING([Chuỗi], 1, [Độ dài cắt])
--	Cắt chuỗi từ bên phải RIGHT([Chuỗi], [Độ dài cắt])
SELECT RIGHT('Hello, SD18317', 7) -- = SUBSTRING([Chuỗi], ??? , [Độ dài cắt]) + BONUS
--	Loại bỏ khoảng trống bên trái LTRIM([Chuỗi])
SELECT LTRIM('    Hello    ')
--	Loại bỏ khoảng trống bên phải RTRIM([Chuỗi])
SELECT RTRIM('    Hello    ')
--	Loại bỏ khoảng trống ở trái lẫn phải
SELECT LTRIM(RTRIM('    Hello    ')) -- Lồng hàm
--	Đảo ngược thứ tự chuỗi
SELECT REVERSE('Hello, SD18317')