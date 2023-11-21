using System;
using System.Collections.Generic;

namespace API.Models
{
    public partial class User
    {
        public string UserId { get; set; } = null!;
        public string Password { get; set; } = null!;
        public int? Permission { get; set; }
    }
}
