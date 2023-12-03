using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class ThongKeKhachHangModel
    {
        public int MaMP { get; set; }
        public string TenMP { get; set; }
        public int SoLuong { get; set; }
        public float TongGia { get; set; }
        public DateTime NgayBan { get; set; }
        public string HoTenKH { get; set; }
        public string DiachiKH { get; set; }
    }

}
}
