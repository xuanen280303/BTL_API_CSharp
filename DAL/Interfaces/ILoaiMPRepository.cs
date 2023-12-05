﻿using DTO;
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
        bool Delete(string id);
        public List<LoaiMyPhamModel> Search(int pageIndex, int pageSize, out long total, string tenloai_mp, string motaloai_mp);
    }
}
