using API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface IMyPhamBusiness
    {
        MyPham GetMyPhambyID(string id);
        bool Create(MyPham model);
    }
}
