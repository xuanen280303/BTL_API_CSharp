using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using API.Models;

namespace API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class LoaiMPControllers : ControllerBase
    {
        private ILoaiMPBusiness _loaimyPhamBusiness;
        public LoaiMPControllers(ILoaiMPBusiness loaimyPhamBusiness)
        {
            _loaimyPhamBusiness = loaimyPhamBusiness;
        }

        [Route("get-loaimypham-id/{id}")]
        [HttpGet]
        public LoaiMyPham GetLoaiMyPhambyID(string id)
        {
            return _loaimyPhamBusiness.GetLoaiMyPhambyID(id);
        }

        [Route("create-loaimypham")]
        [HttpPost]
        public LoaiMyPham CreateItem([FromBody] LoaiMyPham model)
        {
            _loaimyPhamBusiness.Create(model);
            return model;
        }

        [Route("update-loaimypham")]
        [HttpPost]
        public LoaiMyPham UpdateItem([FromBody] LoaiMyPham model)
        {
            _loaimyPhamBusiness.Update(model);
            return model;
        }
    }
}
