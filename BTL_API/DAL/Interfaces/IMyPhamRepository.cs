using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface IMyPhamRepository
    {
        MyPhamModel GetMyPhambyID(string id);
        List<MyPhamTheoChucNang> MyPhamTheoChucNang(int id);
        List<LayMPTheoLoaiMPModel> GetMPTheoLoaiMP();
        bool Create(MyPhamModel model);
        bool Update(MyPhamModel model);
        bool Delete(string id);
        bool DeleteS(MyPhamModel_deletes model);
        public List<MyPhamModel> Search(int pageIndex, int pageSize, out long total, string ten_mp, string mota_mp);
        public List<MyPhamModel2> Searchlmp(int pageIndex, int pageSize, out long total, string tmaloai_mp);
    }
}
