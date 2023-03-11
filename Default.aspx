<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="margin-top: 40px;">
        <h2>Admin Analytics Panel</h2>
        <p class="lead">
            Visually analyse the records and insights of your organisation
        </p>

        <div class="col-md-3" style="background-color: lightseagreen; padding: 10px; margin-left: 15px;">
            <asp:Label ID="Label1" runat="server" OnDataBinding="Page_Load" Text="Subriti Aryal" AssociatedControlID="SqlDataSource2"></asp:Label>

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM (
  SELECT COUNT(v.voting_id) AS &quot;Number of Votes&quot;, e.employee_id, e.employee_name
  FROM Voting_Details v 
  JOIN standing_candidate s ON s.voting_id = v.voting_id 
  JOIN employee e ON e.employee_id = s.candidate_id 
  WHERE s.voting_month = INITCAP(TO_CHAR(SYSDATE, 'fmMonth')) AND CAST(s.voting_year AS INT) = EXTRACT(YEAR FROM SYSDATE) 
  GROUP BY v.voting_id, e.employee_id, e.employee_name
  ORDER BY COUNT(v.voting_id) DESC
)
WHERE ROWNUM = 1"></asp:SqlDataSource>
            <h3>is the <b>Employee of the Month🥇</b></h3>
            <br />
            <h4>Votes Gained: 10</h4>
            <br />
        </div>


    </div>
    <div style="float: right; border: dashed; border-width: 5px; width: fit-content; background: -webkit-linear-gradient(top, #56d8e4, #9f01ea);">
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT d.Department_Name, Count(j.Employee_id) from department d join job_history j on j.department_id=d.department_id where j.end_date is null group by d.department_name"></asp:SqlDataSource>

        <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource3" Width="500" Height="300">
            <Titles>
                <asp:Title ShadowOffset="3" Name="Number of employee working in each department" />
            </Titles>
            <Legends>
                <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="False" Name="Number of Employee" LegendStyle="Row" />
            </Legends>
            <Series>
                <asp:Series Name="Number of Employee" XValueMember="Department_Name" YValueMembers="Count(j.Employee_id)"></asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
    </div>

    <br />
    <br />

    <div class="row" style="margin-top: 260px;">
        <div class="col-md-3" style="background-color: lightseagreen; padding: 10px; margin-left: 15px;">
            <asp:Label ID="empOfTheMonth" runat="server" OnDataBinding="Page_Load" Text="Subriti Aryal"></asp:Label>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM (
  SELECT COUNT(v.voting_id) AS &quot;Number of Votes&quot;, e.employee_id, e.employee_name
  FROM Voting_Details v 
  JOIN standing_candidate s ON s.voting_id = v.voting_id 
  JOIN employee e ON e.employee_id = s.candidate_id 
  WHERE s.voting_month = INITCAP(TO_CHAR(SYSDATE, 'fmMonth')) AND CAST(s.voting_year AS INT) = EXTRACT(YEAR FROM SYSDATE) 
  GROUP BY v.voting_id, e.employee_id, e.employee_name
  ORDER BY COUNT(v.voting_id) DESC
)
WHERE ROWNUM = 1"></asp:SqlDataSource>
            <h3>is the <b>Employee of the Month🥇</b></h3>

            <h4>Votes Gained: 10</h4>
            <br />
        </div>
        <div class="col-md-4">
            <h2>Get more libraries</h2>
            <p>
                NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301949">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Web Hosting</h2>
            <p>
                You can easily find a web hosting company that offers the right mix of features and price for your applications.
            </p>
            <p>
                <a class="btn btn-default" href="https://go.microsoft.com/fwlink/?LinkId=301950">Learn more &raquo;</a>
            </p>
        </div>
    </div>

    <h2><%: Title %>.</h2>
    <h3>Your application description page.</h3>
    <p>Use this area to provide additional information.</p>

    <h2><%: Title %>.</h2>
    <h3>Your contact page.</h3>
    <address>
        One Microsoft Way<br />
        Redmond, WA 98052-6399<br />
        <abbr title="Phone">P:</abbr>
        425.555.0100
    </address>

    <address>
        <strong>Support:</strong>   <a href="mailto:Support@example.com">Support@example.com</a><br />
        <strong>Marketing:</strong> <a href="mailto:Marketing@example.com">Marketing@example.com</a>
    </address>

</asp:Content>
