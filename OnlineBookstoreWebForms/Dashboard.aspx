<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="OnlineBookstoreWebForms.Dashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>📊 User Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #f3e5f5, #e1f5fe);
            color: #333;
        }

        .dashboard-container {
            max-width: 1000px;
            margin: 50px auto;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        h2, h3 {
            color: #6a1b9a;
            text-align: center;
        }

        .section {
            margin-top: 30px;
        }

        .gridview-style {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .gridview-style th, .gridview-style td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        .gridview-style th {
            background-color: #6a1b9a;
            color: white;
        }

        .logout-btn {
            display: block;
            margin: 30px auto 0;
            background-color: #c62828;
            color: white;
            border: none;
            padding: 10px 25px;
            font-size: 1rem;
            border-radius: 5px;
            cursor: pointer;
        }

        .logout-btn:hover {
            background-color: #b71c1c;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <h2>Welcome to Your Dashboard</h2>
            <asp:Label ID="lblWelcome" runat="server" Font-Bold="true" />

            <div class="section">
                <h3>🛒 Your Orders</h3>
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="True" CssClass="gridview-style"></asp:GridView>
            </div>

            <div class="section">
                <h3>🛍️ Your Cart Summary</h3>
                <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="True" CssClass="gridview-style"></asp:GridView>
            </div>

            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />
        </div>
    </form>
</body>
</html>
