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
        HoaDonBanModel GetHoaDonBanbyID(string id);
        List<HoaDonBanModel> GetAll();
        bool Create(HoaDonBanModel model);
    }
}
