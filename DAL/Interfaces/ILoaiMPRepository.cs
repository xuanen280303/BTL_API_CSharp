using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface ILoaiMPRepository
    {
        LoaiMyPhamModel GetLoaiMyPhambyID(string id);
        bool Create(LoaiMyPhamModel model);
        bool Update(LoaiMyPhamModel model);
    }
}
