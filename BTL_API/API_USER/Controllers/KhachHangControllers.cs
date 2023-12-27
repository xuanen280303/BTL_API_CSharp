using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

namespace API_USER.Controllers
{

    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class KhachHangControllers : ControllerBase
    {
        private IKhachHangBusiness _khachHangBusiness;
        private string _path;
        private IWebHostEnvironment _env;
        public KhachHangControllers(IKhachHangBusiness khachHangBusiness, IConfiguration configuration, IWebHostEnvironment env)
        {
            _khachHangBusiness = khachHangBusiness;
            _path = configuration["AppSettings:PATH"];
            _env = env;
        }

        [Route("get-khachhang-id/{id}")]
        [HttpGet]
        public KhachHangModel GetKhachHangbyID(string id)
        {
            return _khachHangBusiness.GetKhachHangbyID(id);
        }

        [Route("create-khachhang")]
        [HttpPost]
        public KhachHangModel CreateItem([FromBody] KhachHangModel model)
        {
            _khachHangBusiness.Create(model);
            return model;
        }

        [Route("update-khachhang")]
        [HttpPost]
        public KhachHangModel UpdateItem([FromBody] KhachHangModel model)
        {
            _khachHangBusiness.Update(model);
            return model;
        }
    }
}
