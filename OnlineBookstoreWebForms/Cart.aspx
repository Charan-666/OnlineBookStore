<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OnlineBookstoreWebForms.Cart" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <title>🛒 Your Cart - BookNest</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(to right, #f3e5f5, #e1f5fe);
      color: #333;
    }

    .cart-container {
      max-width: 1000px;
      margin: 40px auto;
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      padding: 30px;
    }

    h2 {
      text-align: center;
      color: #6a1b9a;
      margin-bottom: 30px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th {
      background-color: #6a1b9a;
      color: white;
      padding: 15px;
      font-size: 1rem;
    }

    td {
      padding: 15px;
      text-align: center;
      border-bottom: 1px solid #eee;
    }

    .checkout-section {
      text-align: right;
      margin-top: 20px;
    }

    .btn-checkout {
      background: #2e7d32;
      color: white;
      border: none;
      padding: 12px 25px;
      font-size: 1rem;
      font-weight: bold;
      border-radius: 5px;
      cursor: pointer;
      transition: background 0.3s;
    }

    .btn-checkout:hover {
      background: #1b5e20;
    }

    .message {
      text-align: center;
      font-size: 1.1rem;
      color: #388e3c;
      margin-top: 20px;
    }

    .empty {
      text-align: center;
      padding: 50px;
      font-size: 1.2rem;
      color: #999;
    }

    @media (max-width: 600px) {
      table, th, td {
        font-size: 0.9rem;
      }

      .btn-checkout {
        width: 100%;
        padding: 12px;
      }

      .checkout-section {
        text-align: center;
      }
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="cart-container">
      <h2>🛍️ Your Shopping Cart</h2>

      <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" CssClass="cart-table" GridLines="None" BorderStyle="None">
        <Columns>
          <asp:BoundField DataField="Title" HeaderText="Book Title" />
          <asp:BoundField DataField="Price" HeaderText="Price (₹)" />
          <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
          <asp:BoundField DataField="Total" HeaderText="Total (₹)" />
        </Columns>
      </asp:GridView>

      <div class="empty" id="emptyCart" runat="server" visible="false">
        😔 Your cart is empty.
      </div>

      <div class="checkout-section" id="checkoutSection" runat="server">
          <asp:Label ID="lblTotal" runat="server" CssClass="message" />

        <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" CssClass="btn-checkout" OnClick="btnCheckout_Click" />
      </div>

      <asp:Label ID="lblMessage" runat="server" CssClass="message" />
    </div>
  </form>
</body>
</html>
