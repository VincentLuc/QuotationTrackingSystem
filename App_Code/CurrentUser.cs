using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;

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

    public static string GetRedirectPath(string role) {
        String returnUrl1 = "";
        if (role == "super_admin")
        {
            returnUrl1 = "/ASM/Users/Index.aspx";
        }
        else if (role == "admin")
        {
            returnUrl1 = "/ASM/Hardwares/Index.aspx";
        }
        else if (role == "dispose_items")
        {
            returnUrl1 = "/ASM/DisposeItems/Index.aspx";
        }
        else if (role == "po_deliveries_master")
        {
            returnUrl1 = "/ASM/PODeliveriesMaster/Index.aspx";
        }
        else if (role == "smart_streem_logs_master")
        {
            returnUrl1 = "/ASM/SmartStreemLogsMaster/Index.aspx";
        }
        else if (role == "store_logs")
        {
            returnUrl1 = "/ASM/StoreLogs/Index.aspx";
        }
        return returnUrl1;
    }
}