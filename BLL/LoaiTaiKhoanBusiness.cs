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
    public class LoaiTaiKhoanBusiness : ILoaiTaiKhoanBusiness
    {
        private ILoaiTaiKhoanRepository _loaitaikhoan;

        public LoaiTaiKhoanBusiness(ILoaiTaiKhoanRepository loaitaikhoan)
        {
            _loaitaikhoan = loaitaikhoan;
        }
        public LoaiTaiKhoanModel GetLoaiTaiKhoanbyID(string id)
        {
            return _loaitaikhoan.GetLoaiTaiKhoanbyID(id);
        }
        public bool Create(LoaiTaiKhoanModel model)
        {
            return _loaitaikhoan.Create(model);
        }
        public bool Update(LoaiTaiKhoanModel model)
        {
            return _loaitaikhoan.Update(model);
        }
        public bool Delete(string id)
        {
            return _loaitaikhoan.Delete(id);
        }
        public List<LoaiTaiKhoanModel> Search(int pageIndex, int pageSize, out long total, string tenloai_tk, string motaloai_tk)
        {
            return _loaitaikhoan.Search(pageIndex, pageSize, out total, tenloai_tk, motaloai_tk);
        }
    }
}
