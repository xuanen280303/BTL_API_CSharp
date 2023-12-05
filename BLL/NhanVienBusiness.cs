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
    public class NhanVienBusiness:INhanVienBusiness
    {
        private INhanVienRepository _nhanvien;
        
        public NhanVienBusiness(INhanVienRepository nhanvien)
        {
            _nhanvien = nhanvien;
        }
        public NhanVienModel GetNhanVienbyID(string id)
        {
            return _nhanvien.GetNhanVienbyID(id);
        }
        public bool Create(NhanVienModel model)
        {
            return _nhanvien.Create(model);
        }
        public bool Update(NhanVienModel model)
        {
            return _nhanvien.Update(model);
        }
        public bool Delete(string id)
        {
            return _nhanvien.Delete(id);
        }
        public List<NhanVienModel> Search(int pageIndex, int pageSize, out long total, string ten_nv, string dia_chinv)
        {
            return _nhanvien.Search(pageIndex, pageSize, out total, ten_nv, dia_chinv);
        }

    }
}
