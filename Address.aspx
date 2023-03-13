﻿<%@ Page Title="Address" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Address.aspx.cs" Inherits="WebApplication1.Address" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="css/style.css" type="text/css" />
    <style>
        .mydatagrid {
            width: 40%;
            min-width: 30%;
        }
    </style>
    <div>

        <h3>Address Details</h3>
        <asp:Button Text="Add Address" ID="modal" CssClass="btn btn-primary" OnClick="modal_Click" runat="server" />
        <div>
            <br />
            <asp:GridView ID="addressTable" runat="server" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" DataKeyNames="ADDRESS_ID" OnRowDataBound="OnRowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added." AutoGenerateEditButton="true" AutoGenerateDeleteButton="true" />
            <asp:TextBox ID="txtID" runat="server" Visible="false"></asp:TextBox>
        </div>
    </div>

    <div class="container">
        <div class="modal fade" id="addModal" data-backdrop="false" role="dialog">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add New Address
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <label>Address Name</label>
                        <asp:TextBox ID="txtname" CssClass="form-control" placeholder="Address" runat="server" />
                        <br />

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                            <asp:Button ID="btnSave" CssClass="btn btn-primary" Text="Save" OnClick="btnsubmit_Click" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
