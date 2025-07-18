<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>Order Confirmed | BookNest</title>
  <style>
    body {
      background: #f3f3f3;
      font-family: sans-serif;
      text-align: center;
      padding-top: 100px;
    }
    .msg {
      background: #ffffff;
      padding: 30px 50px;
      margin: auto;
      border-radius: 10px;
      max-width: 500px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .msg h2 {
      color: #4caf50;
    }
  </style>
</head>
<body>
  <div class="msg">
    <h2>✅ Order Placed Successfully!</h2>
    <p>Thank you for shopping at BookNest.</p>
    <a href="Home.aspx">Continue Shopping</a>
  </div>
</body>
</html>
