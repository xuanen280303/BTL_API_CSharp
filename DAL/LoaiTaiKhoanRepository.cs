using DTO;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class LoaiTaiKhoanRepository : ILoaiTaiKhoanRepository
    {
        private IDatabaseHelper _dbHelper;
        public LoaiTaiKhoanRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public LoaiTaiKhoanModel GetLoaiTaiKhoanbyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "getloaitaikhoanbyid", "@id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<LoaiTaiKhoanModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(LoaiTaiKhoanModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_loaitaikhoan_create",
                "@TenLoaiTK", model.TenLoaiTK,
                "@MoTa", model.MoTa);
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
        public bool Update(LoaiTaiKhoanModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_loaitaikhoan_update",
                "@MaLoaiTK", model.MaLoaiTK,
                "@TenLoaiTK", model.TenLoaiTK,
                "@MoTa", model.MoTa);
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

        public bool Delete(string id)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_loaitaikhoan_delete",
                     "@MaLoaiTK", id);
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

        public List<LoaiTaiKhoanModel> Search(int pageIndex, int pageSize, out long total, string tenloai_tk, string motaloai_tk)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_loaitaikhoan_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@tenloai_tk", tenloai_tk,
                    "@motaloai_tk", motaloai_tk);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<LoaiTaiKhoanModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
