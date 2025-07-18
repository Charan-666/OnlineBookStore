<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="OnlineBookstoreWebForms.Checkout" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <title>Checkout | BookNest</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(to right, #f3e5f5, #e1f5fe);
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 1000px;
      margin: auto;
      padding: 40px 20px;
    }

    .section {
      background: white;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      margin-bottom: 30px;
    }

    h2 {
      margin-bottom: 20px;
      color: #6a1b9a;
    }

    input[type="text"], input[type="email"] {
      width: 100%;
      padding: 10px;
      margin: 8px 0 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .cart-summary {
      margin-top: 20px;
    }

    .btn-primary {
      background: #6a1b9a;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-weight: bold;
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="container">
      <div class="section">
        <h2>Billing Information</h2>
        <asp:TextBox ID="txtName" runat="server" placeholder="Full Name" />
        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" TextMode="Email" />
        <asp:TextBox ID="txtAddress" runat="server" placeholder="Address" TextMode="MultiLine" Rows="3" />
      </div>

      <div class="section">
        <h2>Your Cart</h2>
        <asp:Repeater ID="rptCart" runat="server">
          <HeaderTemplate>
            <table width="100%" cellpadding="8" cellspacing="0" border="1">
              <tr style="background-color:#eee;font-weight:bold;">
                <td>Title</td>
                <td>Price</td>
                <td>Qty</td>
                <td>Total</td>
              </tr>
          </HeaderTemplate>
          <ItemTemplate>
              <tr>
                <td><%# Eval("Title") %></td>
                <td>₹<%# Eval("Price") %></td>
                <td><%# Eval("Quantity") %></td>
                <td>₹<%# Eval("Total") %></td>
              </tr>
          </ItemTemplate>
          <FooterTemplate>
            </table>
          </FooterTemplate>
        </asp:Repeater>

        <div class="cart-summary">
          <strong>Total: ₹</strong><asp:Label ID="lblGrandTotal" runat="server" ForeColor="#2e7d32" Font-Bold="true" />
        </div>
        <br />
        <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn-primary" OnClick="btnPlaceOrder_Click" />
      </div>
    </div>
  </form>
</body>
</html>
