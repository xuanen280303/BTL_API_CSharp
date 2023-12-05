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
    public class KhachHangBusiness : IKhachHangBusiness
    {
        private IKhachHangRepository _khachhang;

        public KhachHangBusiness(IKhachHangRepository khachhang)
        {
            _khachhang = khachhang;
        }
        public KhachHangModel GetKhachHangbyID(string id)
        {
            return _khachhang.GetKhachHangbyID(id);
        }
        public bool Create(KhachHangModel model)
        {
            return _khachhang.Create(model);
        }
        public bool Update(KhachHangModel model)
        {
            return _khachhang.Update(model);
        }
    }
}
