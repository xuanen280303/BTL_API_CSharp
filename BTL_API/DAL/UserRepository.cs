﻿using DTO;
using DAL.Helper.Interfaces;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

namespace DAL
{
    public class UserRepository : IUserRepository
    {
        private IDatabaseHelper _dbHelper;
        private IConfiguration _configuration;

        public UserRepository(IDatabaseHelper dbHelper, IConfiguration configuration)
        {
            _dbHelper = dbHelper;
            _configuration = configuration;
        }
        public List<UserModel> GetAll()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taikhoan_select_all");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<UserModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public int CheckLogin(CheckLoginModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_check_login",
                "@TenTaiKhoan", model.TenTaiKhoan,
                "@MatKhau", model.MatKhau);

                if (int.TryParse(result.ToString(), out int accountType))
                {
                    return accountType;
                }

                throw new Exception("Không thể xác định loại tài khoản!");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public UserModel GetTaiKhoanbyID(string id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "gettaikhoanbyid",
                     "@MaTK", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<UserModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Create(UserModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_taikhoan_create",
                "@LoaiTaiKhoan", model.LoaiTaiKhoan,
                "@TenTaiKhoan", model.TenTaiKhoan,
                "@MatKhau", model.MatKhau,
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

        public bool Update(UserModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_taikhoan_update",
                "@MaTK", model.MaTaiKhoan,
                "@LoaiTaiKhoan", model.LoaiTaiKhoan,
                "@TenTaiKhoan", model.TenTaiKhoan,
                "@MatKhau", model.MatKhau,
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

        public bool Delete(string Id)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taikhoan_delete",
                     "@MaTK", Id);
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
        public bool DeleteS(TaiKhoanModel_deletes model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_taikhoan_deleteS",
                "@list_json_mataikhoan", model.list_json_mataikhoan != null ? MessageConvert.SerializeObject(model.list_json_mataikhoan) : null);
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

        public List<UserModel1> Search(int pageIndex, int pageSize, out long total, int maloaitk, string ten_tk, string email)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_taikhoan_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@maloaitk", maloaitk,
                    "@ten_tk", ten_tk,
                    "@email", email);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<UserModel1>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public UserModel2 Login(string taikhoan, string matkhau)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_login",
                     "@taikhoan", taikhoan,
                     "@matkhau", matkhau
                     );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<UserModel2>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string CreatePathFile(string RelativePathFileName)
        {
            try
            {
                string serverRootPathFolder = _configuration["AppSettings:WEB_SERVER_FULL_PATH"].ToString();
                string fullPathFile = $@"{serverRootPathFolder}\{RelativePathFileName}";
                string fullPathFolder = System.IO.Path.GetDirectoryName(fullPathFile);
                if (!Directory.Exists(fullPathFolder))
                    Directory.CreateDirectory(fullPathFolder);
                return fullPathFile;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

    }
}
