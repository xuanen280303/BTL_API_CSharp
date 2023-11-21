using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class HoaDonNhap
    {
        public string MaHdn { get; set; } = null!;
        public DateTime? NgayNhap { get; set; }
        public string? MaNv { get; set; }
        public string? MaNcc { get; set; }
        public string? HoTenNcc { get; set; }
        public string? Sdtncc { get; set; }
        public double? TongTien { get; set; }

        public virtual NhaCc? MaNccNavigation { get; set; }
        public virtual NhanVien? MaNvNavigation { get; set; }
    }
}
