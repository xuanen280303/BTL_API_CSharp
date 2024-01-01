using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;
using Microsoft.AspNetCore.Authorization;

namespace API.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class HoaDonBanControllers : ControllerBase
    {
        private IHoaDonBanBusiness _hoadonBanBusiness;
        public HoaDonBanControllers(IHoaDonBanBusiness hoadonBanBusiness)
        {
            _hoadonBanBusiness = hoadonBanBusiness;
        }

        [Route("get-hoadonban-id/{id}")]
        [HttpGet]
        public getbyidHoaDonBanModel GetHoaDonBanbyID(int id)
        {
            return _hoadonBanBusiness.GetHoaDonBanbyID(id);
        }
        [Route("Select-all-hoadon")]
        [HttpGet]
        public List<HoaDonBanModel> GetAll()
        {
            return _hoadonBanBusiness.GetAll();
        }
        [Route("create-hoadon")]
        [HttpPost]
        public HoaDonBanModel CreateItem([FromBody] HoaDonBanModel model)
        {
            _hoadonBanBusiness.Create(model);
            return model;
        }
        [Route("update-hoadon")]
        [HttpPost]
        public HoaDonBanModel Update([FromBody] HoaDonBanModel model)
        {
            _hoadonBanBusiness.Update(model);
            return model;
        }
        [Route("delete/{id}")]
        [HttpDelete]
        public bool Delete(string id)
        {
            return _hoadonBanBusiness.Delete(id);
        }
        [Route("searchHDB")]
        [HttpPost]
        public IActionResult SearchHDB([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                int ma_hdb = 0;
                if (formData.Keys.Contains("ma_hdb")) { ma_hdb = int.Parse(formData["ma_hdb"].ToString()); }
                string ten_kh = "";
                if (formData.Keys.Contains("ten_kh") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_kh"]))) { ten_kh = Convert.ToString(formData["ten_kh"]); }
                long total = 0;
                var data = _hoadonBanBusiness.SearchHDB(page, pageSize, out total, ma_hdb, ten_kh);
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

