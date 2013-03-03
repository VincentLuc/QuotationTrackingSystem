using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;

public partial class Users_Details : System.Web.UI.Page
{
    QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    protected tblUser _user;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            hdnFldUserId.Value = Request.QueryString["id"];
        }
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var UserId = int.Parse(hdnFldUserId.Value);
        _user = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == UserId).First();
    }

}