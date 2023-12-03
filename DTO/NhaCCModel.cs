using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class NhaCCModel
    {
        public string MaNCC { get; set; } 
        public string HoTenNCC { get; set; } 
        public string SDTNCC { get; set; }
        public string DiaChiNCC { get; set; }
    }
    public class NhaCCModel_deletes
    {
        public List<ChiTietNhaCCModel> list_json_mancc{ get; set; }
    }
    public class ChiTietNhaCCModel
    {
        public int MaNhaCC { get; set; }
        public int GhiChu { get; set; }

    }
}
