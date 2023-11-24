using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class MyPham
    {
        public string MaMP { get; set; } = null!;
        public string TenMP { get; set; } = null!;
        public string? MaLoaiMP { get; set; }
        public int? SLTon { get; set; }
        public string? MoTa { get; set; }
        public string? GhiChu { get; set; }

        public virtual LoaiMyPham? MaLoaiMpNavigation { get; set; }
    }
}
