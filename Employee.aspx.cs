using Oracle.ManagedDataAccess.Client;
using System;
using System.Data;
using System.Globalization;
using System.Runtime.InteropServices.ComTypes;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Employee : System.Web.UI.Page
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
            cmd.CommandText = @"SELECT  EMPLOYEE_ID, EMPLOYEE_NAME, TO_CHAR(DATE_OF_BIRTH, 'DD-Mon-YY') AS DATE_OF_BIRTH, CONTACT_NUMBER FROM Employee";
            cmd.CommandType = CommandType.Text;

            DataTable dt = new DataTable("employee");

            using (OracleDataReader sdr = cmd.ExecuteReader())
            {
                dt.Load(sdr);
            }
            con.Close();
            empTable.DataSource = dt;
            empTable.DataBind();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            // insert code
            string name = txtname.Text.ToString();
            string dob = txtdob.Text.ToString();
            string contact = txtcontact.Text.ToString();

            if (DateTime.TryParseExact(dob, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
            {
                // Parsing was successful, and the date is in the correct format
                DateTime inputDate = DateTime.ParseExact(dob, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                dob = inputDate.ToString("dd-MMM-yy");
            }
            else
            {
                if (DateTime.TryParseExact(dob, "d/M/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out _))
                {
                    // Parsing was successful, and the date is in the correct format
                    DateTime inputDate = DateTime.ParseExact(dob, "d/M/yyyy", CultureInfo.InvariantCulture);
                    dob = inputDate.ToString("dd-MMM-yy");
                }
            }

            OracleConnection con = new OracleConnection(constr);

            if (btnSave.Text == "Save")
            {
                OracleCommand cmd = new OracleCommand("Insert into employee(EMPLOYEE_NAME, DATE_OF_BIRTH, CONTACT_NUMBER) Values('" + name + "','" + dob + "','" + contact + "')");
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            else if (btnSave.Text == "Update")
            {
                //get ID for the Update
                string ID = txtID.Text.ToString();
                OracleCommand cmd = new OracleCommand("update employee set EMPLOYEE_NAME = '" + name + "',DATE_OF_BIRTH = '" + dob + "',CONTACT_NUMBER = '" + contact + "' where EMPLOYEE_ID = " + ID);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                btnSave.Text = "Save";
                empTable.EditIndex = -1;

            }
            txtID.Text = "";
            txtname.Text = "";
            txtdob.Text = "";
            txtcontact.Text = "";

            this.BindGrid();


        }


        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            txtID.Text = "";
            txtname.Text = "";
            txtdob.Text = "";
            txtcontact.Text = "";
            btnSave.Text = "Save";


            empTable.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int ID = Convert.ToInt32(empTable.DataKeys[e.RowIndex].Values[0]);
            using (OracleConnection con = new OracleConnection(constr))
            {
                try
                {
                    using (OracleCommand cmd = new OracleCommand("DELETE FROM Employee WHERE EMPLOYEE_ID =" + ID))
                    {
                        cmd.Connection = con;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }
                catch (Exception exception)
                {
                    errorLabel.Text = "The employee could not be deleted because it holds few child records.";

                    // show the modal using jQuery
                    string script = "$('#errorModal').modal('show');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", script, true);
                }
            }
            this.BindGrid();
            empTable.EditIndex = -1;
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != empTable.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }
            empTable.EditIndex = -1;
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            // get id for data update
            txtID.Text = this.empTable.Rows[e.NewEditIndex].Cells[1].Text;
            txtname.Text = this.empTable.Rows[e.NewEditIndex].Cells[2].Text.ToString().TrimStart().TrimEnd(); // (row.Cells[2].Controls[0] as TextBox).Text;

            String date = this.empTable.Rows[e.NewEditIndex].Cells[3].Text.ToString().TrimStart().TrimEnd();
            DateTime inputDate = DateTime.ParseExact(date, "dd-MMM-yy", CultureInfo.InvariantCulture);

            txtdob.Text = inputDate.ToString("dd/MM/yyyy");


            txtcontact.Text = this.empTable.Rows[e.NewEditIndex].Cells[4].Text;
            btnSave.Text = "Update";

            empTable.EditIndex = -1;
            this.BindGrid();

            string script = "$('#addModal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }

        protected void modal_Click(object sender, EventArgs e)
        {
            string script = "$('#addModal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);

            txtID.Text = "";
            txtname.Text = "";
            txtdob.Text = "";
            txtcontact.Text = "";
            btnSave.Text = "Save";


            empTable.EditIndex = -1;
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