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
    public class MyPhamBusiness : IMyPhamBusiness
    {
        private IMyPhamRepository _mypham;

        public MyPhamBusiness(IMyPhamRepository mypham)
        {
            _mypham = mypham;
        }
        public MyPhamModel GetMyPhambyID(string id)
        {
            return _mypham.GetMyPhambyID(id);
        }
        public List<MyPhamTheoChucNang> MyPhamTheoChucNang(int id)
        {
            return _mypham.MyPhamTheoChucNang(id);
        }
        public List<LayMPTheoLoaiMPModel> GetMPTheoLoaiMP()
        {
            return _mypham.GetMPTheoLoaiMP();
        }
        public bool Create(MyPhamModel model)
        {
            return _mypham.Create(model);
        }
        public bool Update(MyPhamModel model)
        {
            return _mypham.Update(model);
        }
        public bool Delete(string id)
        {
            return _mypham.Delete(id);
        }
        public bool DeleteS(MyPhamModel_deletes model)
        {
            return _mypham.DeleteS(model);
        }
        public List<MyPhamModel> Search(int pageIndex, int pageSize, out long total, string ten_mp, string mota_mp)
        {
            return _mypham.Search(pageIndex, pageSize, out total, ten_mp, mota_mp);
        }
        public List<MyPhamModel2> Searchlmp(int pageIndex, int pageSize, out long total, string maloai_mp)
        {
            return _mypham.Searchlmp(pageIndex, pageSize, out total, maloai_mp);
        }
    }
}
