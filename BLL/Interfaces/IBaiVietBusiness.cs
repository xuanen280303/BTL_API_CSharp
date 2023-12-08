using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface IBaiVietRepository
    {
        BaiVietModel GetBaiVietbyID(string id);
        bool Create(BaiVietModel model);
        bool Update(BaiVietModel model);
        bool Delete(string id);
        public List<BaiVietModel> Search(int pageIndex, int pageSize, out long total, string tieu_de, string noi_dung);
    }
}
