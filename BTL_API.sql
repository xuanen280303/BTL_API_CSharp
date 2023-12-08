CREATE DATABASE BTL_BanMyPham
USE BTL_BanMyPham
GO

--LoaiTaiKhoan(MaLoaiTK, TenLoaiTK, MoTa)
CREATE Table LoaiTaiKhoan (
MaLoaiTK INT IDENTITY(1,1) PRIMARY KEY,
TenLoaiTK Nvarchar(20),
MoTa Nvarchar(30)
)

--TaiKhoan(MaTaiKhoan, LoaiTaiKhoan, TenTaiKhoan, MatKhau, Email)
CREATE TABLE TaiKhoan (
MaTaiKhoan INT IDENTITY(1,1) PRIMARY KEY,
LoaiTaiKhoan INT CONSTRAINT TK_LoaiTK_FK FOREIGN KEY (LoaiTaiKhoan) REFERENCES  LoaiTaiKhoan(MaLoaiTK),
TenTaiKhoan Nvarchar(20),
MatKhau Nvarchar(20),
Email Varchar(30) CHECK (Email LIKE '%@%')
)

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
MoTa Nvarchar(MAX)
)

--MyPham(MaMP, TenMP, MaLoaiMP, SoLuongTon, MoTa, GhiChu)
CREATE TABLE MyPham
(
MaMP Nvarchar(10) CONSTRAINT PK_MaMP PRIMARY KEY,
TenMP Nvarchar(50) not null, 
MaLoaiMP Nvarchar(10) CONSTRAINT FK_MP_MaLoaiMP FOREIGN KEY REFERENCES LoaiMyPham(MaLoaiMP) 
ON DELETE CASCADE ON UPDATE CASCADE,
SLTon int check (SLTon>=0),
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
GioiTinh Nvarchar(3) CHECK (GioiTinh IN ('Nam',N'Nữ')),
CaLam Nvarchar(8) Check( CaLam IN('Fulltime','Parttime')),
SDTNV Varchar(11) DEFAULT N'Không có',
DiachiNV Nvarchar(30),
Email Varchar(30) CHECK (Email LIKE '%@%')
)


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

--HoaDonBan (MaHDB, NgayBan, MaNV, IDKH, HoTenKH, LoaiKhachHang, TongTien)
CREATE TABLE HoaDonBan
(
MaHDB Nvarchar(10) PRIMARY KEY,
NgayBan Date ,
MaTaiKhoan INT CONSTRAINT HDB_MaTK_FK FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan),
IDKH Nvarchar(10) CONSTRAINT FK_HoaDonBan_IDKH FOREIGN KEY REFERENCES KhachHang(IDKH),
HoTenKH Nvarchar(30),
TongTien float check(TongTien>=0)
)

--ChiTietHoaDonBan(MaCTHDB, MaHDB, MaSP, SoLuong, DonGia)
CREATE TABLE ChiTietHoaDonBan
(
MaCTHDB Nvarchar(10) PRIMARY KEY,
MaHDB Nvarchar(10) CONSTRAINT FK_ChiTietHoaDonNhap_HDB FOREIGN KEY REFERENCES HoaDonBan(MaHDB),
MaMP Nvarchar(10) CONSTRAINT FK_ChiTietHoaDonBan_MyPham FOREIGN KEY REFERENCES MyPham(MaMP),
TenMP Nvarchar(50) not null,
SLBan INT CHECK (SLBan>0),
DGBan FLOAT CHECK (DGBan>0),
ThanhTien  FLOAT CHECK(ThanhTien>0)
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

-- INSERT LoaiMyPham(MaLoaiMP, TenLoaiMP, MoTa)
INSERT INTO LoaiMyPham(MaLoaiMP, TenLoaiMP, MoTa)
VALUES('L01',N'Kem chống nắng',N'Các loại mỹ phẩm kem chống nắng'),
      ('L02',N'Kem dưỡng ẩm',N' Các loại mỹ phẩm kem dưỡng ẩm'),
	  ('L03',N'Sữa rửa mặt',N' Các loại mỹ phẩm sữa rửa mặt'),
	  ('L04',N'Kem trị mụn',N' Các loại mỹ phẩm kem trị mụn'),
	  ('L05',N'Mask',N' Các loại mỹ phẩm mặt nạ'),
	  ('L06',N'Nước tẩy trang',N' Các loại mỹ phẩm nước tẩy trang'),
	  ('L07',N'Toner',N' Các loại mỹ phẩm nước hoa hồng'),
	  ('L08',N'Tinh dầu',N' Các loại mỹ phẩm tinh dầu'),
	  ('L09',N'Son dưỡng môi',N' Các loại mỹ phẩm son dưỡng môi'),
	  ('L10',N'Vaseline',N' Các loại mỹ phẩm kem dưỡng trắng da'),
	  ('L11',N'Mascara',N'Các loại mascara'),
      ('L12',N'Eyeliner',N' Các loại bút kẻ mắt'),
	  ('L13',N'Lotion',N' Các loại lotion'),
	  ('L14',N'Kem nghệ',N' Các loại kem nghệ'),
	  ('L15',N'Body mist',N' Các loại Body mist'),
	  ('L16',N'Sữa tắm',N' Các loại sữa tắm'),
	  ('L17',N'Dầu gội thường',N' Các loại dầu gội thường'),
	  ('L18',N'Dầu gội dược liệu',N' Các loại dầu gội dược liệu'),
	  ('L19',N'Son',N' Các loại mỹ phẩm son'),
	  ('L20',N'Tẩy da chết',N' Các loại mỹ phẩm tẩy da chết')

--MyPham(MaMP, TenMP, MaLoaiMP, SLTon, MoTa, GhiChu)
INSERT INTO MyPham(MaMP, TenMP, MaLoaiMP, SLTon, MoTa, GhiChu)
VALUES('MP01',N'Kem chống nắng Cetella','L01',5,N'Kem chống nắng Cetella',N'Phù hợp với da dầu'),
      ('MP02',N'Kem chống nắng Laroche Posay','L01',100,N'Kem chống nắng Laroche Posay',N'Phù hợp với da nhạy cảm'),
	  ('MP03',N'Kem dưỡng ẩm Klieh','L02',80,N'Kem dưỡng ẩm Klieh',N'Phù hợp với mọi loại da'),
	  ('MP04',N'Kem dưỡng ẩm VitaminE','L02',100,N'Kem dưỡng ẩm VitaminE',N'Phù hợp với mọi loại da'),
	  ('MP05',N'Sữa rửa mặt SVR','L03',50,N'Sữa rửa mặt SVR',N'Phù hợp với da khô'),
	  ('MP06',N'Sữa rửa mặt Cerave','L03',150,N'Sữa rửa mặt Cerave',N'Phù hợp với mọi loại da'),
	  ('MP07',N'Kem trị mụn Megadou','L04',100,N'Kem trị mụn Megadou',N'Phù hợp với mọi loại da'),
	  ('MP08',N'Kem trị mụn Decoma','L04',100,N'Kem trị mụn Decoma',N'Phù hợp với mọi loại da'),
	  ('MP09',N'Mask Whitening','L05', 500,N'Mask Whitening',N'Phù hợp với mọi loại da'),
	  ('MP10',N'Mask Skin','L05', 500,N'Mask Skin',N'Phù hợp với mọi loại da'),
	  ('MP11',N'Nước Tẩy Trang Garnie','L06', 200,N'Nước Tẩy Trang Garnie',N'Phù hợp với da dầu'),
	  ('MP12',N'Nước Tẩy Trang Bio','L06', 100,N'Nước Tẩy Trang Bio',N'Phù hợp với da khô'),
	  ('MP13',N'Toner hoa cúc','L07', 50,N'Toner hoa cúc',N'Phù hợp với da khô'),
	  ('MP14',N'Toner Kiel','L07', 50,N'Toner Kiel',N'Phù hợp với mọi loại da'),
	  ('MP15',N'Tinh dầu bưởi Cococoon','L08', 100,N'Tinh dầu bưởi Cococoon',N'Phù hợp với người trên 12 tuổi'),
	  ('MP16',N'Tinh dầu Bioma','L08', 30,N'Tinh dầu Bioma',N'Phù hợp với người trên 12 tuổi'),
	  ('MP17',N'son dưỡng môi Blackrouge','L09', 100,N'son dưỡng môi Blackrouge',N'Phù hợp với người trên 12 tuổi'),
	  ('MP18',N'Son dưỡng môi MAC','L09', 50,N'Son dưỡng môi MAC',N'Phù hợp với người trên 12 tuổi'),
	  ('MP19',N'Vaseline PX50','L10', 100,N'Vaseline PX50',N'Phù hợp với mọi loại da'),
	  ('MP20',N'Vaseline trắng da','L10', 50,N'Vaseline trắng da',N'Phù hợp với mọi loại da'),
	  ('MP21',N'Mascara MAC','L11', 200,N'Mascara MAC',N'Đầu bút tơi và dễ thao tác'),
	  ('MP22',N'Eyeliner maybeline','L12', 100,N'Eyeliner maybeline',N'Đầu bút mảnh và dễ thao tác'),
	  ('MP23',N'Lotion Olay','L13', 50,N'Lotion Olay hoa cúc',N'Phù hợp với mọi loại da'),
	  ('MP24',N'Kem nghệ Decumar','L14', 50,N'Kem nghệ Decumar',N'Phù hợp với mọi loại da'),
	  ('MP25',N'Body mist Victoria','L15', 100,N'Body mist Victoria',N'Phù hợp với người trên 16 tuổi'),
	  ('MP26',N'Sữa tắm Terosi','L16', 30,N'Sữa tắm Terosi',N'Phù hợp với người trên 12 tuổi'),
	  ('MP27',N'Dầu gội Tsubaki','L17', 100,N'Dầu gội Tsubaki',N'Phù hợp với người trên 12 tuổi'),
	  ('MP28',N'Dầu gội Nguyên xuân','L18', 50,N'Dầu gội Nguyên xuân',N'Phù hợp với người trên 12 tuổi'),
	  ('MP29',N'Son Color Key','L19', 100,N'Son Color Key',N'Son nhẹ, đánh mềm môi'),
	  ('MP30',N'Tẩy da chết Cocoon','L20', 50,N'Tẩy da chết Cocoon',N'Phù hợp với người trên 16 tuổi')

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
      ('NV02',N'Trần Tuấn Lập','09-01-1985',N'Nam','PartTime',N'LapTT@gmail.com',0904898998,N'Yên Mỹ, Hưng Yên'),
      ('NV03',N'Nguyễn Văn An','05-05-2000',N'Nam','FullTime',N'Annguyen09@gmail.com',0996890777,N'Ba Vì, Hà Nội'),
      ('NV04',N'Vũ Thị Liên','09-09-1999',N'Nữ',N'FullTime', 'Mailien05@gmail.com',0984890005,N'Vũ Thư, Thái Bình'),
      ('NV05',N'Cao Thị Thu','05-07-1989',N'Nữ','PartTime','ThuCao89@gmail.com',0976890123,N'Quế Võ,Bắc Ninh'),
	  ('NV06',N'Nguyễn Duy Luân','02-04-1992',N'Nam','FullTime',N'Luan10hn@gmail.com',0981890898,N'Đống Đa, Hà Nội'),
      ('NV07',N'Bùi Đăng Hậu','08-02-1995',N'Nam','PartTime',N'Haubui@gmail.com',0904898998,N'Bà Rịa, Vũng Tàu'),
      ('NV08',N'Trần Đăng Lâm','06-03-2003',N'Nam','FullTime',N'Lamper03@gmail.com',0386890777,N'Vân Đồn, Quảng Ninh'),
      ('NV09',N'Cao Bá Hưng','02-01-1998',N'Nam',N'FullTime', 'Hungcao12@gmail.com',0384890005,N'Nam Sách, Hải Dương'),
      ('NV10',N'Lê Mai Anh','07-06-1999',N'Nữ','PartTime','Anhanh99@gmail.com',0946890123,N'Hải Hậu, Nam Định')


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


--HoaDonBanHang (MaHDB, NgayBan, MaNV, IDKH, HoTenKH, TongTien)
INSERT INTO HoaDonBan(MaHDB, NgayBan, MaNV, IDKH, HoTenKH, TongTien)
VALUES('HDB01','2023-04-18','NV02','KH02',N'Nguyễn Văn Quỳnh',500000),
      ('HDB02','2023-05-20','NV03','KH01',N'Trần Thị Liễu',500000),
	  ('HDB03','2023-04-20','NV01','KH03',N'Vũ Thị Minh',500000),
	  ('HDB04','2023-05-07','NV02','KH05',N'Trần Thanh Thuỷ',500000),
	  ('HDB05','2023-04-24','NV04','KH07',N'Nguyễn Hoa Như',500000),
	  ('HDB06','2023-04-18','NV05','KH08',N'Đỗ Nhật Dương',500000),
      ('HDB07','2023-05-20','NV03','KH09',N'Trịnh Thị Duyên',500000),
	  ('HDB08','2023-04-20','NV01','KH10',N'Hà Diệp Hoa',500000),
	  ('HDB09','2023-05-07','NV09','KH03',N'Vũ Thị Minh',500000),
	  ('HDB10','2023-04-24','NV08','KH06',N'Trần Hồng Anh',500000)

--HoaDonNhap(MaHDN, NgayNhap, MaNV, MaNCC, HoTenNCC, SDTNCC, TongTien)
INSERT INTO HoaDonNhap(MaHDN,NgayNhap,MaNV,MaNCC,HoTenNCC,SDTNCC,TongTien)
VALUES('HDN01','2023-08-10','NV01','NCC04',N'Sỉ lẻ Ngọc Bích',03872336255,500000),
      ('HDN02','2023-09-26','NV04','NCC02',N'Makeup BigBoon',09872336223,500000),
	  ('HDN03','2023-08-15','NV05','NCC04',N'Sỉ lẻ Ngọc Bích',03872336253,500000),
	  ('HDN04','2023-08-01','NV04','NCC03',N'Cocoon Group',09892336252,500000),
	  ('HDN05','2022-07-28','NV01','NCC05',N'Thanh Hằng Mỹ phẩm',03572336251,500000),
	  ('HDN06','2023-05-10','NV06','NCC07',N'Makeup Beuty',0997233622,500000),
      ('HDN07','2023-11-26','NV08','NCC08',N'Tiệm làm đẹp',0929233625,500000),
	  ('HDN08','2023-12-15','NV07','NCC09',N'Sỉ lẻ Nhật Linh',0337233625,500000),
	  ('HDN09','2023-08-01','NV09','NCC10',N'Tuyết Ngân Mỹ phẩm',0357233625,500000),
	  ('HDN10','2022-04-28','NV10','NCC06',N'VietNam KAO',0977233625,500000)

--ChiTietHoaDonNhap(MaMP, TenMP, SLNhap, DGNhap, TrietKhau, ThanhTien)
INSERT INTO ChiTietHoaDonNhap(MaHDN, MaMP, TenMP, SLNhap, DGNhap, TrietKhau, ThanhTien)
VALUES('HDN01','MP01',N'Kem chống nắng Cetella',20, 250000,0,4500000),
      ('HDN02','MP03',N'Kem dưỡng ẩm Klieh',10, 300000,5,2700000),
	  ('HDN03','MP06',N'Sữa rửa mặt Cerave',10, 400000,5,3800000),
	  ('HDN04','MP09',N'Mask Whitening',20, 20000,5,380000),
	  ('HDN05','MP15',N'Tinh dầu bưởi Cococoon',30, 150000,15,3825000),
	  ('HDN06','MP22',N'Eyeliner maybeline',10, 150000,0,1500000),
      ('HDN07','MP25',N'Body mist Victoria ',20, 300000,0,6000000),
	  ('HDN08','MP26',N'Sữa tắm Terosi',2, 200000,0,400000),
	  ('HDN09','MP19',N'Vaseline PX50',2, 200000,0,400000),
	  ('HDN10','MP05',N'Sữa rửa mặt SVR',10, 400000,0,4000000)

--ChiTietHoaDonBan(MaMP, TenMP, SLBan, DGBan, GiamGia, ThanhTien)
INSERT INTO ChiTietHoaDonBan(MaHDB, MaMP, TenMP, SLBan, DGBan, ThanhTien)
VALUES('HDB01','MP01',N'Kem chống nắng Cetella',10, 350000,3500000),
      ('HDB02','MP03',N'Kem dưỡng ẩm Klieh',10, 400000,4000000),
	  ('HDB03','MP06',N'Sữa rửa mặt Cerave',10, 450000,4500000),
	  ('HDB04','MP09',N'Mask Whitening',20, 25000,450000),
	  ('HDB05','MP15',N'Tinh dầu bưởi Cococoon',30, 250000,7500000),
	  ('HDB06','MP22',N'Eyeliner maybeline',10, 200000,2000000),
      ('HDB07','MP25',N'Body mist Victoria ',20, 400000,8000000),
	  ('HDB08','MP26',N'Sữa tắm Terosi',20, 250000,5000000),
	  ('HDB09','MP19',N'Vaseline PX50',2, 250000,500000),
	  ('HDB10','MP05',N'Sữa rửa mặt SVR',10, 450000,4500000)


-------------USER(Tài khoản)---------------------------
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

-------------------------BÀI VIẾT--------------------
CREATE TABLE BaiViet (
MaBV Nvarchar(10) CONSTRAINT PK_MaBV PRIMARY KEY,
TieuDe Nvarchar(100),
NguoiDang Nvarchar(20),
TGDang Date,
NgayKT Date, 
NoiDung Nvarchar(MAX)
)
---------------------GET BY ID-------------------------
create PROCEDURE getbaivietbyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from BaiViet where MaBV = @id 
END;

-------------------THÊM-------------------
create PROCEDURE sp_baiviet_create(
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

--------------------------TÌM KIẾM------------------------------
CREATE PROCEDURE [dbo].[sp_baiviet_search] (@page_index  INT, 
                                       @page_size   INT,
									   @tieu_de Nvarchar(100),
									   @noi_dung Nvarchar(MAX)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
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

SELECT * FROM NhanVien

exec [sp_nhanvien_search]  @page_index = 1 , @page_size = 5 , @ten_nv = '' , @dia_chinv = ''
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

SELECT * FROM KhachHang

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

SELECT * FROM NhaCC


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

---------------------THÊM---------------------------
create PROCEDURE sp_mypham_create(
@MaMP Nvarchar(10),
@TenMP Nvarchar(50),
@MaLoaiMP Nvarchar(10),
@SLTon int,
@MoTa Nvarchar(MAX),
@GhiChu Nvarchar(30)
)
AS
    BEGIN
       insert into MyPham(MaMP, TenMP, MaLoaiMP, SLTon, MoTa, GhiChu)
	   values(@MaMP, @TenMP, @MaLoaiMP, @SLTon, @MoTa, @GhiChu);
    END;
GO

------------------------------SỬA----------------------
create PROCEDURE [dbo].[sp_mypham_update](
@MaMP Nvarchar(10),
@TenMP Nvarchar(50),
@MaLoaiMP Nvarchar(10),
@SLTon int,
@MoTa Nvarchar(MAX),
@GhiChu Nvarchar(30)
)
AS
    BEGIN
		update MyPham set tenmp = @TenMP, mota = @MoTa, ghichu = @GhiChu where mamp = @MaMP; 
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


SELECT * FROM MyPham


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
							  n.SLTon,
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
							  n.SLTon,
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
@MoTa Nvarchar(MAX)
)
AS
    BEGIN
       insert into LoaiMyPham(MaLoaiMP,TenLoaiMP, MoTa)
	   values(@MaLoaiMP, @TenLoaiMP, @MoTa);
    END;
GO

------------------------------SỬA----------------------
create PROCEDURE [dbo].[sp_loaimypham_update](
@MaLoaiMP Nvarchar(10),
@TenLoaiMP Nvarchar(30),
@MoTa Nvarchar(MAX)
)
AS
    BEGIN
		update LoaiMyPham set tenloaimp = @TenLoaiMP, mota = @MoTa where maloaimp = @MaLoaiMP; 
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

SELECT * FROM LoaiMyPham

-------------------------Tìm kiếm----------------------------
CREATE PROCEDURE [dbo].[sp_loaimypham_search] (@page_index  INT, 
                                       @page_size   INT,
									   @tenloai_mp Nvarchar(30),
									   @motaloai_mp Nvarchar(30)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenLoaiMP ASC)) AS RowNumber, 
							  n.MaLoaiMP,
							  n.TenLoaiMP,
							  n.MoTa				  
                        INTO #Results1
                        FROM LoaiMyPham AS n
					    WHERE  (@tenloai_mp = '' Or n.TenLoaiMP like N'%'+@tenloai_mp+'%') and						
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
                              ORDER BY TenLoaiMP ASC)) AS RowNumber, 
							  n.MaLoaiMP,
							  n.TenLoaiMP,
							  n.MoTa	
                        INTO #Results2
                        FROM LoaiMyPham AS n
					    WHERE  (@tenloai_mp = '' Or n.TenLoaiMP like N'%'+@tenloai_mp+'%') and						
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


----------------Hoá đơn bán------------------------
---------------------GET BY ID------------------
create PROCEDURE gethoadonbanbyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from HoaDonBan where MaHDB = @id 
END;

---------------------THÊM---------------------------
create PROCEDURE sp_hoadonban_create(
@MaHDB Nvarchar(10),
@NgayBan Date ,
@MaNV Nvarchar(10),
@IDKH Nvarchar(10),
@HoTenKH Nvarchar(30),
@TongTien float
)
AS
    BEGIN
       insert into HoaDonBan(MaHDB,NgayBan, MaNV, IDKH, HoTenKH, TongTien)
	   values(@MaHDB, @NgayBan, @MaNV, @IDKH, @HoTenKH, @TongTien);
    END;
GO

----------------Hoá đơn nhập------------------------
---------------------GET BY ID------------------
create PROCEDURE gethoadonnhapbyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from HoaDonNhap where MaHDN = @id 
END;

---------------------THÊM---------------------------
create PROCEDURE sp_hoadonnhap_create(
@MaHDN Nvarchar(10),
@NgayNhap Date,
@MaNV Nvarchar(10),
@MaNCC Nvarchar(10),
@HoTenNCC Nvarchar(30),
@SDTNCC Varchar(11),
@TongTien float
)
AS
    BEGIN
       insert into HoaDonNhap(MaHDN, NgayNhap, MaNV, MaNCC, HoTenNCC, SDTNCC, TongTien)
	   values(@MaHDN, @NgayNhap, @MaNV, @MaNCC, @HoTenNCC, @SDTNCC, @TongTien);
    END;
GO




