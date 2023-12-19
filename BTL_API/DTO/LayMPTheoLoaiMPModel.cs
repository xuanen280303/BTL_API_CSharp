using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class LayMPTheoLoaiMPModel
    {
        public int MaLoaiMP { get; set; }
        public string TenLoaiMP { get; set; }
        public List<MyPhamModel> list_json_loaimypham { get; set; }
    }
}
