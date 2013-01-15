using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using QuotationTrackingSystemDBModel;

/// <summary>
/// Summary description for CurrentUser
/// </summary>
public static class CurrentUser
{
	public static int Id() {
        var cookie = FormsAuthentication.Decrypt(HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
        //return int.Parse(HttpContext.Current.Session["currentUserId"].ToString());
        return int.Parse(cookie.Split('#')[1].ToString());
    }

    public static tblUser DbUser() {
        QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        int CurrentUserId = Id();
        return _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == CurrentUserId).First();
    }

    public static string Role() {
        var cookie = FormsAuthentication.Decrypt(HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
        return cookie.Split('#')[0];
    }

    public static string Action() {
        var cookie = FormsAuthentication.Decrypt(HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
        return cookie.Split('#')[2];
    }

    public static bool CanPerformEdit()
    {
        var cookie = FormsAuthentication.Decrypt(HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
        var action = cookie.Split('#')[2];
        return action == "all" || action == "create_and_edit";
    }

    public static bool CanPerformDelete()
    {
        var cookie = FormsAuthentication.Decrypt(HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
        var action = cookie.Split('#')[2];
        return action == "all";
    }

    public static bool IsSalesSupervisor(string UserId){
        var action = "";
        if (String.Empty == UserId){
            var cookie = FormsAuthentication.Decrypt(HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName].Value).UserData;
            action = cookie.Split('#')[2];
        }
        else {
            int IntUserId = int.Parse(UserId.ToString());
            QuotationTrackingSystemDBModel.QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBModel.QuotationTrackingSystemDBEntities();
            var user = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == IntUserId).First();
            action = user.Role;
        }
        return action == "SalesSupervisor";
    }

    public static string GetRedirectPath(string role) {
        String returnUrl1 = "";
        if (role == "Admin")
        {
            returnUrl1 = "/QuotationTrackingSystem/Admin/Home.aspx";
        }
        else if (role == "Sales")
        {
            returnUrl1 = "/QuotationTrackingSystem/Sales/Home.aspx";
        }
        else if (role == "SalesSupervisor") 
        {
            returnUrl1 = "/QuotationTrackingSystem/SalesSupervisor/Home.aspx";
        }
        else if (role == "UnderWriter")
        {
            returnUrl1 = "/QuotationTrackingSystem/UnderWriters/Home.aspx";
        }
        return returnUrl1;
    }
}