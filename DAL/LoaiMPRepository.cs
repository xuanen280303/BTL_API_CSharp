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
    public class LoaiMPRepository : ILoaiMPRepository
    {
        private IDatabaseHelper _dbHelper;
        public LoaiMPRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public LoaiMyPhamModel GetLoaiMyPhambyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "getloaimyphambyid", "@id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<LoaiMyPhamModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Create(LoaiMyPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_loaimypham_create",
                "@MaLoaiMP", model.MaLoaiMP,
                "@TenLoaiMP", model.TenLoaiMP,
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

        public bool Update(LoaiMyPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_loaimypham_update",
                "@MaLoaiMP", model.MaLoaiMP,
                "@TenLoaiMP", model.TenLoaiMP,
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
                var result = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_loaimypham_delete",
                     "@MaLoaiMP", id);
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

        public bool DeleteS(LoaiMyPhamModel_deletes model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_loaimypham_deleteS",
                "@list_json_maloaimp", model.list_json_maloaimp != null ? MessageConvert.SerializeObject(model.list_json_maloaimp) : null);
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

        public List<LoaiMyPhamModel> Search(int pageIndex, int pageSize, out long total, string tenloai_mp, string motaloai_mp)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_loaimypham_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@tenloai_mp", tenloai_mp,
                    "@motaloai_mp", motaloai_mp);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<LoaiMyPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
