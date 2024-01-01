using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

namespace API_USER.Controllers
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

        [Route("Select-myphamtheochucnang/{id}")]
        [HttpGet]
        public List<MyPhamTheoChucNang> MyPhamTheoChucNang(int id)
        {
            return _myPhamBusiness.MyPhamTheoChucNang(id);
        }

        [Route("GetMPTheoLoaiMP")]
        [HttpGet]
        public List<LayMPTheoLoaiMPModel> GetMPTheoLoaiMP()
        {
            return _myPhamBusiness.GetMPTheoLoaiMP();
        }

        [Route("search-mypham")]
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

        [Route("search-loaimypham")]
        [HttpPost]
        public IActionResult Searchlmp([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string maloai_mp = "";
                if (formData.Keys.Contains("maloai_mp") && !string.IsNullOrEmpty(Convert.ToString(formData["maloai_mp"]))) { maloai_mp = Convert.ToString(formData["maloai_mp"]); }
                long total = 0;
                var data = _myPhamBusiness.Searchlmp(page, pageSize, out total, maloai_mp);
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
