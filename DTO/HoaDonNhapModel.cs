using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class HoaDonNhapModel
    {
        public string MaHDN { get; set; } 
        public DateTime NgayNhap { get; set; }
        public string MaTaiKhoan { get; set; }
        public string MaNCC { get; set; }
        public string KieuThanhToan { get; set; }
        public double TongTien { get; set; }
    }
}
