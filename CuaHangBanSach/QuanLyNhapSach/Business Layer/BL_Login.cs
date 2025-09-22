using QuanLyNhapSach.Database_Layer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyNhapSach.Business_Layer
{
    internal class BL_Login
    {
        DBMain db = null;

        public BL_Login()
        {
            db = new DBMain();
        }

        public bool UserLogin(string username, string password, ref int id, ref string name, ref string role, ref string message, ref string errMessage)
        {
            bool result = false;
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "sp_DangNhap";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("TenDangNhap", username);
            cmd.Parameters.AddWithValue("MatKhau", password);

            DataSet ds = db.ExecuteQuery(cmd, ref errMessage);
            if (ds == null) return false;
            DataTable dt = ds.Tables[0];

            result = Convert.ToInt32(dt.Rows[0]["KetQua"].ToString()) != 0;
            message = dt.Rows[0]["ThongBao"].ToString();

            if (result)
            {
                id = Convert.ToInt32(dt.Rows[0]["MaNguoiDung"].ToString());
                name = dt.Rows[0]["HoTen"].ToString();
                role = dt.Rows[0]["VaiTro"].ToString();
            }

            return result;
        }
    }
}
