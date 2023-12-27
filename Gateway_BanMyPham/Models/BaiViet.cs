using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class BaiViet
    {
        public string MaBv { get; set; } = null!;
        public string? TieuDe { get; set; }
        public string? NguoiDang { get; set; }
        public DateTime? Tgdang { get; set; }
        public DateTime? NgayKt { get; set; }
        public string? NoiDung { get; set; }
    }
}
