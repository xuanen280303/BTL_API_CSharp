using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class MyPham
    {
        public MyPham()
        {
            ChiTietHoaDonBans = new HashSet<ChiTietHoaDonBan>();
            ChiTietHoaDonNhaps = new HashSet<ChiTietHoaDonNhap>();
            ChiTietMyPhams = new HashSet<ChiTietMyPham>();
        }

        public string MaMp { get; set; } = null!;
        public string TenMp { get; set; } = null!;
        public string? MaLoaiMp { get; set; }
        public int? Slton { get; set; }
        public string? MoTa { get; set; }
        public string? GhiChu { get; set; }

        public virtual LoaiMyPham? MaLoaiMpNavigation { get; set; }
        public virtual ICollection<ChiTietHoaDonBan> ChiTietHoaDonBans { get; set; }
        public virtual ICollection<ChiTietHoaDonNhap> ChiTietHoaDonNhaps { get; set; }
        public virtual ICollection<ChiTietMyPham> ChiTietMyPhams { get; set; }
    }
}
