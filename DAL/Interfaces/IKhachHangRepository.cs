using API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface IKhachHangRepository
    {
        KhachHang GetKhachHangbyID(string id);
        bool Create(KhachHang model);
        bool Update(KhachHang model);
    }
}
