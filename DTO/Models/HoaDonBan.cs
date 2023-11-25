using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class HoaDonBan
    {
        public string MaHDB { get; set; } = null!;
        public DateTime? NgayBan { get; set; }
        public string? MaNV { get; set; }
        public string? IDKH { get; set; }
        public string? HoTenKH { get; set; }
        public double? TongTien { get; set; }

        public virtual KhachHang? IDKHNavigation { get; set; }
        public virtual NhanVien? MaNVNavigation { get; set; }
    }
}
