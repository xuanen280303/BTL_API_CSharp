using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class NhaCc
    {
        public NhaCc()
        {
            ChiTietMyPhams = new HashSet<ChiTietMyPham>();
            HoaDonNhaps = new HashSet<HoaDonNhap>();
        }

        public string MaNcc { get; set; } = null!;
        public string HoTenNcc { get; set; } = null!;
        public string? Sdtncc { get; set; }
        public string? DiaChiNcc { get; set; }

        public virtual ICollection<ChiTietMyPham> ChiTietMyPhams { get; set; }
        public virtual ICollection<HoaDonNhap> HoaDonNhaps { get; set; }
    }
}
