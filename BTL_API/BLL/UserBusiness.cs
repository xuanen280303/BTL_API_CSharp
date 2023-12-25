using BLL.Interfaces;
using DAL;
using DAL.Interfaces;
using DTO;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Net.Sockets;
using System.Security.Claims;
using System.Text;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BLL
{
    public class UserBusiness : IUserBusiness
    {
        private IUserRepository _taikhoan;
        private string secret;

        public UserBusiness(IUserRepository taikhoan, IConfiguration configuration)
        {
            _taikhoan = taikhoan;
            secret = configuration["AppSettings:Secret"];
        }
        public int CheckLogin(CheckLoginModel model)
        {
            return _taikhoan.CheckLogin(model);
        }
        public UserModel GetTaiKhoanbyID(string id)
        {
            return _taikhoan.GetTaiKhoanbyID(id);
        }
        public List<UserModel> GetAll()
        {
            return _taikhoan.GetAll();
        }
        public bool Create(UserModel model)
        {
            return _taikhoan.Create(model);
        }    
        public bool Update(UserModel model)
        {
            return _taikhoan.Update(model);
        }
        public bool Delete(string Id)
        {
            return _taikhoan.Delete(Id);
        }
        public bool DeleteS(TaiKhoanModel_deletes model)
        {
            return _taikhoan.DeleteS(model);
        }
        public UserModel2 Login(string taikhoan, string matkhau)
        {
            var user = _taikhoan.Login(taikhoan, matkhau);
            if (user == null)
                return null;
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.TenTaiKhoan.ToString()),
                    new Claim(ClaimTypes.Email, user.Email.ToString()),
                 new Claim(ClaimTypes.DenyOnlyWindowsDeviceGroup, user.MatKhau.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.Aes128CbcHmacSha256)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            user.token = tokenHandler.WriteToken(token);
            return user;
        }




        public List<UserModel1> Search(int pageIndex, int pageSize, out long total, int maloaitk, string ten_tk, string email)
        {
            return _taikhoan.Search(pageIndex, pageSize, out total, maloaitk, ten_tk, email);
        }
    }
}
