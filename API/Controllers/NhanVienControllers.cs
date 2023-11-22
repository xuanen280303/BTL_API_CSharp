using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using API.Models;

namespace API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class NhanVienControllers : ControllerBase
    {
        private INhanVienBusiness _nhanVienBusiness;
        public NhanVienControllers(INhanVienBusiness nhanVienBusiness)
        {
            _nhanVienBusiness = nhanVienBusiness;
        }

        [Route("get-nhanvien-id/{id}")]
        [HttpGet]
        public NhanVien GetNhanVienbyID(string id)
        {
            return _nhanVienBusiness.GetNhanVienbyID(id);
        }

        [Route("create-nhanvien")]
        [HttpPost]
        public NhanVien CreateItem([FromBody] NhanVien model)
        {
            _nhanVienBusiness.Create(model);
            return model;
        }

        [Route("update-nhanvien")]
        [HttpPost]
        public NhanVien UpdateItem([FromBody] NhanVien model)
        {
            _nhanVienBusiness.Update(model);
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
                string ten_nv = "";
                if (formData.Keys.Contains("ten_nv") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_nv"]))) { ten_nv = Convert.ToString(formData["ten_nv"]); }
                string dia_chinv = "";
                if (formData.Keys.Contains("dia_chinv") && !string.IsNullOrEmpty(Convert.ToString(formData["dia_chinv"]))) { dia_chinv = Convert.ToString(formData["dia_chinv"]); }
                long total = 0;
                var data = _nhanVienBusiness.Search(page, pageSize, out total, ten_nv, dia_chinv);
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
