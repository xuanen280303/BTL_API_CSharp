using API.Models;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class NhanVienRepository : INhanVienRepository
    {
        private IDatabaseHelper _dbHelper;
        public NhanVienRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public NhanVien GetNhanVienbyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "getnhanvienbyid","@id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<NhanVien>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(NhanVien model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_nhanvien_create",
                "@MaNV", model.MaNV,
                "@HoTenNV", model.HoTenNV,
                "@NgaySinh", model.NgaySinh,
                "@GioiTinh", model.GioiTinh,
                "@CaLam", model.CaLam,
                "@SDTNV", model.SDTNV,
                "@DiaChiNV", model.DiachiNV,
                "@Email", model.Email);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(NhanVien model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_nhanvien_update",
                "@MaNV", model.MaNV,
                "@HoTenNV", model.HoTenNV,
                "@NgaySinh", model.NgaySinh,
                "@GioiTinh", model.GioiTinh,
                "@CaLam", model.CaLam,
                "@SDTNV", model.SDTNV,
                "@DiaChiNV", model.DiachiNV,
                "@Email", model.Email);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<NhanVien> Search(int pageIndex, int pageSize, out long total, string ten_nv, string dia_chinv)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_nhanvien_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_nv", ten_nv,
                    "@dia_chinv", dia_chinv);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<NhanVien>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
