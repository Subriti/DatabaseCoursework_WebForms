using Oracle.ManagedDataAccess.Client;
using System;
using System.Data;
using System.Globalization;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class JobHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // default load data
            if (!this.IsPostBack)
            {
                this.BindGrid();
            }
        }

        string constr = "Data Source=localhost;Persist Security Info=True;User ID=DatabaseCoursework;Password=db;";

        private void BindGrid()
        {
            OracleCommand cmd = new OracleCommand();
            OracleConnection con = new OracleConnection(constr);
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT  HISTORY_ID, TO_CHAR(START_DATE, 'DD-Mon-YY') AS START_DATE, J.EMPLOYEE_ID, E.EMPLOYEE_NAME, J.DEPARTMENT_ID, D.DEPARTMENT_NAME, J.ROLE_ID, R.ROLE_NAME FROM Job_History J JOIN EMPLOYEE E ON E.EMPLOYEE_ID=J.EMPLOYEE_ID JOIN DEPARTMENT D ON D.DEPARTMENT_ID=J.DEPARTMENT_ID JOIN ROLES R ON R.ROLE_ID=J.ROLE_ID WHERE J.END_DATE IS NULL  ORDER BY HISTORY_ID";
            cmd.CommandType = CommandType.Text;

            DataTable dt = new DataTable("job_history");

            using (OracleDataReader sdr = cmd.ExecuteReader())
            {
                dt.Load(sdr);
            }
            con.Close();
            jobTable.DataSource = dt;
            jobTable.DataBind();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            // insert code
            string startDate = txtstartdate.Text.ToString();
            string endDate = txtenddate.Text.ToString();
            string employee = txtEmp.Text.ToString();
            string department = txtDep.Text.ToString();
            string role = txtRole.Text.ToString();

            if (endDate == "null" || endDate == "")
            {
                endDate = null;
            }
            else
            {
                if (DateTime.TryParseExact(endDate, "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
                {
                    // Parsing was successful, and the date is in the correct format
                    DateTime inputDate = DateTime.ParseExact(endDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                    endDate = inputDate.ToString("dd-MMM-yy");
                }
                if (DateTime.TryParseExact(endDate, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
                {
                    // Parsing was successful, and the date is in the correct format
                    DateTime inputDate = DateTime.ParseExact(endDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    endDate = inputDate.ToString("dd-MMM-yy");
                }
            }

            if (DateTime.TryParseExact(startDate, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                // Parsing was successful, and the date is in the correct format
                DateTime inputDate = DateTime.ParseExact(startDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                startDate = inputDate.ToString("dd-MMM-yy");
            }
            else
            {
                if (DateTime.TryParseExact(startDate, "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
                {
                    // Parsing was successful, and the date is in the correct format
                    DateTime inputDate = DateTime.ParseExact(startDate, "d/M/yyyy", CultureInfo.InvariantCulture);
                    startDate = inputDate.ToString("dd-MMM-yy");
                }
            }

            

            OracleConnection con = new OracleConnection(constr);

            if (btnSave.Text == "Save")
            {
                OracleCommand cmd = new OracleCommand("Insert into job_history( START_DATE, END_DATE, EMPLOYEE_ID, DEPARTMENT_ID, ROLE_ID) Values('" + startDate + "','" + endDate + "','" + employee + "','" + department + "','" + role + "')");
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            else if (btnSave.Text == "Update")
            {
                //get ID for the Update
                string ID = txtID.Text.ToString();
                OracleCommand cmd = new OracleCommand("update job_history set START_DATE = '" + startDate + "',END_DATE = '" + endDate + "',EMPLOYEE_ID = '" + employee + "',DEPARTMENT_ID = '" + department + "',ROLE_ID = '" + role + "' where HISTORY_ID = " + ID);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                btnSave.Text = "Save";
                jobTable.EditIndex = -1;
            }

            txtID.Text = "";
            txtstartdate.Text = "";
            txtenddate.Text = "";
            txtEmp.SelectedIndex = 0;
            txtDep.SelectedIndex = 0;
            txtRole.SelectedIndex = 0;

            this.BindGrid();
        }


        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            txtID.Text = "";
            txtstartdate.Text = "";
            txtenddate.Text = "";
            txtEmp.SelectedIndex = 0;
            txtDep.SelectedIndex = 0;
            txtRole.SelectedIndex = 0;

            btnSave.Text = "Save";

            jobTable.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int ID = Convert.ToInt32(jobTable.DataKeys[e.RowIndex].Values[0]);
            using (OracleConnection con = new OracleConnection(constr))
            {
                using (OracleCommand cmd = new OracleCommand("DELETE FROM Job_History WHERE HISTORY_ID =" + ID))
                {
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            this.BindGrid();
            jobTable.EditIndex = -1;
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != jobTable.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }
            jobTable.EditIndex = -1;
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            // get id for data update
            txtID.Text = this.jobTable.Rows[e.NewEditIndex].Cells[1].Text;
           
            String date = this.jobTable.Rows[e.NewEditIndex].Cells[2].Text.ToString().TrimStart().TrimEnd();
            DateTime inputDate = DateTime.ParseExact(date, "dd-MMM-yy", CultureInfo.InvariantCulture);
            txtstartdate.Text = inputDate.ToString("dd/MM/yyyy");

            /*
            if (this.jobTable.Rows[e.NewEditIndex].Cells[3].Text.ToString().TrimStart().TrimEnd() == "&nbsp;")
            {
                txtenddate.Text = "";
            }
            else      //bc end_date is hidden; as employee is still doing his job
            {
               String dates = this.jobTable.Rows[e.NewEditIndex].Cells[3].Text.ToString().TrimStart().TrimEnd();
                DateTime inputDates = DateTime.ParseExact(dates, "dd-MMM-yy", CultureInfo.InvariantCulture);
                txtenddate.Text = inputDates.ToString("dd/MM/yyyy");
            }
            
            txtEmp.Text = this.jobTable.Rows[e.NewEditIndex].Cells[4].Text;
            txtDep.Text = this.jobTable.Rows[e.NewEditIndex].Cells[6].Text;
            txtRole.Text = this.jobTable.Rows[e.NewEditIndex].Cells[8].Text;
            */
            txtEmp.Text = this.jobTable.Rows[e.NewEditIndex].Cells[3].Text;
            txtDep.Text = this.jobTable.Rows[e.NewEditIndex].Cells[5].Text;
            txtRole.Text = this.jobTable.Rows[e.NewEditIndex].Cells[7].Text;

            btnSave.Text = "Update";

            jobTable.EditIndex = -1;
            this.BindGrid();

            string script = "$('#addModal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }

        protected void modal_Click(object sender, EventArgs e)
        {
            string script = "$('#addModal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);

            txtID.Text = "";
            txtstartdate.Text = "";
            txtenddate.Text = "";
            txtEmp.SelectedIndex = 0;
            txtDep.SelectedIndex = 0;
            txtRole.SelectedIndex = 0;

            btnSave.Text = "Save";

            jobTable.EditIndex = -1;
            this.BindGrid();
        }

        protected void dateValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string dateString = args.Value;
            DateTime date;
            if (DateTime.TryParseExact(dateString, "dd-MMM-yy", CultureInfo.InvariantCulture, DateTimeStyles.None, out date))
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }
    }
}