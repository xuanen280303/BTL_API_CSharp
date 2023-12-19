using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

namespace API_USER.Controllers
{
    public class BaiVietControllers : ControllerBase
    {
        private IBaiVietBusiness _baiVietBusiness;
        private string _path;
        private IWebHostEnvironment _env;
        public BaiVietControllers(IBaiVietBusiness baiVietBusiness, IConfiguration configuration, IWebHostEnvironment env)
        {
            _baiVietBusiness = baiVietBusiness;
            _path = configuration["AppSettings:PATH"];
            _env = env;
        }

        [Route("get-baiviet-id/{id}")]
        [HttpGet]
        public BaiVietModel GetBaiVietbyID(string id)
        {
            return _baiVietBusiness.GetBaiVietbyID(id);
        }

        [Route("search-baiviet")]
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
