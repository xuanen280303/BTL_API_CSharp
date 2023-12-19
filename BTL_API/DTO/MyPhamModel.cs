﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class MyPhamModel
    {
        public string MaMP { get; set; } 
        public string TenMP { get; set; } 
        public string MaLoaiMP { get; set; }
        public int SLTon { get; set; }
        public string MoTa { get; set; }
        public string GhiChu { get; set; }
    }
    public class MyPhamModel_deletes
    {
        public List<ChiTietMyPhamModel> list_json_mamp { get; set; }
    }
    public class ChiTietMyPhamModel
    {
        public string MaMP { get; set; }
        public string GhiChu { get; set; }
    }
}