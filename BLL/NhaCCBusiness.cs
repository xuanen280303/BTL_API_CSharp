using BLL.Interfaces;
using DAL;
using DAL.Interfaces;
using DTO;
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
        public NhaCCModel GetNhaCCbyID(string id)
        {
            return _nhacc.GetNhaCCbyID(id);
        }
        public bool Create(NhaCCModel model)
        {
            return _nhacc.Create(model);
        }
        public bool Update(NhaCCModel model)
        {
            return _nhacc.Update(model);
        }
        public bool Delete(string id)
        {
            return _nhacc.Delete(id);
        }
        public bool DeleteS(NhaCCModel_deletes model)
        {
            return _nhacc.DeleteS(model);
        }
        public List<NhaCCModel> Search(int pageIndex, int pageSize, out long total, string ten_ncc, string dia_chincc)
        {
            return _nhacc.Search(pageIndex, pageSize, out total, ten_ncc, dia_chincc);
        }
    }
}