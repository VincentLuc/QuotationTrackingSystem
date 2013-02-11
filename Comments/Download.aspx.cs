using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Comments_Download : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        QuotationTrackingSystemDBModel.QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBModel.QuotationTrackingSystemDBEntities();
        var _commentId = int.Parse(Request.QueryString["id"]);
        var _comment = _quotationTrackingSystemDBEntities.Comments.Where(x => x.Id == _commentId).FirstOrDefault();
        if ((_comment == null) || (string.IsNullOrEmpty(_comment.FilePath))) {
            var path = CurrentUser.GetRedirectPath(CurrentUser.Role());
            var message = _comment == null ? "Comment does not exists in the system !" : "Comment  does not have any file attached !";
            Session["ErrorMessage"] = message;
            Response.Redirect(path);
            return;
        }
        System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
        response.ClearContent();
        response.Clear();
        response.ContentType = "text/plain";
        response.AddHeader("Content-Disposition", "attachment; filename=" + _comment.FileName + ";");
        response.TransmitFile(_comment.FilePath);
        response.Flush();
        response.End();
    }
}