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
        public getbyidHoaDonBanModel GetHoaDonBanbyID(int id)
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
        public bool Update(HoaDonBanModel model)
        {
            return _hdb.Update(model);
        }
        public bool Delete(string id)
        {
            return _hdb.Delete(id);
        }
        public List<SearchHDBModel> SearchHDB(int pageIndex, int pageSize, out long total, int ma_hdb, string ten_kh)
        {
            return _hdb.SearchHDB(pageIndex, pageSize, out total, ma_hdb, ten_kh);
        }
    }
}
