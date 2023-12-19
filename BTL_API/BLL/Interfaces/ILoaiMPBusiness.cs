﻿using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface ILoaiMPBusiness
    {
        LoaiMyPhamModel GetLoaiMyPhambyID(string id);
        bool Create(LoaiMyPhamModel model);
        bool Update(LoaiMyPhamModel model);
        bool Delete(string id);
        bool DeleteS(LoaiMyPhamModel_deletes model);
        public List<LoaiMyPhamModel> Search(int pageIndex, int pageSize, out long total, string tenloai_mp, string motaloai_mp);
    }
}