using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class ChiTietMyPham
    {
        public string MaChiTietMyPham { get; set; } = null!;
        public string? MaMp { get; set; }
        public string? MaNcc { get; set; }
        public string? MoTa { get; set; }
        public string? ChiTiet { get; set; }

        public virtual MyPham? MaMpNavigation { get; set; }
        public virtual NhaCc? MaNccNavigation { get; set; }
    }
}
