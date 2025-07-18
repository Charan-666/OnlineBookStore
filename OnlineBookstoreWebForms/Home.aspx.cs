using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineBookstoreWebForms
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                    Response.Redirect("Login.aspx");

                LoadGenres();
                LoadAuthors();
                LoadBooks();
            }

            // 🔴 Move this outside or ensure it's not re-attached
            rptBooks.ItemCommand -= rptBooks_ItemCommand;  
            rptBooks.ItemCommand += rptBooks_ItemCommand;
        }


        private void LoadGenres()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT GenreID, GenreName FROM Genres", con);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    ddlGenre.Items.Add(new System.Web.UI.WebControls.ListItem(dr["GenreName"].ToString(), dr["GenreID"].ToString()));
                }
            }
        }

        private void LoadAuthors()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT AuthorID, AuthorName FROM Authors", con);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    ddlAuthor.Items.Add(new System.Web.UI.WebControls.ListItem(dr["AuthorName"].ToString(), dr["AuthorID"].ToString()));
                }
            }
        }

        private void LoadBooks()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();

                string query = "SELECT b.BookID, b.Title, b.Price, b.Stock, b.ImagePath, a.AuthorName, g.GenreName FROM Books b " +
                 "JOIN Authors a ON b.AuthorID = a.AuthorID " +
                 "JOIN Genres g ON b.GenreID = g.GenreID WHERE 1=1";


                if (!string.IsNullOrEmpty(ddlGenre.SelectedValue))
                    query += " AND b.GenreID = @GenreID";

                if (!string.IsNullOrEmpty(ddlAuthor.SelectedValue))
                    query += " AND b.AuthorID = @AuthorID";

                if (!string.IsNullOrEmpty(txtSearch.Text))
                    query += " AND b.Title LIKE @Search";

                SqlCommand cmd = new SqlCommand(query, con);

                if (!string.IsNullOrEmpty(ddlGenre.SelectedValue))
                    cmd.Parameters.AddWithValue("@GenreID", ddlGenre.SelectedValue);

                if (!string.IsNullOrEmpty(ddlAuthor.SelectedValue))
                    cmd.Parameters.AddWithValue("@AuthorID", ddlAuthor.SelectedValue);

                if (!string.IsNullOrEmpty(txtSearch.Text))
                    cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text + "%");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptBooks.DataSource = dt;
                rptBooks.DataBind();
            }
        }



        protected void Filter_Changed(object sender, EventArgs e)
        {
            LoadBooks();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        private void AddToCart(int bookID, int userID)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString))
            {
                con.Open();

                // Check if item already in cart
                SqlCommand checkCmd = new SqlCommand("SELECT Quantity FROM CartItems WHERE UserID = @UserID AND BookID = @BookID", con);
                checkCmd.Parameters.AddWithValue("@UserID", userID);
                checkCmd.Parameters.AddWithValue("@BookID", bookID);

                object result = checkCmd.ExecuteScalar();

                if (result != null)
                {
                    // Update quantity
                    SqlCommand updateCmd = new SqlCommand("UPDATE CartItems SET Quantity = Quantity + 1 WHERE UserID = @UserID AND BookID = @BookID", con);
                    updateCmd.Parameters.AddWithValue("@UserID", userID);
                    updateCmd.Parameters.AddWithValue("@BookID", bookID);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    // Insert new item
                    SqlCommand insertCmd = new SqlCommand("INSERT INTO CartItems (UserID, BookID, Quantity) VALUES (@UserID, @BookID, 1)", con);
                    insertCmd.Parameters.AddWithValue("@UserID", userID);
                    insertCmd.Parameters.AddWithValue("@BookID", bookID);
                    insertCmd.ExecuteNonQuery();
                }
            }
        }


        protected void rptBooks_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                int bookID = Convert.ToInt32(e.CommandArgument);
                int userID = Convert.ToInt32(Session["UserID"]);

                AddToCart(bookID, userID);
            }
        }



    }
}





