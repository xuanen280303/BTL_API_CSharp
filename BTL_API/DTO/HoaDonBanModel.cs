using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class HoaDonBanModel
    {
        public string MaHDB { get; set; } 
        public DateTime? NgayBan { get; set; }
        public string MaTaiKhoan { get; set; }
        public string IDKH { get; set; }
        public string HoTenKH { get; set; }
        public double TongTien { get; set; }
        public List<ChiTietHDBModel> list_json_chitiethoadonban { get; set; }
    }
    public class ChiTietHDBModel
    {
        public string MaHDB { get; set; }
        public string MaMP { get; set; }
        public string TenMP { get; set; }
        public double SLBan { get; set; }
        public double DGBan { get; set; }
        public double GiamGia { get; set; }
        public double ThanhTien { get; set; }
    }
}
