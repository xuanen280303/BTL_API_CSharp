using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class MyPhamModel
    {
        public string MaMP { get; set; } 
        public string TenMP { get; set; } 
        public string MaLoaiMP { get; set; }
        public Decimal GiaMoi { get; set; }
        public Decimal GiaCu { get; set; }
        public int DanhGia { get; set; }
        public int SLTon { get; set; }
        public string AnhDaiDien { get; set; }
        public string MoTa { get; set; }
        public string GhiChu { get; set; }
    }
    public class MyPhamModel2
    {
        public string MaMP { get; set; }
        public string TenLoaiMP { get; set; }
        public string TenMP { get; set; }
        public string MaLoaiMP { get; set; }
        public Decimal GiaMoi { get; set; }
        public Decimal GiaCu { get; set; }
        public int DanhGia { get; set; }
        public int SLTon { get; set; }
        public string AnhDaiDien { get; set; }
        public string MoTa { get; set; }
        public string GhiChu { get; set; }
    }
    public class MyPhamModel_deletes
    {
        public List<ChiTietMyPhamModel> list_json_mamp { get; set; }
    }
    public class ChiTietMyPhamModel
    {
        public string MaMP { get; set; }
        public string GhiChu { get; set; }
    }
    public class MyPhamTheoChucNang
    {
        public int ChucNang;
        public string MaMP { get; set; }
        public string TenMP { get; set; }
        public int SLTon { get; set; }
        public int TongSLBan { get; set; }
        public int SoDonDatHang { get; set; }
    }
}
