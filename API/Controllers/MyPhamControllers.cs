using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

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
        public MyPhamModel GetMyPhambyID(string id)
        {
            return _myPhamBusiness.GetMyPhambyID(id);
        }

        [Route("create-mypham")]
        [HttpPost]
        public MyPhamModel CreateItem([FromBody] MyPhamModel model)
        {
            _myPhamBusiness.Create(model);
            return model;
        }

        [Route("update-mypham")]
        [HttpPost]
        public MyPhamModel UpdateItem([FromBody] MyPhamModel model)
        {
            _myPhamBusiness.Update(model);
            return model;
        }

        [Route("delete-mypham/{id}")]
        [HttpDelete]
        public bool Delete(string id)
        {
            return _myPhamBusiness.Delete(id);
        }

        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string ten_mp = "";
                if (formData.Keys.Contains("ten_mp") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_mp"]))) { ten_mp = Convert.ToString(formData["ten_mp"]); }
                string mota_mp = "";
                if (formData.Keys.Contains("mota_mp ") && !string.IsNullOrEmpty(Convert.ToString(formData["mota_mp "]))) { mota_mp = Convert.ToString(formData["mota_mp "]); }
                long total = 0;
                var data = _myPhamBusiness.Search(page, pageSize, out total, ten_mp, mota_mp);
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
