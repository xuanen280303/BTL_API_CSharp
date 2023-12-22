using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface IMyPhamBusiness
    {
        MyPhamModel GetMyPhambyID(string id);
        List<MyPhamTheoChucNang> MyPhamTheoChucNang(int id);
        List<LayMPTheoLoaiMPModel> GetMPTheoLoaiMP();
        bool Create(MyPhamModel model);
        bool Update(MyPhamModel model);
        bool Delete(string id);
        bool DeleteS(MyPhamModel_deletes model);
         List<MyPhamModel> Search(int pageIndex, int pageSize, out long total, string ten_mp, string mota_mp);
    }
}
