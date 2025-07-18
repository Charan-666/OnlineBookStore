<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="OnlineBookstoreWebForms.MyOrders" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <title>📦 My Orders - BookNest</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(to right, #f3e5f5, #e1f5fe);
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 1000px;
      margin: 40px auto;
      padding: 30px;
      background: white;
      border-radius: 10px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    h2 {
      text-align: center;
      color: #6a1b9a;
      margin-bottom: 30px;
    }

    .order {
      margin-bottom: 25px;
      padding: 20px;
      border-left: 5px solid #6a1b9a;
      background: #f9f9f9;
      border-radius: 5px;
    }

    .order h4 {
      margin: 0 0 10px;
      color: #4a148c;
    }

    .book-item {
      margin-left: 20px;
      color: #333;
    }

    .no-orders {
      text-align: center;
      font-size: 1.2rem;
      color: #888;
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="container">
      <h2>🕒 My Orders</h2>
      <asp:Literal ID="litOrders" runat="server" />
    </div>
  </form>
</body>
</html>
