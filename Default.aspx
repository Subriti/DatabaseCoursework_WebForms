<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron" style="margin-bottom: -50px; margin-top: -3px;">
        <%--  <h2>Admin Analytics Panel</h2>

        <p class="lead" style="font-family: cursive">
            Visually analyse the records and insights of the organisation
        </p>--%>

        <center>
            <div class="ag-courses_item" style="background-color: mediumseagreen; padding: 10px; padding-left: 20px; padding-right: 20px; margin-left: 15px; width: fit-content; margin-top: -30px">
                <h2>
                    <b>
                        <asp:Label ID="Label1" runat="server"></asp:Label></b></h2>
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
                <h3 style="margin-top: -2px">is the </h3>
                <h3 style="margin-top: -30px;">
                    <br />
                    <b>
                        <img src="icons/award.png" alt="records" height="40" width="40">
                        Employee of the Month
                     <img src="icons/award.png" alt="records" height="40" width="40">
                    </b></h3>

                <h4 style="margin-top: 20px;">Votes Gained: 
                <asp:Label ID="Label2" runat="server"></asp:Label></h4>
            </div>
        </center>


        <div class="ag-format-container" style="margin-left: -50px; margin-top: -50px;">
            <div class="ag-courses_box">
                <div class="ag-courses_item">
                    <a href="Employee" class="ag-courses-item_link">
                        <div class="ag-courses-item_bg"></div>

                        <div class="ag-courses-item_title">
                            Employee 
                            <img src="icons/manager.png" alt="records" height="40" width="40">
                        </div>
                        <div class="ag-courses-item_date-box">
                            Count:
          <span class="ag-courses-item_date">
              <asp:Label ID="empCount" runat="server"></asp:Label>
              <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="Select Count(employee_id) As &quot;Employee Count&quot; from employee"></asp:SqlDataSource>
          </span>
                        </div>
                    </a>
                </div>

                <div class="ag-courses_item">
                    <a href="Department" class="ag-courses-item_link">
                        <div class="ag-courses-item_bg"></div>

                        <div class="ag-courses-item_title">
                            Department 
                            <img src="icons/office.png" alt="records" height="40" width="40">
                        </div>

                        <div class="ag-courses-item_date-box">
                            Count:
         <span class="ag-courses-item_date">
             <asp:Label ID="depCount" runat="server"></asp:Label>
             <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="Select Count(department_id) As &quot;Department Count&quot; from department"></asp:SqlDataSource>
         </span>
                        </div>
                    </a>
                </div>

                <div class="ag-courses_item">
                    <a href="Role" class="ag-courses-item_link">
                        <div class="ag-courses-item_bg"></div>

                        <div class="ag-courses-item_title">
                            Roles 
                            <img src="icons/employee.png" alt="records" height="40" width="40">
                        </div>

                        <div class="ag-courses-item_date-box">
                            Count:
         <span class="ag-courses-item_date">
             <asp:Label ID="roleCount" runat="server"></asp:Label>
             <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="Select Count(role_id) As &quot;Role Count&quot; from roles"></asp:SqlDataSource>
         </span>
                        </div>
                    </a>
                </div>

                <div class="ag-courses_item">
                    <a href="JobHistory" class="ag-courses-item_link">
                        <div class="ag-courses-item_bg"></div>

                        <div class="ag-courses-item_title">
                            Job Details 
                              <img src="icons/job-offer.png" alt="records" height="40" width="40">
                        </div>

                        <div class="ag-courses-item_date-box">
                            Count:
         <span class="ag-courses-item_date">
             <asp:Label ID="jobCount" runat="server"></asp:Label>
             <asp:SqlDataSource ID="SqlDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="Select Count(history_id) As &quot;Job Count&quot; from job_history where end_date is null"></asp:SqlDataSource>
         </span>
                        </div>
                    </a>
                </div>

                <div class="ag-courses_item">
                    <a href="Address" class="ag-courses-item_link">
                        <div class="ag-courses-item_bg"></div>

                        <div class="ag-courses-item_title">
                            Address 
                            <img src="icons/location.png" alt="records" height="40" width="40">
                        </div>

                        <div class="ag-courses-item_date-box" style="margin-bottom: -10px">
                            Count:
          <span class="ag-courses-item_date">
              <asp:Label ID="addressCount" runat="server"></asp:Label>
              <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="Select Count(address_id) As &quot;Address Count&quot; from address"></asp:SqlDataSource>
          </span>
                        </div>
                    </a>
                </div>

                <div class="ag-courses_item">
                    <a href="JobHistoryMapping" class="ag-courses-item_link">
                        <div class="ag-courses-item_bg"></div>
                        <div class="ag-courses-item_title" style="margin-bottom: -1px">
                            View Job History 
                            <img src="icons/history.png" alt="records" height="40" width="40">
                        </div>
                    </a>
                </div>

                <div class="ag-courses_item">
                    <a href="VotingRecords" class="ag-courses-item_link">
                        <div class="ag-courses-item_bg"></div>

                        <div class="ag-courses-item_title" style="margin-bottom: -1px">
                            View Voting Details
                            <img src="icons/documents.png" alt="records" height="40" width="40">
                        </div>
                    </a>
                </div>

                <div class="ag-courses_item">
                    <a href="EmployeeOfTheMonth" class="ag-courses-item_link">
                        <div class="ag-courses-item_bg">
                        </div>
                        <div class="ag-courses-item_title" style="margin-bottom: -1px">
                            View Best Employees 
                            <img src="icons/employee-of-the-month.png" alt="records" height="40" width="40">
                        </div>
                    </a>
                </div>


                <div style="margin-left: 330px; margin-bottom: -80px; border: dashed; border-width: 5px; width: fit-content; background: -webkit-linear-gradient(top, #67d8f2, #9f01ea);">
                    <p style="text-align: center;"><b>Employee Count in each Department</b></p>
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
            </div>
        </div>
    </div>
    <br />
    <br />

    <style>
        .ag-format-container {
            width: 1250px;
            margin: 0 auto;
        }


        body {
            width: 100%;
            overflow-x: hidden; /*
            background-color: #000;*/
        }

        .ag-courses_box {
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-align: start;
            -ms-flex-align: start;
            align-items: flex-start;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            padding: 50px 0;
        }

        .ag-courses_item {
            -ms-flex-preferred-size: calc(22.22222% - 20px);
            flex-basis: calc(22.22222% - 20px);
            margin: 0 15px 30px;
            overflow: hidden;
            border-radius: 28px;
        }

        .ag-courses-item_link {
            display: block;
            padding: 30px 20px;
            background-color: #121212;
            overflow: hidden;
            position: relative;
        }

            .ag-courses-item_link:hover,
            .ag-courses-item_link:hover .ag-courses-item_date {
                text-decoration: none;
                color: #FFF;
            }

                .ag-courses-item_link:hover .ag-courses-item_bg {
                    -webkit-transform: scale(10);
                    -ms-transform: scale(10);
                    transform: scale(10);
                }

        .ag-courses-item_title {
            min-height: 40px;
            margin: 0 0 25px;
            overflow: hidden;
            font-weight: bold;
            font-size: 30px;
            color: #FFF;
            z-index: 2;
            position: relative;
        }

        .ag-courses-item_date-box {
            font-size: 18px;
            color: #FFF;
            z-index: 2;
            position: relative;
        }

        .ag-courses-item_date {
            font-weight: bold;
            color: #f9b234;
            -webkit-transition: color .5s ease;
            -o-transition: color .5s ease;
            transition: color .5s ease
        }

        .ag-courses-item_bg {
            height: 128px;
            width: 128px;
            background-color: #f9b234;
            z-index: 1;
            position: absolute;
            top: -75px;
            right: -75px;
            border-radius: 50%;
            -webkit-transition: all .5s ease;
            -o-transition: all .5s ease;
            transition: all .5s ease;
        }

        .ag-courses_item:nth-child(2n) .ag-courses-item_bg {
            background-color: #3ecd5e;
        }

        .ag-courses_item:nth-child(3n) .ag-courses-item_bg {
            background-color: #e44002;
        }

        .ag-courses_item:nth-child(4n) .ag-courses-item_bg {
            background-color: #952aff;
        }

        .ag-courses_item:nth-child(5n) .ag-courses-item_bg {
            background-color: #cd3e94;
        }

        .ag-courses_item:nth-child(6n) .ag-courses-item_bg {
            background-color: #4c49ea;
        }



        @media only screen and (max-width: 979px) {
            .ag-courses_item {
                -ms-flex-preferred-size: calc(50% - 30px);
                flex-basis: calc(50% - 30px);
            }

            .ag-courses-item_title {
                font-size: 24px;
            }
        }

        @media only screen and (max-width: 767px) {
            .ag-format-container {
                width: 96%;
            }
        }

        @media only screen and (max-width: 639px) {
            .ag-courses_item {
                -ms-flex-preferred-size: 100%;
                flex-basis: 100%;
            }

            .ag-courses-item_title {
                min-height: 72px;
                line-height: 1;
                font-size: 24px;
            }

            .ag-courses-item_link {
                padding: 22px 40px;
            }

            .ag-courses-item_date-box {
                font-size: 16px;
            }
        }
    </style>
</asp:Content>
