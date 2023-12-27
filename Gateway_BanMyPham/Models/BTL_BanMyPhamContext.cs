using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace GateWay.Models
{
    public partial class BTL_BanMyPhamContext : DbContext
    {
        public BTL_BanMyPhamContext()
        {
        }

        public BTL_BanMyPhamContext(DbContextOptions<BTL_BanMyPhamContext> options)
            : base(options)
        {
        }

        public virtual DbSet<BaiViet> BaiViets { get; set; } = null!;
        public virtual DbSet<ChiTietHoaDonBan> ChiTietHoaDonBans { get; set; } = null!;
        public virtual DbSet<ChiTietHoaDonNhap> ChiTietHoaDonNhaps { get; set; } = null!;
        public virtual DbSet<ChiTietMyPham> ChiTietMyPhams { get; set; } = null!;
        public virtual DbSet<ChiTietTaiKhoan> ChiTietTaiKhoans { get; set; } = null!;
        public virtual DbSet<HoaDonBan> HoaDonBans { get; set; } = null!;
        public virtual DbSet<HoaDonNhap> HoaDonNhaps { get; set; } = null!;
        public virtual DbSet<KhachHang> KhachHangs { get; set; } = null!;
        public virtual DbSet<LoaiMyPham> LoaiMyPhams { get; set; } = null!;
        public virtual DbSet<LoaiTaiKhoan> LoaiTaiKhoans { get; set; } = null!;
        public virtual DbSet<MyPham> MyPhams { get; set; } = null!;
        public virtual DbSet<NhaCc> NhaCcs { get; set; } = null!;
        public virtual DbSet<NhanVien> NhanViens { get; set; } = null!;
        public virtual DbSet<TaiKhoan> TaiKhoans { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=ENCHAN-28032003\\SQLEXPRESS;Database=BTL_BanMyPham;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<BaiViet>(entity =>
            {
                entity.HasKey(e => e.MaBv)
                    .HasName("PK_MaBV");

                entity.ToTable("BaiViet");

                entity.Property(e => e.MaBv)
                    .HasMaxLength(10)
                    .HasColumnName("MaBV");

                entity.Property(e => e.NgayKt)
                    .HasColumnType("date")
                    .HasColumnName("NgayKT");

                entity.Property(e => e.NguoiDang).HasMaxLength(20);

                entity.Property(e => e.Tgdang)
                    .HasColumnType("date")
                    .HasColumnName("TGDang");

                entity.Property(e => e.TieuDe).HasMaxLength(100);
            });

            modelBuilder.Entity<ChiTietHoaDonBan>(entity =>
            {
                entity.HasKey(e => e.MaCthdb)
                    .HasName("PK__ChiTietH__508BFF6F5657CDFE");

                entity.ToTable("ChiTietHoaDonBan");

                entity.Property(e => e.MaCthdb)
                    .HasMaxLength(10)
                    .HasColumnName("MaCTHDB");

                entity.Property(e => e.Dgban).HasColumnName("DGBan");

                entity.Property(e => e.MaHdb)
                    .HasMaxLength(10)
                    .HasColumnName("MaHDB");

                entity.Property(e => e.MaMp)
                    .HasMaxLength(10)
                    .HasColumnName("MaMP");

                entity.Property(e => e.Slban).HasColumnName("SLBan");

                entity.Property(e => e.TenMp)
                    .HasMaxLength(50)
                    .HasColumnName("TenMP");

                entity.HasOne(d => d.MaHdbNavigation)
                    .WithMany(p => p.ChiTietHoaDonBans)
                    .HasForeignKey(d => d.MaHdb)
                    .HasConstraintName("FK_ChiTietHoaDonNhap_HDB");

                entity.HasOne(d => d.MaMpNavigation)
                    .WithMany(p => p.ChiTietHoaDonBans)
                    .HasForeignKey(d => d.MaMp)
                    .HasConstraintName("FK_ChiTietHoaDonBan_MyPham");
            });

            modelBuilder.Entity<ChiTietHoaDonNhap>(entity =>
            {
                entity.HasKey(e => e.MaCthdn)
                    .HasName("PK__ChiTietH__508BFF5BB8480080");

                entity.ToTable("ChiTietHoaDonNhap");

                entity.Property(e => e.MaCthdn)
                    .HasMaxLength(10)
                    .HasColumnName("MaCTHDN");

                entity.Property(e => e.Dgnhap).HasColumnName("DGNhap");

                entity.Property(e => e.MaHdn)
                    .HasMaxLength(10)
                    .HasColumnName("MaHDN");

                entity.Property(e => e.MaMp)
                    .HasMaxLength(10)
                    .HasColumnName("MaMP");

                entity.Property(e => e.Slnhap).HasColumnName("SLNhap");

                entity.Property(e => e.TenMp)
                    .HasMaxLength(50)
                    .HasColumnName("TenMP");

                entity.HasOne(d => d.MaHdnNavigation)
                    .WithMany(p => p.ChiTietHoaDonNhaps)
                    .HasForeignKey(d => d.MaHdn)
                    .HasConstraintName("FK_ChiTietHoaDonNhap_HDN");

                entity.HasOne(d => d.MaMpNavigation)
                    .WithMany(p => p.ChiTietHoaDonNhaps)
                    .HasForeignKey(d => d.MaMp)
                    .HasConstraintName("FK_ChiTietHoaDonNhap_MyPham");
            });

            modelBuilder.Entity<ChiTietMyPham>(entity =>
            {
                entity.HasKey(e => e.MaChiTietMyPham)
                    .HasName("PK__ChiTietM__FF9C76EF6D62EC75");

                entity.ToTable("ChiTietMyPham");

                entity.Property(e => e.MaChiTietMyPham).HasMaxLength(10);

                entity.Property(e => e.MaMp)
                    .HasMaxLength(10)
                    .HasColumnName("MaMP");

                entity.Property(e => e.MaNcc)
                    .HasMaxLength(10)
                    .HasColumnName("MaNCC");

                entity.HasOne(d => d.MaMpNavigation)
                    .WithMany(p => p.ChiTietMyPhams)
                    .HasForeignKey(d => d.MaMp)
                    .HasConstraintName("CTMP_MaMP_FK");

                entity.HasOne(d => d.MaNccNavigation)
                    .WithMany(p => p.ChiTietMyPhams)
                    .HasForeignKey(d => d.MaNcc)
                    .HasConstraintName("FK_NhaCC_MaNCC");
            });

            modelBuilder.Entity<ChiTietTaiKhoan>(entity =>
            {
                entity.HasKey(e => e.MaChitietTaiKhoan)
                    .HasName("PK__ChiTietT__8EB663DF4D8DA0B2");

                entity.ToTable("ChiTietTaiKhoan");

                entity.Property(e => e.AnhDaiDien).HasMaxLength(500);

                entity.Property(e => e.DiaChi).HasMaxLength(30);

                entity.Property(e => e.HoTen).HasMaxLength(30);

                entity.Property(e => e.Sdt)
                    .HasMaxLength(11)
                    .IsUnicode(false)
                    .HasColumnName("SDT")
                    .HasDefaultValueSql("(N'Không có')");

                entity.HasOne(d => d.MaTaiKhoanNavigation)
                    .WithMany(p => p.ChiTietTaiKhoans)
                    .HasForeignKey(d => d.MaTaiKhoan)
                    .HasConstraintName("CTTK_MaTK_FK");
            });

            modelBuilder.Entity<HoaDonBan>(entity =>
            {
                entity.HasKey(e => e.MaHdb)
                    .HasName("PK__HoaDonBa__3C90E8FA1A8250CE");

                entity.ToTable("HoaDonBan");

                entity.Property(e => e.MaHdb)
                    .HasMaxLength(10)
                    .HasColumnName("MaHDB");

                entity.Property(e => e.HoTenKh)
                    .HasMaxLength(30)
                    .HasColumnName("HoTenKH");

                entity.Property(e => e.Idkh)
                    .HasMaxLength(10)
                    .HasColumnName("IDKH");

                entity.Property(e => e.NgayBan).HasColumnType("date");

                entity.HasOne(d => d.IdkhNavigation)
                    .WithMany(p => p.HoaDonBans)
                    .HasForeignKey(d => d.Idkh)
                    .HasConstraintName("FK_HoaDonBan_IDKH");

                entity.HasOne(d => d.MaTaiKhoanNavigation)
                    .WithMany(p => p.HoaDonBans)
                    .HasForeignKey(d => d.MaTaiKhoan)
                    .HasConstraintName("HDB_MaTK_FK");
            });

            modelBuilder.Entity<HoaDonNhap>(entity =>
            {
                entity.HasKey(e => e.MaHdn)
                    .HasName("PK__HoaDonNh__3C90E8C6276A9D67");

                entity.ToTable("HoaDonNhap");

                entity.Property(e => e.MaHdn)
                    .HasMaxLength(10)
                    .HasColumnName("MaHDN");

                entity.Property(e => e.KieuThanhToan).HasMaxLength(20);

                entity.Property(e => e.MaNcc)
                    .HasMaxLength(10)
                    .HasColumnName("MaNCC");

                entity.Property(e => e.NgayNhap).HasColumnType("date");

                entity.HasOne(d => d.MaNccNavigation)
                    .WithMany(p => p.HoaDonNhaps)
                    .HasForeignKey(d => d.MaNcc)
                    .HasConstraintName("FK_HoaDonNhap_MaNCC");

                entity.HasOne(d => d.MaTaiKhoanNavigation)
                    .WithMany(p => p.HoaDonNhaps)
                    .HasForeignKey(d => d.MaTaiKhoan)
                    .HasConstraintName("HDN_MaTK_FK");
            });

            modelBuilder.Entity<KhachHang>(entity =>
            {
                entity.HasKey(e => e.Idkh)
                    .HasName("PK__KhachHan__B87DC1A7ED4A33D1");

                entity.ToTable("KhachHang");

                entity.Property(e => e.Idkh)
                    .HasMaxLength(10)
                    .HasColumnName("IDKH");

                entity.Property(e => e.DiaChiKh)
                    .HasMaxLength(30)
                    .HasColumnName("DiaChiKH");

                entity.Property(e => e.HoTenKh)
                    .HasMaxLength(30)
                    .HasColumnName("HoTenKH");

                entity.Property(e => e.Sdtkh)
                    .HasMaxLength(11)
                    .IsUnicode(false)
                    .HasColumnName("SDTKH")
                    .HasDefaultValueSql("(N'Không có')");
            });

            modelBuilder.Entity<LoaiMyPham>(entity =>
            {
                entity.HasKey(e => e.MaLoaiMp)
                    .HasName("PK_MaLoaiMP");

                entity.ToTable("LoaiMyPham");

                entity.Property(e => e.MaLoaiMp)
                    .HasMaxLength(10)
                    .HasColumnName("MaLoaiMP");

                entity.Property(e => e.TenLoaiMp)
                    .HasMaxLength(30)
                    .HasColumnName("TenLoaiMP");
            });

            modelBuilder.Entity<LoaiTaiKhoan>(entity =>
            {
                entity.HasKey(e => e.MaLoaiTk)
                    .HasName("PK__LoaiTaiK__1224F2542E315D21");

                entity.ToTable("LoaiTaiKhoan");

                entity.Property(e => e.MaLoaiTk).HasColumnName("MaLoaiTK");

                entity.Property(e => e.MoTa).HasMaxLength(30);

                entity.Property(e => e.TenLoaiTk)
                    .HasMaxLength(20)
                    .HasColumnName("TenLoaiTK");
            });

            modelBuilder.Entity<MyPham>(entity =>
            {
                entity.HasKey(e => e.MaMp)
                    .HasName("PK_MaMP");

                entity.ToTable("MyPham");

                entity.Property(e => e.MaMp)
                    .HasMaxLength(10)
                    .HasColumnName("MaMP");

                entity.Property(e => e.GhiChu).HasMaxLength(30);

                entity.Property(e => e.MaLoaiMp)
                    .HasMaxLength(10)
                    .HasColumnName("MaLoaiMP");

                entity.Property(e => e.Slton).HasColumnName("SLTon");

                entity.Property(e => e.TenMp)
                    .HasMaxLength(50)
                    .HasColumnName("TenMP");

                entity.HasOne(d => d.MaLoaiMpNavigation)
                    .WithMany(p => p.MyPhams)
                    .HasForeignKey(d => d.MaLoaiMp)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK_MP_MaLoaiMP");
            });

            modelBuilder.Entity<NhaCc>(entity =>
            {
                entity.HasKey(e => e.MaNcc)
                    .HasName("PK__NhaCC__3A185DEB2E1D216C");

                entity.ToTable("NhaCC");

                entity.Property(e => e.MaNcc)
                    .HasMaxLength(10)
                    .HasColumnName("MaNCC");

                entity.Property(e => e.DiaChiNcc)
                    .HasMaxLength(30)
                    .HasColumnName("DiaChiNCC");

                entity.Property(e => e.HoTenNcc)
                    .HasMaxLength(30)
                    .HasColumnName("HoTenNCC");

                entity.Property(e => e.Sdtncc)
                    .HasMaxLength(11)
                    .IsUnicode(false)
                    .HasColumnName("SDTNCC")
                    .HasDefaultValueSql("(N'Không có')");
            });

            modelBuilder.Entity<NhanVien>(entity =>
            {
                entity.HasKey(e => e.MaNv)
                    .HasName("PK__NhanVien__2725D70AB16C4C9B");

                entity.ToTable("NhanVien");

                entity.Property(e => e.MaNv)
                    .HasMaxLength(10)
                    .HasColumnName("MaNV");

                entity.Property(e => e.CaLam).HasMaxLength(8);

                entity.Property(e => e.DiachiNv)
                    .HasMaxLength(30)
                    .HasColumnName("DiachiNV");

                entity.Property(e => e.Email)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.GioiTinh).HasMaxLength(3);

                entity.Property(e => e.HoTenNv)
                    .HasMaxLength(30)
                    .HasColumnName("HoTenNV");

                entity.Property(e => e.NgaySinh).HasColumnType("date");

                entity.Property(e => e.Sdtnv)
                    .HasMaxLength(11)
                    .IsUnicode(false)
                    .HasColumnName("SDTNV")
                    .HasDefaultValueSql("(N'Không có')");
            });

            modelBuilder.Entity<TaiKhoan>(entity =>
            {
                entity.HasKey(e => e.MaTaiKhoan)
                    .HasName("PK__TaiKhoan__AD7C6529F4FF9621");

                entity.ToTable("TaiKhoan");

                entity.Property(e => e.Email)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.MatKhau).HasMaxLength(20);

                entity.Property(e => e.TenTaiKhoan).HasMaxLength(20);

                entity.HasOne(d => d.LoaiTaiKhoanNavigation)
                    .WithMany(p => p.TaiKhoans)
                    .HasForeignKey(d => d.LoaiTaiKhoan)
                    .HasConstraintName("TK_LoaiTK_FK");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.Property(e => e.UserId)
                    .HasMaxLength(10)
                    .HasColumnName("UserID");

                entity.Property(e => e.EmailUser)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.Password).HasMaxLength(30);

                entity.Property(e => e.Username).HasMaxLength(20);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
