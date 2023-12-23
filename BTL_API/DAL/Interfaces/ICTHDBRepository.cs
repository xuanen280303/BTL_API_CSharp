using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface ICTHDBRepository
    {
        CTHDBModel GetCTHDBbyID(string id);
        public List<CTHDBModel> Search(int pageIndex, int pageSize, out long total, int ma_hd, int ma_mp);
    }
}
