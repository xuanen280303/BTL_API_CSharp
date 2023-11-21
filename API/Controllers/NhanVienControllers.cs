using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using API.Models;

namespace API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class NhanVienControllers : ControllerBase
    {
        private INhanVienBusiness _nhanVienBusiness;
       public NhanVienControllers(INhanVienBusiness nhanVienBusiness)
        {
            _nhanVienBusiness = nhanVienBusiness;
        }

        [Route("get-nhanvien-id/{id}")]
        [HttpGet]
        public NhanVien GetNhanVienbyID(string id)
        {
            return _nhanVienBusiness.GetNhanVienbyID(id);
        }

        [Route("create-nhanvien")]
        [HttpPost]
        public NhanVien CreateItem([FromBody] NhanVien model)
        {
            _nhanVienBusiness.Create(model);
            return model;
        }
    }
}
