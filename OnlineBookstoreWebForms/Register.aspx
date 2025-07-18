<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineBookstoreWebForms.Register" %>

<!DOCTYPE html>
<html>
<head runat="server">
  <title>Register - BookNest</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(to right, #f8bbd0, #b2ebf2);
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .register-container {
      background: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      width: 400px;
    }

    h2 {
      text-align: center;
      color: #00796b;
    }

    .form-group {
      margin-bottom: 15px;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      border-radius: 6px;
      border: 1px solid #ccc;
      transition: border 0.3s;
    }

    input:focus {
      border: 1px solid #00796b;
      outline: none;
    }

    .btn-register {
      background-color: #00796b;
      color: white;
      border: none;
      padding: 10px;
      width: 100%;
      border-radius: 6px;
      font-weight: bold;
      cursor: pointer;
      transition: background 0.3s;
    }

    .btn-register:hover {
      background-color: #004d40;
    }

    .message {
      color: red;
      font-size: 14px;
      margin-top: 10px;
    }

    .switch-link {
      text-align: center;
      margin-top: 20px;
    }

    .switch-link a {
      color: #00796b;
      text-decoration: none;
      font-weight: bold;
    }

    .switch-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="register-container">
      <h2>Create Account</h2>
      <div class="form-group">
        <asp:TextBox ID="txtName" runat="server" placeholder="Full Name"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
          ErrorMessage="Name is required" CssClass="message" Display="Dynamic" />
      </div>
      <div class="form-group">
        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" TextMode="Email"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
          ErrorMessage="Email is required" CssClass="message" Display="Dynamic" />
      </div>
      <div class="form-group">
        <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
          ErrorMessage="Password is required" CssClass="message" Display="Dynamic" />
      </div>
      <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-register" OnClick="btnRegister_Click" />
      <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

      <div class="switch-link">
        <p>Already have an account? <a href="Login.aspx">Login here</a></p>
      </div>
    </div>
  </form>
</body>
</html>
