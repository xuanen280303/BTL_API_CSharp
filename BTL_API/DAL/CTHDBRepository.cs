using DTO;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public class CTHDBRepository : ICTHDBRepository
    {
        private IDatabaseHelper _dbHelper;
        public CTHDBRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }
        public CTHDBModel GetCTHDBbyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "getcthdbbyid",
                     "@id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<CTHDBModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<CTHDBModel> Search(int pageIndex, int pageSize, out long total, int ma_hd, int ma_mp)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_cthdn_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ma_hd", ma_hd,
                    "@ma_mp", ma_mp);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<CTHDBModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
