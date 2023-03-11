using Oracle.ManagedDataAccess.Client;
using System;
using System.Data;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Department : System.Web.UI.Page
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
            cmd.CommandText = @"SELECT  DEPARTMENT_ID, DEPARTMENT_NAME FROM Department";
            cmd.CommandType = CommandType.Text;

            DataTable dt = new DataTable("department");

            using (OracleDataReader sdr = cmd.ExecuteReader())
            {
                dt.Load(sdr);
            }
            con.Close();
            depTable.DataSource = dt;
            depTable.DataBind();
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            // insert code
            string name = txtname.Text.ToString();

            OracleConnection con = new OracleConnection(constr);

            if (btnSave.Text == "Save")
            {
                OracleCommand cmd = new OracleCommand("Insert into department(DEPARTMENT_NAME) Values('" + name + "')");
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
            else if (btnSave.Text == "Update")
            {
                //get ID for the Update
                string ID = txtID.Text.ToString();
                OracleCommand cmd = new OracleCommand("update department set DEPARTMENT_NAME = '" + name + "' where DEPARTMENT_ID = " + ID);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                btnSave.Text = "Save";
                depTable.EditIndex = -1;

            }
            txtID.Text = "";
            txtname.Text = "";

            this.BindGrid();
        }


        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            txtID.Text = "";
            txtname.Text = "";
            btnSave.Text = "Save";


            depTable.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int ID = Convert.ToInt32(depTable.DataKeys[e.RowIndex].Values[0]);
            using (OracleConnection con = new OracleConnection(constr))
            {
                using (OracleCommand cmd = new OracleCommand("DELETE FROM Department WHERE DEPARTMENT_ID =" + ID))
                {
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            this.BindGrid();
            depTable.EditIndex = -1;
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != depTable.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this record?');";
            }
            depTable.EditIndex = -1;
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            // get id for data update
            txtID.Text = this.depTable.Rows[e.NewEditIndex].Cells[1].Text;
            txtname.Text = this.depTable.Rows[e.NewEditIndex].Cells[2].Text.ToString().TrimStart().TrimEnd(); // (row.Cells[2].Controls[0] as TextBox).Text;
            btnSave.Text = "Update";

            depTable.EditIndex = -1;
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
            btnSave.Text = "Save";


            depTable.EditIndex = -1;
            this.BindGrid();
        }
    }
}