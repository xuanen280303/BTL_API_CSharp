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
    public class CTHDBBusiness : ICTHDBBusiness
    {
        private ICTHDBRepository _cthdb;

        public CTHDBBusiness(ICTHDBRepository cthdb)
        {
            _cthdb = cthdb;
        }
        public CTHDBModel GetCTHDBbyID(string id)
        {
            return _cthdb.GetCTHDBbyID(id);
        }
        public List<CTHDBModel> Search(int pageIndex, int pageSize, out long total, int ma_hd, int ma_mp)
        {
            return _cthdb.Search(pageIndex, pageSize, out total, ma_hd, ma_mp);
        }
    }
}

