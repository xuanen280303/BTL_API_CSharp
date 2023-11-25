using API.Models;
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
        public LoaiMyPham GetLoaiMyPhambyID(string id)
        {
            return _loaimypham.GetLoaiMyPhambyID(id);
        }
        public bool Create(LoaiMyPham model)
        {
            return _loaimypham.Create(model);
        }
        public bool Update(LoaiMyPham model)
        {
            return _loaimypham.Update(model);
        }
    }
}
