using API.Models;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public class HoaDonBanRepository : IHoaDonBanRepository
    {
        private IDatabaseHelper _dbHelper;
        public HoaDonBanRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public HoaDonBan GetHoaDonBanbyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "gethoadonbanbyid", "@id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<HoaDonBan>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(HoaDonBan model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoadonban_create",
                "@MaHDB", model.MaHDB,
                "@NgayBan", model.NgayBan,
                "@MaNV", model.MaNV,
                "@IDKH", model.IDKH,
                "@HoTenKH", model.HoTenKH,
                "@TongTien", model.TongTien);
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

        public bool Update(HoaDonBan model)
        {
            throw new NotImplementedException();
        }

        //public bool Update(HoaDonBan model)
        //{
        //    string msgerror = "";
        //    try
        //    {
        //        var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgerror, "sp_hoadonban_update",
        //        "@MaHDB", model.MaHDB,
        //        "@NgayBan", model.NgayBan,
        //        "@MaNV", model.MaNV,
        //        "@IDKH", model.IDKH,
        //        "@HoTenKH", model.HoTenKH,
        //        "@TongTien", model.TongTien);
        //        "@list_json_chitiethoadon", model.list_json_chitiethoadon != null ? messageconvert.serializeobject(model.list_json_chitiethoadon) : null);
        //        if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
        //        {
        //            throw new Exception(Convert.ToString(result) + msgError);
        //        }
        //        return true;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        //public List<ThongKeKhachHangModels> Search(int pageIndex, int pageSize, out long total, string ten_khach, DateTime? fr_NgayTao, DateTime? to_NgayTao)
        //{
        //    string msgError = "";
        //    total = 0;
        //    try
        //    {
        //        var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_thong_ke_khach",
        //            "@page_index", pageIndex,
        //            "@page_size", pageSize,   
        //            "@ten_khach", ten_khach,
        //            "@fr_NgayTao", fr_NgayTao,
        //            "@to_NgayTao", to_NgayTao
        //             );
        //        if (!string.IsNullOrEmpty(msgError))
        //            throw new Exception(msgError);
        //        if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
        //        return dt.ConvertTo<ThongKeKhachHangModels>().ToList();
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
    }
}
