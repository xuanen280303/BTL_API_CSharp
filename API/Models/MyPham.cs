using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class MyPham
    {
        public string MaMp { get; set; } = null!;
        public string TenMp { get; set; } = null!;
        public string? MaLoaiMp { get; set; }
        public int? Slton { get; set; }
        public string? MoTa { get; set; }
        public string? GhiChu { get; set; }

        public virtual LoaiMyPham? MaLoaiMpNavigation { get; set; }
    }
}
