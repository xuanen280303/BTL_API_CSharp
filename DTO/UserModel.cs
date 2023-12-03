using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO.Models
{
    public class UserModel
    {
        public string UserID { get; set; } 
        public string Password { get; set; } 
        public int Permission { get; set; }
    }
}
