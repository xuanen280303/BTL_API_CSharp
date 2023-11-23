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
    public class NhaCCRepository : INhaCCRepository
    {
        private IDatabaseHelper _dbHelper;
        public NhaCCRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public NhaCC GetNhaCCbyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "getnhaccbyid", "@id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<NhaCC>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Create(NhaCC model)
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

    }
}