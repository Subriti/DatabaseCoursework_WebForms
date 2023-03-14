using System;
using System.Data;
using System.Web.UI;

namespace WebApplication1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataView dvSql = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView drvSql in dvSql)
            {
                Label1.Text = drvSql["EMPLOYEE_NAME"].ToString();
                Label2.Text = drvSql["NUMBER OF VOTES"].ToString();

            }

            DataView dvSql1 = (DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView drvSql in dvSql1)
            {
                empCount.Text = drvSql["EMPLOYEE COUNT"].ToString();
            }

            DataView dvSql2 = (DataView)SqlDataSource4.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView drvSql in dvSql2)
            {
                depCount.Text = drvSql["DEPARTMENT COUNT"].ToString();
            }

            DataView dvSql3 = (DataView)SqlDataSource5.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView drvSql in dvSql3)
            {
                roleCount.Text = drvSql["ROLE COUNT"].ToString();
            }

            DataView dvSql4 = (DataView)SqlDataSource6.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView drvSql in dvSql4)
            {
                addressCount.Text = drvSql["ADDRESS COUNT"].ToString();
            }

            DataView dvSql5= (DataView)SqlDataSource7.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView drvSql in dvSql5)
            {
                jobCount.Text = drvSql["JOB COUNT"].ToString();
            }
        }
    }
}