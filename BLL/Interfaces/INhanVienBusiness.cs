using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface INhanVienBusiness
    {
        NhanVienModel GetNhanVienbyID(string id);
        bool Create(NhanVienModel model);
        bool Update(NhanVienModel model);
        bool Delete(string id);
        bool DeleteS(NhanVienModel_deletes model);
        public List<NhanVienModel> Search(int pageIndex, int pageSize, out long total, string ten_nv, string dia_chinv);
    }
}
