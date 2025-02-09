﻿<%@ Page Title="Employee" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Employee.aspx.cs" Inherits="WebApplication1.Employee" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="css/style.css" type="text/css" />
    <style>
        .textAlign{
            float:left;
            position: absolute;
        }
    </style>

    <div>
        <center>
            <h3>Employee Details</h3>
            <asp:Button Text="Add Employee" ID="modal" CssClass="btn btn-primary" OnClick="modal_Click" runat="server" CausesValidation="false" />
            <div>
                <br />
                <asp:GridView ID="empTable" runat="server" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" DataKeyNames="EMPLOYEE_ID" OnRowDataBound="OnRowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added." AutoGenerateEditButton="true" AutoGenerateDeleteButton="true" />
                <asp:TextBox ID="txtID" runat="server" Visible="false"></asp:TextBox>
            </div>

        </center>
    </div>

    <div class="container">
        <div class="modal fade" id="addModal" data-backdrop="false" role="dialog">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add New Employee 
                         <button type="button" class="close" data-dismiss="modal" onclick="OnRowCancelingEdit">&times;</button>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <label>Name</label>
                        <asp:TextBox ID="txtname" CssClass="form-control" placeholder="Name" runat="server" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage=" Name cannot be empty" ControlToValidate="txtname" CssClass="text-danger" ForeColor="Red"></asp:RequiredFieldValidator>

                        <br />
                        <label>Date of Birth</label>
                        <asp:TextBox ID="txtdob" CssClass="form-control" placeholder="Date of Birth (01/12/1993)" runat="server"/>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtdob" ErrorMessage="Please enter a valid date." ValueToCompare="dd-MMM-yy" ForeColor="Red" OnServerValidate="dateValidator_ServerValidate"></asp:CompareValidator>

                        <br />
                        <div class="form-group">
                            <label>Contact Number</label>
                            <asp:TextBox ID="txtcontact" CssClass="form-control" placeholder="Contact Number" runat="server" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Contact Number cannot be empty" ControlToValidate="txtcontact" CssClass="text-danger textAlign" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="textAlign" runat="server" ControlToValidate="txtcontact" ErrorMessage="Invalid Mobile Number." ForeColor="Red" ValidationExpression="^([0-9]{10})$"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="OnRowCancelingEdit">Close</button>
                        <asp:Button ID="btnSave" CssClass="btn btn-primary" Text="Save" OnClick="btnsubmit_Click" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="errorModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Error</h4>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="errorLabel" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
