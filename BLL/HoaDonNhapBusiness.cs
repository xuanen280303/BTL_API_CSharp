using API.Models;
using BLL.Interfaces;
using DAL;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class HoaDonNhapBusiness : IHoaDonNhapBusiness
    {
        private IHoaDonNhapRepository _hdn;

        public HoaDonNhapBusiness(IHoaDonNhapRepository hdn)
        {
            _hdn = hdn;
        }
        public HoaDonNhap GetHoaDonNhapbyID(string id)
        {
            return _hdn.GetHoaDonNhapbyID(id);
        }
        public bool Create(HoaDonNhap model)
        {
            return _hdn.Create(model);
        }
    }
}
