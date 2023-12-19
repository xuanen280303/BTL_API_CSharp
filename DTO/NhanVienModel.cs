using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class NhanVienModel
    {
        public string MaNV { get; set; } 
        public string HoTenNV { get; set; }
        public DateTime NgaySinh { get; set; }
        public string GioiTinh { get; set; }
        public string CaLam { get; set; }
        public string SDTNV { get; set; }
        public string DiachiNV { get; set; }
        public string Email { get; set; }
    }
    public class NhanVienModel_deletes
    {
        public List<ChiTietNhanVienModel> list_json_manv { get; set; }
    }
    public class ChiTietNhanVienModel
    {
        public string MaNV { get; set; }
        public string GhiChu { get; set; }
    }
}
