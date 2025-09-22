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
    public partial class FormMain : Form
    {
        public static int userID;
        public static string userName;
        public static string userRole;
        public FormMain()
        {
            InitializeComponent();
        }

        FormLogin formLogin = new FormLogin();

        private void FormMain_Load(object sender, EventArgs e)
        {
            formLogin.ShowDialog();
        }
    }
}
