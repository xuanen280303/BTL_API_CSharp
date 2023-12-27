using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class LoaiTaiKhoan
    {
        public LoaiTaiKhoan()
        {
            TaiKhoans = new HashSet<TaiKhoan>();
        }

        public int MaLoaiTk { get; set; }
        public string? TenLoaiTk { get; set; }
        public string? MoTa { get; set; }

        public virtual ICollection<TaiKhoan> TaiKhoans { get; set; }
    }
}
