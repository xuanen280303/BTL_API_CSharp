using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class NhaCc
    {
        public NhaCc()
        {
            HoaDonNhaps = new HashSet<HoaDonNhap>();
        }

        public string MaNcc { get; set; } = null!;
        public string HoTenNcc { get; set; } = null!;
        public string? Sdtncc { get; set; }
        public string? DiaChiNcc { get; set; }

        public virtual ICollection<HoaDonNhap> HoaDonNhaps { get; set; }
    }
}
