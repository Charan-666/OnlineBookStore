<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="OnlineBookstoreWebForms.AdminPanel" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Panel</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to left, #ffe0b2, #e0f7fa);
            margin: 0;
            padding: 20px;
        }

       .form-inputs-vertical {
    display: flex;
    flex-direction: column;
    gap: 12px;
    max-width: 400px;
    margin-bottom: 20px;
}

.form-control {
    padding: 8px;
    font-size: 1rem;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.btn-submit {
    margin-top: 15px;
    padding: 10px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
}

.btn-submit:hover {
    background-color: #0056b3;
}



        .admin-container {
            max-width: 1300px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        h2, h4 {
            text-align: center;
            color: #00695c;
            margin-bottom: 30px;
        }

        .admin-gridview {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        .admin-gridview th, .admin-gridview td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        .admin-gridview th {
            background-color: #004d40;
            color: white;
        }

        .form-inputs {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .form-inputs input {
            padding: 5px 10px;
            width: 250px;
        }

        .form-inputs button, .logout-btn {
            padding: 8px 20px;
            font-size: 1rem;
            border: none;
            border-radius: 5px;
            background-color: #00796b;
            color: white;
            cursor: pointer;
        }

        .form-inputs button:hover, .logout-btn:hover {
            background-color: #004d40;
        }

        .logout-btn {
            background-color: #c62828;
            display: block;
            margin: 30px auto 0;
        }

        .logout-btn:hover {
            background-color: #b71c1c;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-container">
            <h2>📘 Admin Panel - Book Management</h2>

            <asp:GridView ID="gvBooks" runat="server" AutoGenerateColumns="False"
                          CssClass="admin-gridview"
                          DataKeyNames="BookID"
                          OnRowEditing="gvBooks_RowEditing"
                          OnRowCancelingEdit="gvBooks_RowCancelingEdit"
                          OnRowUpdating="gvBooks_RowUpdating">
                <Columns>
                    <asp:BoundField DataField="BookID" HeaderText="ID" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Title">
                        <ItemTemplate><%# Eval("Title") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTitle" runat="server" Text='<%# Bind("Title") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Price">
                        <ItemTemplate><%# Eval("Price") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Stock">
                        <ItemTemplate><%# Eval("Stock") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtStock" runat="server" Text='<%# Bind("Stock") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" />
                </Columns>
            </asp:GridView>

            <h4>Add New Book</h4>
<div class="form-inputs-vertical">
    <label for="txtNewTitle">Title:</label>
    <asp:TextBox ID="txtNewTitle" runat="server" CssClass="form-control" />

    <label for="txtNewPrice">Price:</label>
    <asp:TextBox ID="txtNewPrice" runat="server" CssClass="form-control" />

    <label for="txtNewStock">Stock:</label>
    <asp:TextBox ID="txtNewStock" runat="server" CssClass="form-control" />

    <label for="txtNewAuthorID">Author ID:</label>
    <asp:TextBox ID="txtNewAuthorID" runat="server" CssClass="form-control" />

    <label for="txtNewGenreID">Genre ID:</label>
    <asp:TextBox ID="txtNewGenreID" runat="server" CssClass="form-control" />

    <label for="fuImage">Photo:</label>
    <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />

    <asp:Button ID="btnAddBook" runat="server" Text="Add" CssClass="btn-submit" OnClick="btnAddBook_Click" />
</div>


            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />
        </div>
    </form>
</body>
</html>
