using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class NhanVien
    {
        public string MaNv { get; set; } = null!;
        public string? HoTenNv { get; set; }
        public DateTime? NgaySinh { get; set; }
        public string? GioiTinh { get; set; }
        public string? CaLam { get; set; }
        public string? Sdtnv { get; set; }
        public string? DiachiNv { get; set; }
        public string? Email { get; set; }
    }
}
