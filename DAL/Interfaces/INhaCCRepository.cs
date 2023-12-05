using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface INhaCCRepository
    {
        NhaCCModel GetNhaCCbyID(string id);
        bool Create(NhaCCModel model);
        bool Update(NhaCCModel model);
        bool Delete(string id);
        public List<NhaCCModel> Search(int pageIndex, int pageSize, out long total, string ten_ncc, string dia_chincc);
    }
}
