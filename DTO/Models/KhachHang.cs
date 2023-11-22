using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class KhachHang
    {
        public KhachHang()
        {
            HoaDonBans = new HashSet<HoaDonBan>();
        }

        public string IDKH { get; set; } = null!;
        public string? HoTenKH { get; set; }
        public string? SDTKH { get; set; }
        public string? DiaChiKH { get; set; }

        public virtual ICollection<HoaDonBan> HoaDonBans { get; set; }
    }
}
