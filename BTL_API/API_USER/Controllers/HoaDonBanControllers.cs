using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

namespace API_USER.Controllers
{

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
        public getbyidHoaDonBanModel GetHoaDonBanbyID(int id)
        {
            return _hoadonBanBusiness.GetHoaDonBanbyID(id);
        }

        [Route("create-hoadon")]
        [HttpPost]
        public HoaDonBanModel CreateItem([FromBody] HoaDonBanModel model)
        {
            _hoadonBanBusiness.Create(model);
            return model;
        }
    }
}
