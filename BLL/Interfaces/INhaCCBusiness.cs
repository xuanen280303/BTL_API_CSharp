using DTO; 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface INhaCCBusiness
    {
        NhaCCModel GetNhaCCbyID(string id);
        bool Create(NhaCCModel model);
        bool Update(NhaCCModel model);
        bool Delete(string id);
        bool DeleteS(NhaCCModel_deletes model);
        public List<NhaCCModel> Search(int pageIndex, int pageSize, out long total, string ten_ncc, string dia_chincc);
    }
}
