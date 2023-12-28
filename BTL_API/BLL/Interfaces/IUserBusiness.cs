using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface IUserBusiness
    {
        UserModel2 Login(string taikhoan, string matkhau);
        UserModel GetTaiKhoanbyID(string id);
        List<UserModel> GetAll();
        int CheckLogin(CheckLoginModel model);
        bool Create(UserModel model);
        bool Update(UserModel model);
        bool Delete(string Id);
        bool DeleteS(TaiKhoanModel_deletes model);
        public List<UserModel1> Search(int pageIndex, int pageSize, out long total, int maloaitk, string ten_tk, string email);
        public string CreatePathFile(string RelativePathFileName);
    }
}
