using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

namespace API_USER.Controllers
{
    public class HoaDonBanControllers : ControllerBase
    {
        private IHoaDonBanBusiness _hoadonBanBusiness;
        private string _path;
        private IWebHostEnvironment _env;
        public HoaDonBanControllers(IHoaDonBanBusiness hoadonBanBusiness, IConfiguration configuration, IWebHostEnvironment env)
        {
            _hoadonBanBusiness = hoadonBanBusiness;
            _path = configuration["AppSettings:PATH"];
            _env = env;
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
