using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace OnlineBookstoreWebForms
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrders();
                LoadCart(Convert.ToInt32(Session["UserID"]));  


            }
        }

        private void LoadOrders()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    @"SELECT o.OrderID, o.OrderDate, o.TotalAmount
              FROM Orders o
              WHERE o.UserID = @UserID
              ORDER BY o.OrderDate DESC", con);
                cmd.Parameters.AddWithValue("@UserID", userID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }



        private void LoadCart(int userID)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT b.Title, c.Quantity FROM CartItems c JOIN Books b ON b.BookID = c.BookID WHERE c.UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCart.DataSource = dt;
                gvCart.DataBind();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}