﻿using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface IKhachHangBusiness
    {
        KhachHangModel GetKhachHangbyID(string id);
        bool Create(KhachHangModel model);
        bool Update(KhachHangModel model);
        bool Delete(string id);
        bool DeleteS(KhachHangModel_deletes model);
        public List<KhachHangModel> Search(int pageIndex, int pageSize, out long total, string ten_kh, string dia_chikh);
    }
}
