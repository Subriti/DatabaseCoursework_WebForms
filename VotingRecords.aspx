<%@ Page Title="Voting Records" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VotingRecords.aspx.cs" Inherits="WebApplication1.VotingRecords" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="css/style.css" type="text/css" />
    <style>
        .mydatagrid {
            width: 105%;
        }
    </style>
    <div>

        <h3>Voting Record Details</h3>
        <br />
        <label>Select Employee: </label>
        <asp:DropDownList runat="server" DataTextField="EMPLOYEE_NAME" DataValueField="EMPLOYEE_ID" DataSourceID="SqlDataSource1" ID="empName" AutoPostBack="True"></asp:DropDownList>
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT EMPLOYEE_ID, EMPLOYEE_NAME FROM EMPLOYEE"></asp:SqlDataSource>

        <div>
            <br />
            <asp:GridView ID="votingTable" runat="server" CssClass="mydatagrid" HeaderStyle-CssClass="header" RowStyle-CssClass="rows" EmptyDataText="No records were found." AutoGenerateColumns="False" DataKeyNames="EMPLOYEE_ID,VOTING_ID" DataSourceID="SqlDataSource2">
                <Columns>
                    <asp:BoundField DataField="EMPLOYEE_ID" HeaderText="EMPLOYEE_ID" ReadOnly="True" SortExpression="EMPLOYEE_ID" />
                    <asp:BoundField DataField="EMPLOYEE_NAME" HeaderText="NAME" SortExpression="EMPLOYEE_NAME" />
                    <asp:BoundField DataField="DATE_OF_BIRTH" HeaderText="DOB" SortExpression="DATE_OF_BIRTH" DataFormatString="{0:dd-MMM-yy}" />
                    <asp:BoundField DataField="CONTACT_NUMBER" HeaderText="CONTACT" SortExpression="CONTACT_NUMBER" />
                    <asp:BoundField DataField="VOTING_ID" HeaderText="VOTING_ID" ReadOnly="True" SortExpression="VOTING_ID" />
                    <asp:BoundField DataField="VOTING_MONTH" HeaderText="MONTH" SortExpression="VOTING_MONTH" />
                    <asp:BoundField DataField="VOTING_YEAR" HeaderText="YEAR" SortExpression="VOTING_YEAR" />
                    <asp:BoundField DataField="CANDIDATE_ID" HeaderText="CANDIDATE_ID" SortExpression="CANDIDATE_ID" />
                    <asp:BoundField DataField="EMPLOYEE_NAME1" HeaderText="CANDIDATE_ID_NAME" SortExpression="EMPLOYEE_NAME1" />
                    <asp:BoundField DataField="DATE_OF_BIRTH1" HeaderText="DOB" SortExpression="DATE_OF_BIRTH1" DataFormatString="{0:dd-MMM-yy}" />
                    <asp:BoundField DataField="CONTACT_NUMBER1" HeaderText="CONTACT" SortExpression="CONTACT_NUMBER1" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="select e.employee_id, e.employee_name, e.date_of_birth, e.contact_number, s.voting_id, s.voting_month, s.voting_year, s.candidate_id, emp.employee_name, emp.date_of_birth, emp.contact_number  from Voting_Details v join employee e on v.voter_id=e.employee_id join standing_candidate s on s.voting_id = v.voting_id join employee emp on s.candidate_id=emp.employee_id  where v.voter_id=:empName">
                <SelectParameters>
                    <asp:ControlParameter ControlID="empName" DefaultValue="1" Name="empName" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />

        </div>
    </div>
</asp:Content>

