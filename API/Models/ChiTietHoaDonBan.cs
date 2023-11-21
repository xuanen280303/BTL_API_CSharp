using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class ChiTietHoaDonBan
    {
        public string? MaHdb { get; set; }
        public string? MaMp { get; set; }
        public string TenMp { get; set; } = null!;
        public double? Slban { get; set; }
        public double? Dgban { get; set; }
        public double? GiamGia { get; set; }
        public double? ThanhTien { get; set; }

        public virtual HoaDonBan? MaHdbNavigation { get; set; }
        public virtual MyPham? MaMpNavigation { get; set; }
    }
}
