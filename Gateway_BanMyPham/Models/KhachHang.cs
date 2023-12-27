using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class KhachHang
    {
        public KhachHang()
        {
            HoaDonBans = new HashSet<HoaDonBan>();
        }

        public string Idkh { get; set; } = null!;
        public string? HoTenKh { get; set; }
        public string? Sdtkh { get; set; }
        public string? DiaChiKh { get; set; }

        public virtual ICollection<HoaDonBan> HoaDonBans { get; set; }
    }
}
