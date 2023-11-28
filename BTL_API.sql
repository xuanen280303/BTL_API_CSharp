CREATE DATABASE BTL_BanMyPham
USE BTL_BanMyPham
GO

-- Tạo các bảng 
--Users( UserID, Password, Permission)

CREATE TABLE Users
(
UserID Nvarchar(10) PRIMARY KEY,
Username Nvarchar(20) not null,
Password Nvarchar(30) not null,
EmailUser Varchar(30) CHECK (EmailUser LIKE '%@%'),
Permission int
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
MaNV Nvarchar(10) CONSTRAINT FK_HoaDonNhap_MaNV FOREIGN KEY REFERENCES NhanVien(MaNV),
MaNCC Nvarchar(10) CONSTRAINT FK_HoaDonNhap_MaNCC FOREIGN KEY REFERENCES NhaCC(MaNCC),
HoTenNCC Nvarchar(30),
SDTNCC Varchar(11) DEFAULT N'Không có',
TongTien float check(TongTien>=0)
)

--ChiTietHoaDonNhap(MaHDN, MaMP, TenMP, SoLuong, DonGia, TrietKhau, ThanhTien)
CREATE TABLE ChiTietHoaDonNhap
(
MaHDN Nvarchar(10) CONSTRAINT FK_ChiTietHoaDonNhap_HDN FOREIGN KEY REFERENCES HoaDonNhap(MaHDN),
MaMP Nvarchar(10) CONSTRAINT FK_ChiTietHoaDonNhap_MyPham FOREIGN KEY REFERENCES MyPham(MaMP),
TenMP Nvarchar(50) not null, 
SLNhap float check (SLNhap>0),
DGNhap float check (DGNhap>0),
TrietKhau float Check(TrietKhau>=0),
ThanhTien float check (ThanhTien>=0)
)

--HoaDonBan (MaHDB, NgayBan, MaNV, IDKH, HoTenKH, LoaiKhachHang, TongTien)
CREATE TABLE HoaDonBan
(
MaHDB Nvarchar(10) PRIMARY KEY,
NgayBan Date ,
MaNV Nvarchar(10) CONSTRAINT FK_HoaDonBan_MaNV FOREIGN KEY REFERENCES NhanVien(MaNV),
IDKH Nvarchar(10) CONSTRAINT FK_HoaDonBan_IDKH FOREIGN KEY REFERENCES KhachHang(IDKH),
HoTenKH Nvarchar(30),
TongTien float check(TongTien>=0)
)

--ChiTietHoaDonBan(MaCTHDB, MaHDB, MaSP, SoLuong, DonGia)
CREATE TABLE ChiTietHoaDonBan
(
MaHDB Nvarchar(10) CONSTRAINT FK_ChiTietHoaDonNhap_HDB FOREIGN KEY REFERENCES HoaDonBan(MaHDB),
MaMP Nvarchar(10) CONSTRAINT FK_ChiTietHoaDonBan_MyPham FOREIGN KEY REFERENCES MyPham(MaMP),
TenMP Nvarchar(50) not null,
SLBan int check (SLBan>0),
DGBan float check (DGBan>0),
ThanhTien float check (ThanhTien>0)
)


SELECT TOP 1 MyPham.MaMP, MyPham.TenMP, SUM(ChiTietHoaDonBan.SLBan) AS TongSoLuongBan
FROM MyPham
INNER JOIN ChiTietHoaDonBan ON MyPham.MaMP = ChiTietHoaDonBan.MaMP
GROUP BY MyPham.MaMP, MyPham.TenMP
ORDER BY SUM(ChiTietHoaDonBan.SLBan) DESC

drop table ChiTietHoaDonBan

-- INSERT THÔNG TIN VÀO CÁC BẢNG
CREATE TABLE Users
(
UserID Nvarchar(10) PRIMARY KEY,
Username Nvarchar(20) not null,
Password Nvarchar(30) not null,
EmailUser Varchar(30) CHECK (EmailUser LIKE '%@%'),
Permission int
)

--INSERT Users(UserID, Username, Password, EmailUser, Permission)
INSERT INTO Users(UserID, Username, Password, EmailUser, Permission)
VALUES('ADMIN',N'ChuCuaHang',12345,N'enchan280303@gmail.com',1),
      ('USER',N'NhanVien',123456,N'enchan280303@gmail.com',0)

SELECT * FROM Users

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


--------------------------TÌM KIẾM------------------------------
create PROCEDURE [dbo].[sp_nhanvien_search] (@page_index  INT, 
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
                              n.Manv,
							  n.HoTennv,
							  n.DiachiNV
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
                              n.Manv,
							  n.HoTenNV,
							  n.DiachiNV
                        INTO #Results2
                        FROM KhachHangs AS n
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



--------------Mỹ phẩm----------------------------
---------GetByID---------------------
create PROCEDURE getmyphambyid(@id Nvarchar(10))
AS
BEGIN
SELECT*from MyPham where MaMP = @id 
END;

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


--------------Loại Mỹ phẩm----------------------------
---------GetByID---------------------
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




