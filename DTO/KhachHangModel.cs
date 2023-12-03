using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class KhachHangModel
    {
        public string IDKH { get; set; } 
        public string HoTenKH { get; set; }
        public string SDTKH { get; set; }
        public string DiaChiKH { get; set; }

    }
    public class KhachHangModel_deletes
    {
        public List<ChiTietKhachHangModel> list_json_idkhachhang { get; set; }
    }
    public class ChiTietKhachHangModel
    {
        public int IDKH { get; set; }
        public int GhiChu { get; set; }

    }
}
