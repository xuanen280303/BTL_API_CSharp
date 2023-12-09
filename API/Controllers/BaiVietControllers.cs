using Microsoft.AspNetCore.Mvc;
using BLL;
using DTO;
using BLL.Interfaces;

namespace API_ADMIN.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class BaiVietControllers : ControllerBase
    {
        private IBaiVietBusiness _baiVietBusiness;
        public BaiVietControllers(IBaiVietBusiness baiVietBusiness)
        {
            _baiVietBusiness = baiVietBusiness;
        }

        [Route("get-baiviet-id/{id}")]
        [HttpGet]
        public BaiVietModel GetBaiVietbyID(string id)
        {
            return _baiVietBusiness.GetBaiVietbyID(id);
        }

        [Route("create-baiviet")]
        [HttpPost]
        public BaiVietModel CreateItem([FromBody] BaiVietModel model)
        {
            _baiVietBusiness.Create(model);
            return model;
        }

        [Route("update-baiviet")]
        [HttpPost]
        public BaiVietModel UpdateItem([FromBody] BaiVietModel model)
        {
            _baiVietBusiness.Update(model);
            return model;
        }

        [Route("delete-baiviet/{id}")]
        [HttpDelete]
        public bool Delete(string id)
        {
            return _baiVietBusiness.Delete(id);
        }

        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string tieu_de = "";
                if (formData.Keys.Contains("tieu_de") && !string.IsNullOrEmpty(Convert.ToString(formData["tieu_de"]))) { tieu_de = Convert.ToString(formData["tieu_de"]); }
                string noi_dung = "";
                if (formData.Keys.Contains("noi_dung") && !string.IsNullOrEmpty(Convert.ToString(formData["noi_dung"]))) { noi_dung = Convert.ToString(formData["noi_dung"]); }
                long total = 0;
                var data = _baiVietBusiness.Search(page, pageSize, out total, tieu_de, noi_dung);
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

