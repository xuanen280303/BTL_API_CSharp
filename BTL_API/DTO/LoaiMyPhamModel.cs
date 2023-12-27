using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class LoaiMyPhamModel
    {
        public string MaLoaiMP { get; set; } 
        public string TenLoaiMP { get; set; } 
        public string AnhDaiDien { get; set; }
        public string MoTa { get; set; }
    }
    public class LoaiMyPhamModel_deletes
    {
        public List<ChiTietLoaiMyPhamModel> list_json_maloaimp { get; set; }
    }
    public class ChiTietLoaiMyPhamModel
    {
        public string MaLoaiMP { get; set; }
        public string GhiChu { get; set; }
    }
}
