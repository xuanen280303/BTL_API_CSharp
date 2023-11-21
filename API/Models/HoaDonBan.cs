using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class HoaDonBan
    {
        public string MaHdb { get; set; } = null!;
        public DateTime? NgayBan { get; set; }
        public string? MaNv { get; set; }
        public string? Idkh { get; set; }
        public string? HoTenKh { get; set; }
        public double? TongTien { get; set; }

        public virtual KhachHang? IdkhNavigation { get; set; }
        public virtual NhanVien? MaNvNavigation { get; set; }
    }
}
