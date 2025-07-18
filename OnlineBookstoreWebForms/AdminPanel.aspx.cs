using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace OnlineBookstoreWebForms
{
    public partial class AdminPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] == null || Session["UserEmail"].ToString() != "admin@booknest.com")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                BindBooks();
            }
        }

        private void BindBooks()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Books", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvBooks.DataSource = dt;
                gvBooks.DataBind();
            }
        }

        protected void gvBooks_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBooks.EditIndex = e.NewEditIndex;
            BindBooks();
        }

        protected void gvBooks_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBooks.EditIndex = -1;
            BindBooks();
        }

        protected void gvBooks_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int bookID = Convert.ToInt32(gvBooks.DataKeys[e.RowIndex].Value);

            GridViewRow row = gvBooks.Rows[e.RowIndex];
            string title = ((TextBox)row.FindControl("txtTitle")).Text;
            decimal price = Convert.ToDecimal(((TextBox)row.FindControl("txtPrice")).Text);
            int stock = Convert.ToInt32(((TextBox)row.FindControl("txtStock")).Text);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("UPDATE Books SET Title = @Title, Price = @Price, Stock = @Stock WHERE BookID = @BookID", con);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@Stock", stock);
                cmd.Parameters.AddWithValue("@BookID", bookID);
                cmd.ExecuteNonQuery();
            }

            gvBooks.EditIndex = -1;
            BindBooks();
        }

        protected void btnAddBook_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                string fileName = Path.GetFileName(fuImage.PostedFile.FileName);
                string filePath = "Image/" + fileName;
                fuImage.SaveAs(Server.MapPath("~/Image/" + fileName));

                SqlCommand cmd = new SqlCommand("sp_InsertBook", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Title", txtNewTitle.Text);
                cmd.Parameters.AddWithValue("@GenreID", Convert.ToInt32(txtNewGenreID.Text));
                cmd.Parameters.AddWithValue("@AuthorID", Convert.ToInt32(txtNewAuthorID.Text));
                cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtNewPrice.Text));
                cmd.Parameters.AddWithValue("@Stock", Convert.ToInt32(txtNewStock.Text));
                cmd.Parameters.AddWithValue("@ImagePath", filePath);





                cmd.ExecuteNonQuery();

                // Refresh Grid
                BindBooks();

                // Optional: clear form
                txtNewTitle.Text = "";
                txtNewPrice.Text = "";
                txtNewStock.Text = "";
                txtNewAuthorID.Text = "";
                txtNewGenreID.Text = "";
            }
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

       


    }
}
