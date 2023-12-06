using DTO;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DTO.Models;

//namespace DAL
//{
//    public class UserRepository : IUserRepository
//    {
//        private IDatabaseHelper _dbHelper;
//        public UserRepository(IDatabaseHelper dbHelper)
//        {
//            _dbHelper = dbHelper;
//        }
//        public UserModel GetTaiKhoanbyID(string id)
//        {
//            string msgError = "";
//            try
//            {
//                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "getnhanvienbyid", "@id", id);
//                if (!string.IsNullOrEmpty(msgError))
//                    throw new Exception(msgError);
//                return dt.ConvertTo<UserModel>().FirstOrDefault();
//            }
//            catch (Exception ex)
//            {
//                throw ex;
//            }
//        }
//        public int CheckLogin(CheckLoginModel model)
//        {
//            string msgError = "";
//            try
//            {
//                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_check_login",
//                "@TenTaiKhoan", model.TenTaiKhoan,
//                "@MatKhau", model.MatKhau);

//                if (int.TryParse(result.ToString(), out int accountType))
//                {
//                    return accountType;
//                }

//                throw new Exception("Không thể xác định loại tài khoản!");
//            }
//            catch (Exception ex)
//            {
//                throw ex;
//            }
//        }
//        public bool Create(UserModel model)
//        {
//            string msgError = "";
//            try
//            {
//                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_taikhoan_create",
//                "@LoaiTaiKhoan", model.LoaiTaiKhoan,
//                "@TenTaiKhoan", model.TenTaiKhoan,
//                "@MatKhau", model.MatKhau,
//                "@Email", model.Email);
//                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
//                {
//                    throw new Exception(Convert.ToString(result) + msgError);
//                }
//                return true;
//            }
//            catch (Exception ex)
//            {
//                throw ex;
//            }
//        }
//        public List<UserModel> GetAll()
//        {
//            string msgError = "";
//            try
//            {
//                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taikhoan_select_all");
//                if (!string.IsNullOrEmpty(msgError))
//                    throw new Exception(msgError);
//                return dt.ConvertTo<UserModel>().ToList();
//            }
//            catch (Exception ex)
//            {
//                throw ex;
//            }
//        }
//        public bool Update(UserModel model)
//        {
//            string msgError = "";
//            try
//            {
//                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_taikhoan_update",
//                "@MaTK", model.MaTaiKhoan,
//                "@LoaiTaiKhoan", model.LoaiTaiKhoan,
//                "@TenTaiKhoan", model.TenTaiKhoan,
//                "@MatKhau", model.MatKhau,
//                "@Email", model.Email);
//                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
//                {
//                    throw new Exception(Convert.ToString(result) + msgError);
//                }
//                return true;
//            }
//            catch (Exception ex)
//            {
//                throw ex;
//            }
//        }
//        public bool Delete(string Id)
//        {
//            string msgError = "";
//            try
//            {
//                var result = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taikhoan_delete",
//                     "@MaTK", Id);
//                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
//                {
//                    throw new Exception(Convert.ToString(result) + msgError);
//                }
//                return true;
//            }
//            catch (Exception ex)
//            {
//                throw ex;
//            }
//        }

//    }
//}
