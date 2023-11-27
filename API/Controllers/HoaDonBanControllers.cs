using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using API.Models;

namespace API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class HoaDonBanControllers : ControllerBase
    {
        private IHoaDonBanBusiness _hoadonBanBusiness;
        public HoaDonBanControllers(IHoaDonBanBusiness hoadonBanBusiness)
        {
            _hoadonBanBusiness = hoadonBanBusiness;
        }

        [Route("get-hoadonban-id/{id}")]
        [HttpGet]
        public HoaDonBan GetHoaDonBanbyID(string id)
        {
            return _hoadonBanBusiness.GetHoaDonBanbyID(id);
        }

        [Route("create-hoadonban")]
        [HttpPost]
        public HoaDonBan CreateItem([FromBody] HoaDonBan model)
        {
            _hoadonBanBusiness.Create(model);
            return model;
        }
    }
}
