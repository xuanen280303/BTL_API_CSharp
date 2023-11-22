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
    public class NhanVienBusiness:INhanVienBusiness
    {
        private INhanVienRepository _nhanvien;
        
        public NhanVienBusiness(INhanVienRepository nhanvien)
        {
            _nhanvien = nhanvien;
        }

        public NhanVien GetNhanVienbyID(string id)
        {
            return _nhanvien.GetNhanVienbyID(id);
        }
        public bool Create(NhanVien model)
        {
            return _nhanvien.Create(model);
        }
        public bool Update(NhanVien model)
        {
            return _nhanvien.Update(model);
        }

        public List<NhanVien> Search(int pageIndex, int pageSize, out long total, string ten_nv, string dia_chinv)
        {
            return _nhanvien.Search(pageIndex, pageSize, out total, ten_nv, dia_chinv);
        }

    }
}
