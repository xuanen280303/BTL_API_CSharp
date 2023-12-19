using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface ILoaiTaiKhoanBusiness
    {
        LoaiTaiKhoanModel GetLoaiTaiKhoanbyID(string id);
        bool Create(LoaiTaiKhoanModel model);
        bool Update(LoaiTaiKhoanModel model);
        bool Delete(string id);
        public List<LoaiTaiKhoanModel> Search(int pageIndex, int pageSize, out long total, string tenloai_tk, string motaloai_tk);

    }
}
