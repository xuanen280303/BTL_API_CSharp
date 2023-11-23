using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using API.Models;

namespace API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class NhaCCControllers : ControllerBase
    {
        private INhaCCBusiness _nhaccBusiness;
        public NhaCCControllers(INhaCCBusiness nhaccBusiness)
        {
            _nhaccBusiness = nhaccBusiness;
        }

        [Route("get-nhacc-id/{id}")]
        [HttpGet]
        public NhaCC GetNhaCCbyID(string id)
        {
            return _nhaccBusiness.GetNhaCCbyID(id);
        }

        [Route("create-nhacc")]
        [HttpPost]
        public NhaCC CreateItem([FromBody] NhaCC model)
        {
            _nhaccBusiness.Create(model);
            return model;
        }
    }
}