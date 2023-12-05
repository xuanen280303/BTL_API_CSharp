using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

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
        public LoaiMyPhamModel GetLoaiMyPhambyID(string id)
        {
            return _loaimyPhamBusiness.GetLoaiMyPhambyID(id);
        }

        [Route("create-loaimypham")]
        [HttpPost]
        public LoaiMyPhamModel CreateItem([FromBody] LoaiMyPhamModel model)
        {
            _loaimyPhamBusiness.Create(model);
            return model;
        }

        [Route("update-loaimypham")]
        [HttpPost]
        public LoaiMyPhamModel UpdateItem([FromBody] LoaiMyPhamModel model)
        {
            _loaimyPhamBusiness.Update(model);
            return model;
        }
    }
}
