using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class HoaDonNhap
    {
        public HoaDonNhap()
        {
            ChiTietHoaDonNhaps = new HashSet<ChiTietHoaDonNhap>();
        }

        public string MaHdn { get; set; } = null!;
        public DateTime? NgayNhap { get; set; }
        public int? MaTaiKhoan { get; set; }
        public string? MaNcc { get; set; }
        public string? KieuThanhToan { get; set; }
        public double? TongTien { get; set; }

        public virtual NhaCc? MaNccNavigation { get; set; }
        public virtual TaiKhoan? MaTaiKhoanNavigation { get; set; }
        public virtual ICollection<ChiTietHoaDonNhap> ChiTietHoaDonNhaps { get; set; }
    }
}
