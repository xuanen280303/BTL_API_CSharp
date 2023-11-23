using API.Models;
using BLL.Interfaces;
using DAL;
using DAL.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class NhaCCBusiness : INhaCCBusiness
    {
        private INhaCCRepository _nhacc;

        public NhaCCBusiness(INhaCCRepository nhacc)
        {
            _nhacc = nhacc;
        }
        public NhaCC GetNhaCCbyID(string id)
        {
            return _nhacc.GetNhaCCbyID(id);
        }
        public bool Create(NhaCC model)
        {
            return _nhacc.Create(model);
        }
    }
}