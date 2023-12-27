using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class ChiTietTaiKhoan
    {
        public int MaChitietTaiKhoan { get; set; }
        public int? MaTaiKhoan { get; set; }
        public string? HoTen { get; set; }
        public string? DiaChi { get; set; }
        public string? Sdt { get; set; }
        public string? AnhDaiDien { get; set; }

        public virtual TaiKhoan? MaTaiKhoanNavigation { get; set; }
    }
}
