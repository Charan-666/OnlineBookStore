using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace OnlineBookstoreWebForms
{
    public partial class MyOrders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                    Response.Redirect("Login.aspx");

                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            string connectionString = ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                //string query = @"
                //    SELECT o.OrderID, o.OrderDate, b.Title, od.Quantity
                //    FROM Orders o
                //    JOIN Orderdetails od ON o.OrderID = od.OrderID
                //    JOIN Books b ON od.BookID = b.BookID
                //    WHERE o.UserID = @UserID
                //    ORDER BY o.OrderDate DESC";

                SqlCommand cmd = new SqlCommand("sp_GetUserOrders", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", userID);
                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.HasRows)
                {
                    litOrders.Text = "<div class='no-orders'>You haven’t placed any orders yet.</div>";
                    return;
                }

                StringBuilder sb = new StringBuilder();
                int currentOrderId = -1;

                while (dr.Read())
                {
                    int orderId = Convert.ToInt32(dr["OrderID"]);

                    if (orderId != currentOrderId)
                    {
                        if (currentOrderId != -1)
                            sb.Append("</div>"); // Close previous order

                        currentOrderId = orderId;
                        sb.Append($"<div class='order'><h4>Order #{orderId} - Date: {Convert.ToDateTime(dr["OrderDate"]).ToShortDateString()}</h4>");
                    }

                    sb.Append($"<div class='book-item'>📘 {dr["Title"]} - Qty: {dr["Quantity"]}</div>");
                }

                sb.Append("</div>"); // close last order

                litOrders.Text = sb.ToString();
            }
        }
    }
}
