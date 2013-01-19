using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;

public partial class SalesSupervisor_Details : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    public List<VisitDetails> _visitDetailsList;
    public VisitDetails _visitDetails;
    protected void Page_Load(object sender, EventArgs e)
    {
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var qurey =
           from v in _quotationTrackingSystemDBEntities.Visits
           join u in _quotationTrackingSystemDBEntities.tblUsers
             on v.UserId equals u.Id
           group v by new { y = v.CreatedAt.Year, m = v.CreatedAt.Month, d = v.CreatedAt.Day, u.UserName } into x
           select new { x.Key.UserName, x.Key.d, x.Key.m, x.Key.y, countx = x.Count() };

        var dataList = qurey.ToList();

        _visitDetailsList = new List<VisitDetails>();
        foreach (var x in dataList) { 
            _visitDetails = new VisitDetails();
            _visitDetails.UserName = x.UserName;
            _visitDetails.VisitedAt = x.d.ToString() + "/" + x.m.ToString() + "/" + x.y.ToString();
            _visitDetails.Count = x.countx;
            _visitDetailsList.Add(_visitDetails);
        }
    }
}
