using Microsoft.AspNetCore.Mvc;
using BLL;
using BLL.Interfaces;
using DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace API_USER.Controllers
{
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
            return Ok(new { taikhoan = user.TenTaiKhoan, email = user.Email, token = user.token, loaitaikhoan = user.LoaiTaiKhoan, mataikhoan = user.MaTaiKhoan });
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

        [Route("Upload")]
        [HttpPost]
        public async Task<IActionResult> Upload(IFormFile file)
        {
            try
            {
                if (file.Length > 0)
                {
                    string filePath = $"upload/{file.FileName.Replace("-", "_").Replace("%", "")}";
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

        [Route("create-taikhoan")]
        [HttpPost]
        public UserModel CreateItem([FromBody] UserModel model)
        {
            _userBusiness.Create(model);
            return model;
        }
        [Route("update-taikhoan")]
        [HttpPost]
        public UserModel UpdateItem([FromBody] UserModel model)
        {
            _userBusiness.Update(model);
            return model;
        }
    }
}
