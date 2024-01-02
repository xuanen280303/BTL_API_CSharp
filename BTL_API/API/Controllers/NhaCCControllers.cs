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
    public class NhaCCControllers : ControllerBase
    {
        private INhaCCBusiness _nhaccBusiness;
        public NhaCCControllers(INhaCCBusiness nhaccBusiness)
        {
            _nhaccBusiness = nhaccBusiness;
        }

        [Route("get-nhacc-id/{id}")]
        [HttpGet]
        public NhaCCModel GetNhaCCbyID(string id)
        {
            return _nhaccBusiness.GetNhaCCbyID(id);
        }

        [Route("create-nhacc")]
        [HttpPost]
        public NhaCCModel CreateItem([FromBody] NhaCCModel model)
        {
            _nhaccBusiness.Create(model);
            return model;
        }

        [Route("update-nhacc")]
        [HttpPost]
        public NhaCCModel UpdateItem([FromBody] NhaCCModel model)
        {
            _nhaccBusiness.Update(model);
            return model;
        }

        [Route("delete-nhacc/{id}")]
        [HttpDelete]
        public bool Delete(string id)
        {
            return _nhaccBusiness.Delete(id);
        }

        [Route("deleteS-nhacc")]
        [HttpPost]
        public NhaCCModel_deletes DeleteS([FromBody] NhaCCModel_deletes model)
        {
            _nhaccBusiness.DeleteS(model);
            return model;
        }

        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string ten_ncc = "";
                if (formData.Keys.Contains("ten_ncc") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_ncc"]))) { ten_ncc = Convert.ToString(formData["ten_ncc"]); }
                string dia_chincc = "";
                if (formData.Keys.Contains("dia_chincc") && !string.IsNullOrEmpty(Convert.ToString(formData["dia_chincc"]))) { dia_chincc = Convert.ToString(formData["dia_chincc"]); }
                long total = 0;
                var data = _nhaccBusiness.Search(page, pageSize, out total, ten_ncc, dia_chincc);
                return Ok(
                    new
                    {
                        TotalItems = total,
                        Data = data,
                        Page = page,
                        PageSize = pageSize
                    }
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}