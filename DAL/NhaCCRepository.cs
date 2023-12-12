using DAL.Helper.Interfaces;
using DAL.Interfaces;
using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class NhaCCRepository : INhaCCRepository
    {
        private IDatabaseHelper _dbHelper;
        public NhaCCRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public NhaCCModel GetNhaCCbyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "getnhaccbyid", "@id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<NhaCCModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Create(NhaCCModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_nhacc_create",
                "@MaNCC", model.MaNCC,
                "@HoTenNCC", model.HoTenNCC,
                "@SDTNCC", model.SDTNCC,
                "@DiaChiNCC", model.DiaChiNCC);
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
        public bool Update(NhaCCModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_nhacc_update",
                "@MaNCC", model.MaNCC,
                "@HoTenNCC", model.HoTenNCC,
                "@SDTNCC", model.SDTNCC,
                "@DiaChiNCC", model.DiaChiNCC);
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
                var result = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_nhacc_delete",
                     "@MaNCC", id);
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

        public bool DeleteS(NhaCCModel_deletes model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_nhacc_deleteS",
                "@list_json_mancc", model.list_json_mancc != null ? MessageConvert.SerializeObject(model.list_json_mancc) : null);
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

        public List<NhaCCModel> Search(int pageIndex, int pageSize, out long total, string ten_ncc, string dia_chincc)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_nhacc_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_ncc", ten_ncc,
                    "@dia_chincc", dia_chincc);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<NhaCCModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}