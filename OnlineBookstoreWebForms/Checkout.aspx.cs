using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace OnlineBookstoreWebForms
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadCart();
        }

        private void LoadCart()
        {
            if (Session["Cart"] != null)
            {
                DataTable cart = (DataTable)Session["Cart"];
                rptCart.DataSource = cart;
                rptCart.DataBind();

                decimal total = 0;
                foreach (DataRow row in cart.Rows)
                {
                    total += Convert.ToDecimal(row["Total"]);
                }
                lblGrandTotal.Text = total.ToString("0.00");
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["Cart"] == null)
                Response.Redirect("Login.aspx");

            int userId = Convert.ToInt32(Session["UserID"]);
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string address = txtAddress.Text.Trim();
            DataTable cart = (DataTable)Session["Cart"];

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();

                try
                {
                    SqlCommand orderCmd = new SqlCommand("INSERT INTO Orders (UserID, OrderDate, TotalAmount) OUTPUT INSERTED.OrderID VALUES (@UserID, GETDATE(), @Total)", con, trans);
                    decimal total = Convert.ToDecimal(lblGrandTotal.Text);
                    orderCmd.Parameters.AddWithValue("@UserID", userId);
                    orderCmd.Parameters.AddWithValue("@Total", total);
                    int orderId = (int)orderCmd.ExecuteScalar();

                    foreach (DataRow row in cart.Rows)
                    {
                        SqlCommand itemCmd = new SqlCommand("INSERT INTO OrderDetails (OrderID, BookID, Quantity, Price) VALUES (@OrderID, (SELECT BookID FROM Books WHERE Title=@Title), @Qty, @Price)", con, trans);
                        itemCmd.Parameters.AddWithValue("@OrderID", orderId);
                        itemCmd.Parameters.AddWithValue("@Title", row["Title"]);
                        itemCmd.Parameters.AddWithValue("@Qty", row["Quantity"]);
                        itemCmd.Parameters.AddWithValue("@Price", row["Price"]);
                        itemCmd.ExecuteNonQuery();
                    }

                    trans.Commit();
                    Session["Cart"] = null;
                    Response.Redirect("Confirmation.aspx");
                }
                catch
                {
                    trans.Rollback();
                    Response.Write("<script>alert('Something went wrong while placing the order.');</script>");
                }
            }
        }
    }
}
