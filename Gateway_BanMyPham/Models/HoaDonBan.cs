using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class HoaDonBan
    {
        public HoaDonBan()
        {
            ChiTietHoaDonBans = new HashSet<ChiTietHoaDonBan>();
        }

        public string MaHdb { get; set; } = null!;
        public DateTime? NgayBan { get; set; }
        public int? MaTaiKhoan { get; set; }
        public string? Idkh { get; set; }
        public string? HoTenKh { get; set; }
        public double? TongTien { get; set; }

        public virtual KhachHang? IdkhNavigation { get; set; }
        public virtual TaiKhoan? MaTaiKhoanNavigation { get; set; }
        public virtual ICollection<ChiTietHoaDonBan> ChiTietHoaDonBans { get; set; }
    }
}
