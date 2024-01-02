using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;
using Microsoft.AspNetCore.Authorization;

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
        public HoaDonNhapModel GetHoaDonNhapbyID(string id)
        {
            return _hoadonNhapBusiness.GetHoaDonNhapbyID(id);
        }

        [Route("Select-all-hoadonnhap")]
        [HttpGet]
        public List<HoaDonNhapModel> GetAll()
        {
            return _hoadonNhapBusiness.GetAll();
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
