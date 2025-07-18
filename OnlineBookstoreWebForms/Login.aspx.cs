using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Activities;

namespace OnlineBookstoreWebForms
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT UserID FROM Users WHERE Email = @Email AND Password = @Password", con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    int userId = Convert.ToInt32(result);
                    Session["UserID"] = userId;
                    Session["UserEmail"] = email;

                    if (email == "admin@booknest.com")  // ✅ Hardcoded check
                        Response.Redirect("AdminPanel.aspx");
                    else
                        Response.Redirect("Home.aspx");
                }
                else
                {
                    lblError.Text = "❌ Invalid credentials!";
                }
            }
        }

    }
}






