using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class ChiTietHoaDonNhap
    {
        public string? MaHDN { get; set; }
        public string? MaMP { get; set; }
        public string TenMP { get; set; } = null!;
        public double? SLNhap { get; set; }
        public double? DGNhap { get; set; }
        public double? TrietKhau { get; set; }
        public double? ThanhTien { get; set; }

        public virtual HoaDonNhap? MaHDNNavigation { get; set; }
        public virtual MyPham? MaMPNavigation { get; set; }
    }
}
