using QuanLyNhapSach.Business_Layer;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyNhapSach
{
    public partial class FormLogin : Form
    {
        BL_Login bl_Login;
        int id;
        string name;
        string role;
        string message = "";
        string errMessage = "";
        public FormLogin()
        {
            InitializeComponent();
        }

        private void FormLogin_Load(object sender, EventArgs e)
        {
            bl_Login = new BL_Login();
        }

        private void buttonLoginCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void buttonLoginConfirm_Click(object sender, EventArgs e)
        {
            string username = textBoxUsername.Text;
            string password = textBoxPassword.Text;
            if (bl_Login.UserLogin(username, password, ref id, ref name, ref role, ref message, ref errMessage))
            {

            }
        }
    }
}
