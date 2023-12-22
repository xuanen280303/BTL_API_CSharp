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
        public List<ChiTietHDNModel> list_json_chitiethoadonnhap { get; set; }
    }
    public class ChiTietHDNModel
    {
        public string MaCTHDN { get; set; }
        public string MaHDN { get; set; }
        public string MaMP { get; set; }
        public string TenMP { get; set; }
        public double SLNhap { get; set; }
        public double DGNhap { get; set; }
        public double ThanhTien { get; set; }

    }
}
