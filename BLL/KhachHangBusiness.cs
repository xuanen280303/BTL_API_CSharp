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
    public class KhachHangBusiness : IKhachHangBusiness
    {
        private IKhachHangRepository _khachhang;

        public KhachHangBusiness(IKhachHangRepository khachhang)
        {
            _khachhang = khachhang;
        }
        public KhachHang GetKhachHangbyID(string id)
        {
            return _khachhang.GetKhachHangbyID(id);
        }
        public bool Create(KhachHang model)
        {
            return _khachhang.Create(model);
        }
    }
}
