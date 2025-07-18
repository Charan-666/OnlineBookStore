<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="OnlineBookstoreWebForms.Home" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <title>BookNest | Home</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(to right, #f3e5f5, #e1f5fe);
    }

   .header {
    background: #f3e5f5;
    padding: 20px;
    border-bottom: 1px solid #ddd;
    position: relative;
}
   .header h1 {
    margin: 0;
    color: #6a1b9a;
}


   .header-buttons {
    display: flex;
    gap: 15px;
    position: absolute;
    top: 20px;
    right: 20px;
    align-items: center;
}
   
.header-link {
    font-weight: bold;
    color: #6a1b9a;
    text-decoration: none;
    font-size: 1rem;
    padding: 8px 12px;
    border-radius: 5px;
    transition: background 0.3s;
}

    .container {
      max-width: 1100px;
      margin: auto;
      padding: 30px 20px;
    }

    .books-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 30px;
  padding: 30px 10px;
} 

    .filters {
      display: flex;
      gap: 20px;
      margin-bottom: 30px;
    }

    select, input[type="text"] {
      flex: 1;
      padding: 10px;
      border-radius: 5px;
      border: 1px solid #999;
    }

    .book-list {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
      gap: 20px;
    }

   .book-card {
    background: #fff;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  text-align: center;
  transition: transform 0.3s ease;
  width: 100%;
  max-width: 220px;
  margin: auto;
}

   .book-card img {
   width: 100%;
  height: 180px;
  object-fit: cover;
  border-radius: 8px;
  margin-bottom: 15px;
}
    .book-card:hover {
      transform: scale(1.03);
    }

    .book-img {
      width: 200%;
      height: 200px;
      object-fit: cover;
      border-radius: 8px;
    }

    .book-title {
      font-size: 1.1rem;
      font-weight: bold;
      color: #4a148c;
      margin-top: 10px;
    }

    .book-info {
      font-size: 0.9rem;
      color: #555;
    }

    .book-price {
      font-weight: bold;
      margin-top: 10px;
      color: #2e7d32;
    }

    .logout-btn {
     position: absolute;
  top: 20px;
  right: 30px;
  background: #e91e63;
  color: white;
  padding: 6px 14px;
  border: none;
  border-radius: 6px;
  font-weight: bold;
  cursor: pointer;
    }

    .cart-btn {
  position: absolute;
  top: 20px;
  right: 120px;
  background: #6a1b9a;
  color: white;
  padding: 6px 14px;
  border-radius: 6px;
  font-weight: bold;
  text-decoration: none;
  transition: background 0.3s;
}

.cart-btn:hover {
  background: #4a148c;
}










.header-link:hover {
    background-color: #e1bee7;
}

.header-btn {
    padding: 8px 14px;
    font-size: 1rem;
    border: none;
    background-color: #6a1b9a;
    color: white;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s ease;
}

.header-btn:hover {
    background-color: #4a148c;
}

.logout {
    background-color: #c62828;
}

.logout:hover {
    background-color: #b71c1c;
}





  </style>
</head>
<body>
  <form id="form1" runat="server">
   <div class="header">
  <h1>📚 BookNest</h1>

  <div class="header-buttons">
    <a href="Dashboard.aspx" class="header-link">👤 Profile</a>
    <a href="MyOrders.aspx" class="header-link">📦 My Orders</a>
    <a href="Cart.aspx" class="header-link">🛒 Cart</a>
    <asp:Button ID="btnLogout" runat="server" CssClass="header-btn logout" Text="🚪 Logout" OnClick="btnLogout_Click" />
  </div>
</div>



    <div class="container">
      <div class="filters">
        <asp:DropDownList ID="ddlGenre" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
          <asp:ListItem Text="All Genres" Value="" />
        </asp:DropDownList>
        <asp:DropDownList ID="ddlAuthor" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
          <asp:ListItem Text="All Authors" Value="" />
        </asp:DropDownList>
        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search books..." AutoPostBack="true" OnTextChanged="Filter_Changed" />
      </div>
        <div class="book-list">
      <asp:Repeater ID="rptBooks" runat="server" OnItemCommand="rptBooks_ItemCommand">
  <ItemTemplate>
  <div class="book-card">
     <img src='<%# Eval("ImagePath") %>' style="width:100%; height:200px; object-fit:cover;" />

    
    <div class="book-title"><%# Eval("Title") %></div>
      <div class="book-info">by <%# Eval("AuthorName") %> | <%# Eval("GenreName") %></div>
      <div class="book-price">₹<%# Eval("Price") %> | Stock: <%# Eval("Stock") %></div>
      <asp:Button ID="btnAdd" runat="server" Text="Add to Cart"
                  CommandName="AddToCart"
                  CommandArgument='<%# Eval("BookID") %>' 
                  CssClass="btn btn-success mt-2" />
  </div>
</ItemTemplate>

</asp:Repeater>

            </div>

    </div>
  </form>
</body>
</html>
