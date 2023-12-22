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
        HoaDonBanModel GetHoaDonBanbyID(string id);
        List<HoaDonBanModel> GetAll();
        bool Create(HoaDonBanModel model);
    }
}
