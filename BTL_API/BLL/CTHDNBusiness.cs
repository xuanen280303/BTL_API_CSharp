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
    public class CTHDNBusiness : ICTHDNBusiness
    {
        private ICTHDNRepository _cthdn;

        public CTHDNBusiness(ICTHDNRepository cthdn)
        {
            _cthdn = cthdn;
        }
        public CTHDNModel GetCTHDNbyID(string id)
        {
            return _cthdn.GetCTHDNbyID(id);
        }
        public List<CTHDNModel> Search(int pageIndex, int pageSize, out long total, int ma_hd, int ma_mp)
        {
            return _cthdn.Search(pageIndex, pageSize, out total, ma_hd, ma_mp);
        }
    }
}
