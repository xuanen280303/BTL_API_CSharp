using API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface INhaCCRepository
    {
        NhaCC GetNhaCCbyID(string id);
        bool Create(NhaCC model);
    }
}
