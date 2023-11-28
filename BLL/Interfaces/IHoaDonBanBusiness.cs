﻿using API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface IHoaDonBanBusiness
    {
        HoaDonBan GetHoaDonBanbyID(string id);
        bool Create(HoaDonBan model);
        bool Update(HoaDonBan model);
    }
}
