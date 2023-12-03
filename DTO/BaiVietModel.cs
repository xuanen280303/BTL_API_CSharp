using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    internal class BaiVietModel
    {
        public string MaBV { get; set; }
        public string TieuDe { get; set; }
        public string NguoiDang { get; set; }      
        public DateTime TGDang { get; set; }
        public DateTime NgayKT { get; set; }
        public string NoiDung { get; set; }
    }
    public class BaiVietModel_deletes
    {
        public List<ChiTietBaiVietModel> list_json_mabv { get; set; }
    }
    public class ChiTietBaiVietModel
    {
        public int MaBV { get; set; }
        public int GhiChu { get; set; }

    }
}
