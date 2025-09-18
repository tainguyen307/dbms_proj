DROP DATABASE CuaHangBanSach
GO

CREATE DATABASE CuaHangBanSach
GO

USE CuaHangBanSach
GO

------------------------------------------------------
-- 1. Bảng NguoiDung
------------------------------------------------------
CREATE TABLE NguoiDung (
    MaNguoiDung INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    SDT VARCHAR(15),
    DiaChi NVARCHAR(200),
    TenDangNhap VARCHAR(50) UNIQUE,
    MatKhau VARCHAR(255),
    VaiTro NVARCHAR(50),
    Luong DECIMAL(18,2)
);

------------------------------------------------------
-- 2. Bảng HoaDon
------------------------------------------------------
CREATE TABLE HoaDon (
    MaHD INT IDENTITY(1,1) PRIMARY KEY,
    NgayLapHD DATE,
    TinhTrangTT NVARCHAR(50),
    TongTien DECIMAL(18,2),
    PhuongThucTT NVARCHAR(50),
    MaNguoiDung INT NOT NULL,
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);

------------------------------------------------------
-- 3. Bảng DonNhap
------------------------------------------------------
CREATE TABLE DonNhap (
    MaDN INT IDENTITY(1,1) PRIMARY KEY,
    NgayLapDN DATE,
    TongTien DECIMAL(18,2),
    TinhTrangNhap NVARCHAR(50),
    MaNguoiDung INT NOT NULL,
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung)
);

------------------------------------------------------
-- 4. Bảng NhaCungCap
------------------------------------------------------
CREATE TABLE NhaCungCap (
    MaNCC INT IDENTITY(1,1) PRIMARY KEY,
    TenNCC NVARCHAR(100),
    DienThoai VARCHAR(15),
    DiaChi NVARCHAR(200),
    Website NVARCHAR(200)
);

------------------------------------------------------
-- 5. Bảng Sach
------------------------------------------------------
CREATE TABLE Sach (
    MaSach INT IDENTITY(1,1) PRIMARY KEY,
    TenSach NVARCHAR(200),
    TacGia NVARCHAR(100),
    NhaXuatBan NVARCHAR(100),
    NamXuatBan INT,
    TheLoai NVARCHAR(100),
    NgonNgu NVARCHAR(50),
    DonGia DECIMAL(18,2),
    SLTonKho INT,
    AnhBia NVARCHAR(255)
);

------------------------------------------------------
-- 6. Bảng ChiTietHoaDon
------------------------------------------------------
CREATE TABLE ChiTietHoaDon (
    MaHD INT NOT NULL,
    MaSach INT NOT NULL,
    SoLuong INT,
    ThanhTien DECIMAL(18,2),
    PRIMARY KEY (MaHD, MaSach),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);

------------------------------------------------------
-- 7. Bảng ChiTietDonNhap
------------------------------------------------------
CREATE TABLE ChiTietDonNhap (
    MaDN INT NOT NULL,
    MaSach INT NOT NULL,
	MaNCC INT NOT NULL,
    SoLuong INT,
    ThanhTien DECIMAL(18,2),
    PRIMARY KEY (MaDN, MaSach, MaNCC),
    FOREIGN KEY (MaDN) REFERENCES DonNhap(MaDN),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach),
	FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC)
);

------------------------------------------------------
-- 8. Bảng HoiVien
------------------------------------------------------
CREATE TABLE HoiVien (
    MaHoiVien INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    SDT VARCHAR(15),
    DiaChi NVARCHAR(200),
    NgayDangKy DATE,
    NgayHetHan DATE,
    LoaiThe NVARCHAR(50),
    DiemTichLuy INT
);

------------------------------------------------------
-- 9. Quan hệ DangKyHoiVien
------------------------------------------------------
CREATE TABLE DangKyHoiVien (
    MaNguoiDung INT NOT NULL,
    MaHoiVien INT NOT NULL,
    PRIMARY KEY (MaNguoiDung, MaHoiVien),
    FOREIGN KEY (MaNguoiDung) REFERENCES NguoiDung(MaNguoiDung),
    FOREIGN KEY (MaHoiVien) REFERENCES HoiVien(MaHoiVien)
);
