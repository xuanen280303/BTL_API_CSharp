using System;
using System.Collections.Generic;

namespace GateWay.Models
{
    public partial class User
    {
        public string UserId { get; set; } = null!;
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string? EmailUser { get; set; }
        public int? Permission { get; set; }
    }
}
