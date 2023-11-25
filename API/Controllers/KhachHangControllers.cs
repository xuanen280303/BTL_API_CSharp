using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using API.Models;

namespace API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class KhachHangControllers : ControllerBase
    {
        private IKhachHangBusiness _khachHangBusiness;
        public KhachHangControllers(IKhachHangBusiness khachHangBusiness)
        {
            _khachHangBusiness = khachHangBusiness;
        }

        [Route("get-khachhang-id/{id}")]
        [HttpGet]
        public KhachHang GetKhachHangbyID(string id)
        {
            return _khachHangBusiness.GetKhachHangbyID(id);
        }

        [Route("create-khachhang")]
        [HttpPost]
        public KhachHang CreateItem([FromBody] KhachHang model)
        {
            _khachHangBusiness.Create(model);
            return model;
        }

        [Route("update-khachhang")]
        [HttpPost]
        public KhachHang UpdateItem([FromBody] KhachHang model)
        {
            _khachHangBusiness.Update(model);
            return model;
        }

    }
}
