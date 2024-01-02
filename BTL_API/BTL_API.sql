CREATE DATABASE BTL_BanMyPham
USE BTL_BanMyPham
GO

--LoaiTaiKhoan(MaLoaiTK, TenLoaiTK, MoTa)
CREATE Table LoaiTaiKhoan (
MaLoaiTK INT IDENTITY(1,1) PRIMARY KEY,
TenLoaiTK Nvarchar(20),
MoTa Nvarchar(30)
)

SELECT * FROM TaiKhoan
--TaiKhoan(MaTaiKhoan, LoaiTaiKhoan, TenTaiKhoan, MatKhau, Email)
CREATE TABLE TaiKhoan (
MaTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
LoaiTaiKhoan INT CONSTRAINT TK_LoaiTK_FK FOREIGN KEY (LoaiTaiKhoan) REFERENCES  LoaiTaiKhoan(MaLoaiTK),
TenTaiKhoan Nvarchar(20),
MatKhau Nvarchar(20),
Email Varchar(30) CHECK (Email LIKE '%@%')
)

SElect * from TaiKhoan

--ChiTietTaiKhoan(MaChiTietTaiKhoan, MaTaiKhoan, HoTen, DiaChi, SDT, AnhDaiDien)
CREATE TABLE ChiTietTaiKhoan (
MaChitietTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
MaTaiKhoan INT CONSTRAINT CTTK_MaTK_FK  FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
HoTen Nvarchar(30),
DiaChi Nvarchar(30),
SDT Varchar(11) DEFAULT N'Không có',
AnhDaiDien Nvarchar(500)
)

--BaiViet(MaBV, TieuDe, NguoiDang, TGDang, NgayKT, NoiDung)
CREATE TABLE BaiViet (
MaBV Nvarchar(10) CONSTRAINT PK_MaBV PRIMARY KEY,
TieuDe Nvarchar(100),
NguoiDang Nvarchar(20),
TGDang Date,
NgayKT Date, 
NoiDung Nvarchar(MAX)
)

-- LoaiMyPham(MaLoaiMP, TenMP, GhiChu) 
CREATE TABLE LoaiMyPham
(
MaLoaiMP Nvarchar(10) CONSTRAINT PK_MaLoaiMP PRIMARY KEY,
TenLoaiMP Nvarchar(30) not null, 
AnhDaiDien nvarchar(500),
MoTa Nvarchar(MAX)
)


--MyPham(MaMP, TenMP, MaLoaiMP, SoLuongTon, MoTa, GhiChu)
CREATE TABLE MyPham
(
MaMP Nvarchar(10) CONSTRAINT PK_MaMP PRIMARY KEY,
TenMP Nvarchar(50),
MaLoaiMP Nvarchar(10) CONSTRAINT FK_MP_MaLoaiMP FOREIGN KEY REFERENCES LoaiMyPham(MaLoaiMP) 
ON DELETE CASCADE ON UPDATE CASCADE,
GiaMoi Decimal(18, 0),
GiaCu Decimal(18, 0),
SLTon int check (SLTon>=0),
AnhDaiDien nvarchar(500),
MoTa Nvarchar(MAX),
GhiChu Nvarchar(30)
)

--ChiTietMyPham(MaChiTietMP, MaMP, MaNCC, MoTa, ChiTiet)
CREATE TABLE ChiTietMyPham (
MaChiTietMyPham Nvarchar(10) PRIMARY KEY,
MaMP Nvarchar(10) CONSTRAINT CTMP_MaMP_FK FOREIGN KEY (MaMP) REFERENCES MyPham(MaMP),
MaNCC Nvarchar(10) CONSTRAINT FK_NhaCC_MaNCC FOREIGN KEY REFERENCES NhaCC(MaNCC),
MoTa Nvarchar(MAX),
ChiTiet Nvarchar(MAX)
)


--NhanVien(MaNV, HoTenNV, NgaySinh, GioiTinh, CaLam, SDTNV, DiaChiNV, Email)
CREATE TABLE NhanVien
(
MaNV Nvarchar(10) PRIMARY KEY,
HoTenNV Nvarchar(30),
NgaySinh DATE CHECK (YEAR(NgaySinh)<2005),
GioiTinh Nvarchar(3),
CaLam Nvarchar(8),
SDTNV Varchar(11) DEFAULT N'Không có',
DiachiNV Nvarchar(30),
Email Varchar(30)
)

DROP TABLE NhanVien


--KhachHang (IDKH, HoTenKH, SDTKH, DiaChiKH)
CREATE TABLE KhachHang
(
IDKH Nvarchar(10) PRIMARY KEY,
HoTenKH Nvarchar(30),
SDTKH Varchar(11) DEFAULT N'Không có',
DiaChiKH Nvarchar(30)
)

--NHACC(MaNCC, HoTenNCC, SDTNCC, DiaChiNCC)
CREATE TABLE NhaCC
(
MaNCC Nvarchar(10) PRIMARY KEY,
HoTenNCC Nvarchar(30) not null,
SDTNCC Varchar(11) DEFAULT N'Không có',
DiaChiNCC Nvarchar(30)
)

--HoaDonNhap (MaHDN, NgayNhap, MaNV, MaNCC, HoTenNCC, SDTNCC, TongTien)
CREATE TABLE HoaDonNhap
(
MaHDN Nvarchar(10) PRIMARY KEY,
NgayNhap Date,
MaTaiKhoan INT CONSTRAINT HDN_MaTK_FK FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
MaNCC Nvarchar(10) CONSTRAINT FK_HoaDonNhap_MaNCC FOREIGN KEY REFERENCES NhaCC(MaNCC),
KieuThanhToan Nvarchar(20),
TongTien float check(TongTien>=0)
)



--ChiTietHoaDonNhap(MaHDN, MaMP, TenMP, SoLuong, DonGia, TrietKhau, ThanhTien)
CREATE TABLE ChiTietHoaDonNhap
(
MaCTHDN Nvarchar(10) PRIMARY KEY,
MaHDN Nvarchar(10) CONSTRAINT FK_ChiTietHoaDonNhap_HDN FOREIGN KEY REFERENCES HoaDonNhap(MaHDN),
MaMP Nvarchar(10) CONSTRAINT FK_ChiTietHoaDonNhap_MyPham FOREIGN KEY REFERENCES MyPham(MaMP),
TenMP Nvarchar(50) not null, 
SLNhap float check (SLNhap>0),
DGNhap float check (DGNhap>0),
ThanhTien float check (ThanhTien>=0)
)

--HoaDonBan (MaHDB,MaTaiKhoan, IDKH, HoTenKH, SDTKH, DiaChiKH, TrangThai, NgayTao, NgayDuyet, TongTien, TGGiaoHang)
CREATE TABLE HoaDonBan
(
MaHDB INT IDENTITY(1,1)  PRIMARY KEY,
HoTenKH Nvarchar(30),
SDTKH Varchar(10) DEFAULT N'Không có',
DiaChiKH nvarchar(30),
TrangThai bit,
NgayTao datetime,
NgayDuyet datetime,
TongTien decimal(18, 0),
TGGiaoHang datetime
)

--ChiTietHoaDonBan(MaCTHDB, MaHDB, MaMP, SLBan, TongTien)
CREATE TABLE ChiTietHoaDonBan
(
MaCTHDB INT IDENTITY(1,1)  PRIMARY KEY,
MaHDB INT CONSTRAINT FK_ChiTietHoaDonBan_HDB FOREIGN KEY REFERENCES HoaDonBan(MaHDB),
MaMP Nvarchar(10) CONSTRAINT FK_ChiTietHoaDonBan_MyPham FOREIGN KEY REFERENCES MyPham(MaMP),
SLBan INT CHECK (SLBan>0),
TongTien decimal(18, 0)
)

------------------------------------INSERT THÔNG TIN VÀO CÁC BẢNG---------------------------------------------
--INSERT LoaiTaiKhoan(TenLoaiTK, MoTa)
INSERT INTO LoaiTaiKhoan(TenLoaiTK, MoTa)
VALUES (N'Nhân viên', null),
       (N'Quản lý', null),
	   (N'Khách hàng', null)

-- INSERT TaiKhoan(LoaiTaiKhoan, TenTaiKhoan, MatKhau, Email)
INSERT INTO TaiKhoan (LoaiTaiKhoan, TenTaiKhoan, MatKhau, Email)
VALUES (1, N'enchan', N'123456', N'enchan2803@gmail.com'),
       (2, N'ngocmun', N'123456', N'ngoc06@gmail.com')

--INSERT ChiTietTaiKhoan(MaTaiKhoan, HoTen, DiaChi, SDT, AnhDaiDien)
INSERT INTO ChiTietTaiKhoan(MaTaiKhoan, HoTen, DiaChi, SDT, AnhDaiDien)
VALUES (9, N'Trần Thị Xuân Én', N'Hà Nội', '0987233625', null),
       (10, N'Nguyễn Ngọc', N'Hưng Yên', '0358312793', null)

--INSERT BaiViet(MaBV, TieuDe, NguoiDang, TGDang, NgayKT, NoiDung)
INSERT INTO BaiViet(MaBV, TieuDe, NguoiDang, TGDang, NgayKT, NoiDung)
VALUES('BV01', N'Dùng kem chống nắng như thế nào?', N'Nhân viên', '09-09-2023', '01-09-2024', N'Dùng mỗi ngày'),
      ('BV02', N'Dùng nước tẩy trang như thế nào?', N'Quản lý', '05-12-2023', '01-01-2024', N'Dùng mỗi ngày'),
	  ('BV03', N'Dùng toner như thế nào?', N'Nhân viên', '03-08-2023', '05-03-2024', N'Dùng mỗi ngày')

	  SELECT * FROM BaiViet

-- INSERT LoaiMyPham(MaLoaiMP, TenLoaiMP, MoTa)
INSERT INTO LoaiMyPham(MaLoaiMP, TenLoaiMP, AnhDaiDien, MoTa)
VALUES('L01',N'Dưỡng Mượt Tóc',N'/Images/danhmuc1.jpg', N'Các loại mỹ phẩm Dưỡng Tóc'),
      ('L02',N'Dầu Gội, Xả Tóc', N'/Images/danhmuc2.jpg', N' Các loại mỹ phẩm Dầu Gội'),
	  ('L03',N'Dưỡng Thể Body', N'/Images/danhmuc3.jpg',N' Các loại mỹ phẩm Dưỡng Thể'),
	  ('L04',N'Toner Hoa Hồng',N'/Images/danhmuc4.jpg',N' Các loại mỹ phẩm Toner'),
	  ('L05',N'Nước Hoa Thơm',N'/Images/danhmuc5.jpg',N' Các loại mỹ phẩm Nước hoa'),
	  ('L06',N'Trang Điểm Môi',N'/Images/danhmuc6.jpg',N' Các loại mỹ phẩm Son Môi'),
	  ('L07',N'Kem Nền Mịn',N'/Images/danhmuc7.jpg',N' Các loại mỹ phẩm Kem Nền'),
	  ('L08',N'K.Chống Nắng',N'/Images/danhmuc8.jpg',N' Các loại mỹ phẩm Kem'),
	  ('L09',N'Sữa Rửa Mặt',N'/Images/danhmuc9.jpg',N' Các loại mỹ phẩm Sữa Rửa Mặt'),
	  ('L10',N'Nước Tẩy Trang',N'/Images/danhmuc10.jpg',N'Các loại mỹ phẩm Nước Tẩy Trang'),
	  ('L11',N'Mascara',N'/Images',N'Các loại mỹ phẩm Mascara'),
      ('L12',N'Eyeliner',N'/Images',N' Các loại bút kẻ mắt'),
	  ('L13',N'Lotion',N'/Images',N' Các loại lotion'),
	  ('L14',N'Kem nghệ',N'/Images',N' Các loại kem nghệ'),
	  ('L15',N'Body mist',N'/Images',N' Các loại Body mist'),
	  ('L16',N'Sữa tắm',N'/Images',N' Các loại sữa tắm'),
	  ('L17',N'Dầu gội thường',N'/Images',N' Các loại dầu gội thường'),
	  ('L18',N'Dầu gội dược liệu',N'/Images',N' Các loại dầu gội dược liệu'),
	  ('L19',N'Vitamin',N'/Images',N' Các loại mỹ phẩm Vitamin'),
	  ('L20',N'Tẩy da chết',N'/Images',N' Các loại mỹ phẩm tẩy da chết')

--MyPham(MaMP, TenMP, MaLoaiMP,GiaMoi, GiaCu, DanhGia, SLTon, MoTa, GhiChu)
INSERT INTO MyPham(MaMP, TenMP, MaLoaiMP, GiaMoi, GiaCu, SLTon, AnhDaiDien, MoTa, GhiChu)
VALUES('MP01',N'Dầu LOreal Tinh Dầu Hoa Tự Nhiên','L01',CAST(250000 AS Decimal(18, 0)),CAST(300000 AS Decimal(18, 0)),5, N'Upload/sp4.png', N'Dầu LOreal Tinh Dầu Hoa Tự Nhiên',N'Phù hợp với da dầu'),
      ('MP02',N'Nước Xịt Dưỡng Tóc Double Rich','L01',CAST(150000 AS Decimal(18, 0)),CAST(200000 AS Decimal(18, 0)),100, N'Upload/sp5.jpg',N'Kem chống nắng Laroche Posay',N'Phù hợp với da nhạy cảm'),
	  ('MP03',N'Tinh Dầu Dưỡng Tóc Raip Bóng Mượt','L01',CAST(350000 AS Decimal(18, 0)),CAST(500000 AS Decimal(18, 0)),80,N'Upload/sp2.png',N'Tinh Dầu Dưỡng Tóc Raip Bóng Mượt',N'Phù hợp với mọi loại da'),
	  ('MP04',N'Dưỡng Tóc Tinh Dầu Bưởi Pomelo Shampoo','L01',CAST(150000 AS Decimal(18, 0)),CAST(200000 AS Decimal(18, 0)),100,N'Upload/sp3.jpg',N'Kem dưỡng ẩm VitaminE',N'Phù hợp với mọi loại da'),

	  ('MP05',N'Dầu Gội Tsubaki Phục Hồi','L02',CAST(450000 AS Decimal(18, 0)),CAST(500000 AS Decimal(18, 0)),50,N'Upload/daugoi1.jpg',N'Ngăn rụng tóc',N'Mượt tóc'),
	  ('MP06',N'Bộ Gội Xả TRESemmé Keratin Vào Nếp','L02',CAST(300000 AS Decimal(18, 0)),CAST(370000 AS Decimal(18, 0)),150,N'Upload/daugoi2.jpg',N'Ngăn rụng tóc',N'Mượt tóc'),
	  ('MP07',N'Dầu Gội OGX Biotin & Collagen','L02',CAST(250000 AS Decimal(18, 0)),CAST(270000 AS Decimal(18, 0)),100,N'Upload/daugoi3.jpg',N'Dầu Gội OGX Biotin & Collagen',N'Mượt tóc'),
	  ('MP08',N'Dầu Gội LOreal Paris Dưỡng Tóc','L02',CAST(150000 AS Decimal(18, 0)),CAST(200000 AS Decimal(18, 0)),280,N'Upload/daugoi4.jpg',N'Dầu Gội LOreal Paris',N'Mượt tóc'),

	  ('MP09',N'Serum Dưỡng Thể Vaseline Chống Nắng','L03',CAST(120000 AS Decimal(18, 0)),CAST(150000 AS Decimal(18, 0)), 500,N'Upload/dt1.png',N'Serum Dưỡng Thể Vaseline Chống Nắng',N'Phù hợp với mọi loại da'),
	  ('MP10',N'Sữa Dưỡng Thể Nivea Sáng Da','L03',CAST(80000 AS Decimal(18, 0)),CAST(120000 AS Decimal(18, 0)), 500,N'Upload/dt2.png',N'Sữa Dưỡng Thể Nivea Sáng Da',N'Phù hợp với mọi loại da'),
	  ('MP11',N'Sữa Dưỡng Thể Vaseline Dịu Mát','L03',CAST(100000 AS Decimal(18, 0)),CAST(160000 AS Decimal(18, 0)), 200,N'Upload/dt3.png',N'Sữa Dưỡng Thể Vaseline Dịu Mát',N'Phù hợp với da dầu'),
	  ('MP12',N'Dầu Chăm Sóc Da Bio-Oil ','L03',CAST(300000 AS Decimal(18, 0)),CAST(350000 AS Decimal(18, 0)), 100,N'Upload/dt4.jpg',N'Dầu Chăm Sóc Da Bio-Oil ',N'Phù hợp với da khô'),

	  ('MP13',N'Toner hoa cúc','L04',CAST(220000 AS Decimal(18, 0)),CAST(250000 AS Decimal(18, 0)), 50,N'Upload/t1.png',N'Toner hoa cúc',N'Phù hợp với da khô'),
	  ('MP14',N'Toner Kiel','L04',CAST(320000 AS Decimal(18, 0)),CAST(400000 AS Decimal(18, 0)), 50,N'Upload/t2.png',N'Toner Kiel',N'Phù hợp với mọi loại da'),
	  ('MP15',N'Toner Laroche Posay','L04',CAST(250000 AS Decimal(18, 0)),CAST(300000 AS Decimal(18, 0)), 100,N'Upload/t3.png',N'Toner Laroche Posay',N'Phù hợp với người trên 12 tuổi'),
	  ('MP16',N'Nước hoa hồng Klair','L04',CAST(400000 AS Decimal(18, 0)),CAST(450000 AS Decimal(18, 0)), 30,N'Upload/t4.jpg',N'Nước hoa hồng Klair',N'Phù hợp với người trên 12 tuổi'),

	  ('MP17',N'Nước hoa nữ MAC Jacob','L05',CAST(700000 AS Decimal(18, 0)),CAST(750000 AS Decimal(18, 0)), 100,N'Upload/nh1.jpg',N'Nước hoa nữ MAC Jacob',N'Hương nữ'),
	  ('MP18',N'Nước hoa nữ Caloria','L05',CAST(620000 AS Decimal(18, 0)),CAST(8500000 AS Decimal(18, 0)), 50,N'Upload/nh2.png',N'Nước hoa nữ Caloria',N'Hương nữ'),
	  ('MP19',N'Nước hoa nữ Caloria','L05',CAST(820000 AS Decimal(18, 0)),CAST(900000 AS Decimal(18, 0)), 100,N'Upload/nh3.jpg',N'Nước hoa nữ Caloria',N'Hương nữ'),
	  ('MP20',N'Nước hoa nam Paco','L05',CAST(900000 AS Decimal(18, 0)),CAST(990000 AS Decimal(18, 0)), 50,N'Upload/nh4.jpg',N'Nước hoa nam Paco',N'Hương nam'),

	  ('MP21',N'Son Background A12','L06',CAST(220000 AS Decimal(18, 0)),CAST(2500000 AS Decimal(18, 0)), 250,N'Upload/sm1.jpg',N'Son Background A12',N'Thơm và mềm môi'),
	  ('MP22',N'Son Kem lì 3CE','L06',CAST(320000 AS Decimal(18, 0)),CAST(3500000 AS Decimal(18, 0)), 100,N'Upload/sm2.jpg',N'Son Kem lì 3CE',N'Thơm và mềm môi'),
	  ('MP23',N'Son Bóng Mac','L06',CAST(220000 AS Decimal(18, 0)),CAST(2500000 AS Decimal(18, 0)), 50,N'Upload/sm3.png',N'Son Bóng Mac',N'Thơm và mềm môi'),
	  ('MP24',N'Son Bóng Maybeline','L06',CAST(350000 AS Decimal(18, 0)),CAST(4500000 AS Decimal(18, 0)),50,N'Upload/sm4.jpg',N'Son Bóng Maybeline',N'Thơm và mềm môi'),

	  ('MP25',N'Phấn Nước Lanegie Căng','L07',CAST(520000 AS Decimal(18, 0)),CAST(600000 AS Decimal(18, 0)), 100,N'Upload/m1.png',N'Phấn Nước Lanegie Căng',N'Phù hợp với mọi loại da'),
	  ('MP26',N'Phấn Nước Lanegie Mịn','L07',CAST(550000 AS Decimal(18, 0)),CAST(6500000 AS Decimal(18, 0)), 30,N'Upload/m2.png',N'Phấn Nước Lanegie Mịn',N'Phù hợp với mọi loại da'),
	  ('MP27',N'Kem Nền Maybeline','L07',CAST(160000 AS Decimal(18, 0)),CAST(2000000 AS Decimal(18, 0)), 100,N'Upload/m3.jpg',N'Kem Nền Maybeline',N'Phù hợp với mọi loại da'),
	  ('MP28',N'Phấn Nước Kiềm Dầu Gar','L07',CAST(330000 AS Decimal(18, 0)),CAST(3500000 AS Decimal(18, 0)), 50,N'Upload/m4.png',N'Phấn Nước Kiềm Dầu Gar',N'Phù hợp với mọi loại da'),

	  ('MP29',N'Kem Chống Nắng Laroche Posay','L08',CAST(320000 AS Decimal(18, 0)),CAST(3500000 AS Decimal(18, 0)), 100,N'Upload/kcn1.png',N'Kem Chống Nắng Laroche Posay',N'Phù hợp với da khô'),
	  ('MP30',N'Kem Chống Nắng Centella 1004','L08',CAST(190000 AS Decimal(18, 0)),CAST(2500000 AS Decimal(18, 0)), 50,N'Upload/kcn2.png',N'Kem Chống Nắng Centella 1004',N'Phù hợp với da dầu'),
	   
	  ('MP31',N'Sữa Rửa Mặt SVR','L09',CAST(350000 AS Decimal(18, 0)),CAST(4200000 AS Decimal(18, 0)), 100,N'Upload/s1.png',N'Sữa Rửa Mặt SVR',N'Phù hợp với da khô'),
	  ('MP32',N'Sữa Rửa Mặt Bí Đao Cocoon','L09',CAST(160000 AS Decimal(18, 0)),CAST(2000000 AS Decimal(18, 0)), 50,N'Upload/s2.png',N'Sữa Rửa Mặt Bí Đao Cocoon',N'Phù hợp với da dầu'),

	  ('MP33',N'Tẩy Trang Biodema','L10',CAST(370000 AS Decimal(18, 0)),CAST(4500000 AS Decimal(18, 0)), 100,N'Upload/tt1.jpg',N'Tẩy Trang Biodema',N'Phù hợp với mọi loại dai'),
	  ('MP34',N'Tẩy Trang Garnie','L10',CAST(130000 AS Decimal(18, 0)),CAST(2500000 AS Decimal(18, 0)), 50,N'Upload/tt2.png',N'Tẩy Trang Garnie',N'Phù hợp với mọi loại da')
SELECT * FROM MyPham
SELECT * FROM HoaDonBan
SELECT * FROM ChiTietHoaDonBan

--ChiTietMyPham(MaChiTietMP, MaMP, MaNCC, MoTa, ChiTiet)
INSERT INTO ChiTietMyPham(MaChiTietMyPham, MaMP, MaNCC, MoTa, ChiTiet)
VALUES ('MaCT01', 'MP01', 'NCC01', null, null),
       ('MaCT02', 'MP02', 'NCC02', null, null),
	   ('MaCT03', 'MP03', 'NCC03', null, null),
	   ('MaCT04', 'MP04', 'NCC04', null, null),
	   ('MaCT05', 'MP05', 'NCC05', null, null),
	   ('MaCT06', 'MP06', 'NCC06', null, null),
	   ('MaCT07', 'MP07', 'NCC07', null, null),
	   ('MaCT08', 'MP08', 'NCC08', null, null),
	   ('MaCT09', 'MP09', 'NCC09', null, null),
	   ('MaCT10', 'MP10', 'NCC10', null, null)
       
--NhanVien(MaNV, HoTenNV,NgaySinh,GioiTinh, CaLam, Email, SDTNV, DiaChiNV)
INSERT INTO NhanVien(MaNV, HoTenNV,NgaySinh,GioiTinh, CaLam, Email, SDTNV, DiaChiNV)
VALUES('NV01',N'Mai Thị Hoa','09-09-1999',N'Nữ','FullTime',N'HoaMH09@gmail.com',0981890898,N'Mỹ Hào, Hưng Yên'),
      ('NV02',N'Trần Tuấn','09-01-1985',N'Nam','PartTime',N'LapTT@gmail.com',0904898998,N' Hưng Yên'),
      ('NV03',N'Nguyễn An','05-05-2000',N'Nam','FullTime',N'Anng09@gmail.com',0996890777,N'Hà Nội'),
      ('NV04',N'Vũ Thị Liên','09-09-1999',N'Nữ',N'FullTime', 'Mailien05@gmail.com',0984890005,N'Thái Bình'),
      ('NV05',N'Cao Thị Thu','05-07-1989',N'Nữ','PartTime','Thu89@gmail.com',0976890123,N'Bắc Ninh'),
	  ('NV06',N'Nguyễn Duy ','02-04-1992',N'Nam','FullTime',N'Luan10hn@gmail.com',0981890898,N'Hà Nội'),
      ('NV07',N'Bùi Hậu','08-02-1995',N'Nam','PartTime',N'Haubui@gmail.com',0904898998,N'Vũng Tàu'),
      ('NV08',N'Trần Lâm','06-03-2003',N'Nam','FullTime',N'Lamper03@gmail.com',0386890777,N' Quảng Ninh'),
      ('NV09',N'Cao Bá Hưng','02-01-1998',N'Nam',N'FullTime', 'Hung12@gmail.com',0384890005,N' Hải Dương'),
      ('NV10',N'Lê Mai Anh','07-06-1999',N'Nữ','PartTime','Anh99@gmail.com',0946890123,N'Nam Định')

----KhachHang(IDKH, HoTenKH,LoaiKhachHang, SDTKH, DiaChiKH)
INSERT INTO KhachHang(IDKH, HoTenKH, SDTKH, DiaChiKH)
VALUES('KH01',N'Trần Thị Liễu',09875678888,N'Yên Mỹ, Hưng Yên'),
      ('KH02',N'Nguyễn Văn Quỳnh', 09885638696,N'Mê Linh, Hà Nội'),
	  ('KH03',N'Vũ Thị Minh', 09455671232,N'Cẩm Giàng, Hải Dương'),
	  ('KH04',N'Trịnh Thị Lan', 03435556777,N'Mỹ Hào, Hưng Yên'),
	  ('KH05',N'Trần Thanh Thuỷ', 03538312793,N'Phù Cừ, Hưng Yên'),
	  ('KH06',N'Trần Hồng Anh',03875678888,N'Đống Đa, Hà Nội'),
      ('KH07',N'Nguyễn Hoa Như', 09585638696,N'Mê Linh, Hà Nội'),
	  ('KH08',N'Đỗ Nhật Dương', 09655671232,N'Nam Sách, Hải Dương'),
	  ('KH09',N'Trịnh Thị Duyên', 03535556777,N'Mỹ Hào, Hưng Yên'),
	  ('KH10',N'Hà Diệp Hoa', 03538312793,N'Vân Đồn, Quảng Ninh')
SELECT * From KhachHang

--NHACC(MaNCC, HoTenNCC, SDTNCC, DiaChiNCC)
INSERT INTO NHACC(MaNCC, HoTenNCC, SDTNCC, DiaChiNCC)
VALUES('NCC01',N'Cosmetic Hoa Lê', 0987233625,N'Bà Rịa, Vũng Tàu'),
      ('NCC02',N'Makeup BigBoon', 0987233622,N'Thanh Xuân, Hà Nội'),
	  ('NCC03',N'Cocoon Group', 0989233625,N'Thuận Thành, Bắc Ninh'),
	  ('NCC04',N'Sỉ lẻ Ngọc Bích', 0387233625,N'Cầu Giấy, Hà Nội'),
	  ('NCC05',N'Thanh Hằng Mỹ phẩm', 0357233625,N'Quận 9, TP Hồ Chí Minh'),
	  ('NCC06',N'VietNam KAO', 0977233625,N'Bà Rịa, Vũng Tàu'),
      ('NCC07',N'Makeup Beuty', 0997233622,N'Thanh Xuân, Hà Nội'),
	  ('NCC08',N'Tiệm làm đẹp', 0929233625,N'Thuận Thành, Bắc Ninh'),
	  ('NCC09',N'Sỉ lẻ Nhật Linh', 0337233625,N'Cầu Giấy, Hà Nội'),
	  ('NCC10',N'Tuyết Ngân Mỹ phẩm', 0357233625,N'Quận 9, TP Hồ Chí Minh')

INSERT INTO KhachHang(IDKH, HoTenKH, SDTKH, DiaChiKH)
VALUES('KH01',N'Trần Thị Liễu',09875678888,N'Yên Mỹ, Hưng Yên'),
      ('KH02',N'Nguyễn Văn Quỳnh', 09885638696,N'Mê Linh, Hà Nội'),
	  ('KH03',N'Vũ Thị Minh', 09455671232,N'Cẩm Giàng, Hải Dương'),
	  ('KH04',N'Trịnh Thị Lan', 03435556777,N'Mỹ Hào, Hưng Yên'),
	  ('KH05',N'Trần Thanh Thuỷ', 03538312793,N'Phù Cừ, Hưng Yên'),
	  ('KH06',N'Trần Hồng Anh',03875678888,N'Đống Đa, Hà Nội'),
      ('KH07',N'Nguyễn Hoa Như', 09585638696,N'Mê Linh, Hà Nội'),
	  ('KH08',N'Đỗ Nhật Dương', 09655671232,N'Nam Sách, Hải Dương'),
	  ('KH09',N'Trịnh Thị Duyên', 03535556777,N'Mỹ Hào, Hưng Yên'),
	  ('KH10',N'Hà Diệp Hoa', 03538312793,N'Vân Đồn, Quảng Ninh')

--HoaDonNhap(MaHDN,NgayNhap,MaTaiKhoan,MaNCC,KieuThanhToan,TongTien)
INSERT INTO HoaDonNhap(MaHDN,NgayNhap,MaTaiKhoan,MaNCC,KieuThanhToan,TongTien)
VALUES('HDN01','2023-08-10',9,'NCC04',N'Trả trước',500000),
      ('HDN02','2023-09-26',10,'NCC02',N'Trả sau',500000),
	  ('HDN03','2023-08-15',10,'NCC04',N'Trả trước',500000),
	  ('HDN04','2023-08-01',9,'NCC03',N'Trả sau',500000),
	  ('HDN05','2022-07-28',9,'NCC05',N'Trả trước',500000),
	  ('HDN06','2023-05-10',10,'NCC07',N'Trả trước',500000),
      ('HDN07','2023-11-26',9,'NCC08',N'Trả sau',500000),
	  ('HDN08','2023-12-15',10,'NCC09',N'Trả trước',500000),
	  ('HDN09','2023-08-01',9,'NCC10',N'Trả sau', 500000),
	  ('HDN10','2022-04-28',10,'NCC06',N'Trả trước',500000)

--ChiTietHoaDonNhap(MaMP, TenMP, SLNhap, DGNhap, TrietKhau, ThanhTien)
INSERT INTO ChiTietHoaDonNhap(MaCTHDN, MaHDN, MaMP, TenMP, SLNhap, DGNhap, ThanhTien)
VALUES('CTHDN01','HDN01','MP01',N'Kem chống nắng Cetella',20, 250000,4500000),
      ('CTHDN02','HDN02','MP03',N'Kem dưỡng ẩm Klieh',10, 300000,2700000),
	  ('CTHDN03','HDN03','MP06',N'Sữa rửa mặt Cerave',10, 400000,3800000),
	  ('CTHDN04','HDN04','MP09',N'Mask Whitening',20, 20000,380000),
	  ('CTHDN05','HDN05','MP15',N'Tinh dầu bưởi Cococoon',30, 150000,3825000),
	  ('CTHDN06','HDN06','MP22',N'Eyeliner maybeline',10, 150000,1500000),
      ('CTHDN07','HDN07','MP25',N'Body mist Victoria ',20, 300000,6000000),
	  ('CTHDN08','HDN08','MP26',N'Sữa tắm Terosi',2, 200000,400000),
	  ('CTHDN09','HDN09','MP19',N'Vaseline PX50',2, 200000,400000),
	  ('CTHDN10','HDN10','MP05',N'Sữa rửa mặt SVR',10, 400000,4000000)

--HoaDonBan(MaHDB, HoTenKH, SDTKH, DiaChiKH, TrangThai, NgayTao, NgayDuyet, TongTien, TGGiaoHang)
INSERT INTO HoaDonBan(HoTenKH, SDTKH, DiaChiKH, TrangThai, NgayTao, NgayDuyet, TongTien, TGGiaoHang)
VALUES(N'Nguyễn Văn Quỳnh','0988563869',N'Mê Linh, Hà Nội',1,'2023-04-18','2023-04-20', 500000, '2023-04-22'),
      (N'Trần Thị Liễu','0987567888',N'Yên Mỹ, Hưng Yên',2,'2023-05-20','2023-05-21', 600000,'2023-05-22'),
	  (N'Vũ Thị Minh','0945567123',N'Cẩm Giàng, Hải Dương',1,'2023-04-21','2023-04-23',700000,'2023-04-25'),
	  (N'Trần Thanh Thuỷ','0353831279',N'Phù Cừ, Hưng Yên',1,'2023-05-07','2023-05-08',800000,'2023-05-09'),
	  (N'Nguyễn Hoa Như','0958563869',N'Mê Linh, Hà Nội',2,'2023-06-24','2023-06-25',200000,'2023-06-26'),
	  (N'Đỗ Nhật Dương','0965567123',N'Nam Sách, Hải Dương',1,'2023-07-18','2023-07-19',300000,'2023-07-20'),
      (N'Trịnh Thị Duyên','0353555677',N'Kim Động, Hưng Yên',2,'2023-05-20','2023-05-21',500000,'2023-05-22'),
	  (N'Hà Diệp Hoa','0353831279',N'Vân Đồn, Quảng Ninh',1,'2023-06-20','2023-06-22',900000,'2023-06-24'),
	  (N'Vũ Thị Minh','0945567123',N'Cẩm Giàng, Hải Dương',2,'2023-05-07','2023-05-08',1000000,'2023-05-08'),
	  (N'Trần Hồng Anh','0387567888',N'Đống Đa, Hà Nội',1,'2023-08-15','2023-08-15',500000,'2023-08-16')


--ChiTietHoaDonBan(MaMP, SLBan, DGBan, GiamGia, ThanhTien)
INSERT INTO ChiTietHoaDonBan(MaHDB, MaMP, SLBan, TongTien)
VALUES(1,'MP01',10,500000),
      (2,'MP03',10,6000000),
	  (3,'MP06',10,700000),
	  (4,'MP09',20,800000),
	  (5,'MP15',30,200000),
	  (6,'MP22',20,300000),
      (7,'MP25',50,500000),
	  (8,'MP26',20,900000),
	  (9,'MP19',5,1000000),
	  (10,'MP05',10,500000)

SELECT * FRom ChiTietHoaDonBan
-------------USER(Tài khoản)---------------------------
----------------------LOGIN---------------------
CREATE PROCEDURE sp_login(@taikhoan nvarchar(20), @matkhau nvarchar(20))
AS
    BEGIN
      SELECT  *
      FROM TaiKhoan
      where TenTaiKhoan= @taikhoan and MatKhau = @matkhau;
    END;
GO

-------------GET BY ID----------------------------------
create PROCEDURE gettaikhoanbyid(@id INT)
AS
BEGIN
   SELECT*from TaiKhoan Where MaTaiKhoan = @id 
END;

---------------------CHECK LOGIN----------------------
CREATE PROCEDURE sp_check_login
@TenTaiKhoan NVARCHAR(20),
@MatKhau NVARCHAR(20)
AS
BEGIN
    DECLARE @LoaiTaiKhoan INT

    SELECT @LoaiTaiKhoan = LoaiTaiKhoan
    FROM TaiKhoan
    WHERE TenTaiKhoan = @TenTaiKhoan AND MatKhau = @MatKhau

    IF @LoaiTaiKhoan IS NOT NULL
    BEGIN
        SELECT @LoaiTaiKhoan AS LoaiTaiKhoan
    END
    ELSE
    BEGIN
        -- Không tìm thấy tài khoản
        SELECT -1 AS LoaiTaiKhoan
    END
END;


----------------------SELECT ALL----------------------
create PROCEDURE sp_taikhoan_select_all
AS
    BEGIN
      SELECT * FROM TaiKhoan
    END;
GO

-----------------THÊM---------------------------
create PROCEDURE sp_taikhoan_create(
@LoaiTaiKhoan INT,
@TenTaiKhoan Nvarchar(20),
@MatKhau Nvarchar(20),
@Email Varchar(30)
)
AS
    BEGIN
       INSERT INTO TaiKhoan(LoaiTaiKhoan, TenTaiKhoan, MatKhau, Email)
	   VALUES(@LoaiTaiKhoan, @TenTaiKhoan, @MatKhau, @Email);
    END;
GO

---------------------SỬA----------------------
create PROCEDURE sp_taikhoan_update(
@MaTK int,
@LoaiTaiKhoan INT,
@TenTaiKhoan Nvarchar(20),
@MatKhau Nvarchar(20),
@Email Varchar(30)
)
AS
    BEGIN
		Update TaiKhoan
		Set LoaiTaiKhoan = @LoaiTaiKhoan, TenTaiKhoan = @TenTaiKhoan, MatKhau = @MatKhau, Email = @Email
		Where MaTaiKhoan = @MaTK
    End;
GO


---------------------XOÁ------------------------
create PROCEDURE sp_taikhoan_delete
@MaTK int
AS
	Begin
		Delete TaiKhoan where MaTaiKhoan = @MaTK
	End;
GO

-----------------------------XOÁ NHIỀU--------------------------------
CREATE PROCEDURE sp_taikhoan_deleteS
(
    @list_json_mataikhoan Nvarchar(MAX)
)
AS
BEGIN
	IF(@list_json_mataikhoan IS NOT NULL) 
			BEGIN
				 -- Insert data to temp table 
			   SELECT
				  JSON_VALUE(t.value, '$.maTaiKhoan') as maTaiKhoan,
				  JSON_VALUE(t.value, '$.ghiChu') AS ghiChu 
				  INTO #Results 
			   FROM OPENJSON(@list_json_mataikhoan) AS t;

    DELETE FROM TaiKhoan
    WHERE MaTaiKhoan IN (SELECT MaTaiKhoan FROM #Results WHERE #Results.ghiChu = N'Cho phép xoá!');
    DROP TABLE #Results;
	END;
END;

-----------------------TÌM KIẾM---------------------------
create PROCEDURE sp_taikhoan_search (@page_index INT, 
                                  @page_size INT,
								  @maloaitk INT,
								  @ten_tk Nvarchar(20),
								  @email Nvarchar(30)
								  )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaTaiKhoan ASC)) AS RowNumber, 
                              tk.MaTaiKhoan,
							  tk.LoaiTaiKhoan,
							  ltk.TenLoaiTK,
							  tk.TenTaiKhoan,
							  tk.MatKhau,
							  tk.Email
                        INTO #Results1
                        FROM TaiKhoan AS tk
						inner join LoaiTaiKhoan ltk on ltk.MaLoaiTK = tk.LoaiTaiKhoan
					    WHERE (@maloaitk = 0 OR tk.LoaiTaiKhoan = @maloaitk) and 
						(@ten_tk = '' Or tk.TenTaiKhoan like N'%'+@ten_tk+'%') and
						(@email = '' Or tk.Email like N'%'+@email+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaTaiKhoan ASC)) AS RowNumber, 
                              tk.MaTaiKhoan,
							  tk.LoaiTaiKhoan,
							  ltk.TenLoaiTK,
							  tk.TenTaiKhoan,
							  tk.MatKhau,
							  tk.Email
                        INTO #Results2
                        FROM TaiKhoan AS tk
						inner join LoaiTaiKhoan ltk on ltk.MaLoaiTK = tk.LoaiTaiKhoan
					    WHERE (@maloaitk = 0 OR tk.LoaiTaiKhoan = @maloaitk) and 
						(@ten_tk = '' Or tk.TenTaiKhoan like N'%'+@ten_tk+'%') and
						(@email = '' Or tk.Email like N'%'+@email+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO

---------------------------LOẠI TÀI KHOẢN-----------------------
-------------GET BY ID----------------------------------
create PROCEDURE getloaitaikhoanbyid(@id INT)
AS
BEGIN
   SELECT*from LoaiTaiKhoan Where MaLoaiTK = @id 
END;

CREATE Table LoaiTaiKhoan (
MaLoaiTK INT IDENTITY(1,1) PRIMARY KEY,
TenLoaiTK Nvarchar(20),
MoTa Nvarchar(30)
)
-----------------THÊM---------------------------
create PROCEDURE sp_loaitaikhoan_create(
@TenLoaiTK Nvarchar(20),
@MoTa Nvarchar(30)
)
AS
    BEGIN
       INSERT INTO LoaiTaiKhoan(TenLoaiTK, MoTa)
	   VALUES(@TenLoaiTK, @MoTa);
    END;
GO

---------------------SỬA----------------------
create PROCEDURE sp_loaitaikhoan_update(
@MaLoaiTK INT,
@TenLoaiTK Nvarchar(20),
@MoTa Nvarchar(30)
)
AS
    BEGIN
		Update LoaiTaiKhoan
		set TenLoaiTK = @TenLoaiTK, MoTa = @MoTa where MaLoaiTK = @MaLoaiTK
    End;
GO

---------------------XOÁ------------------------
create PROCEDURE sp_loaitaikhoan_delete
@MaLoaiTK INT
AS
	Begin
		Delete LoaiTaiKhoan where MaLoaiTK = @MaLoaiTK
	End;
GO

-----------------------TÌM KIẾM---------------------------
CREATE PROCEDURE [dbo].[sp_loaitaikhoan_search] (@page_index  INT, 
                                       @page_size   INT,
									   @tenloai_tk Nvarchar(20),
									   @motaloai_tk Nvarchar(30)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenLoaiTK ASC)) AS RowNumber, 
							  n.MaLoaiTK,
							  n.TenLoaiTK,
							  n.MoTa				  
                        INTO #Results1
                        FROM LoaiTaiKhoan AS n
					    WHERE  (@tenloai_tk = '' Or n.TenLoaiTK like N'%'+@tenloai_tk+'%') and						
						(@motaloai_tk = '' Or n.MoTa like N'%'+@motaloai_tk+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                         SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenLoaiTK ASC)) AS RowNumber, 
							  n.MaLoaiTK,
							  n.TenLoaiTK,
							  n.MoTa	
                        INTO #Results2
                        FROM LoaiTaiKhoan AS n
					    WHERE  (@tenloai_tk = '' Or n.TenLoaiTK like N'%'+@tenloai_tk+'%') and						
						(@motaloai_tk = '' Or n.MoTa like N'%'+@motaloai_tk+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO

-------------------------BÀI VIẾT--------------------
---------------------GET BY ID-------------------------
----Trả về inf của một bài viết dựa trên MaBV được truyền vào qua tham số @id
create PROCEDURE getbaivietbyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from BaiViet where MaBV = @id 
END;

-------------------THÊM-------------------
create PROCEDURE sp_baiviet_create(
-----5 tham số đầu vào
@MaBV Nvarchar(10),
@TieuDe Nvarchar(100),
@NguoiDang Nvarchar(20),
@TGDang Date,
@NgayKT Date, 
@NoiDung Nvarchar(MAX)
)
AS
    BEGIN
       INSERT INTO BaiViet(MaBV, TieuDe, NguoiDang, TGDang, NgayKT, NoiDung)
	   VALUES(@MaBV, @TieuDe, @NguoiDang, @TGDang, @NgayKT, @NoiDung);
    END;
GO

------------------------------SỬA----------------------
create PROCEDURE [dbo].[sp_baiviet_update](
@MaBV Nvarchar(10),
@TieuDe Nvarchar(100),
@NguoiDang Nvarchar(20),
@TGDang Date,
@NgayKT Date, 
@NoiDung Nvarchar(MAX)
)
AS
    BEGIN
		update BaiViet set tieude = @TieuDe, nguoidang = @NguoiDang, tgdang = @TGDang, ngaykt = @NgayKT, noidung = @NoiDung where mabv = @MaBV; 
    END;
GO

----------------------------XOÁ---------------------------------
CREATE PROCEDURE sp_baiviet_delete
@MaBV Nvarchar(10)
AS
	BEGIN
		DELETE BaiViet WHERE MaBV = @MaBV
	END;
GO

-----------------------------XOÁ NHIỀU--------------------------------
CREATE PROCEDURE sp_baiviet_deleteS
(
--- 1 tham số đầu vào là @list_json_mabv: chứa list mabv cần xóa, được truyền dưới dạng chuỗi JSON.
    @list_json_mabv Nvarchar(MAX)
)
AS
BEGIN
	IF(@list_json_mabv IS NOT NULL) 
			BEGIN
				 --mở rộng chuỗi JSON trong tham số @list_json_mabv thành các cột maBV và ghiChu 
				 --của một bảng tạm thời (#Results) => xác định mabv cần xóa.
			   SELECT
				  JSON_VALUE(b.value, '$.maBV') as maBV,
				  JSON_VALUE(b.value, '$.ghiChu') AS ghiChu 
				  INTO #Results 
			   FROM OPENJSON(@list_json_mabv) AS b;

    DELETE FROM BaiViet
    WHERE MaBV IN (SELECT MaBV FROM #Results WHERE #Results.ghiChu = N'Cho phép xoá!');
	--Xóa bảng tạm thời sau khi sd.
    DROP TABLE #Results;
	END;
END;

SELECT * FROM BaiViet


exec [sp_baiviet_search]  @page_index = 1 , @page_size = 1 , @tieu_de = N'Dùng son' , @noi_dung = N'Dùng mỗi ngày'
--------------------------TÌM KIẾM------------------------------
---tìm kiếm bài viết thông qua: tiêu đề và nội dung; hỗ trợ phân trang 
CREATE PROCEDURE [dbo].[sp_baiviet_search] (@page_index  INT, 
                                       @page_size   INT,
									   @tieu_de Nvarchar(100),
									   @noi_dung Nvarchar(MAX)
									   )
AS
    BEGIN
	   --sd để lưu trữ tổng số bản ghi trong KQ tìm kiếm
        DECLARE @RecordCount BIGINT;
		--kiểm tra xem @page_size có giá trị # 0 hay không? Có => Phân trang
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TieuDe ASC)) AS RowNumber, 
                              n.MaBV,
							  n.TieuDe,
							  n.NguoiDang,
							  n.TGDang,
							  n.NgayKT,
							  n.NoiDung
                        INTO #Results1
                        FROM BaiViet AS n
					    WHERE  (@tieu_de = '' Or n.TieuDe like N'%'+@tieu_de+'%') and						
						(@noi_dung = '' Or n.NoiDung like N'%'+@noi_dung+'%');    
						--Đếm tổng số bản ghi tìm kiếm và lưu vào biến @RecordCount
                        SELECT @RecordCount = COUNT(*) FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
			--Ngược lại, nếu @page_size = 0 => 0 cần phân trang
            ELSE
            BEGIN
						SET NOCOUNT ON;
                         SELECT(ROW_NUMBER() OVER(
                              ORDER BY TieuDe ASC)) AS RowNumber, 
                              n.MaBV,
							  n.TieuDe,
							  n.NguoiDang,
							  n.TGDang,
							  n.NgayKT,
							  n.NoiDung
                        INTO #Results2
                       FROM BaiViet AS n
					    WHERE  (@tieu_de = '' Or n.TieuDe like N'%'+@tieu_de+'%') and						
						(@noi_dung = '' Or n.NoiDung like N'%'+@noi_dung+'%');                 
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO


----------------------NHÂN VIÊN---------------------
-------------------GET BY ID-------------------------
create PROCEDURE getnhanvienbyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from NhanVien where MaNV = @id 
END;

-------------------THÊM-------------------
create PROCEDURE sp_nhanvien_create(
@MaNV Nvarchar(10),
@HoTenNV Nvarchar(30),
@NgaySinh DATE,
@GioiTinh Nvarchar(3),
@CaLam Nvarchar(8),
@SDTNV Varchar(11),
@DiachiNV Nvarchar(30),
@Email Varchar(30)
)
AS
    BEGIN
       insert into NhanVien(MaNV,HoTenNV,NgaySinh,GioiTinh,CaLam,SDTNV,DiachiNV,Email)
	   values(@MaNV,@HoTenNV,@NgaySinh,@GioiTinh,@CaLam,@SDTNV,@DiachiNV,@Email);
    END;
GO

------------------------------SỬA----------------------
create PROCEDURE [dbo].[sp_nhanvien_update](
@MaNV Nvarchar(10),
@HoTenNV Nvarchar(30),
@NgaySinh DATE,
@GioiTinh Nvarchar(3),
@CaLam Nvarchar(8),
@SDTNV Varchar(11),
@DiachiNV Nvarchar(30),
@Email Varchar(30)
)
AS
    BEGIN
		update NhanVien set hotennv = @HoTenNV, calam = @CaLam, sdtnv = @SDTNV, diachinv = @DiachiNV, email = @Email where manv = @MaNV; 
    END;
GO

----------------------------XOÁ---------------------------------
CREATE PROCEDURE sp_nhanvien_delete
@MaNV Nvarchar(10)
AS
	BEGIN
		DELETE NhanVien WHERE MaNV = @MaNV
	END;
GO


-----------------------------XOÁ NHIỀU--------------------------------
CREATE PROCEDURE sp_nhanvien_deleteS
(
    @list_json_manv Nvarchar(MAX)
)
AS
BEGIN
	IF(@list_json_manv IS NOT NULL) 
			BEGIN
				 -- Insert data to temp table 
			   SELECT
				  JSON_VALUE(n.value, '$.maNV') as maNV,
				  JSON_VALUE(n.value, '$.ghiChu') AS ghiChu 
				  INTO #Results 
			   FROM OPENJSON(@list_json_manv) AS n;

    DELETE FROM NhanVien
    WHERE MaNV IN (SELECT MaNV FROM #Results WHERE #Results.ghiChu = N'Cho phép xoá!');
    DROP TABLE #Results;
	END;
END;
SELECT * FROM NhanVien


exec [sp_nhanvien_search]  @page_index = 1 , @page_size = 1 , @ten_nv = N'Mai Thị Hoa' , @dia_chinv = N'Mỹ Hào, Hưng Yên'
--------------------------TÌM KIẾM------------------------------
CREATE PROCEDURE [dbo].[sp_nhanvien_search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_nv Nvarchar(30),
									   @dia_chinv Nvarchar(30)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY HoTenNV ASC)) AS RowNumber, 
                              n.MaNV,
							  n.HoTenNV,
							  n.NgaySinh,
							  n.GioiTinh,
							  n.CaLam,
							  n.SDTNV,
							  n.DiachiNV,
							  n.Email
                        INTO #Results1
                        FROM NhanVien AS n
					    WHERE  (@ten_nv = '' Or n.HoTenNV like N'%'+@ten_nv+'%') and						
						(@dia_chinv = '' Or n.DiaChiNV like N'%'+@dia_chinv+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY HoTenNV ASC)) AS RowNumber, 
                              n.MaNV,
							  n.HoTenNV,
							  n.NgaySinh,
							  n.GioiTinh,
							  n.CaLam,
							  n.SDTNV,
							  n.DiachiNV,
							  n.Email
                        INTO #Results2
                        FROM NhanVien AS n
					    WHERE  (@ten_nv = '' Or n.HoTenNV like N'%'+@ten_nv+'%') and						
						(@dia_chinv = '' Or n.DiaChiNV like N'%'+@dia_chinv+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO


--------------------------KHÁCH HÀNG--------------------
-------------------GET BY ID--------------------

create PROCEDURE getkhachhangbyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from KhachHang where IDKH = @id 
END;

------------------------THÊM----------------------
create PROCEDURE sp_khachhang_create(
@IDKH Nvarchar(10),
@HoTenKH Nvarchar(30),
@SDTKH Varchar(11),
@DiaChiKH Nvarchar(30)
)
AS
    BEGIN
       insert into KhachHang(IDKH, HoTenKH, SDTKH, DiaChiKH)
	   values(@IDKH, @HoTenKH, @SDTKH, @DiaChiKH);
    END;
GO

------------------------------SỬA----------------------
create PROCEDURE [dbo].[sp_khachhang_update](
@IDKH Nvarchar(10),
@HoTenKH Nvarchar(30),
@SDTKH Varchar(11),
@DiaChiKH Nvarchar(30)
)
AS
    BEGIN
		update KhachHang set hotenkh = @HoTenKH, sdtkh = @SDTKH, diachikh = @DiaChiKH where idkh = @IDKH; 
    END;
GO

----------------------------XOÁ---------------------------------
CREATE PROCEDURE sp_khachhang_delete
@IDKH Nvarchar(10)
AS
	BEGIN
		DELETE KhachHang WHERE IDKH = @IDKH
	END;
GO
H
-----------------------------XOÁ NHIỀU--------------------------------
CREATE PROCEDURE sp_khachhang_deleteS
(
    @list_json_idkh Nvarchar(MAX)
)
AS
BEGIN
	IF(@list_json_idkh IS NOT NULL) 
			BEGIN
				 -- Insert data to temp table 
			   SELECT
				  JSON_VALUE(k.value, '$.idkh') as idkh,
				  JSON_VALUE(k.value, '$.ghiChu') AS ghiChu 
				  INTO #Results 
			   FROM OPENJSON(@list_json_idkh) AS k;

    DELETE FROM KhachHang
    WHERE IDKH IN (SELECT IDKH FROM #Results WHERE #Results.ghiChu = N'Cho phép xoá!');
    DROP TABLE #Results;
	END;
END;

SELECT * FROM KhachHang

exec [sp_khachhang_search]  @page_index = 1 , @page_size = 5 , @ten_kh = N'Nguyễn Văn Quỳnh' , @dia_chikh = N'Mê Linh, Hà Nội'
--------------------------TÌM KIẾM------------------------------
CREATE PROCEDURE [dbo].[sp_khachhang_search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_kh Nvarchar(30),
									   @dia_chikh Nvarchar(30)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY HoTenKH ASC)) AS RowNumber, 
                              n.IDKH,
							  n.HoTenKH,
							  n.SDTKH,
							  n.DiaChiKH
                        INTO #Results1
                        FROM KhachHang AS n
					    WHERE  (@ten_kh = '' Or n.HoTenKH like N'%'+@ten_kh+'%') and						
						(@dia_chikh = '' Or n.DiaChiKH like N'%'+@dia_chikh+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY HoTenKH ASC)) AS RowNumber, 
                              n.IDKH,
							  n.HoTenKH,
							  n.SDTKH,
							  n.DiaChiKH
                        INTO #Results2
                        FROM KhachHang AS n
					    WHERE  (@ten_kh = '' Or n.HoTenKH like N'%'+@ten_kh+'%') and						
						(@dia_chikh = '' Or n.DiaChiKH like N'%'+@dia_chikh+'%');                     
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO

SELECT * FROM KhachHang

-----------------------------NHÀ CUNG CẤP---------------------
EXEC getnhaccbyid 'NCC01'
------------------GET BY ID--------------------
create PROCEDURE getnhaccbyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from NhaCC where MaNCC = @id 
END;

------------------------THÊM-------------------
create PROCEDURE sp_nhacc_create(
@MaNCC Nvarchar(10),
@HoTenNCC Nvarchar(30),
@SDTNCC Varchar(11),
@DiaChiNCC Nvarchar(30)
)
AS
    BEGIN
       insert into NhaCC(MaNCC, HoTenNCC, SDTNCC, DiaChiNCC)
	   values(@MaNCC, @HoTenNCC, @SDTNCC, @DiaChiNCC);
    END;
GO

------------------------------SỬA----------------------
create PROCEDURE [dbo].[sp_nhacc_update](
@MaNCC Nvarchar(10),
@HoTenNCC Nvarchar(30),
@SDTNCC Varchar(11),
@DiaChiNCC Nvarchar(30)
)
AS
    BEGIN
		update NhaCC set hotenncc = @HoTenNCC, sdtncc = @SDTNCC, diachincc = @DiaChiNCC where mancc = @MaNCC; 
    END;
GO

-----------------------Xoá Nhà cung cấp----------------------
CREATE PROCEDURE sp_nhacc_delete
@MaNCC Nvarchar(10)
AS
	BEGIN
		DELETE NhaCC WHERE MaNCC = @MaNCC
	END;
GO

-----------------------------XOÁ NHIỀU--------------------------------
CREATE PROCEDURE sp_nhacc_deleteS
(
    @list_json_mancc Nvarchar(MAX)
)
AS
BEGIN
	IF(@list_json_mancc IS NOT NULL) 
			BEGIN
				 -- Insert data to temp table 
			   SELECT
				  JSON_VALUE(n.value, '$.maNCC') as maNCC,
				  JSON_VALUE(n.value, '$.ghiChu') AS ghiChu 
				  INTO #Results 
			   FROM OPENJSON(@list_json_mancc) AS n;

    DELETE FROM NhaCC
    WHERE MaNCC IN (SELECT MaNCC FROM #Results WHERE #Results.ghiChu = N'Cho phép xoá!');
    DROP TABLE #Results;
	END;
END;

SELECT * FROM NhaCC

exec [sp_nhacc_search]  @page_index = 1 , @page_size = 5 , @ten_ncc = N'Cosmetic Hoa Lê' , @dia_chincc = N'Bà Rịa, Vũng Tàu'
-------------------------Tìm kiếm----------------------------
CREATE PROCEDURE [dbo].[sp_nhacc_search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_ncc Nvarchar(30),
									   @dia_chincc Nvarchar(30)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY HoTenNCC ASC)) AS RowNumber, 
                              n.MaNCC,
							  n.HoTenNCC,
							  n.SDTNCC,
							  n.DiaChiNCC
                        INTO #Results1
                        FROM NhaCC AS n
					    WHERE  (@ten_ncc = '' Or n.HoTenNCC like N'%'+@ten_ncc+'%') and						
						(@dia_chincc = '' Or n.DiaChiNCC like N'%'+@dia_chincc+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                         SELECT(ROW_NUMBER() OVER(
                              ORDER BY HoTenNCC ASC)) AS RowNumber, 
                               n.MaNCC,
							  n.HoTenNCC,
							  n.SDTNCC,
							  n.DiaChiNCC
                        INTO #Results2
                        FROM NhaCC AS n
					    WHERE  (@ten_ncc = '' Or n.HoTenNCC like N'%'+@ten_ncc+'%') and						
						(@dia_chincc = '' Or n.DiaChiNCC like N'%'+@dia_chincc+'%');                  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO

--------------Mỹ phẩm----------------------------
---------GetByID---------------------
create PROCEDURE getmyphambyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from MyPham where MaMP = @id 
END;

-----------LẤY MỸ PHẨM THEO LOẠI MỸ PHẨM----------------
CREATE PROCEDURE sp_laymptheoloai
AS
    BEGIN
        SELECT lmp.*, 
        (
            SELECT mp.*
            FROM MyPham AS mp
            WHERE lmp.MaLoaiMP = mp.MaLoaiMP FOR JSON PATH
        ) AS list_json_loaimypham
        FROM LoaiMyPham AS lmp
    END;
GO

exec sp_LayMyPhamTheoChucNang @ChucNang = 1
GO
-------------------Lấy Theo chức năng----------------
CREATE PROCEDURE sp_LayMyPhamTheoChucNang 
    @ChucNang int
AS
BEGIN
    IF @ChucNang = 1
    BEGIN
        -- Lấy mỹ phẩm bán chạy nhất
        WITH Top3MyPhamBanChay AS (
        SELECT 
		CTHDB.MaMP, MyPham.TenMP,
        SUM(CTHDB.SLBan) AS TongSLBan,
		-- Đếm số đơn đặt hàng( DISTINCT để đảm bảo chỉ đếm các đơn đặt hàng duy nhất)
        COUNT(DISTINCT HDB.MaHDB) AS SoDonDatHang,
        ROW_NUMBER() OVER (ORDER BY SUM(CTHDB.SLBan) DESC) AS RowNum
        FROM ChiTietHoaDonBan CTHDB JOIN MyPham ON CTHDB.MaMP = MyPham.MaMP JOIN HoaDonBan HDB ON CTHDB.MaHDB = HDB.MaHDB
        GROUP BY CTHDB.MaMP, MyPham.TenMP)
		SELECT MaMP,TenMP,TongSLBan,SoDonDatHang
        FROM Top3MyPhamBanChay WHERE RowNum <= 3;

    END
    ELSE IF @ChucNang = 2
    BEGIN
        -- Lấy mỹ phẩm có giá thấp nhất
        SELECT TOP 1 MyPham.MaMP,MyPham.TenMP,ChiTietHoaDonBan.DGBan AS GiaBanThapNhat
        FROM MyPham
        JOIN ChiTietHoaDonBan ON MyPham.MaMP = ChiTietHoaDonBan.MaMP
        WHERE ChiTietHoaDonBan.DGBan = (SELECT MIN(DGBan) FROM ChiTietHoaDonBan WHERE DGBan IS NOT NULL)
		--hữu ích để đảm bảo rằng nếu có nhiều mỹ phẩm có giá bán thấp = nhau
        ORDER BY MyPham.MaMP;
    END

	ELSE IF @ChucNang = 3
    BEGIN
        -- Lấy 3 mỹ phẩm có nhiều sl tồn nhất
        SELECT TOP 3 MaMP,TenMP,SLTon
        FROM MyPham
        ORDER BY SLTon DESC;
    END
    ELSE
    BEGIN
        PRINT 'Chức năng không hợp lệ!';
    END
END

SELECT * FROM MyPham
select * from HoaDonNhap
select * from ChiTietHoaDonBan

---------------------THÊM---------------------------
alter PROCEDURE sp_mypham_create(
@MaMP Nvarchar(10),
@TenMP Nvarchar(50),
@MaLoaiMP Nvarchar(10),
@GiaMoi Decimal(18, 0),
@GiaCu Decimal(18, 0),
@SLTon int,
@MoTa Nvarchar(MAX),
@AnhDaiDien Nvarchar(MAX),
@GhiChu Nvarchar(30)
)
AS
    BEGIN
       insert into MyPham(MaMP, TenMP, MaLoaiMP, GiaMoi, GiaCu, SLTon, MoTa, GhiChu,AnhDaiDien)
	   values(@MaMP, @TenMP, @MaLoaiMP, @GiaMoi, @GiaCu,  @SLTon, @MoTa, @GhiChu,@AnhDaiDien);
    END;
GO

------------------------------SỬA----------------------
alter PROCEDURE [dbo].[sp_mypham_update](
@MaMP Nvarchar(10),
@TenMP Nvarchar(50),
@MaLoaiMP Nvarchar(10),
@GiaMoi Decimal(18, 0),
@GiaCu Decimal(18, 0),
@SLTon int,
@MoTa Nvarchar(MAX),
@AnhDaiDien Nvarchar(MAX),
@GhiChu Nvarchar(30)
)
AS
    BEGIN
		update MyPham set tenmp = @TenMP, maloaimp = @MaLoaiMP,AnhDaiDien=@AnhDaiDien, giamoi = @GiaMoi, giacu = @GiaCu, mota = @MoTa, ghichu = @GhiChu where mamp = @MaMP; 
    END;
GO

-----------------------Xoá Mỹ phẩm----------------------
CREATE PROCEDURE sp_mypham_delete
@MaMP Nvarchar(10)
AS
	BEGIN
		DELETE MyPham WHERE MaMP = @MaMP
	END;
GO

-----------------------------XOÁ NHIỀU--------------------------------
CREATE PROCEDURE sp_mypham_deleteS
(
    @list_json_mamp Nvarchar(MAX)
)
AS
BEGIN
	IF(@list_json_mamp IS NOT NULL) 
			BEGIN
				 -- Insert data to temp table 
			   SELECT
				  JSON_VALUE(m.value, '$.maMP') as maMP,
				  JSON_VALUE(m.value, '$.ghiChu') AS ghiChu 
				  INTO #Results 
			   FROM OPENJSON(@list_json_mamp) AS m;

    DELETE FROM MyPham
    WHERE MaMP IN (SELECT MaMP FROM #Results WHERE #Results.ghiChu = N'Cho phép xoá!');
    DROP TABLE #Results;
	END;
END;

SELECT * FROM MyPham

exec [sp_mypham_search]  @page_index = 1 , @page_size = 1 , @ten_mp = N'Dầu LOreal Tinh Dầu Hoa Tự Nhiên' , @mota_mp = N'Dầu LOreal Tinh Dầu Hoa Tự Nhiên'
-------------------------Tìm kiếm----------------------------
CREATE PROCEDURE [dbo].[sp_mypham_search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_mp Nvarchar(30),
									   @mota_mp Nvarchar(30)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenMP ASC)) AS RowNumber, 
                              n.MaMP,
							  n.TenMP,
							  n.MaLoaiMP,
							  n.GiaMoi,
							  n.GiaCu,
							  n.SLTon,
							  n.AnhDaiDien,
							  n.MoTa,
							  n.GhiChu						  
                        INTO #Results1
                        FROM MyPham AS n
					    WHERE  (@ten_mp = '' Or n.TenMP like N'%'+@ten_mp+'%') and						
						(@mota_mp = '' Or n.MoTa like N'%'+@mota_mp+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenMP ASC)) AS RowNumber, 
                              n.MaMP,
							  n.TenMP,
							  n.MaLoaiMP,
							  n.GiaMoi,
							  n.GiaCu,
							  n.SLTon,
							  n.AnhDaiDien,
							  n.MoTa,
							  n.GhiChu	
                        INTO #Results2
                        FROM MyPham AS n
					     WHERE  (@ten_mp = '' Or n.TenMP like N'%'+@ten_mp+'%') and						
						(@mota_mp = '' Or n.MoTa like N'%'+@mota_mp+'%');                  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO

DROP PROCEDURE [dbo].[sp_mypham_searchlmp]

exec [sp_mypham_searchlmp]  @page_index = 1 , @page_size = 1 , @maloai_mp = N'L01' 
-------------------------Tìm kiếm theo mã loại cho user----------------------------
CREATE PROCEDURE [dbo].[sp_mypham_searchlmp] (@page_index  INT, 
                                       @page_size   INT,
									   @maloai_mp Nvarchar(30)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaMP ASC)) AS RowNumber, 
                              n.MaMP,
							  l.TenLoaiMP,
							  n.TenMP,
							  n.MaLoaiMP,
							  n.GiaMoi,
							  n.GiaCu,
							  n.SLTon,
							  n.AnhDaiDien,
							  n.MoTa,
							  n.GhiChu						  
                        INTO #Results1
                        FROM MyPham AS n
						Inner join LoaiMyPham l on l.MaLoaiMP = n.MaLoaiMP
					    WHERE  (@maloai_mp = '' Or n.MaLoaiMP like N'%'+@maloai_mp+'%');
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaMP ASC)) AS RowNumber, 
                              n.MaMP,
							  l.TenLoaiMP,
							  n.TenMP,
							  n.MaLoaiMP,
							  n.GiaMoi,
							  n.GiaCu,
							  n.SLTon,
							  n.AnhDaiDien,
							  n.MoTa,
							  n.GhiChu		
                        INTO #Results2
                        FROM MyPham AS n
					    Inner join LoaiMyPham l on l.MaLoaiMP = n.MaLoaiMP
					    WHERE  (@maloai_mp = '' Or n.MaLoaiMP like N'%'+@maloai_mp+'%');                 
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO
SELECT * FROM MyPham

--------------Loại Mỹ phẩm----------------------------
-------------------GetByID---------------------
create PROCEDURE getloaimyphambyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from LoaiMyPham where MaLoaiMP = @id 
END;

---------------------THÊM---------------------------
create PROCEDURE sp_loaimypham_create(
@MaLoaiMP Nvarchar(10),
@TenLoaiMP Nvarchar(30),
@AnhDaiDien Nvarchar(500),
@MoTa Nvarchar(MAX)
)
AS
    BEGIN
       insert into LoaiMyPham(MaLoaiMP,TenLoaiMP, AnhDaiDien, MoTa)
	   values(@MaLoaiMP, @TenLoaiMP, @AnhDaiDien, @MoTa);
    END;
GO
SELECT * FROM LoaiMyPham

------------------------------SỬA----------------------
create PROCEDURE [dbo].[sp_loaimypham_update](
@MaLoaiMP Nvarchar(10),
@TenLoaiMP Nvarchar(30),
@AnhDaiDien Nvarchar(500),
@MoTa Nvarchar(MAX)
)
AS
    BEGIN
		update LoaiMyPham set tenloaimp = @TenLoaiMP, anhdaidien = @AnhDaiDien, mota = @MoTa where maloaimp = @MaLoaiMP; 
    END;
GO

-----------------------Xoá loại Mỹ phẩm----------------------
CREATE PROCEDURE sp_loaimypham_delete
@MaLoaiMP Nvarchar(10)
AS
	BEGIN
		DELETE LoaiMyPham WHERE MaLoaiMP = @MaLoaiMP
	END;
GO

-----------------------------XOÁ NHIỀU--------------------------------
CREATE PROCEDURE sp_loaimypham_deleteS
(
    @list_json_maloaimp Nvarchar(MAX)
)
AS
BEGIN
	IF(@list_json_maloaimp IS NOT NULL) 
			BEGIN
				 -- Insert data to temp table 
			   SELECT
				  JSON_VALUE(l.value, '$.maLoaiMP') as maLoaiMP,
				  JSON_VALUE(l.value, '$.ghiChu') AS ghiChu 
				  INTO #Results 
			   FROM OPENJSON(@list_json_maloaimp) AS l;

    DELETE FROM LoaiMyPham
    WHERE MaLoaiMP IN (SELECT MaLoaiMP FROM #Results WHERE #Results.ghiChu = N'Cho phép xoá!');
    DROP TABLE #Results;
	END;
END;

SELECT * FROM LoaiMyPham

-------------------------Tìm kiếm----------------------------
CREATE PROCEDURE [dbo].[sp_loaimypham_search] (@page_index  INT, 
                                       @page_size   INT,
									   @tenloai_mp Nvarchar(30),
									   @motaloai_mp Nvarchar(30),
									   @anh_dai_dien Nvarchar(500)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaLoaiMP ASC)) AS RowNumber, 
							  n.MaLoaiMP,
							  n.TenLoaiMP,
							  n.AnhDaiDien,
							  n.MoTa				  
                        INTO #Results1
                        FROM LoaiMyPham AS n
					    WHERE  (@tenloai_mp = '' Or n.TenLoaiMP like N'%'+@tenloai_mp+'%') and	
						(@anh_dai_dien = '' Or n.AnhDaiDien like N'%'+@anh_dai_dien+'%') and
						(@motaloai_mp = '' Or n.MoTa like N'%'+@motaloai_mp+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaLoaiMP ASC)) AS RowNumber, 
							  n.MaLoaiMP,
							  n.TenLoaiMP,
							  n.AnhDaiDien,
							  n.MoTa	
                        INTO #Results2
                        FROM LoaiMyPham AS n
					    WHERE  (@tenloai_mp = '' Or n.TenLoaiMP like N'%'+@tenloai_mp+'%') and	
						(@anh_dai_dien = '' Or n.AnhDaiDien like N'%'+@anh_dai_dien+'%') and						
						(@motaloai_mp = '' Or n.MoTa like N'%'+@motaloai_mp+'%');                  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO




----------------Hoá đơn nhập------------------------
---------------------GET BY ID------------------
create PROCEDURE gethoadonnhapbyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from HoaDonNhap where MaHDN = @id 
END;

------------------GETALL-------------------
exec sp_hoadonnhap_get_all
drop proc sp_hoadonnhap_get_all

CREATE PROC sp_hoadonnhap_get_all
AS
Begin
	SELECT h.*, 
        (
            SELECT c.*
            FROM ChiTietHoaDonNhap AS c
            WHERE h.MaHDN = c.MaHDN FOR JSON PATH
        ) AS list_json_chitiethoadonnhap
        FROM HoaDonNhap AS h
End;

---------------------THÊM---------------------------
create PROCEDURE sp_hoadonnhap_create(
@MaHDN Nvarchar(10),
@NgayNhap Date,
@MaTaiKhoan INT,
@MaNCC Nvarchar(10),
@KieuThanhToan Nvarchar(20),
@TongTien float
)
AS
    BEGIN
       insert into HoaDonNhap(MaHDN, NgayNhap, MaTaiKhoan, MaNCC, KieuThanhToan, TongTien)
	   values(@MaHDN, @NgayNhap, @MaTaiKhoan, @MaNCC, @KieuThanhToan, @TongTien);
    END;
GO

----------------CT Hoá đơn nhập------------------------
---------------------GET BY ID------------------
create PROCEDURE getcthdnbyid(@id Nvarchar(10)) 
AS
BEGIN
SELECT*from ChiTietHoaDonNhap where MaCTHDN = @id 
END;

SELECT * FROM ChiTietHoaDonNhap

-------------------------Tìm kiếm----------------------------
create PROCEDURE sp_cthdn_search (@page_index INT, 
                                  @page_size INT,
								  @ma_hd Nvarchar(10),
								  @ma_mp Nvarchar(10)
								  )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaCTHDN ASC)) AS RowNumber, 
							  cthdn.MaCTHDN,
                              cthdn.MaHDN,
							  cthdn.MaMP,
							  cthdn.TenMP,
							  cthdn.SLNhap,
							  cthdn.DGNhap,
							  cthdn.ThanhTien
                        INTO #Results1
                        FROM ChiTietHoaDonNhap AS cthdn
						inner join MyPham mp on mp.MaMP = cthdn.MaMP
					    WHERE (@ma_hd = 0 OR cthdn.MaHDN = @ma_hd) and 
						(@ma_mp = 0 OR cthdn.MaMP= @ma_mp)         
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaCTHDN ASC)) AS RowNumber, 
							  cthdn.MaCTHDN,
                              cthdn.MaHDN,
							  cthdn.MaMP,
							  cthdn.TenMP,
							  cthdn.SLNhap,
							  cthdn.DGNhap,
							  cthdn.ThanhTien
                        INTO #Results2
                        FROM ChiTietHoaDonNhap AS cthdn
						inner join MyPham mp on mp.MaMP = cthdn.MaMP
					    WHERE (@ma_hd = 0 OR cthdn.MaHDN = @ma_hd) and 
						(@ma_mp = 0 OR cthdn.MaMP= @ma_mp)                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO


SELECT * FROM HoaDonBan

-----------------------------HOÁ ĐƠn bán----------------------------
EXEC gethoadonbanbyid 55
---------------------GET BY ID------------------
CREATE PROCEDURE gethoadonbanbyid(@id int)
AS
    BEGIN
        SELECT h.*,
        (
            SELECT c.*, sp.TenMP
            FROM ChiTietHoaDonBan AS c
			inner join MyPham sp on sp.MaMP = c.MaMP
            WHERE h.MaHDB = c.MaHDB FOR JSON PATH
        ) AS list_json_chitiethoadonban
        FROM HoaDonBan AS h
        WHERE  h.MaHDB = @id;
    END;

	drop proc gethoadonbanbyid

------------------GETALL-------------------
exec sp_hoadonban_get_all 

CREATE PROC sp_hoadonban_get_all
AS
Begin
	SELECT h.*, 
        (
            SELECT c.*
            FROM ChiTietHoaDonBan AS c
            WHERE h.MaHDB = c.MaHDB FOR JSON PATH --chuyển đổi kết quả thành định dạng JSON
        ) AS list_json_chitiethoadonban --Trả về json giúp dễ dàng tích hợp với các ứng dụng như website
        FROM HoaDonBan AS h
End;
SELECT * FROM MyPham
SELECT * FROM HoaDonBan
SELECT * FROM ChiTietHoaDonBan
DROP PROCEDURE [dbo].[sp_hoadon_create]
-------------- thêm hóa đơn bán ------------------------
EXEC sp_hoadon_create
     @HoTenKH = N'khách mới 8',
     @SDTKH = N'0123456789',
     @DiaChiKH = N'HY',
     @TrangThai = 1,
     @list_json_chitiethoadon = N'[{"maMP": "MP03", "sLBan": 4, "tongTien": 450000, "ghiChu": 1}, {"maMP": "MP04", "sLBan": 5, "tongTien": 250000, "ghiChu": 1}]';

drop proc sp_hoadonban_create
select * from HoaDonBan
select * from ChiTietHoaDonBan


create PROCEDURE [dbo].[sp_hoadonban_create]
(	@HoTenKH              NVARCHAR(50), 
    @SDTKH                NVARCHAR(10),
    @DiaChiKH             NVARCHAR(250), 
    @TrangThai          BIT,
    @list_json_chitiethoadonban NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHDB INT;
        INSERT INTO HoaDonBan(HoTenKH, SDTKH, DiaChiKH, TrangThai, NgayTao, NgayDuyet, TongTien, TGGiaoHang)
		VALUES(@HoTenKH, @SDTKH, @DiaChiKH, @TrangThai, GETDATE(), NULL, NULL, NULL);

				SET @MaHDB = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitiethoadonban IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
		   SELECT
			  JSON_VALUE(p.value, '$.maCTHDB') as maCTHDB,
			  JSON_VALUE(p.value, '$.maHDB') as maHDB,
			  JSON_VALUE(p.value, '$.maMP') as maMP,
			  JSON_VALUE(p.value, '$.sLBan') as sLBan,
			  JSON_VALUE(p.value, '$.tongTien') as tongTien,
			  JSON_VALUE(p.value, '$.ghiChu') AS ghiChu 
			  INTO #Results 
		   FROM OPENJSON(@list_json_chitiethoadonban) AS p;

    -- Thực hiện thêm, sửa và xóa chi tiết hóa đơn dựa trên status
    -- Thêm chi tiết hóa đơn (Status = 1)
    INSERT INTO ChiTietHoaDonBan(MaHDB, MaMP, SLBan, TongTien)
    SELECT
        @MaHDB, #Results.maMP, #Results.sLBan, #Results.tongTien
        FROM #Results WHERE #Results.ghiChu = 1;
		-- Cập nhật tổng tiền vào hóa đơn
         UPDATE HoaDonBan
         SET TongTien = (SELECT SUM(TongTien) FROM ChiTietHoaDonBan WHERE MaHDB = @MaHDB)
         WHERE MaHDB = @MaHDB;
    END;
 END;

exec sp_hoadonban_get_all
-- PROC sửa thông tin hóa đơn tích hợp thêm sửa xóa chi tiết hóa đơn
EXEC sp_hoadonban_update
	 @MaHDB = 55,
     @HoTenKH = N'khách mới 66666666',
     @SDTKH = N'0123456789',
     @DiaChiKH = N'HY sửa mới',
     @TrangThai = 1,
     @list_json_chitiethoadonban = N'[{"maMP": "MP06", "slBan": 5, "tongTien": 890000, "ghiChu": 1}, 
									{"maCTHDB": "23", "slBan": 5, "tongTien": 10000, "ghiChu": 2},
									{"maCTHDB": "24", "slBan": 10, "tongTien": 100000, "ghiChu": 2}]';

select * from HoaDonBan
select * from ChiTietHoaDonBan
drop proc sp_hoadonban_update
CREATE PROCEDURE sp_hoadonban_update
(
    @MaHDB              INT,
    @HoTenKH            NVARCHAR(30), 
    @SDTKH              NCHAR(10),
    @DiaChiKH           NVARCHAR(30),
    @TrangThai          BIT,
    @list_json_chitiethoadonban NVARCHAR(MAX)
)
AS
BEGIN
	UPDATE HoaDonBan
	SET HoTenKH  = @HoTenKH ,
		SDTKH = @SDTKH,
		DiaChiKH = @DiaChiKH,
		TrangThai = @TrangThai
	WHERE MaHDB = @MaHDB;
    IF (@list_json_chitiethoadonban IS NOT NULL) 
    BEGIN
        -- Insert data to temp table 
        SELECT
            JSON_VALUE(p.value, '$.maCTHDB') as maCTHDB,
            JSON_VALUE(p.value, '$.maHDB') as maHDB,
            JSON_VALUE(p.value, '$.maMP') as maMP,
            JSON_VALUE(p.value, '$.slBan') as slBan,
            JSON_VALUE(p.value, '$.tongTien') as tongTien,
            JSON_VALUE(p.value, '$.ghiChu') AS ghiChu 
        INTO #Results 
        FROM OPENJSON(@list_json_chitiethoadonban) AS p;

        -- Thực hiện thêm, sửa và xóa chi tiết hóa đơn dựa trên status
        -- Thêm chi tiết hóa đơn (Status = 1)
        INSERT INTO ChiTietHoaDonBan (MaHDB, MaMP, SLBan, TongTien)
        SELECT @MaHDB, #Results.MaMP, #Results.SLBan, #Results.TongTien
        FROM #Results WHERE ghiChu = 1;

        -- Sửa chi tiết hóa đơn (Status = 2)
        UPDATE ChiTietHoaDonBan
        SET
            SLBan = #Results.SLBan,
            TongTien = #Results.TongTien
        FROM #Results
        WHERE ChiTietHoaDonBan.MaCTHDB = #Results.MaCTHDB
            AND #Results.ghiChu = 2;

        -- Xóa chi tiết hóa đơn (Status = 3)
        DELETE FROM ChiTietHoaDonBan
        WHERE MaCTHDB IN (SELECT MaCTHDB FROM #Results WHERE #Results.ghiChu = 3);

        -- Cập nhật thông tin hóa đơn
        UPDATE HoaDonBan
        SET
            HoTenKH = @HoTenKH,
            DiaChiKH = @DiaChiKH,
            SDTKH = @SDTKH,
            TrangThai = @TrangThai,
            TongTien = (SELECT SUM(TongTien) FROM ChiTietHoaDonBan WHERE MaHDB = @MaHDB)
        WHERE MaHDB = @MaHDB;
        DROP TABLE #Results;
    END;
END;

SELECT * FROM HoaDonBan
exec sp_hoadonban_get_all
EXEC sp_hoadonban_delete 54
-- PROC xóa hóa đơn và chi tiết hóa đơn-------------------------
CREATE PROCEDURE sp_hoadonban_delete
    @MaHDB Nvarchar(10)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM ChiTietHoaDonBan WHERE MaHDB = @MaHDB;
        DELETE FROM HoaDonBan WHERE MaHDB = @MaHDB;
        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;
        PRINT ERROR_MESSAGE();
    END CATCH;
END;

SELECT * FROM HoaDonBan

--------------- proc tìm kiếm hóa đơn bán---------------------
select * from TaiKhoan
exec sp_hoadonban_get_all
exec sp_hoadonban_search 1, 10, 55, N''
exec sp_hoadonban_search 1, 10, 52, N''
exec sp_hoadonban_search 1, 5, 0, N'Nguyễn'
drop proc sp_hoadonban_search
create PROCEDURE sp_hoadonban_search (@page_index  INT, 
                                      @page_size   INT,
								      @ma_hdb int,
								      @ten_kh nvarchar(30)
								      )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaHDB ASC)) AS RowNumber,
							  hdb.*,
							   (
									SELECT 
  				                        cthdb.*,
										mp.MaLoaiMP,
										mp.TenMP,
										mp.AnhDaiDien,
										mp.GiaMoi,
										mp.GiaCu
									FROM ChiTietHoaDonBan AS cthdb
									INNER JOIN MyPham AS mp ON mp.MaMP = cthdb.MaMP
									WHERE cthdb.MaHDB = hdb.MaHDB and cthdb.MaMP = mp.MaMP
									FOR JSON PATH
								) AS list_json_chitiethoadonban
                        INTO #Results1
                        FROM HoaDonBan AS hdb
						WHERE (@ma_hdb = 0 OR hdb.MaHDB = @ma_hdb) and
						(@ten_kh = '' Or hdb.HoTenKH like N'%'+@ten_kh+'%')         
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaHDB ASC)) AS RowNumber,
							   hdb.*,
							   (
									SELECT 
  				                        cthdb.*,
										mp.MaLoaiMP,
										mp.TenMP,
										mp.AnhDaiDien,
										mp.GiaMoi,
										mp.GiaCu
									FROM ChiTietHoaDonBan AS cthdb
									INNER JOIN MyPham AS mp ON mp.MaMP = cthdb.MaMP
									WHERE cthdb.MaHDB = hdb.MaHDB and cthdb.MaMP = mp.MaMP
									FOR JSON PATH
								) AS list_json_chitiethoadonban
                        INTO #Results2
						FROM HoaDonBan AS hdb
						WHERE (@ma_hdb = 0 OR hdb.MaHDB = @ma_hdb) and
						(@ten_kh = '' Or hdb.HoTenKH like N'%'+@ten_kh+'%') 
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO

----------------CT Hoá đơn bán------------------------
---------------------GET BY ID------------------
create PROCEDURE getcthdbbyid(@id int) 
AS
BEGIN
SELECT*from ChiTietHoaDonBan where MaCTHDB = @id 
END;


DROP PROCEDURE sp_cthdb_search
--ChiTietHoaDonBan(MaCTHDB, MaHDB, MaMP, TenMP, SLBan, TongTien)
-------------------------Tìm kiếm----------------------------
create PROCEDURE sp_cthdb_search (@page_index  INT, 
                                  @page_size   INT,
								  @ma_hdb INT,
								  @ma_mp Nvarchar(10)
								  )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaCTHDB ASC)) AS RowNumber, 
							  cthdn.MaCTHDN,
                              cthdn.MaHoaDon,
							  cthdn.MaSanPham,
							  sp.TenSanPham,
							  sp.AnhDaiDien,
							  cthdn.SoLuong,
							  cthdn.DonViTinh,
							  cthdn.GiaNhap,
							  cthdn.TongTien
                        INTO #Results1
                        FROM ChiTietHoaDonBan AS cthdn
						inner join SanPham sp on sp.MaSanPham = cthdn.MaSanPham
					    WHERE (@ma_hd = 0 OR cthdn.MaHoaDon = @ma_hd) and 
						(@ma_sp = 0 OR cthdn.MaSanPham = @ma_sp)         
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaCTHDN ASC)) AS RowNumber, 
							  cthdn.MaCTHDN,
                              cthdn.MaHoaDon,
							  cthdn.MaSanPham,
							  sp.TenSanPham,
							  sp.AnhDaiDien,
							  cthdn.SoLuong,
							  cthdn.DonViTinh,
							  cthdn.GiaNhap,
							  cthdn.TongTien
                        INTO #Results2
                        FROM ChiTietHoaDonNhap AS cthdn
						inner join SanPham sp on sp.MaSanPham = cthdn.MaSanPham
					    WHERE (@ma_hd = 0 OR cthdn.MaHoaDon = @ma_hd) and 
						(@ma_sp = 0 OR cthdn.MaSanPham = @ma_sp)                     
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
GO





