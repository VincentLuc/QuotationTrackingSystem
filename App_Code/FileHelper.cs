using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

/// <summary>
/// Summary description for FileHelper
/// </summary>
public static class FileHelper
{
    public static string GetEnquiryFolderPath(int id) {     
        if (!Directory.Exists(HttpContext.Current.Server.MapPath(Path.Combine("~/Uploads/", id.ToString())))) {
            Directory.CreateDirectory(HttpContext.Current.Server.MapPath(Path.Combine("~/Uploads/", id.ToString())));
        }
        var path = HttpContext.Current.Server.MapPath(Path.Combine("~/Uploads/", id.ToString()));
        return path ;
    }
}