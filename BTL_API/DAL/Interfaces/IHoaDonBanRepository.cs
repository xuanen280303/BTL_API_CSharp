using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface IHoaDonBanRepository
    {
        getbyidHoaDonBanModel GetHoaDonBanbyID(int id);
        List<HoaDonBanModel> GetAll();
        bool Create(HoaDonBanModel model);
        bool Update(HoaDonBanModel model);
        bool Delete(string id);
        public List<HoaDonBanModel> SearchHDB(int pageIndex, int pageSize, out long total, int ma_hdb, string ten_kh);
        
    }
}
