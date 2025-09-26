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
(N'Nguyễn Văn An', '1980-01-01', N'Nam', '0901234567', N'123 Nguyễn Trãi, Q1, TP.HCM', 'manager', 'manager123', 'Manager', 15000000),
(N'Trần Thị Bình', '1990-05-15', N'Nữ', '0907654321', N'456 Lê Lợi, Q3, TP.HCM', 'staff1', 'staff123', 'Staff', 8000000),
(N'Lê Văn Cường', '1992-08-20', N'Nam', '0912345678', N'789 Nguyễn Huệ, Q1, TP.HCM', 'staff2', 'staff123', 'Staff', 8500000);

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