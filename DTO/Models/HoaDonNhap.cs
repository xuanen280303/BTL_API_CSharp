using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class HoaDonNhap
    {
        public string MaHDN { get; set; } = null!;
        public DateTime? NgayNhap { get; set; }
        public string? MaNV { get; set; }
        public string? MaNCC { get; set; }
        public string? HoTenNCC { get; set; }
        public string? SDTNCC { get; set; }
        public double? TongTien { get; set; }

        public virtual NhaCC? MaNCCNavigation { get; set; }
        public virtual NhanVien? MaNVNavigation { get; set; }
    }
}
