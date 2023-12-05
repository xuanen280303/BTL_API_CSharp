﻿using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;

namespace API.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class LoaiMPControllers : ControllerBase
    {
        private ILoaiMPBusiness _loaimyPhamBusiness;
        public LoaiMPControllers(ILoaiMPBusiness loaimyPhamBusiness)
        {
            _loaimyPhamBusiness = loaimyPhamBusiness;
        }

        [Route("get-loaimypham-id/{id}")]
        [HttpGet]
        public LoaiMyPhamModel GetLoaiMyPhambyID(string id)
        {
            return _loaimyPhamBusiness.GetLoaiMyPhambyID(id);
        }

        [Route("create-loaimypham")]
        [HttpPost]
        public LoaiMyPhamModel CreateItem([FromBody] LoaiMyPhamModel model)
        {
            _loaimyPhamBusiness.Create(model);
            return model;
        }

        [Route("update-loaimypham")]
        [HttpPost]
        public LoaiMyPhamModel UpdateItem([FromBody] LoaiMyPhamModel model)
        {
            _loaimyPhamBusiness.Update(model);
            return model;
        }

        [Route("delete-mypham/{id}")]
        [HttpDelete]
        public bool Delete(string id)
        {
            return _loaimyPhamBusiness.Delete(id);
        }

        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string tenloai_mp = "";
                if (formData.Keys.Contains("tenloai_mp") && !string.IsNullOrEmpty(Convert.ToString(formData["tenloai_mp"]))) { tenloai_mp = Convert.ToString(formData["tenloai_mp"]); }
                string motaloai_mp = "";
                if (formData.Keys.Contains("motaloai_mp ") && !string.IsNullOrEmpty(Convert.ToString(formData["motaloai_mp "]))) { motaloai_mp = Convert.ToString(formData["motaloai_mp "]); }
                long total = 0;
                var data = _loaimyPhamBusiness.Search(page, pageSize, out total, tenloai_mp, motaloai_mp);
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
