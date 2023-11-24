﻿using API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface INhanVienBusiness
    {
        NhanVien GetNhanVienbyID(string id);
        bool Create(NhanVien model);
        bool Update(NhanVien model);
        public List<NhanVien> Search(int pageIndex, int pageSize, out long total, string ten_nv, string dia_chinv);
    }
}