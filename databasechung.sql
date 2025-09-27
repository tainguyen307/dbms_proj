CREATE DATABASE CuaHangBanSach
GO
USE CuaHangBanSach
GO

------------------------------------------------------
-- TABLES
------------------------------------------------------

-- 1. Bảng NguoiDung
CREATE TABLE NguoiDung (
    MaNguoiDung INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    SDT VARCHAR(15),
    DiaChi NVARCHAR(200),
    TenDangNhap VARCHAR(50) UNIQUE,
    MatKhau VARCHAR(255),
    VaiTro NVARCHAR(50) CHECK (VaiTro IN ('Manager', 'Staff')),
    Luong DECIMAL(18,2),
    NgayTao DATETIME DEFAULT GETDATE(),
    NguoiTao INT,
    TrangThai NVARCHAR(20) DEFAULT N'Hoạt động'
);

-- 2. Bảng HoaDon
CREATE TABLE HoaDon (
    MaHD INT IDENTITY(1,1) PRIMARY KEY,
    NgayLapHD DATE DEFAULT CAST(GETDATE() AS DATE),
    TinhTrangTT NVARCHAR(50) DEFAULT N'Chưa thanh toán',
    TongTien DECIMAL(18,2) DEFAULT 0,
    PhuongThucTT NVARCHAR(50),
    MaNguoiDung INT NOT NULL,
    MaHoiVien INT NULL,
    GhiChu NVARCHAR(500),
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);

-- 3. Bảng DonNhap
CREATE TABLE DonNhap (
    MaDN INT IDENTITY(1,1) PRIMARY KEY,
    NgayLapDN DATE DEFAULT CAST(GETDATE() AS DATE),
    TongTien DECIMAL(18,2) DEFAULT 0,
    TinhTrangNhap NVARCHAR(50) DEFAULT N'Chờ duyệt',
    MaNguoiDung INT NOT NULL,
    GhiChu NVARCHAR(500),
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);

-- 4. Bảng NhaCungCap
CREATE TABLE NhaCungCap (
    MaNCC INT IDENTITY(1,1) PRIMARY KEY,
    TenNCC NVARCHAR(100),
    DienThoai VARCHAR(15),
    DiaChi NVARCHAR(200),
    Website NVARCHAR(200),
    Email NVARCHAR(100)
);

-- 5. Bảng Sach
CREATE TABLE Sach (
    MaSach INT IDENTITY(1,1) PRIMARY KEY,
    TenSach NVARCHAR(200),
    TacGia NVARCHAR(100),
    NhaXuatBan NVARCHAR(100),
    NamXuatBan INT,
    TheLoai NVARCHAR(100),
    NgonNgu NVARCHAR(50),
    DonGia DECIMAL(18,2),
    SLTonKho INT DEFAULT 0,
    AnhBia NVARCHAR(255),
    NgayCapNhat DATETIME DEFAULT GETDATE(),
    TrangThai NVARCHAR(20) DEFAULT N'Có bán',
    MoTa NVARCHAR(1000)
);

-- 6. Bảng ChiTietHoaDon
CREATE TABLE ChiTietHoaDon (
    MaHD INT NOT NULL,
    MaSach INT NOT NULL,
    SoLuong INT,
    DonGia DECIMAL(18,2),
    ThanhTien DECIMAL(18,2),
    PRIMARY KEY (MaHD, MaSach),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);

-- 7. Bảng ChiTietDonNhap
CREATE TABLE ChiTietDonNhap (
    MaDN INT NOT NULL,
    MaSach INT NOT NULL,
    MaNCC INT NOT NULL,
    SoLuong INT,
    GiaNhap DECIMAL(18,2),
    ThanhTien DECIMAL(18,2),
    PRIMARY KEY (MaDN, MaSach, MaNCC),
    FOREIGN KEY (MaDN) REFERENCES DonNhap(MaDN),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach),
    FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC)
);

-- 8. Bảng HoiVien
CREATE TABLE HoiVien (
    MaHoiVien INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    SDT VARCHAR(15),
    DiaChi NVARCHAR(200),
    Email NVARCHAR(100),
    NgayDangKy DATE DEFAULT CAST(GETDATE() AS DATE),
    NgayHetHan DATE,
    LoaiThe NVARCHAR(50) DEFAULT N'Thường',
    DiemTichLuy INT DEFAULT 0,
    TrangThai NVARCHAR(20) DEFAULT N'Hoạt động'
);

-- 9. Quan hệ DangKyHoiVien
CREATE TABLE DangKyHoiVien (
    MaNguoiDung INT NOT NULL,
    MaHoiVien INT NOT NULL,
    NgayDangKy DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (MaNguoiDung, MaHoiVien),
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung),
    FOREIGN KEY (MaHoiVien) REFERENCES HoiVien(MaHoiVien)
);

-- 10. Bảng LogHoatDong
CREATE TABLE LogHoatDong (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    MaNguoiDung INT,
    HanhDong NVARCHAR(100),
    ChiTiet NVARCHAR(500),
    ThoiGian DATETIME DEFAULT GETDATE(),
    IPAddress VARCHAR(45),
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);

-- 11. Bảng ThongBao
CREATE TABLE ThongBao (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NoiDung NVARCHAR(500),
    NgayTao DATETIME DEFAULT GETDATE(),
    TrangThai NVARCHAR(50) DEFAULT N'Chưa xem',
    MaNguoiDung INT,
    LoaiThongBao NVARCHAR(50) DEFAULT N'Thông tin',
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);

-- 12. Bảng CauHinh (cho hệ thống)
CREATE TABLE CauHinh (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    TenCauHinh NVARCHAR(100),
    GiaTri NVARCHAR(500),
    MoTa NVARCHAR(200),
    NgayCapNhat DATETIME DEFAULT GETDATE()
);

-- 13. Bảng KhuyenMai
CREATE TABLE KhuyenMai (
    MaKM INT IDENTITY(1,1) PRIMARY KEY,
    TenKM NVARCHAR(100),
    NgayBatDau DATE,
    NgayKetThuc DATE,
    LoaiKM NVARCHAR(50), -- 'Percent' hoặc 'Amount'
    GiaTriKM DECIMAL(18,2),
    DieuKienToiThieu DECIMAL(18,2) DEFAULT 0,
    TrangThai NVARCHAR(20) DEFAULT N'Hoạt động',
    MoTa NVARCHAR(500)
);

------------------------------------------------------
-- CONSTRAINTS & INDEXES
------------------------------------------------------

-- Thêm ràng buộc
ALTER TABLE HoaDon ADD CONSTRAINT CK_HoaDon_TongTien CHECK (TongTien >= 0);
ALTER TABLE Sach ADD CONSTRAINT CK_Sach_DonGia CHECK (DonGia >= 0);
ALTER TABLE Sach ADD CONSTRAINT CK_Sach_SLTonKho CHECK (SLTonKho >= 0);
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT CK_ChiTietHoaDon_SoLuong CHECK (SoLuong > 0);
ALTER TABLE HoiVien ADD CONSTRAINT CK_HoiVien_DiemTichLuy CHECK (DiemTichLuy >= 0);
ALTER TABLE NguoiDung ADD CONSTRAINT CK_NguoiDung_Luong CHECK (Luong >= 0);
ALTER TABLE DonNhap ADD CONSTRAINT CK_DonNhap_TongTien CHECK (TongTien >= 0);
ALTER TABLE ChiTietDonNhap ADD CONSTRAINT CK_ChiTietDonNhap_SoLuong CHECK (SoLuong > 0);
ALTER TABLE ChiTietDonNhap ADD CONSTRAINT CK_ChiTietDonNhap_GiaNhap CHECK (GiaNhap >= 0);
ALTER TABLE ChiTietDonNhap ADD CONSTRAINT CK_ChiTietDonNhap_ThanhTien CHECK (ThanhTien >= 0);

-- Thêm khóa ngoại cho HoaDon-HoiVien
ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDon_HoiVien
FOREIGN KEY (MaHoiVien) REFERENCES HoiVien(MaHoiVien)
ON DELETE SET NULL;

-- Thêm indexes để tối ưu performance
CREATE INDEX IX_HoaDon_NgayLapHD ON HoaDon(NgayLapHD);
CREATE INDEX IX_HoaDon_TinhTrangTT ON HoaDon(TinhTrangTT);
CREATE INDEX IX_Sach_TheLoai ON Sach(TheLoai);
CREATE INDEX IX_Sach_TacGia ON Sach(TacGia);
CREATE INDEX IX_HoiVien_SDT ON HoiVien(SDT);
CREATE INDEX IX_LogHoatDong_ThoiGian ON LogHoatDong(ThoiGian);
CREATE INDEX IX_NguoiDung_VaiTro ON NguoiDung(VaiTro);
CREATE INDEX IX_NguoiDung_TrangThai ON NguoiDung(TrangThai);

------------------------------------------------------
-- DATA SAMPLES
------------------------------------------------------

-- Cấu hình hệ thống
INSERT INTO CauHinh (TenCauHinh, GiaTri, MoTa) VALUES
(N'DiemTichLuy_TyLe', N'10000', N'Số tiền để tích 1 điểm'),
(N'TonKho_ToiThieu', N'5', N'Số lượng tồn kho tối thiểu để cảnh báo'),
(N'HoiVien_HanThe', N'365', N'Số ngày hiệu lực thẻ hội viên');

-- Thêm Manager và Staff
INSERT INTO NguoiDung (HoTen, NgaySinh, GioiTinh, SDT, DiaChi, TenDangNhap, MatKhau, VaiTro, Luong) VALUES 
(N'Nguyễn Văn An', '1980-01-01', N'Nam', '0901234567', N'123 Nguyễn Trãi, Q1, TP.HCM', 'manager', 'manager123', 'Manager', 15000000);
INSERT INTO NguoiDung (HoTen, NgaySinh, GioiTinh, SDT, DiaChi, TenDangNhap, MatKhau, VaiTro, Luong, NguoiTao) VALUES 
(N'Trần Thị Bình', '1990-05-15', N'Nữ', '0907654321', N'456 Lê Lợi, Q3, TP.HCM', 'staff1', 'staff123', 'Staff', 8000000, 1),
(N'Lê Văn Cường', '1992-08-20', N'Nam', '0912345678', N'789 Nguyễn Huệ, Q1, TP.HCM', 'staff2', 'staff123', 'Staff', 8500000, 1),
(N'Phạm Văn Đức', '1993-10-10', N'Nam', '0935678901', N'321 Lý Thường Kiệt, Q5, TP.HCM', 'staff3', 'staff123', 'Staff', 8500000,1 );

-- Thêm nhà cung cấp
INSERT INTO NhaCungCap (TenNCC, DienThoai, DiaChi, Website, Email) VALUES 
(N'NXB Kim Đồng', '0283123456', N'55 Quang Trung, Hai Bà Trưng, Hà Nội', 'kimdong.com.vn', 'info@kimdong.com.vn'),
(N'NXB Trẻ', '0283654321', N'161B Lý Chính Thắng, Q3, TP.HCM', 'nxbtre.com.vn', 'info@nxbtre.com.vn'),
(N'NXB Giáo Dục Việt Nam', '0284567890', N'81 Trần Hưng Đạo, Hoàn Kiếm, Hà Nội', 'nxbgd.vn', 'contact@nxbgd.vn');

-- Thêm sách đa dạng
INSERT INTO Sach (TenSach, TacGia, NhaXuatBan, NamXuatBan, TheLoai, NgonNgu, DonGia, SLTonKho, MoTa) VALUES 
(N'Doraemon - Tập 45', N'Fujiko F. Fujio', N'Kim Đồng', 2023, N'Truyện tranh', N'Tiếng Việt', 25000, 100, N'Tập truyện mới nhất của Doraemon'),
(N'Thám Tử Lừng Danh Conan - Tập 102', N'Aoyama Gosho', N'Kim Đồng', 2023, N'Truyện tranh', N'Tiếng Việt', 30000, 80, N'Câu chuyện trinh thám hấp dẫn'),
(N'Đắc Nhân Tâm', N'Dale Carnegie', N'NXB Trẻ', 2020, N'Kỹ năng sống', N'Tiếng Việt', 120000, 50, N'Cuốn sách kinh điển về kỹ năng giao tiếp'),
(N'Sapiens - Lược Sử Loài Người', N'Yuval Noah Harari', N'NXB Trẻ', 2022, N'Khoa học', N'Tiếng Việt', 250000, 30, N'Cuốn sách về tiến hóa của loài người'),
(N'Toán Lớp 12', N'Nhóm tác giả', N'NXB Giáo Dục', 2023, N'Giáo khoa', N'Tiếng Việt', 45000, 200, N'Sách giáo khoa Toán lớp 12');

-- Thêm hội viên
INSERT INTO HoiVien (HoTen, NgaySinh, GioiTinh, SDT, DiaChi, Email, LoaiThe) VALUES 
(N'Phạm Thị Lan', '1995-03-20', N'Nữ', '0912345678', N'789 Võ Văn Tần, Q3, TP.HCM', 'lan.pham@email.com', N'VIP'),
(N'Hoàng Minh Tuấn', '1988-12-10', N'Nam', '0923456789', N'123 Điện Biên Phủ, Q1, TP.HCM', 'tuan.hoang@email.com', N'Gold'),
(N'Nguyễn Thị Mai', '1992-07-15', N'Nữ', '0934567890', N'456 Cách Mạng Tháng 8, Q10, TP.HCM', 'mai.nguyen@email.com', N'Thường');

-- Thêm khuyến mãi
INSERT INTO KhuyenMai (TenKM, NgayBatDau, NgayKetThuc, LoaiKM, GiaTriKM, DieuKienToiThieu, MoTa) VALUES 
(N'Giảm giá sách giáo khoa', '2024-08-01', '2024-09-30', N'Percent', 10, 100000, N'Giảm 10% cho sách giáo khoa khi mua từ 100k'),
(N'Ưu đãi hội viên VIP', '2024-01-01', '2024-12-31', N'Percent', 15, 0, N'Giảm 15% cho tất cả hội viên VIP');

-- Thêm hóa đơn
INSERT INTO HoaDon (NgayLapHD, TinhTrangTT, TongTien, PhuongThucTT, MaNguoiDung, MaHoiVien, GhiChu) VALUES
('2024-08-01', N'Đã thanh toán', 445000.00, N'Tiền mặt', 2, 1, N'Khách hàng hội viên VIP'),
('2024-08-02', N'Đã thanh toán', 120000.00, N'Chuyển khoản', 3, NULL, N'Khách mua sách kỹ năng'),
('2024-08-03', N'Chưa thanh toán', 360000.00, N'Tiền mặt', 2, 2, N'Khách hàng hội viên Gold - chờ thanh toán'),
('2024-08-04', N'Đã thanh toán', 45000.00, N'Tiền mặt', 3, 3, N'Mua sách giáo khoa'),
('2024-08-05', N'Đã thanh toán', 545000.00, N'Thẻ tín dụng', 2, 1, N'Khách VIP mua nhiều sách');

-- Thêm dữ liệu vào bảng ChiTietHoaDon
INSERT INTO ChiTietHoaDon (MaHD, MaSach, SoLuong, DonGia, ThanhTien) VALUES
-- Hóa đơn 1: Khách VIP mua 3 loại sách
(1, 1, 3, 25000, 75000),   -- 3 cuốn Doraemon
(1, 3, 1, 120000, 120000), -- 1 cuốn Đắc Nhân Tâm
(1, 4, 1, 250000, 250000), -- 1 cuốn Sapiens
-- Hóa đơn 2: Khách thường mua sách kỹ năng
(2, 3, 1, 120000, 120000), -- 1 cuốn Đắc Nhân Tâm
-- Hóa đơn 3: Khách Gold mua truyện tranh (chưa thanh toán)
(3, 1, 2, 25000, 50000),   -- 2 cuốn Doraemon
(3, 2, 2, 30000, 60000),   -- 2 cuốn Conan
(3, 4, 1, 250000, 250000), -- 1 cuốn Sapiens
-- Hóa đơn 4: Khách thường mua sách giáo khoa
(4, 5, 1, 45000, 45000),   -- 1 cuốn Toán 12
-- Hóa đơn 5: Khách VIP mua nhiều sách
(5, 1, 5, 25000, 125000),  -- 5 cuốn Doraemon
(5, 2, 3, 30000, 90000),   -- 3 cuốn Conan
(5, 3, 2, 120000, 240000), -- 2 cuốn Đắc Nhân Tâm
(5, 5, 2, 45000, 90000);   -- 2 cuốn Toán 12


-- Tạo login trong master
CREATE LOGIN manager WITH PASSWORD = 'manager123';
CREATE LOGIN staff1 WITH PASSWORD = 'staff123';
CREATE LOGIN staff2 WITH PASSWORD = 'staff123';
CREATE LOGIN staff3 WITH PASSWORD = 'staff123';

-- Disable login staff2
ALTER LOGIN staff2 DISABLE;

-- Chuyển sang database CuaHangBanSach
USE CuaHangBanSach;

-- Tạo user cho các login
CREATE USER manager FOR LOGIN manager;
CREATE USER staff1 FOR LOGIN staff1;
CREATE USER staff2 FOR LOGIN staff2;
CREATE USER staff3 FOR LOGIN staff3;

-- Tạo vai trò db_manager và db_staff
CREATE ROLE db_manager;
CREATE ROLE db_staff;

-- Gán user vào vai trò
EXEC sp_addrolemember 'db_manager', 'manager';
EXEC sp_addrolemember 'db_staff', 'staff1';
EXEC sp_addrolemember 'db_staff', 'staff2';
EXEC sp_addrolemember 'db_staff', 'staff3';

-- Cấp quyền cho db_manager
GRANT SELECT, INSERT, UPDATE, DELETE ON NguoiDung TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON HoaDon TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON DonNhap TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON NhaCungCap TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON Sach TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON ChiTietHoaDon TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON ChiTietDonNhap TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON HoiVien TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON DangKyHoiVien TO db_manager;
GRANT SELECT, INSERT ON LogHoatDong TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON ThongBao TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON CauHinh TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON KhuyenMai TO db_manager;
GRANT EXECUTE ON sp_CapNhatNhanVien TO db_manager;
GRANT EXECUTE ON sp_XoaNhanVien TO db_manager;

-- Cấp quyền cho db_staff
GRANT SELECT, INSERT, UPDATE ON HoaDon TO db_staff;
GRANT SELECT, INSERT, UPDATE ON ChiTietHoaDon TO db_staff;
GRANT SELECT ON Sach TO db_staff;
GRANT SELECT ON NhaCungCap TO db_staff;
GRANT SELECT ON HoiVien TO db_staff;
GRANT SELECT ON KhuyenMai TO db_staff;
GRANT INSERT ON LogHoatDong TO db_staff;
GRANT SELECT, INSERT, UPDATE ON ThongBao TO db_staff;

-- Cấp quyền cho manager
USE master;
GRANT ALTER ANY LOGIN TO manager;
USE CuaHangBanSach;
GRANT ALTER ANY USER TO manager;
GRANT ALTER ANY ROLE TO manager;

-- Đồng bộ trạng thái staff2 trong NguoiDung
UPDATE NguoiDung
SET TrangThai = N'Ngừng hoạt động'
WHERE TenDangNhap = 'staff2';