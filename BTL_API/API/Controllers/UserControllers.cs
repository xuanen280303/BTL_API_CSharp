﻿using Microsoft.AspNetCore.Mvc;
using BLL;
using DTO;
using BLL.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace API_ADMIN.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private IUserBusiness _userBusiness;
        public UserController(IUserBusiness userBusiness)
        {
            _userBusiness = userBusiness;
        }
        [AllowAnonymous]
        [HttpPost("login")]
        public IActionResult Login([FromBody] AuthenticateModel model)
        {
            var user = _userBusiness.Login(model.Username, model.Password);
            if (user == null)
                return BadRequest(new { message = "Tài khoản hoặc mật khẩu không đúng!" });
            return Ok(new { taikhoan = user.TenTaiKhoan, email = user.Email, token = user.token });
        }       
        [Route("get-taikhoan-id/{id}")]
        [HttpGet]
        public UserModel GetTaiKhoanbyID(string id)
        {
            return _userBusiness.GetTaiKhoanbyID(id);
        }
        [Route("Select-all-taikhoan")]
        [HttpGet]
        public List<UserModel> GetAll()
        {
            return _userBusiness.GetAll();
        }
        [Route("create-taikhoan")]
        [HttpPost]
        public UserModel CreateItem([FromBody] UserModel model)
        {
            _userBusiness.Create(model);
            return model;
        }
        [Route("check-login")]
        [HttpPost]
        public CheckLoginModel CheckLogin([FromBody] CheckLoginModel model)
        {
            _userBusiness.CheckLogin(model);
            return model;
        }
        [Route("update-taikhoan")]
        [HttpPost]
        public UserModel UpdateItem([FromBody] UserModel model)
        {
            _userBusiness.Update(model);
            return model;
        }
        [Route("delete-taikhoan/{id}")]
        [HttpDelete]
        public bool DeleteKH(string id)
        {
            return _userBusiness.Delete(id);
        }
        [Route("deleteS-taikhoan")]
        [HttpPost]
        public TaiKhoanModel_deletes DeleteS([FromBody] TaiKhoanModel_deletes model)
        {
            _userBusiness.DeleteS(model);
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
                int maloaitk = 0;
                if (formData.Keys.Contains("maloaitk")) { maloaitk = int.Parse(formData["maloaitk"].ToString()); }
                string ten_tk = "";
                if (formData.Keys.Contains("ten_tk") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_tk"]))) { ten_tk = Convert.ToString(formData["ten_tk"]); }
                string email = "";
                if (formData.Keys.Contains("email") && !string.IsNullOrEmpty(Convert.ToString(formData["email"]))) { email = Convert.ToString(formData["email"]); }
                long total = 0;
                var data = _userBusiness.Search(page, pageSize, out total, maloaitk, ten_tk, email);
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

        [Route("Upload")]
        [HttpPut]
        public async Task<IActionResult> Upload(IFormFile file)
        {
            try
            {
                if (file.Length > 0)
                {
                    string filePath = $"Upload/{file.FileName.Replace("-", "_").Replace("%", "")}";
                    var fullPath = _userBusiness.CreatePathFile(filePath);
                    using (var fileStream = new FileStream(fullPath, FileMode.Create))
                    {
                        await file.CopyToAsync(fileStream);
                    }
                    return Ok(new { filePath });
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, "Không thể upload tệp");
            }
        }
    }
}
