using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;
using Microsoft.AspNetCore.Authorization;

namespace API_ADMIN.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class LoaiTaiKhoanControllers : ControllerBase
    {
        private ILoaiTaiKhoanBusiness _loaitaiKhoanBusiness;
        public LoaiTaiKhoanControllers(ILoaiTaiKhoanBusiness loaitaiKhoanBusiness)
        {
            _loaitaiKhoanBusiness = loaitaiKhoanBusiness;
        }

        [Route("get-loaitaikhoan-id/{id}")]
        [HttpGet]
        public LoaiTaiKhoanModel GetLoaiTaiKhoanbyID(string id)
        {
            return _loaitaiKhoanBusiness.GetLoaiTaiKhoanbyID(id);
        }

        [Route("create-loaitaikhoan")]
        [HttpPost]
        public LoaiTaiKhoanModel CreateItem([FromBody] LoaiTaiKhoanModel model)
        {
            _loaitaiKhoanBusiness.Create(model);
            return model;
        }

        [Route("update-loaitaikhoan")]
        [HttpPost]
        public LoaiTaiKhoanModel UpdateItem([FromBody] LoaiTaiKhoanModel model)
        {
            _loaitaiKhoanBusiness.Update(model);
            return model;
        }

        [Route("delete-loaitaikhoan/{id}")]
        [HttpDelete]
        public bool Delete(string id)
        {
            return _loaitaiKhoanBusiness.Delete(id);
        }

        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string tenloai_tk = "";
                if (formData.Keys.Contains("tenloai_tk") && !string.IsNullOrEmpty(Convert.ToString(formData["tenloai_tk"]))) { tenloai_tk = Convert.ToString(formData["tenloai_tk"]); }
                string motaloai_tk = "";
                if (formData.Keys.Contains("motaloai_tk") && !string.IsNullOrEmpty(Convert.ToString(formData["motaloai_tk"]))) { motaloai_tk = Convert.ToString(formData["motaloai_tk"]); }
                long total = 0;
                var data = _loaitaiKhoanBusiness.Search(page, pageSize, out total, tenloai_tk, motaloai_tk);
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
