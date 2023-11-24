using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using API.Models;

namespace API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class MyPhamControllers : ControllerBase
    {
        private IMyPhamBusiness _myPhamBusiness;
        public MyPhamControllers(IMyPhamBusiness myPhamBusiness)
        {
            _myPhamBusiness = myPhamBusiness;
        }

        [Route("get-mypham-id/{id}")]
        [HttpGet]
        public MyPham GetMyPhambyID(string id)
        {
            return _myPhamBusiness.GetMyPhambyID(id);
        }

        [Route("create-mypham")]
        [HttpPost]
        public MyPham CreateItem([FromBody] MyPham model)
        {
            _myPhamBusiness.Create(model);
            return model;
        }
    }
}
