using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface IHoaDonBanBusiness
    {
        getbyidHoaDonBanModel GetHoaDonBanbyID(int id);
        List<HoaDonBanModel> GetAll();
        bool Create(HoaDonBanModel model);
        bool Update(HoaDonBanModel model);
        bool Delete(string id);
        public List<SearchHDBModel> SearchHDB(int pageIndex, int pageSize, out long total, int ma_hdb, string ten_kh);
    }
}
