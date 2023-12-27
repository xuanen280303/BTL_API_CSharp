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
    public class MyPhamRepository : IMyPhamRepository
    {
        private IDatabaseHelper _dbHelper;
        public MyPhamRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public MyPhamModel GetMyPhambyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "getmyphambyid", "@id", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<MyPhamModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<LayMPTheoLoaiMPModel> GetMPTheoLoaiMP()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_laymptheoloai");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<LayMPTheoLoaiMPModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<MyPhamTheoChucNang> MyPhamTheoChucNang(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_LayMyPhamTheoChucNang",
                     "@ChucNang", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<MyPhamTheoChucNang>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Create(MyPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_mypham_create",
                "@MaMP", model.MaMP,
                "@TenMP", model.TenMP,
                "@MaLoaiMP", model.MaLoaiMP,
                "@GiaMoi", model.GiaMoi,
                "@GiaCu", model.GiaCu,
                "@DanhGia", model.DanhGia,
                "@SLTon", model.SLTon,
                "@MoTa", model.MoTa,
                "@GhiChu", model.GhiChu);
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

        public bool Update(MyPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_mypham_update",
                "@MaMP", model.MaMP,
                "@TenMP", model.TenMP,
                "@MaLoaiMP", model.MaLoaiMP,
                "@GiaMoi",model.GiaMoi,
                "@GiaCu", model.GiaCu,
                "@DanhGia", model.DanhGia,
                "@SLTon", model.SLTon,
                "@MoTa", model.MoTa,
                "@GhiChu", model.GhiChu);
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
                var result = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_mypham_delete",
                     "@MaMP", id);
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

        public bool DeleteS(MyPhamModel_deletes model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_mypham_deleteS",
                "@list_json_mamp", model.list_json_mamp != null ? MessageConvert.SerializeObject(model.list_json_mamp) : null);
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

        public List<MyPhamModel> Search(int pageIndex, int pageSize, out long total, string ten_mp, string mota_mp)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_mypham_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_mp", ten_mp,
                    "@mota_mp", mota_mp);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<MyPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<MyPhamModel2> Searchlmp(int pageIndex, int pageSize, out long total, string maloai_mp)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_mypham_searchlmp",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@maloai_mp", maloai_mp);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<MyPhamModel2>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
