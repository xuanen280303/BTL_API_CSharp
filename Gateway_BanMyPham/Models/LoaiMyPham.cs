using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class LoaiMyPham
    {
        public LoaiMyPham()
        {
            MyPhams = new HashSet<MyPham>();
        }

        public string MaLoaiMp { get; set; } = null!;
        public string TenLoaiMp { get; set; } = null!;
        public string? MoTa { get; set; }

        public virtual ICollection<MyPham> MyPhams { get; set; }
    }
}
