using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface IHoaDonNhapRepository
    {
        HoaDonNhapModel GetHoaDonNhapbyID(string id);
        List<HoaDonNhapModel> GetAll();
        bool Create(HoaDonNhapModel model);
    }
}
