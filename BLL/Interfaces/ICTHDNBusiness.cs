using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface ICTHDNBusiness
    {
        CTHDNModel GetCTHDNbyID(string id);
        public List<CTHDNModel> Search(int pageIndex, int pageSize, out long total, int ma_hd, int ma_mp);
    }
}
