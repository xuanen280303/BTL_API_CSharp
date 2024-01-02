using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class SearchHDBModel
    {
        public int MaHDB { get; set; }
        public string HoTenKH { get; set; }
        public string DiaChiKH { get; set; }
        public string SDTKH { get; set; }
        public bool TrangThai { get; set; }
        public decimal TongTien { get; set; }
        public List<CTHDB> list_json_chitiethoadonban { get; set; }
    }
    public class CTHDB
    {
        public int MaCTHDB { get; set; }
        public int MaHDB { get; set; }
        public string MaMP { get; set; }
        public string MaLoaiMP { get; set; }
        public string TenMP { get; set; }
        public string AnhDaiDien { get; set; }
        public decimal GiaMoi { get; set; }
        public decimal GiaCu { get; set; }
        public int SLBan { get; set; }
        public decimal TongTien { get; set; }
        public int GhiChu { get; set; }
    }
}
