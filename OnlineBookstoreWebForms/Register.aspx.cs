using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineBookstoreWebForms
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            string conStr = ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                // Check if user exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@Email", email);

                con.Open();
                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    lblMessage.Text = "Email already registered.";
                    return;
                }

                // Register new user
                string insertQuery = "INSERT INTO Users (UserName, Email, Password) VALUES (@Name, @Email, @Password)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                insertCmd.Parameters.AddWithValue("@Name", name);
                insertCmd.Parameters.AddWithValue("@Email", email);
                insertCmd.Parameters.AddWithValue("@Password", password); // plaintext for now

                insertCmd.ExecuteNonQuery();
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Registration successful! Redirecting to login...";

                // Redirect after short delay
                Response.AddHeader("REFRESH", "2;URL=Login.aspx");
            }
        }
    }
}




