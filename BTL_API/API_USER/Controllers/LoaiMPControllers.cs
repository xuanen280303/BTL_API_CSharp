using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

namespace API_USER.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class LoaiMPControllers : ControllerBase
    {
        private ILoaiMPBusiness _loaimyPhamBusiness;
        private string _path;
        private IWebHostEnvironment _env;
        public LoaiMPControllers(ILoaiMPBusiness loaimyPhamBusiness, IConfiguration configuration, IWebHostEnvironment env)
        {
            _loaimyPhamBusiness = loaimyPhamBusiness;
            _path = configuration["AppSettings:PATH"];
            _env = env;
        }

        [Route("get-loaimypham-id/{id}")]
        [HttpGet]
        public LoaiMyPhamModel GetLoaiMyPhambyID(string id)
        {
            return _loaimyPhamBusiness.GetLoaiMyPhambyID(id);
        }

        [Route("search-loaimp")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string tenloai_mp = "";
                if (formData.Keys.Contains("tenloai_mp") && !string.IsNullOrEmpty(Convert.ToString(formData["tenloai_mp"]))) { tenloai_mp = Convert.ToString(formData["tenloai_mp"]); }
                string anh_dai_dien = "";
                if (formData.Keys.Contains("anh_dai_dien") && !string.IsNullOrEmpty(Convert.ToString(formData["anh_dai_dien"]))) { anh_dai_dien = Convert.ToString(formData["anh_dai_dien"]); }
                string motaloai_mp = "";
                if (formData.Keys.Contains("motaloai_mp ") && !string.IsNullOrEmpty(Convert.ToString(formData["motaloai_mp "]))) { motaloai_mp = Convert.ToString(formData["motaloai_mp "]); }
                long total = 0;
                var data = _loaimyPhamBusiness.Search(page, pageSize, out total, tenloai_mp, anh_dai_dien, motaloai_mp);
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
