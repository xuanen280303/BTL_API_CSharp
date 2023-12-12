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
    public class BaiVietRepository : IBaiVietRepository
    {
        private IDatabaseHelper _dbHelper;
        public BaiVietRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public BaiVietModel GetBaiVietbyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "getbaivietbyid", "@id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<BaiVietModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(BaiVietModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_baiviet_create",
                "@MaBV", model.MaBV,
                "@TieuDe", model.TieuDe,
                "@NguoiDang", model.NguoiDang,
                "@TGDang", model.TGDang,
                "@NgayKT", model.NgayKT,
                "@NoiDung", model.NoiDung);
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

        public bool Update(BaiVietModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_baiviet_update",
                "@MaBV", model.MaBV,
                "@TieuDe", model.TieuDe,
                "@NguoiDang", model.NguoiDang,
                "@TGDang", model.TGDang,
                "@NgayKT", model.NgayKT,
                "@NoiDung", model.NoiDung);
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
                var result = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_baiviet_delete",
                     "@MaBV", id);
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

        public bool DeleteS(BaiVietModel_deletes model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_baiviet_deleteS",
                "@list_json_mabv", model.list_json_mabv != null ? MessageConvert.SerializeObject(model.list_json_mabv) : null);
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

        public List<BaiVietModel> Search(int pageIndex, int pageSize, out long total, string tieu_de, string noi_dung)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_baiviet_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@tieu_de", tieu_de,
                    "@noi_dung", noi_dung);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<BaiVietModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

