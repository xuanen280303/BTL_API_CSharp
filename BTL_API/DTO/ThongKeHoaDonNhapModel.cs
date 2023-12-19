using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class ThongKeHoaDonNhapModel
    {
        public int MaTaiKhoan { get; set; }
        public string HoTen { get; set; }
        public int MaNCC { get; set; }
        public string HoTenNCC { get; set; }
        public int MaMP { get; set; }
        public string TenMP { get; set; }
        public int SoLuong { get; set; }
        public string KieuThanhToan { get; set; }
        public float TongTien { get; set; }
        public DateTime NgayNhap { get; set; }
    }
}
