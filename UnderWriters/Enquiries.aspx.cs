using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class UnderWriters_Enquiries : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdnScope.Value = Request.QueryString["scope"] == null ? "all" : Request.QueryString["scope"].ToString().Trim();
        }
        BindDataToGridView();
    }

    protected void gvEnquiries_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvEnquiries.PageIndex = e.NewPageIndex;
        BindDataToGridView();
    }

    protected void gvEnquiries_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;

        LinkButton lb = new LinkButton();
        lb.CommandArgument = e.Row.Cells[5].Text;
        lb.CommandName = "NumClick";
        lb.Text = "Details";
        lb.PostBackUrl = "EnquiryDetails.aspx?id=" + e.Row.Cells[5].Text;
        e.Row.Cells[5].Controls.Add((Control)lb);

        for (int i = 0; i < e.Row.Cells.Count; i++)
        {
            e.Row.Cells[i].HorizontalAlign = HorizontalAlign.Center;
        }
    }

    protected void BindDataToGridView() {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        
        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("Client Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Phone", typeof(string)));
        dt.Columns.Add(new DataColumn("Status", typeof(string)));
        dt.Columns.Add(new DataColumn("Submitted By (Sales User)", typeof(string)));
        dt.Columns.Add(new DataColumn("Submitted At", typeof(string)));
        dt.Columns.Add(new DataColumn("Details", typeof(string)));

        var _currentUserId = CurrentUser.Id();

        List<int> list = new List<int>();
        foreach (var x in _quotationTrackingSystemDBEntities.EnquiryUsers.Where(x => x.UserId == _currentUserId).ToList())
        {
            list.Add(x.EnquiryId);
        }
        var array = list.ToArray();
        List<Enquiry> enquiryList;
        if (hdnScope.Value == "all") {
            enquiryList = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.UnderWriterId == _currentUserId || array.Contains(x.Id)).OrderByDescending(x => x.CreatedAt).ToList();
        } else {
            enquiryList = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.UnderWriterId == _currentUserId || array.Contains(x.Id)).Where(x => x.Status == hdnScope.Value).OrderByDescending(x => x.CreatedAt).ToList();
        }

        foreach (var x in enquiryList){
            dr = dt.NewRow();
            dr["Client Name"] = x.ClientName;
            dr["Phone"] = x.Phone1;
            dr["Status"] = StringHelper.ToSentenceCase(x.Status);
            dr["Submitted By (Sales User)"] = x.tblUser.UserName;
            dr["Submitted At"] = DateTimeHelper.ConvertToString(x.CreatedAt.ToString());
            dr["Details"] = x.Id;
            dt.Rows.Add(dr);
        }

        gvEnquiries.DataSource = dt;
        gvEnquiries.DataBind();
    }
}