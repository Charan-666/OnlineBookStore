using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI.WebControls;

namespace OnlineBookstoreWebForms
{
    public partial class Cart : System.Web.UI.Page
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
                LoadCartItems(); // ONLY use DB cart
            }
        }





        protected void btnCheckout_Click(object sender, EventArgs e)
        
        
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                SqlTransaction txn = con.BeginTransaction();

                try
                {
                    // 1. Get cart items
                    SqlCommand cmdGetCart = new SqlCommand(
                        "SELECT BookID, Quantity FROM CartItems WHERE UserID = @UserID", con, txn);
                    cmdGetCart.Parameters.AddWithValue("@UserID", userID);

                    DataTable cart = new DataTable();
                    cart.Load(cmdGetCart.ExecuteReader());

                    if (cart.Rows.Count == 0)
                    {
                        lblMessage.Text = "🛒 Your cart is empty.";
                        return;
                    }

                    // 2. Calculate total amount
                    decimal totalAmount = 0;
                    foreach (DataRow row in cart.Rows)
                    {
                        int bookID = Convert.ToInt32(row["BookID"]);
                        int qty = Convert.ToInt32(row["Quantity"]);

                        SqlCommand priceCmd = new SqlCommand(
                            "SELECT Price FROM Books WHERE BookID = @BookID", con, txn);
                        priceCmd.Parameters.AddWithValue("@BookID", bookID);
                        totalAmount += Convert.ToDecimal(priceCmd.ExecuteScalar()) * qty;
                    }

                    // 3. Insert into Orders
                    SqlCommand cmdOrder = new SqlCommand(
                        "INSERT INTO Orders (UserID, OrderDate, TotalAmount) OUTPUT INSERTED.OrderID VALUES (@UserID, GETDATE(), @Total)",
                        con, txn);
                    cmdOrder.Parameters.AddWithValue("@UserID", userID);
                    cmdOrder.Parameters.AddWithValue("@Total", totalAmount);
                    int orderID = Convert.ToInt32(cmdOrder.ExecuteScalar());

                    // 4. Insert into OrderDetails
                    foreach (DataRow row in cart.Rows)
                    {
                        SqlCommand cmdDetail = new SqlCommand(
                            "INSERT INTO OrderDetails (OrderID, BookID, Quantity) VALUES (@OrderID, @BookID, @Qty)", con, txn);
                        cmdDetail.Parameters.AddWithValue("@OrderID", orderID);
                        cmdDetail.Parameters.AddWithValue("@BookID", row["BookID"]);
                        cmdDetail.Parameters.AddWithValue("@Qty", row["Quantity"]);
                        cmdDetail.ExecuteNonQuery();
                    }

                    // 5. Clear cart
                    SqlCommand cmdClear = new SqlCommand(
                        "DELETE FROM CartItems WHERE UserID = @UserID", con, txn);
                    cmdClear.Parameters.AddWithValue("@UserID", userID);
                    cmdClear.ExecuteNonQuery();

                    txn.Commit();

                    lblMessage.Text = "🎉 Order placed successfully!";
                    gvCart.DataSource = null;
                    gvCart.DataBind();
                    gvCart.Visible = false;
                    checkoutSection.Visible = false;
                }
                catch
                {
                    txn.Rollback();
                    lblMessage.Text = "❌ Failed to place the order. Please try again.";
                }
            }
        }

           
        

        private void LoadCartItems()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    @"SELECT c.Quantity, b.Title, b.Price, (c.Quantity * b.Price) AS Total
              FROM CartItems c
              JOIN Books b ON c.BookID = b.BookID
              WHERE c.UserID = @UserID", con);

                cmd.Parameters.AddWithValue("@UserID", userID);

                SqlDataReader dr = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(dr);
                

                // ✅ Bind GridView
                gvCart.DataSource = dt;
                gvCart.DataBind();

                // ✅ Show/Hide based on data
                gvCart.Visible = dt.Rows.Count > 0;
                emptyCart.Visible = dt.Rows.Count == 0;
                checkoutSection.Visible = dt.Rows.Count > 0;

                decimal grandTotal = dt.AsEnumerable().Sum(row => row.Field<decimal>("Total"));
                lblTotal.Text = "Grand Total: ₹" + grandTotal.ToString("0.00");




               
            }
        }

       


    }
}
