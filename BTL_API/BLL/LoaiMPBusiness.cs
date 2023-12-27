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
    public class LoaiMPBusiness : ILoaiMPBusiness
    {
        private ILoaiMPRepository _loaimypham;

        public LoaiMPBusiness(ILoaiMPRepository loaimypham)
        {
            _loaimypham = loaimypham;
        }
        public LoaiMyPhamModel GetLoaiMyPhambyID(string id)
        {
            return _loaimypham.GetLoaiMyPhambyID(id);
        }
        public bool Create(LoaiMyPhamModel model)
        {
            return _loaimypham.Create(model);
        }
        public bool Update(LoaiMyPhamModel model)
        {
            return _loaimypham.Update(model);
        }
        public bool Delete(string id)
        {
            return _loaimypham.Delete(id);
        }
        public bool DeleteS(LoaiMyPhamModel_deletes model)
        {
            return _loaimypham.DeleteS(model);
        }
        public List<LoaiMyPhamModel> Search(int pageIndex, int pageSize, out long total, string tenloai_mp, string anh_dai_dien, string motaloai_mp)
        {
            return _loaimypham.Search(pageIndex, pageSize, out total, tenloai_mp, anh_dai_dien, motaloai_mp);
        }
    }
}
