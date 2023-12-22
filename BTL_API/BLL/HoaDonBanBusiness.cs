using DTO; 
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
        public HoaDonBanModel GetHoaDonBanbyID(string id)
        {
            return _hdb.GetHoaDonBanbyID(id);
        }
        public List<HoaDonBanModel> GetAll()
        {
            return _hdb.GetAll();
        }
        public bool Create(HoaDonBanModel model)
        {
            return _hdb.Create(model);
        }
    }
}
