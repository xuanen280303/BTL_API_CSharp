using BLL.Interfaces;
using DAL;
using DAL.Interfaces;
using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class BaiVietBusiness : IBaiVietBusiness
    {
        private IBaiVietRepository _baiviet;

        public BaiVietBusiness(IBaiVietRepository baiviet)
        {
            _baiviet = baiviet;
        }
        public BaiVietModel GetBaiVietbyID(string id)
        {
            return _baiviet.GetBaiVietbyID(id);
        }
        public bool Create(BaiVietModel model)
        {
            return _baiviet.Create(model);
        }
        public bool Update(BaiVietModel model)
        {
            return _baiviet.Update(model);
        }
        public bool Delete(string id)
        {
            return _baiviet.Delete(id);
        }
        public bool DeleteS(BaiVietModel_deletes model)
        {
            return _baiviet.DeleteS(model);
        }
        public List<BaiVietModel> Search(int pageIndex, int pageSize, out long total, string tieu_de, string noi_dung)
        {
            return _baiviet.Search(pageIndex, pageSize, out total, tieu_de, noi_dung);
        }

    }
}
