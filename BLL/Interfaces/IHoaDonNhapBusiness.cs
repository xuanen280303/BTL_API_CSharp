using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface IHoaDonNhapBusiness
    {
        HoaDonNhapModel GetHoaDonNhapbyID(string id);
        bool Create(HoaDonNhapModel model);
    }
}
