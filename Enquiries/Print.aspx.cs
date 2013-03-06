using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Collections;

public partial class Enquiries_Print : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    public Enquiry enquiry;
    protected void Page_Load(object sender, EventArgs e)
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        hdnEnquiryId.Value = Request.QueryString["id"];
        var _enquiryId = int.Parse(hdnEnquiryId.Value);
        int _currentUserId = CurrentUser.Id();
        Hashtable hash = EnquiryHelper.CanAccessEnquiry(_currentUserId, _enquiryId, true);
        if (!(bool)hash["CanAccess"])
        {
            Session["ErrorMessage"] = "You are not authorized to access that enquiry !";
            Response.Redirect("Index.aspx");
            return;
        }
        enquiry = (Enquiry)hash["Enquiry"];
    }
}