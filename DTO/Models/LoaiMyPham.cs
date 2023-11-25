using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class LoaiMyPham
    {
        public LoaiMyPham()
        {
            MyPhams = new HashSet<MyPham>();
        }

        public string MaLoaiMP { get; set; } = null!;
        public string TenLoaiMP { get; set; } = null!;
        public string? MoTa { get; set; }

        public virtual ICollection<MyPham> MyPhams { get; set; }
    }
}
