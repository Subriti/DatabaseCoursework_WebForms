<%@ Page Title="Job History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="JobHistoryMapping.aspx.cs" Inherits="WebApplication1.JobHistoryMapping" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="css/style.css" type="text/css" />
    <style>
        .mydatagrid {
            width: 105%;
        }
    </style>
    <div style="margin-top: 80px;">
        <h3>Job History Mapping</h3>
        <br />

        <label>Select Employee: </label>
        <asp:DropDownList runat="server" DataTextField="EMPLOYEE_NAME" DataValueField="EMPLOYEE_ID" DataSourceID="SqlDataSource1" ID="empName" AutoPostBack="True"></asp:DropDownList>
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT EMPLOYEE_ID, EMPLOYEE_NAME FROM EMPLOYEE"></asp:SqlDataSource>
        <div>
            <br />
            <asp:GridView ID="jobTable" runat="server" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" DataKeyNames="HISTORY_ID,EMPLOYEE_ID" EmptyDataText="No records were found." AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                <Columns>
                    <asp:BoundField DataField="HISTORY_ID" HeaderText="HISTORY_ID" ReadOnly="True" SortExpression="HISTORY_ID" />
                    <asp:BoundField DataField="START_DATE" HeaderText="START_DATE" SortExpression="START_DATE" DataFormatString="{0:dd-MMM-yy}" />
                    <asp:BoundField DataField="END_DATE" HeaderText="END_DATE" SortExpression="END_DATE" DataFormatString="{0:dd-MMM-yy}" />
                    <asp:BoundField DataField="Job Time Period" HeaderText="TIME PERIOD" SortExpression="Job Time Period" />
                    <asp:BoundField DataField="EMPLOYEE_ID" HeaderText="EMPLOYEE_ID" SortExpression="EMPLOYEE_ID" ReadOnly="True" />
                    <asp:BoundField DataField="EMPLOYEE_NAME" HeaderText="NAME" SortExpression="EMPLOYEE_NAME" />
                    <asp:BoundField DataField="DATE_OF_BIRTH" HeaderText="DOB" SortExpression="DATE_OF_BIRTH" DataFormatString="{0:dd-MMM-yy}" />
                    <asp:BoundField DataField="CONTACT_NUMBER" HeaderText="CONTACT" SortExpression="CONTACT_NUMBER" />
                    <asp:BoundField DataField="DEPARTMENT_NAME" HeaderText="DEPARTMENT_NAME" SortExpression="DEPARTMENT_NAME" />
                    <asp:BoundField DataField="ROLE_NAME" HeaderText="ROLE_NAME" SortExpression="ROLE_NAME" />
                </Columns>
                <HeaderStyle CssClass="header"></HeaderStyle>

                <RowStyle CssClass="rows"></RowStyle>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="select j.history_id, j.start_date, j.end_date, MONTHS_BETWEEN(j.end_date,j.start_date) || ' months' AS &quot;Job Time Period&quot;, e.employee_id, e.employee_name, e.date_of_birth, e.contact_number, j.department_id, d.department_name, j.role_id, r.role_name from job_history j join employee e on j.employee_id=e.employee_id join department d on d.department_id=j.department_id join roles r on r.role_id=j.role_id where j.employee_id=:empName and j.end_date is not null
">
                <SelectParameters>
                    <asp:ControlParameter ControlID="empName" DefaultValue="4" Name="empName" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>

