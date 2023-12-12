using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

namespace API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class KhachHangControllers : ControllerBase
    {
        private IKhachHangBusiness _khachHangBusiness;
        public KhachHangControllers(IKhachHangBusiness khachHangBusiness)
        {
            _khachHangBusiness = khachHangBusiness;
        }

        [Route("get-khachhang-id/{id}")]
        [HttpGet]
        public KhachHangModel GetKhachHangbyID(string id)
        {
            return _khachHangBusiness.GetKhachHangbyID(id);
        }

        [Route("create-khachhang")]
        [HttpPost]
        public KhachHangModel CreateItem([FromBody] KhachHangModel model)
        {
            _khachHangBusiness.Create(model);
            return model;
        }

        [Route("update-khachhang")]
        [HttpPost]
        public KhachHangModel UpdateItem([FromBody] KhachHangModel model)
        {
            _khachHangBusiness.Update(model);
            return model;
        }
        [Route("delete-khachhang/{id}")]
        [HttpDelete]
        public bool Delete(string id)
        {
            return _khachHangBusiness.Delete(id);
        }
        [Route("deleteS-khachhang")]
        [HttpPost]
        public KhachHangModel_deletes DeleteS([FromBody] KhachHangModel_deletes model)
        {
            _khachHangBusiness.DeleteS(model);
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
                string ten_kh = "";
                if (formData.Keys.Contains("ten_nv") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_kh"]))) { ten_kh = Convert.ToString(formData["ten_kh"]); }
                string dia_chikh = "";
                if (formData.Keys.Contains("dia_chikh") && !string.IsNullOrEmpty(Convert.ToString(formData["dia_chikh"]))) { dia_chikh = Convert.ToString(formData["dia_chikh"]); }
                long total = 0;
                var data = _khachHangBusiness.Search(page, pageSize, out total, ten_kh, dia_chikh);
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
