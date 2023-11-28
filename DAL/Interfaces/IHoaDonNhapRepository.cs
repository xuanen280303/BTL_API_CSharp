using API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface IHoaDonNhapRepository
    {
        HoaDonNhap GetHoaDonNhapbyID(string id);
        bool Create(HoaDonNhap model);
    }
}
