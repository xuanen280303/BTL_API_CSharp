using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class ChiTietHoaDonNhap
    {
        public string? MaHdn { get; set; }
        public string? MaMp { get; set; }
        public string TenMp { get; set; } = null!;
        public double? Slnhap { get; set; }
        public double? Dgnhap { get; set; }
        public double? TrietKhau { get; set; }
        public double? ThanhTien { get; set; }

        public virtual HoaDonNhap? MaHdnNavigation { get; set; }
        public virtual MyPham? MaMpNavigation { get; set; }
    }
}
