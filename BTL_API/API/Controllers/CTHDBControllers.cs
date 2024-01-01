﻿using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;
using Microsoft.AspNetCore.Authorization;

namespace API_ADMIN.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class CTHDBControllers : ControllerBase
    {
        private ICTHDBBusiness _cthdbBusiness;
        public CTHDBControllers(ICTHDBBusiness cthdbBusiness)
        {
            _cthdbBusiness = cthdbBusiness;
        }
        //[AllowAnonymous]
        [Route("get-by-id/{id}")]
        [HttpGet]
        public CTHDBModel GetCTHDBbyID(string id)
        {
            return _cthdbBusiness.GetCTHDBbyID(id);
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
                var data = _cthdbBusiness.Search(page, pageSize, out total, ma_hd, ma_mp);
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
