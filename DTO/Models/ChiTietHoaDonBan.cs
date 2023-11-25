using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class ChiTietHoaDonBan
    {
        public string? MaHDB { get; set; }
        public string? MaMP { get; set; }
        public string TenMP { get; set; } = null!;
        public double? SLBan { get; set; }
        public double? DGBan { get; set; }
        public double? GiamGia { get; set; }
        public double? ThanhTien { get; set; }

        public virtual HoaDonBan? MaHDBNavigation { get; set; }
        public virtual MyPham? MaMPNavigation { get; set; }
    }
}
