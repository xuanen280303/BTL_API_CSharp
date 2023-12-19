using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

namespace API_ADMIN.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class CTHDNControllers : ControllerBase
    {
        private ICTHDNBusiness _cthdnBusiness;
        public CTHDNControllers(ICTHDNBusiness cthdnBusiness)
        {
            _cthdnBusiness = cthdnBusiness;
        }
        //[AllowAnonymous]
        [Route("get-by-id/{id}")]
        [HttpGet]
        public CTHDNModel GetDatabyID(string id)
        {
            return _cthdnBusiness.GetCTHDNbyID(id);
        }
        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                int ma_hd = 0;
                if (formData.Keys.Contains("ma_hd")) { ma_hd = int.Parse(formData["ma_hd"].ToString()); }
                int ma_mp = 0;
                if (formData.Keys.Contains("ma_mp")) { ma_mp = int.Parse(formData["ma_mp"].ToString()); }
                long total = 0;
                var data = _cthdnBusiness.Search(page, pageSize, out total, ma_hd, ma_mp);
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
