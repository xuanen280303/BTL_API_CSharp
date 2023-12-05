using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

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
        public HoaDonBanModel GetHoaDonBanbyID(string id)
        {
            return _hoadonBanBusiness.GetHoaDonBanbyID(id);
        }

        [Route("create-hoadonban")]
        [HttpPost]
        public HoaDonBanModel CreateItem([FromBody] HoaDonBanModel model)
        {
            _hoadonBanBusiness.Create(model);
            return model;
        }
    }
}
