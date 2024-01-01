using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class getbyidHoaDonBanModel
    {
        public int MaHDB { get; set; }
        public string HoTenKH { get; set; }
        public string DiaChiKH { get; set; }
        public string SDTKH { get; set; }
        public bool TrangThai { get; set; }
        public decimal TongTien { get; set; }

        public List<getbyidChiTietHDBModel> list_json_chitiethoadonban { get; set; }
    }
    public class getbyidChiTietHDBModel
    {
        public int MaCTHDB { get; set; }
        public int MaHDB { get; set; }
        public string MaMP { get; set; }
        public int SLBan { get; set; }
        public decimal TongTien { get; set; }
        public int GhiChu { get; set; }
    }
    public class HoaDonBanModel
    {
        public int MaHDB { get; set; } 
        public int IDKH { get; set; } 
        public string HoTenKH { get; set; }
        public string SDTKH { get; set; }
        public string DiaChiKH { get; set; }   
        public bool TrangThai { get; set; }
        public List<ChiTietHDBModel> list_json_chitiethoadonban { get; set; }
    }
    public class ChiTietHDBModel
    {
        public int MaCTHDB { get; set; }
        public int MaHDB { get; set; }
        public string MaMP { get; set; }
        public int SLBan { get; set; }
        public decimal TongTien { get; set; }
        public int GhiChu { get; set; }
    }
}
