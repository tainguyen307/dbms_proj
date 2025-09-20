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
    Email NVARCHAR(100),
    TrangThai NVARCHAR(20) DEFAULT N'Hoạt động'
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
-- VIEWS
------------------------------------------------------

-- View 1: Thông tin bán hàng tổng hợp
GO
CREATE VIEW vw_ThongTinBanHang AS
SELECT 
    hd.MaHD,
    hd.NgayLapHD,
    nd.HoTen AS NhanVien,
    hv.HoTen AS KhachHang,
    hv.LoaiThe,
    hd.TongTien,
    hd.TinhTrangTT,
    hd.PhuongThucTT,
    COUNT(ct.MaSach) AS SoLoaiSach,
    SUM(ct.SoLuong) AS TongSoLuong
FROM HoaDon hd
JOIN NguoiDung nd ON hd.MaNguoiDung = nd.MaNguoiDung
LEFT JOIN HoiVien hv ON hd.MaHoiVien = hv.MaHoiVien
LEFT JOIN ChiTietHoaDon ct ON hd.MaHD = ct.MaHD
GROUP BY hd.MaHD, hd.NgayLapHD, nd.HoTen, hv.HoTen, hv.LoaiThe, 
         hd.TongTien, hd.TinhTrangTT, hd.PhuongThucTT;

-- View 2: Báo cáo tồn kho
GO
CREATE VIEW vw_BaoCaoTonKho AS
SELECT 
    s.MaSach,
    s.TenSach,
    s.TacGia,
    s.TheLoai,
    s.DonGia,
    s.SLTonKho,
    s.SLTonKho * s.DonGia AS GiaTriTonKho,
    CASE 
        WHEN s.SLTonKho <= 5 THEN N'Cần nhập'
        WHEN s.SLTonKho <= 20 THEN N'Sắp hết'
        ELSE N'Đủ hàng'
    END AS TinhTrangKho,
    s.NgayCapNhat
FROM Sach s
WHERE s.TrangThai = N'Có bán';

-- View 3: Top sách bán chạy
GO
CREATE VIEW vw_TopSachBanChay AS
SELECT TOP 20
    s.MaSach,
    s.TenSach,
    s.TacGia,
    s.TheLoai,
    s.DonGia,
    SUM(ct.SoLuong) AS TongSoLuongBan,
    SUM(ct.ThanhTien) AS TongDoanhThu,
    COUNT(DISTINCT ct.MaHD) AS SoLanBan,
    AVG(CAST(ct.SoLuong AS FLOAT)) AS SoLuongTrungBinh
FROM Sach s
JOIN ChiTietHoaDon ct ON s.MaSach = ct.MaSach
JOIN HoaDon hd ON ct.MaHD = hd.MaHD
WHERE hd.TinhTrangTT = N'Đã thanh toán'
GROUP BY s.MaSach, s.TenSach, s.TacGia, s.TheLoai, s.DonGia
ORDER BY TongSoLuongBan DESC;

-- View 4: Doanh thu theo tháng
GO
CREATE VIEW vw_DoanhThuTheoThang AS
SELECT 
    YEAR(NgayLapHD) AS Nam,
    MONTH(NgayLapHD) AS Thang,
    COUNT(*) AS SoHoaDon,
    SUM(TongTien) AS TongDoanhThu,
    AVG(TongTien) AS DoanhThuTrungBinh,
    SUM(CASE WHEN MaHoiVien IS NOT NULL THEN TongTien ELSE 0 END) AS DoanhThuHoiVien,
    SUM(CASE WHEN MaHoiVien IS NULL THEN TongTien ELSE 0 END) AS DoanhThuKhachLe
FROM HoaDon
WHERE TinhTrangTT = N'Đã thanh toán'
GROUP BY YEAR(NgayLapHD), MONTH(NgayLapHD);

------------------------------------------------------
-- STORED PROCEDURES
------------------------------------------------------

-- Procedure 1: Đăng nhập
GO
CREATE PROCEDURE sp_DangNhap
    @TenDangNhap VARCHAR(50),
    @MatKhau VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @MaNguoiDung INT, @VaiTro NVARCHAR(50), @TrangThai NVARCHAR(20);
    
    SELECT @MaNguoiDung = MaNguoiDung, @VaiTro = VaiTro, @TrangThai = TrangThai
    FROM NguoiDung 
    WHERE TenDangNhap = @TenDangNhap AND MatKhau = @MatKhau;
    
    IF @MaNguoiDung IS NULL
    BEGIN
        SELECT 0 AS KetQua, N'Tên đăng nhập hoặc mật khẩu không đúng' AS ThongBao;
        RETURN;
    END
    
    IF @TrangThai != N'Hoạt động'
    BEGIN
        SELECT 0 AS KetQua, N'Tài khoản đã bị khóa' AS ThongBao;
        RETURN;
    END
    
    -- Log đăng nhập
    INSERT INTO LogHoatDong (MaNguoiDung, HanhDong, ChiTiet)
    VALUES (@MaNguoiDung, N'ĐĂNG NHẬP', N'Đăng nhập thành công');
    
    -- Trả về thông tin user
    SELECT 
        1 AS KetQua,
        N'Đăng nhập thành công' AS ThongBao,
        @MaNguoiDung AS MaNguoiDung,
        @VaiTro AS VaiTro;
END;

-- Procedure 2: Tạo hóa đơn mới
GO
CREATE PROCEDURE sp_TaoHoaDon
    @MaNguoiDung INT,
    @MaHoiVien INT = NULL,
    @PhuongThucTT NVARCHAR(50) = N'Tiền mặt',
    @GhiChu NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra nhân viên
        IF NOT EXISTS (SELECT 1 FROM NguoiDung WHERE MaNguoiDung = @MaNguoiDung AND TrangThai = N'Hoạt động')
        BEGIN
            RAISERROR(N'Nhân viên không hợp lệ', 16, 1);
            RETURN;
        END
        
        -- Kiểm tra hội viên (nếu có)
        IF @MaHoiVien IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM HoiVien WHERE MaHoiVien = @MaHoiVien AND TrangThai = N'Hoạt động')
            BEGIN
                RAISERROR(N'Mã hội viên không hợp lệ', 16, 1);
                RETURN;
            END
            
            IF EXISTS (SELECT 1 FROM HoiVien WHERE MaHoiVien = @MaHoiVien AND NgayHetHan < GETDATE())
            BEGIN
                RAISERROR(N'Thẻ hội viên đã hết hạn', 16, 1);
                RETURN;
            END
        END
        
        -- Tạo hóa đơn
        INSERT INTO HoaDon (MaNguoiDung, MaHoiVien, PhuongThucTT, GhiChu)
        VALUES (@MaNguoiDung, @MaHoiVien, @PhuongThucTT, @GhiChu);
        
        DECLARE @MaHD INT = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
        SELECT @MaHD AS MaHD, N'Tạo hóa đơn thành công' AS ThongBao;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 0 AS MaHD, ERROR_MESSAGE() AS ThongBao;
    END CATCH
END;

-- Procedure 3: Thêm sách vào hóa đơn
GO
CREATE PROCEDURE sp_ThemSachVaoHoaDon
    @MaHD INT,
    @MaSach INT,
    @SoLuong INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra hóa đơn
        IF NOT EXISTS (SELECT 1 FROM HoaDon WHERE MaHD = @MaHD AND TinhTrangTT = N'Chưa thanh toán')
        BEGIN
            RAISERROR(N'Hóa đơn không hợp lệ hoặc đã thanh toán', 16, 1);
            RETURN;
        END
        
        -- Kiểm tra sách
        IF NOT EXISTS (SELECT 1 FROM Sach WHERE MaSach = @MaSach AND TrangThai = N'Có bán')
        BEGIN
            RAISERROR(N'Sách không có hoặc ngừng bán', 16, 1);
            RETURN;
        END
        
        -- Sử dụng trigger để kiểm tra tồn kho
        INSERT INTO ChiTietHoaDon (MaHD, MaSach, SoLuong)
        VALUES (@MaHD, @MaSach, @SoLuong);
        
        COMMIT TRANSACTION;
        
        SELECT 1 AS KetQua, N'Thêm sách thành công' AS ThongBao;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 0 AS KetQua, ERROR_MESSAGE() AS ThongBao;
    END CATCH
END;

-- Procedure 4: Thanh toán hóa đơn
GO
CREATE PROCEDURE sp_ThanhToanHoaDon
    @MaHD INT,
    @MaNguoiDung INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra quyền thanh toán
        IF NOT EXISTS (SELECT 1 FROM HoaDon WHERE MaHD = @MaHD AND MaNguoiDung = @MaNguoiDung)
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM NguoiDung WHERE MaNguoiDung = @MaNguoiDung AND VaiTro = 'Manager')
            BEGIN
                RAISERROR(N'Không có quyền thanh toán hóa đơn này', 16, 1);
                RETURN;
            END
        END
        
        -- Kiểm tra trạng thái hóa đơn
        IF NOT EXISTS (SELECT 1 FROM HoaDon WHERE MaHD = @MaHD AND TinhTrangTT = N'Chưa thanh toán')
        BEGIN
            RAISERROR(N'Hóa đơn đã được thanh toán hoặc không tồn tại', 16, 1);
            RETURN;
        END
        
        -- Cập nhật trạng thái
        UPDATE HoaDon 
        SET TinhTrangTT = N'Đã thanh toán'
        WHERE MaHD = @MaHD;
        
        -- Log thanh toán
        INSERT INTO LogHoatDong (MaNguoiDung, HanhDong, ChiTiet)
        VALUES (@MaNguoiDung, N'THANH TOÁN', N'Thanh toán hóa đơn số: ' + CAST(@MaHD AS NVARCHAR(10)));
        
        COMMIT TRANSACTION;
        
        SELECT 1 AS KetQua, N'Thanh toán thành công' AS ThongBao;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 0 AS KetQua, ERROR_MESSAGE() AS ThongBao;
    END CATCH
END;

-- Procedure 5: Tạo đơn nhập hàng
GO
CREATE PROCEDURE sp_TaoDonNhap
    @MaNguoiDung INT,
    @GhiChu NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra quyền tạo đơn nhập
        IF NOT EXISTS (SELECT 1 FROM NguoiDung WHERE MaNguoiDung = @MaNguoiDung AND VaiTro = 'Manager' AND TrangThai = N'Hoạt động')
        BEGIN
            RAISERROR(N'Chỉ Manager mới có quyền tạo đơn nhập hàng', 16, 1);
            RETURN;
        END
        
        INSERT INTO DonNhap (MaNguoiDung, GhiChu)
        VALUES (@MaNguoiDung, @GhiChu);
        
        DECLARE @MaDN INT = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
        SELECT @MaDN AS MaDN, N'Tạo đơn nhập thành công' AS ThongBao;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 0 AS MaDN, ERROR_MESSAGE() AS ThongBao;
    END CATCH
END;

-- Procedure 6: Duyệt đơn nhập hàng
GO
CREATE PROCEDURE sp_DuyetDonNhap
    @MaDN INT,
    @MaNguoiDung INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Chỉ Manager mới có quyền duyệt
        IF NOT EXISTS (SELECT 1 FROM NguoiDung WHERE MaNguoiDung = @MaNguoiDung AND VaiTro = 'Manager')
        BEGIN
            RAISERROR(N'Chỉ Manager mới có quyền duyệt đơn nhập', 16, 1);
            RETURN;
        END
        
        -- Kiểm tra đơn nhập
        IF NOT EXISTS (SELECT 1 FROM DonNhap WHERE MaDN = @MaDN AND TinhTrangNhap = N'Chờ duyệt')
        BEGIN
            RAISERROR(N'Đơn nhập không tồn tại hoặc đã được duyệt', 16, 1);
            RETURN;
        END
        
        -- Cập nhật trạng thái
        UPDATE DonNhap 
        SET TinhTrangNhap = N'Đã duyệt'
        WHERE MaDN = @MaDN;
        
        -- Cập nhật tồn kho thông qua trigger
        -- (Trigger trg_CapNhatTonKho_Nhap sẽ tự động cập nhật)
        
        COMMIT TRANSACTION;
        
        SELECT 1 AS KetQua, N'Duyệt đơn nhập thành công' AS ThongBao;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 0 AS KetQua, ERROR_MESSAGE() AS ThongBao;
    END CATCH
END;

-- Procedure 7: Báo cáo doanh thu
GO
CREATE PROCEDURE sp_BaoCaoDoanhThu
    @TuNgay DATE,
    @DenNgay DATE,
    @MaNguoiDung INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        CAST(NgayLapHD AS DATE) AS NgayBan,
        COUNT(*) AS SoHoaDon,
        SUM(TongTien) AS DoanhThu,
        SUM(CASE WHEN MaHoiVien IS NOT NULL THEN TongTien ELSE 0 END) AS DoanhThuHoiVien,
        SUM(CASE WHEN MaHoiVien IS NULL THEN TongTien ELSE 0 END) AS DoanhThuKhachLe,
        AVG(TongTien) AS GiaTriTrungBinh
    FROM HoaDon
    WHERE TinhTrangTT = N'Đã thanh toán'
        AND NgayLapHD BETWEEN @TuNgay AND @DenNgay
        AND (@MaNguoiDung IS NULL OR MaNguoiDung = @MaNguoiDung)
    GROUP BY CAST(NgayLapHD AS DATE)
    ORDER BY NgayBan DESC;
END;

-- Procedure 8: Tìm kiếm sách
GO
CREATE PROCEDURE sp_TimKiemSach
    @TuKhoa NVARCHAR(200),
    @TheLoai NVARCHAR(100) = NULL,
    @TacGia NVARCHAR(100) = NULL,
    @GiaMin DECIMAL(18,2) = NULL,
    @GiaMax DECIMAL(18,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        MaSach,
        TenSach,
        TacGia,
        NhaXuatBan,
        TheLoai,
        DonGia,
        SLTonKho,
        TrangThai
    FROM Sach
    WHERE TrangThai = N'Có bán'
        AND (@TuKhoa IS NULL OR TenSach LIKE N'%' + @TuKhoa + '%' OR TacGia LIKE N'%' + @TuKhoa + '%')
        AND (@TheLoai IS NULL OR TheLoai = @TheLoai)
        AND (@TacGia IS NULL OR TacGia = @TacGia)
        AND (@GiaMin IS NULL OR DonGia >= @GiaMin)
        AND (@GiaMax IS NULL OR DonGia <= @GiaMax)
    ORDER BY TenSach;
END;

-- Procedure 9: Quản lý hội viên
GO
CREATE PROCEDURE sp_TaoHoiVien
    @HoTen NVARCHAR(100),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(10),
    @SDT VARCHAR(15),
    @DiaChi NVARCHAR(200),
    @Email NVARCHAR(100) = NULL,
    @LoaiThe NVARCHAR(50) = N'Thường'
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Kiểm tra trùng số điện thoại
        IF EXISTS (SELECT 1 FROM HoiVien WHERE SDT = @SDT AND TrangThai = N'Hoạt động')
        BEGIN
            RAISERROR(N'Số điện thoại đã được đăng ký', 16, 1);
            RETURN;
        END
        
        INSERT INTO HoiVien (HoTen, NgaySinh, GioiTinh, SDT, DiaChi, Email, LoaiThe)
        VALUES (@HoTen, @NgaySinh, @GioiTinh, @SDT, @DiaChi, @Email, @LoaiThe);
        
        DECLARE @MaHoiVien INT = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
        SELECT @MaHoiVien AS MaHoiVien, N'Tạo hội viên thành công' AS ThongBao;
        
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SELECT 0 AS MaHoiVien, ERROR_MESSAGE() AS ThongBao;
    END CATCH
END;

-- Procedure 10: Backup và thống kê
GO
CREATE PROCEDURE sp_ThongKeChung
    @Thang INT = NULL,
    @Nam INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ThangHienTai INT = ISNULL(@Thang, MONTH(GETDATE()));
    DECLARE @NamHienTai INT = ISNULL(@Nam, YEAR(GETDATE()));
    
    -- Thống kê tổng quan
    SELECT 
        N'Doanh thu tháng' AS ChiTieu,
        FORMAT(ISNULL(SUM(TongTien), 0), 'N0') + ' VNĐ' AS GiaTri
    FROM HoaDon 
    WHERE MONTH(NgayLapHD) = @ThangHienTai 
        AND YEAR(NgayLapHD) = @NamHienTai 
        AND TinhTrangTT = N'Đã thanh toán'
    
    UNION ALL
    
    SELECT 
        N'Số hóa đơn',
        CAST(COUNT(*) AS NVARCHAR(20))
    FROM HoaDon 
    WHERE MONTH(NgayLapHD) = @ThangHienTai 
        AND YEAR(NgayLapHD) = @NamHienTai 
        AND TinhTrangTT = N'Đã thanh toán'
    
    UNION ALL
    
    SELECT 
        N'Số sách bán ra',
        CAST(ISNULL(SUM(ct.SoLuong), 0) AS NVARCHAR(20))
    FROM ChiTietHoaDon ct
    JOIN HoaDon hd ON ct.MaHD = hd.MaHD
    WHERE MONTH(hd.NgayLapHD) = @ThangHienTai 
        AND YEAR(hd.NgayLapHD) = @NamHienTai 
        AND hd.TinhTrangTT = N'Đã thanh toán'
    
    UNION ALL
    
    SELECT 
        N'Hội viên mới',
        CAST(COUNT(*) AS NVARCHAR(20))
    FROM HoiVien
    WHERE MONTH(NgayDangKy) = @ThangHienTai 
        AND YEAR(NgayDangKy) = @NamHienTai;
END;

------------------------------------------------------
-- TRIGGERS
------------------------------------------------------

-- 1. TRIGGER: Kiểm tra tồn kho trước khi bán
GO
CREATE TRIGGER trg_KiemTraTonKho
ON ChiTietHoaDon
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @MaSach INT, @SoLuong INT, @TonKho INT, @TenSach NVARCHAR(200);
    
    DECLARE cur CURSOR FOR SELECT MaSach, SoLuong FROM inserted;
    OPEN cur;
    FETCH NEXT FROM cur INTO @MaSach, @SoLuong;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @TonKho = SLTonKho, @TenSach = TenSach 
        FROM Sach WHERE MaSach = @MaSach;
        
        IF @TonKho < @SoLuong
        BEGIN
            RAISERROR(N'Sách "%s" không đủ hàng trong kho! Còn lại: %d', 16, 1, @TenSach, @TonKho);
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        
        FETCH NEXT FROM cur INTO @MaSach, @SoLuong;
    END;
    
    CLOSE cur;
    DEALLOCATE cur;
    
    -- Thực hiện insert nếu đủ hàng
    INSERT INTO ChiTietHoaDon (MaHD, MaSach, SoLuong, DonGia, ThanhTien)
    SELECT i.MaHD, i.MaSach, i.SoLuong, s.DonGia, i.SoLuong * s.DonGia
    FROM inserted i
    JOIN Sach s ON i.MaSach = s.MaSach;
END;

-- 2. TRIGGER: Cập nhật tồn kho khi bán hàng
GO
CREATE TRIGGER trg_CapNhatTonKho_Ban
ON ChiTietHoaDon
AFTER INSERT
AS
BEGIN
    UPDATE s
    SET SLTonKho = s.SLTonKho - i.SoLuong,
        NgayCapNhat = GETDATE()
    FROM Sach s
    JOIN inserted i ON s.MaSach = i.MaSach;
    
    -- Cảnh báo sách sắp hết
    INSERT INTO ThongBao (NoiDung, LoaiThongBao)
    SELECT N'Cảnh báo: Sách "' + s.TenSach + N'" sắp hết hàng! Còn lại: ' + CAST(s.SLTonKho AS NVARCHAR(10)),
           N'Cảnh báo'
    FROM Sach s
    JOIN inserted i ON s.MaSach = i.MaSach
    WHERE s.SLTonKho <= 5;
END;

-- 3. TRIGGER: Cập nhật tồn kho khi nhập hàng
GO
CREATE TRIGGER trg_CapNhatTonKho_Nhap
ON ChiTietDonNhap
AFTER INSERT
AS
BEGIN
    -- Chỉ cập nhật khi đơn nhập đã được duyệt
    UPDATE s
    SET SLTonKho = s.SLTonKho + i.SoLuong,
        NgayCapNhat = GETDATE()
    FROM Sach s
    JOIN inserted i ON s.MaSach = i.MaSach
    JOIN DonNhap dn ON i.MaDN = dn.MaDN
    WHERE dn.TinhTrangNhap = N'Đã duyệt';
END;

-- 4. TRIGGER: Tính tổng tiền hóa đơn
GO
CREATE TRIGGER trg_TinhTongTienHD
ON ChiTietHoaDon
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Cập nhật từ inserted
    UPDATE hd
    SET TongTien = (
        SELECT ISNULL(SUM(ThanhTien), 0)
        FROM ChiTietHoaDon ct
        WHERE ct.MaHD = hd.MaHD
    )
    FROM HoaDon hd
    WHERE hd.MaHD IN (SELECT MaHD FROM inserted);
    
    -- Cập nhật từ deleted
    UPDATE hd
    SET TongTien = (
        SELECT ISNULL(SUM(ThanhTien), 0)
        FROM ChiTietHoaDon ct
        WHERE ct.MaHD = hd.MaHD
    )
    FROM HoaDon hd
    WHERE hd.MaHD IN (SELECT MaHD FROM deleted);
END;

-- 5. TRIGGER: Kiểm tra phân quyền cập nhật giá
GO
CREATE TRIGGER trg_KiemTraQuyenSuaGia
ON Sach
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN deleted d ON i.MaSach = d.MaSach
        WHERE i.DonGia != d.DonGia
    )
    BEGIN
        -- Tạo thông báo yêu cầu Manager xác nhận
        INSERT INTO ThongBao (NoiDung, LoaiThongBao)
        SELECT N'Yêu cầu xác nhận thay đổi giá sách: ' + i.TenSach + 
               N' từ ' + FORMAT(d.DonGia, 'N0') + N' thành ' + FORMAT(i.DonGia, 'N0'),
               N'Yêu cầu'
        FROM inserted i
        JOIN deleted d ON i.MaSach = d.MaSach
        WHERE i.DonGia != d.DonGia;
    END;
END;

------------------------------------------------------
-- SECURITY & ROLES
------------------------------------------------------

-- Tạo roles
GO
CREATE ROLE db_manager;
CREATE ROLE db_staff;

-- Phân quyền cho Manager
GRANT SELECT, INSERT, UPDATE, DELETE ON NguoiDung TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON Sach TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON HoaDon TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON ChiTietHoaDon TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON DonNhap TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON ChiTietDonNhap TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON NhaCungCap TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON HoiVien TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON DangKyHoiVien TO db_manager;
GRANT SELECT, INSERT, UPDATE, DELETE ON KhuyenMai TO db_manager;
GRANT SELECT ON LogHoatDong TO db_manager;
GRANT SELECT, UPDATE ON ThongBao TO db_manager;
GRANT SELECT, INSERT, UPDATE ON CauHinh TO db_manager;

-- Phân quyền cho Staff (hạn chế hơn)
GRANT SELECT ON NguoiDung TO db_staff;
GRANT SELECT ON Sach TO db_staff;
GRANT SELECT, INSERT, UPDATE ON HoaDon TO db_staff;
GRANT SELECT, INSERT, UPDATE ON ChiTietHoaDon TO db_staff;
GRANT SELECT, INSERT, UPDATE, DELETE ON DonNhap TO db_staff;
GRANT SELECT, INSERT, UPDATE, DELETE ON ChiTietDonNhap TO db_staff;
GRANT SELECT ON NhaCungCap TO db_staff;
GRANT SELECT, INSERT, UPDATE ON HoiVien TO db_staff;
GRANT SELECT, INSERT ON DangKyHoiVien TO db_staff;
GRANT SELECT ON KhuyenMai TO db_staff;
GRANT SELECT ON ThongBao TO db_staff;

-- Phân quyền thực thi procedure
GRANT EXECUTE ON sp_DangNhap TO db_manager, db_staff;
GRANT EXECUTE ON sp_TaoHoaDon TO db_manager, db_staff;
GRANT EXECUTE ON sp_ThemSachVaoHoaDon TO db_manager, db_staff;
GRANT EXECUTE ON sp_ThanhToanHoaDon TO db_manager, db_staff;
GRANT EXECUTE ON sp_TaoDonNhap TO db_manager, db_staff;
GRANT EXECUTE ON sp_DuyetDonNhap TO db_manager, db_staff;
GRANT EXECUTE ON sp_BaoCaoDoanhThu TO db_manager;
GRANT EXECUTE ON sp_TimKiemSach TO db_manager, db_staff;
GRANT EXECUTE ON sp_TaoHoiVien TO db_manager, db_staff;
GRANT EXECUTE ON sp_ThongKeChung TO db_manager;

-- Phân quyền view
GRANT SELECT ON vw_ThongTinBanHang TO db_manager, db_staff;
GRANT SELECT ON vw_BaoCaoTonKho TO db_manager, db_staff;
GRANT SELECT ON vw_TopSachBanChay TO db_manager;
GRANT SELECT ON vw_DoanhThuTheoThang TO db_manager;
------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------

-- Function 1: Kiểm tra tồn kho an toàn
GO
CREATE FUNCTION fn_KiemTraTonKhoAnToan(@MaSach INT, @SoLuongCanBan INT)
RETURNS BIT
AS
BEGIN
    DECLARE @TonKho INT;
    DECLARE @KetQua BIT = 0;
    
    SELECT @TonKho = SLTonKho FROM Sach WHERE MaSach = @MaSach;
    
    IF @TonKho >= @SoLuongCanBan
        SET @KetQua = 1;
    
    RETURN @KetQua;
END;

-- Function 2: Tính doanh thu theo khoảng thời gian
GO
CREATE FUNCTION fn_TinhDoanhThu(@TuNgay DATE, @DenNgay DATE)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @DoanhThu DECIMAL(18,2);
    
    SELECT @DoanhThu = ISNULL(SUM(TongTien), 0)
    FROM HoaDon
    WHERE NgayLapHD BETWEEN @TuNgay AND @DenNgay
        AND TinhTrangTT = N'Đã thanh toán';
    
    RETURN @DoanhThu;
END;

------------------------------------------------------
-- CONSTRAINTS & INDEXES
------------------------------------------------------

-- Thêm ràng buộc
ALTER TABLE HoaDon ADD CONSTRAINT CK_HoaDon_TongTien CHECK (TongTien >= 0);
ALTER TABLE Sach ADD CONSTRAINT CK_Sach_DonGia CHECK (DonGia >= 0);
ALTER TABLE Sach ADD CONSTRAINT CK_Sach_SLTonKho CHECK (SLTonKho >= 0);
ALTER TABLE ChiTietHoaDon ADD CONSTRAINT CK_ChiTietHoaDon_SoLuong CHECK (SoLuong > 0);
ALTER TABLE HoiVien ADD CONSTRAINT CK_HoiVien_DiemTichLuy CHECK (DiemTichLuy >= 0);

-- Thêm indexes để tối ưu performance
CREATE INDEX IX_HoaDon_NgayLapHD ON HoaDon(NgayLapHD);
CREATE INDEX IX_HoaDon_TinhTrangTT ON HoaDon(TinhTrangTT);
CREATE INDEX IX_Sach_TheLoai ON Sach(TheLoai);
CREATE INDEX IX_Sach_TacGia ON Sach(TacGia);
CREATE INDEX IX_HoiVien_SDT ON HoiVien(SDT);
CREATE INDEX IX_LogHoatDong_ThoiGian ON LogHoatDong(ThoiGian);

-- Thêm khóa ngoại cho HoaDon-HoiVien
ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDon_HoiVien
FOREIGN KEY (MaHoiVien) REFERENCES HoiVien(MaHoiVien)
ON DELETE SET NULL;

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

GO

PRINT N'✅ Tạo database hoàn chỉnh thành công!';
PRINT N'📊 Hệ thống bao gồm:';
PRINT N'   - 13 Tables với đầy đủ ràng buộc';
PRINT N'   - 6 Views báo cáo tổng hợp';  
PRINT N'   - 10 Stored Procedures nghiệp vụ';
PRINT N'   - 8 Triggers tự động hóa';
PRINT N'   - 3 Functions hỗ trợ tính toán';
PRINT N'   - Phân quyền Manager/Staff';
PRINT N'   - Indexes tối ưu hiệu suất';
PRINT N'   - Dữ liệu mẫu để test';
PRINT N'';
PRINT N'🔐 Tài khoản mặc định:';
PRINT N'   Manager: manager/manager123';
PRINT N'   Staff: staff1/staff123, staff2/staff123';
PRINT N'';
PRINT N'📈 Sẵn sàng sử dụng các chức năng:';
PRINT N'   - Quản lý bán hàng (có/không hội viên)';
PRINT N'   - Quản lý nhập kho (phân quyền)';
PRINT N'   - Báo cáo doanh thu chi tiết';  
PRINT N'   - Quản lý tồn kho thông minh';
PRINT N'   - Hệ thống tích điểm hội viên';
PRINT N'   - Audit log đầy đủ';
PRINT N'   - Bảo mật dữ liệu';

-- Test nhanh hệ thống
EXEC sp_DangNhap 'manager', 'manager123';
EXEC sp_ThongKeChung;