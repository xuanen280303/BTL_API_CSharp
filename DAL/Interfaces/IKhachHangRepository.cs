using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface IKhachHangRepository
    {
        KhachHangModel GetKhachHangbyID(string id);
        bool Create(KhachHangModel model);
        bool Update(KhachHangModel model);
        bool Delete(string id);
        public List<KhachHangModel> Search(int pageIndex, int pageSize, out long total, string ten_kh, string dia_chikh);

    }
}
