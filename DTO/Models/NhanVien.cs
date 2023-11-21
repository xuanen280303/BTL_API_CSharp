using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class NhanVien
    {
        public NhanVien()
        {
            HoaDonBans = new HashSet<HoaDonBan>();
            HoaDonNhaps = new HashSet<HoaDonNhap>();
        }

        public string MaNV { get; set; } = null!;
        public string? HoTenNV { get; set; }
        public DateTime? NgaySinh { get; set; }
        public string? GioiTinh { get; set; }
        public string? CaLam { get; set; }
        public string? SDTNV { get; set; }
        public string? DiachiNV { get; set; }
        public string? Email { get; set; }

        public virtual ICollection<HoaDonBan> HoaDonBans { get; set; }
        public virtual ICollection<HoaDonNhap> HoaDonNhaps { get; set; }
    }
}
