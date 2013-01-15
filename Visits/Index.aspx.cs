using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class Visits_Index : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {
        BindDataToGridView();
    }

    protected void gvVisits_RowDataBound(object sender, GridViewRowEventArgs e){
        if (e.Row.RowType != DataControlRowType.DataRow) return;

        LinkButton lb = new LinkButton();
        lb.CommandArgument = e.Row.Cells[8].Text;
        lb.CommandName = "NumClick";
        lb.Text = "Edit";
        lb.PostBackUrl = "~/Visits/Edit.aspx?id=" + e.Row.Cells[8].Text;
        e.Row.Cells[8].Controls.Add((Control)lb);
        
        for (int i = 0; i < e.Row.Cells.Count; i++){
            e.Row.Cells[i].HorizontalAlign = HorizontalAlign.Center;
        }
    }

    protected void gvVisits_PageIndexChanging(object sender, GridViewPageEventArgs e){
        gvVisits.PageIndex = e.NewPageIndex;
        BindDataToGridView();
    }

    public void BindDataToGridView(){
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("Client Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Contact Person", typeof(string)));
        dt.Columns.Add(new DataColumn("Designation", typeof(string)));
        dt.Columns.Add(new DataColumn("Phone", typeof(string)));
        dt.Columns.Add(new DataColumn("Line Of Insurance", typeof(string)));
        dt.Columns.Add(new DataColumn("Status", typeof(string)));
        dt.Columns.Add(new DataColumn("Policy Start At", typeof(string)));
        dt.Columns.Add(new DataColumn("Remarks", typeof(string)));
        dt.Columns.Add(new DataColumn("Edit", typeof(string)));

        var user = CurrentUser.DbUser();

        foreach (var x in user.Visits.ToList())
        {
            dr = dt.NewRow();
            dr["Client Name"] = x.ClientName;
            dr["Contact Person"] = x.ContactPerson;
            dr["Designation"] = x.Designation;
            dr["Phone"] = x.Phone;
            dr["Line Of Insurance"] = x.LineOfInsurance;
            dr["Status"] = x.Status;
            dr["Policy Start At"] = DateTimeHelper.ConvertToString(x.PolicyStartAt.ToString());
            dr["Remarks"] = x.Remarks;
            dr["Edit"] = x.Id;
            dt.Rows.Add(dr);
        }

        gvVisits.DataSource = dt;
        gvVisits.DataBind();
    }
}