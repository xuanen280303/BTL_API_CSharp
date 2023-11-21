using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace API.Models
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

        public virtual DbSet<ChiTietHoaDonBan> ChiTietHoaDonBans { get; set; } = null!;
        public virtual DbSet<ChiTietHoaDonNhap> ChiTietHoaDonNhaps { get; set; } = null!;
        public virtual DbSet<HoaDonBan> HoaDonBans { get; set; } = null!;
        public virtual DbSet<HoaDonNhap> HoaDonNhaps { get; set; } = null!;
        public virtual DbSet<KhachHang> KhachHangs { get; set; } = null!;
        public virtual DbSet<LoaiMyPham> LoaiMyPhams { get; set; } = null!;
        public virtual DbSet<MyPham> MyPhams { get; set; } = null!;
        public virtual DbSet<NhaCc> NhaCcs { get; set; } = null!;
        public virtual DbSet<NhanVien> NhanViens { get; set; } = null!;
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
            modelBuilder.Entity<ChiTietHoaDonBan>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("ChiTietHoaDonBan");

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
                    .WithMany()
                    .HasForeignKey(d => d.MaHdb)
                    .HasConstraintName("FK_ChiTietHoaDonNhap_HDB");

                entity.HasOne(d => d.MaMpNavigation)
                    .WithMany()
                    .HasForeignKey(d => d.MaMp)
                    .HasConstraintName("FK_ChiTietHoaDonBan_MyPham");
            });

            modelBuilder.Entity<ChiTietHoaDonNhap>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("ChiTietHoaDonNhap");

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
                    .WithMany()
                    .HasForeignKey(d => d.MaHdn)
                    .HasConstraintName("FK_ChiTietHoaDonNhap_HDN");

                entity.HasOne(d => d.MaMpNavigation)
                    .WithMany()
                    .HasForeignKey(d => d.MaMp)
                    .HasConstraintName("FK_ChiTietHoaDonNhap_MyPham");
            });

            modelBuilder.Entity<HoaDonBan>(entity =>
            {
                entity.HasKey(e => e.MaHdb)
                    .HasName("PK__HoaDonBa__3C90E8FA259F4949");

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

                entity.Property(e => e.MaNv)
                    .HasMaxLength(10)
                    .HasColumnName("MaNV");

                entity.Property(e => e.NgayBan).HasColumnType("date");

                entity.HasOne(d => d.IdkhNavigation)
                    .WithMany(p => p.HoaDonBans)
                    .HasForeignKey(d => d.Idkh)
                    .HasConstraintName("FK_HoaDonBan_IDKH");

                entity.HasOne(d => d.MaNvNavigation)
                    .WithMany(p => p.HoaDonBans)
                    .HasForeignKey(d => d.MaNv)
                    .HasConstraintName("FK_HoaDonBan_MaNV");
            });

            modelBuilder.Entity<HoaDonNhap>(entity =>
            {
                entity.HasKey(e => e.MaHdn)
                    .HasName("PK__HoaDonNh__3C90E8C65F5A5B2B");

                entity.ToTable("HoaDonNhap");

                entity.Property(e => e.MaHdn)
                    .HasMaxLength(10)
                    .HasColumnName("MaHDN");

                entity.Property(e => e.HoTenNcc)
                    .HasMaxLength(30)
                    .HasColumnName("HoTenNCC");

                entity.Property(e => e.MaNcc)
                    .HasMaxLength(10)
                    .HasColumnName("MaNCC");

                entity.Property(e => e.MaNv)
                    .HasMaxLength(10)
                    .HasColumnName("MaNV");

                entity.Property(e => e.NgayNhap).HasColumnType("date");

                entity.Property(e => e.Sdtncc)
                    .HasMaxLength(11)
                    .IsUnicode(false)
                    .HasColumnName("SDTNCC")
                    .HasDefaultValueSql("(N'Không có')");

                entity.HasOne(d => d.MaNccNavigation)
                    .WithMany(p => p.HoaDonNhaps)
                    .HasForeignKey(d => d.MaNcc)
                    .HasConstraintName("FK_HoaDonNhap_MaNCC");

                entity.HasOne(d => d.MaNvNavigation)
                    .WithMany(p => p.HoaDonNhaps)
                    .HasForeignKey(d => d.MaNv)
                    .HasConstraintName("FK_HoaDonNhap_MaNV");
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
                entity.HasKey(e => e.MaNV)
                    .HasName("PK__NhanVien__2725D70A8CABFD04");

                entity.ToTable("NhanVien");

                entity.Property(e => e.MaNV)
                    .HasMaxLength(10)
                    .HasColumnName("MaNV");

                entity.Property(e => e.CaLam).HasMaxLength(8);

                entity.Property(e => e.DiachiNV)
                    .HasMaxLength(30)
                    .HasColumnName("DiachiNV");

                entity.Property(e => e.Email)
                    .HasMaxLength(30)
                    .IsUnicode(false);

                entity.Property(e => e.GioiTinh).HasMaxLength(3);

                entity.Property(e => e.HoTenNV)
                    .HasMaxLength(30)
                    .HasColumnName("HoTenNV");

                entity.Property(e => e.NgaySinh).HasColumnType("date");

                entity.Property(e => e.SDTNV)
                    .HasMaxLength(11)
                    .IsUnicode(false)
                    .HasColumnName("SDTNV")
                    .HasDefaultValueSql("(N'Không có')");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.Property(e => e.UserId)
                    .HasMaxLength(10)
                    .HasColumnName("UserID");

                entity.Property(e => e.Password).HasMaxLength(30);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
