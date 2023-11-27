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
    public class HoaDonBanBusiness : IHoaDonBanBusiness
    {
        private IHoaDonBanRepository _hdb;

        public HoaDonBanBusiness(IHoaDonBanRepository hdb)
        {
            _hdb = hdb;
        }
        public HoaDonBan GetHoaDonBanbyID(string id)
        {
            return _hdb.GetHoaDonBanbyID(id);
        }
        public bool Create(HoaDonBan model)
        {
            return _hdb.Create(model);
        }

        public bool Update(HoaDonBan model)
        {
            throw new NotImplementedException();
        }
    }
}
