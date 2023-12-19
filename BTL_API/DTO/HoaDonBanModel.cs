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
    }
}
