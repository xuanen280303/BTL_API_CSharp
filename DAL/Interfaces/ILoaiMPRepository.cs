using API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface ILoaiMPRepository
    {
        LoaiMyPham GetLoaiMyPhambyID(string id);
        bool Create(LoaiMyPham model);
        bool Update(LoaiMyPham model);
    }
}
