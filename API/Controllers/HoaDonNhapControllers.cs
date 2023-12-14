using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

namespace API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class HoaDonNhapControllers : ControllerBase
    {
        private IHoaDonNhapBusiness _hoadonNhapBusiness;
        public HoaDonNhapControllers(IHoaDonNhapBusiness hoadonNhapBusiness)
        {
            _hoadonNhapBusiness = hoadonNhapBusiness;
        }

        [Route("get-hoadonnhap-id/{id}")]
        [HttpGet]
        public HoaDonNhapModel GetHoaDonBanbyID(string id)
        {
            return _hoadonNhapBusiness.GetHoaDonNhapbyID(id);
        }

        [Route("create-hoadonnhap")]
        [HttpPost]
        public HoaDonNhapModel CreateItem([FromBody] HoaDonNhapModel model)
        {
            _hoadonNhapBusiness.Create(model);
            return model;
        }
    }
}
