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
        public string MaNV { get; set; }
        public string MaNCC { get; set; }
        public string HoTenNCC { get; set; }
        public string SDTNCC { get; set; }
        public double TongTien { get; set; }
    }
}
