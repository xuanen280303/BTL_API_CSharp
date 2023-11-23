using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class NhaCC
    {
        public NhaCC()
        {
            HoaDonNhaps = new HashSet<HoaDonNhap>();
        }

        public string MaNCC { get; set; } = null!;
        public string HoTenNCC { get; set; } = null!;
        public string? SDTNCC { get; set; }
        public string? DiaChiNCC { get; set; }

        public virtual ICollection<HoaDonNhap> HoaDonNhaps { get; set; }
    }
}
