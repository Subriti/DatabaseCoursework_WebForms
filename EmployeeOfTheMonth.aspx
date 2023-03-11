<%@ Page Title="EmployeeOfTheMonth" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EmployeeOfTheMonth.aspx.cs" Inherits="WebApplication1.EmployeeOfTheMonth" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="css/style.css" type="text/css" />
    <style>
        .mydatagrid {
            width: 90%;
        }
    </style>
    <div style="margin-top: 80px;">

        <h3>Employee of the month</h3>
        <br />
        <label>Select Month: </label>
        
        <asp:DropDownList runat="server" ID="votingMonth" AutoPostBack="True">
            <asp:ListItem Selected="True">January</asp:ListItem>
            <asp:ListItem>February</asp:ListItem>
            <asp:ListItem>March</asp:ListItem>
            <asp:ListItem>April</asp:ListItem>
            <asp:ListItem>May</asp:ListItem>
            <asp:ListItem>June</asp:ListItem>
            <asp:ListItem>July</asp:ListItem>
            <asp:ListItem>August</asp:ListItem>
            <asp:ListItem>September</asp:ListItem>
            <asp:ListItem>October</asp:ListItem>
            <asp:ListItem>November</asp:ListItem>
            <asp:ListItem>December</asp:ListItem>
        </asp:DropDownList>

        
        <label style="margin-left:40px;">Select Year: </label>
        <asp:DropDownList ID="votingYear" runat="server" AutoPostBack="True">
            <asp:ListItem Selected="True">2023</asp:ListItem>
            <asp:ListItem>2022</asp:ListItem>
            <asp:ListItem>2021</asp:ListItem>
            <asp:ListItem>2020</asp:ListItem>
            <asp:ListItem>2019</asp:ListItem>
        </asp:DropDownList>
        <div>
            <br />
            <asp:GridView ID="jobTable" runat="server" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" DataKeyNames="EMPLOYEE_ID" EmptyDataText="No records were found." AutoGenerateColumns="False" DataSourceID="SqlDataSource1" >
                <Columns>
                    <asp:BoundField DataField="Number of Votes" HeaderText="Number of Votes" SortExpression="Number of Votes" />
                    <asp:BoundField DataField="EMPLOYEE_ID" HeaderText="EMPLOYEE_ID" ReadOnly="True" SortExpression="EMPLOYEE_ID" />
                    <asp:BoundField DataField="EMPLOYEE_NAME" HeaderText="EMPLOYEE_NAME" SortExpression="EMPLOYEE_NAME" />
                    <asp:BoundField DataField="DATE_OF_BIRTH" HeaderText="DATE_OF_BIRTH" SortExpression="DATE_OF_BIRTH" DataFormatString="{0:dd-MMM-yy}" />
                    <asp:BoundField DataField="CONTACT_NUMBER" HeaderText="CONTACT_NUMBER" SortExpression="CONTACT_NUMBER" />
                </Columns>
<HeaderStyle CssClass="header"></HeaderStyle>

<RowStyle CssClass="rows"></RowStyle>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="select * from (select count(v.voting_id) AS &quot;Number of Votes&quot;, e.employee_id, e.employee_name, e.date_of_birth, e.contact_number from Voting_Details v join standing_candidate s on s.voting_id = v.voting_id join employee e on e.employee_id=s.candidate_id where s.voting_month=:votingMonth and s.voting_year=:votingYear group by v.voting_id, e.employee_id, e.employee_name, e.date_of_birth, e.contact_number order by count(v.voting_id)desc)
WHERE ROWNUM &lt;= 3">
                <SelectParameters>
                    <asp:ControlParameter ControlID="votingMonth" DefaultValue="January" Name="votingMonth" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="votingYear" DefaultValue="2023" Name="votingYear" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>

