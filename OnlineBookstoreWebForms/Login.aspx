<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineBookstoreWebForms.Login" %>


<!DOCTYPE html>
<html>
<head runat="server">
  <title>Login - BookNest</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(to right, #f3e5f5, #e1f5fe);
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .login-container {
      background: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      width: 350px;
    }

    h2 {
      text-align: center;
      color: #6a1b9a;
    }

    .form-group {
      margin-bottom: 15px;
    }

    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      border-radius: 6px;
      border: 1px solid #ccc;
      transition: border 0.3s;
    }

    input:focus {
      border: 1px solid #6a1b9a;
      outline: none;
    }

    .btn-login {
      background-color: #6a1b9a;
      color: white;
      border: none;
      padding: 10px;
      width: 100%;
      border-radius: 6px;
      font-weight: bold;
      cursor: pointer;
      transition: background 0.3s;
    }

    .btn-login:hover {
      background-color: #4a148c;
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
      color: #6a1b9a;
      text-decoration: none;
      font-weight: bold;
    }

    .switch-link a:hover {
      text-decoration: underline;
    }
    .error-message {
  color: red;
  margin-top: 10px;
  display: block;
  font-weight: bold;
}

  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="login-container">
      <h2>User/Admin Login</h2>
      <div class="form-group">
        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
          ErrorMessage="Email is required" CssClass="message" Display="Dynamic" />
      </div>
      <div class="form-group">
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
          ErrorMessage="Password is required" CssClass="message" Display="Dynamic" />
      </div>
      <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />
        <asp:Label ID="lblError" runat="server" CssClass="error-message" />

      <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

      <div class="switch-link">
        <p>Don't have an account? <a href="Register.aspx">Register here</a></p>
      </div>
    </div>
  </form>
</body>
</html>
