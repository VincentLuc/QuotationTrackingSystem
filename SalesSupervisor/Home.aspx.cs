using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class SalesSupervisor_Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindDataToGridView();
    }

     protected void gvSalesUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvSalesUsers.PageIndex = e.NewPageIndex;
        BindDataToGridView();
    }
    protected void gvSalesUsers_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;
        for (int i = 0; i < e.Row.Cells.Count; i++)
        {
            e.Row.Cells[i].HorizontalAlign = HorizontalAlign.Center;
        }
    }

    protected void BindDataToGridView()
    {
        QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("User Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Role", typeof(string)));
        dt.Columns.Add(new DataColumn("Status", typeof(string)));
        dt.Columns.Add(new DataColumn("Created At", typeof(string)));

        int CurrentUserId = CurrentUser.Id();
        var list = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.SupervisorId == CurrentUserId).ToList();

        foreach (var x in list)
        {
            dr = dt.NewRow();
            dr["User Name"] = x.UserName;
            dr["Role"] = StringHelper.ToSentenceCase(x.Role);
            dr["Status"] = x.Status;
            dr["Created At"] = DateTimeHelper.ConvertToString(x.CreatedAt.ToString());
            dt.Rows.Add(dr);
        }

        gvSalesUsers.DataSource = dt;
        gvSalesUsers.DataBind();
    }
}
