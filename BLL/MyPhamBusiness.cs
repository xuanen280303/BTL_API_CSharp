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
    public class MyPhamBusiness : IMyPhamBusiness
    {
        private IMyPhamRepository _mypham;

        public MyPhamBusiness(IMyPhamRepository mypham)
        {
            _mypham = mypham;
        }
        public MyPham GetMyPhambyID(string id)
        {
            return _mypham.GetMyPhambyID(id);
        }
        public bool Create(MyPham model)
        {
            return _mypham.Create(model);
        }
        public bool Update(MyPham model)
        {
            return _mypham.Update(model);
        }
    }
}
