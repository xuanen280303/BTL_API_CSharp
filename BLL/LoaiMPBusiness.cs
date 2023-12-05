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
    }
}
