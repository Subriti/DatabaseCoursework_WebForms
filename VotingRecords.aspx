﻿<%@ Page Title="Voting Records" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VotingRecords.aspx.cs" Inherits="WebApplication1.VotingRecords" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="css/style.css" type="text/css" />
    <style>
        .mydatagrid {
            width: 90%;
        }
    </style>
    <div>

        <h3>Job History Details</h3>
        <asp:Button Text="Add Job History" ID="modal" CssClass="btn btn-primary" OnClick="modal_Click" runat="server" />
        <asp:DropDownList runat="server" DataTextField="EMPLOYEE_NAME" DataValueField="EMPLOYEE_ID" DataSourceID="SqlDataSource1" ID="ctl00"></asp:DropDownList>
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT EMPLOYEE_ID, EMPLOYEE_NAME FROM EMPLOYEE"></asp:SqlDataSource>
        <div>
            <br />
            <asp:GridView ID="jobTable" runat="server" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" DataKeyNames="HISTORY_ID" OnRowDataBound="OnRowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added." AutoGenerateEditButton="True" AutoGenerateDeleteButton="True" />
            <asp:TextBox ID="txtID" runat="server" Visible="false"></asp:TextBox>
        </div>
    </div>

    <div class="container">
        <div class="modal fade" id="addModal" data-backdrop="false" role="dialog">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add New Job History
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <label>Start Date</label>
                        <asp:TextBox ID="txtstartdate" CssClass="form-control" placeholder="Start Date (02-Mar-23)" runat="server" />
                        <br />
                        <label>End Date</label>
                        <asp:TextBox ID="txtenddate" CssClass="form-control" placeholder="End Date (02-Jul-23)" runat="server" />
                        <br />

                        <asp:Label ID="labelEmployee" runat="server" Text="Employee: "></asp:Label>
                        <asp:DropDownList ID="txtEmp" runat="server" DataTextField="EMPLOYEE_NAME" DataValueField="EMPLOYEE_ID" DataSourceID="SqlDataSource1"></asp:DropDownList>
                        <br /> <br />

                        <asp:Label ID="labelDep" runat="server" Text="Department: "></asp:Label>
                        <asp:DropDownList ID="txtDep" runat="server" DataTextField="DEPARTMENT_NAME" DataValueField="DEPARTMENT_ID" DataSourceID="SqlDataSource2" />
                        <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENT"></asp:SqlDataSource>
                        <br /> <br />

                        <asp:Label ID="labelRole" runat="server" Text="Role: "></asp:Label>
                        <asp:DropDownList ID="txtRole" runat="server" DataTextField="ROLE_NAME" DataValueField="ROLE_ID" DataSourceID="SqlDataSource3" />
                        <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT ROLE_ID, ROLE_NAME FROM ROLES"></asp:SqlDataSource>
                       

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

