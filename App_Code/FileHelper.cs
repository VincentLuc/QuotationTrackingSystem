using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using QuotationTrackingSystemDBModel;
using System.Collections;

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

    public static Hashtable GetFilesDetails(HttpPostedFile crFile, HttpPostedFile lossRatioFilex, Enquiry enquiry)
    {
        var _timeStamp = DateTimeHelper.ToTimeStamp();
        var path = FileHelper.GetEnquiryFolderPath(enquiry.Id);
        var _CRFileName = "";
        var _CRFilePath = "";

        if (crFile != null && crFile.ContentLength > 0){
            _CRFileName = "cr_file_" + _timeStamp + "_" + Path.GetFileName(crFile.FileName);
            _CRFilePath = path + "\\" + _CRFileName;
            crFile.SaveAs(_CRFilePath);
        }

        var _lossRatioFileName = "";
        var _lossRatioFilePath = "";

        if (lossRatioFilex != null && lossRatioFilex.ContentLength > 0){
            _lossRatioFileName = "loss_ratio_" + _timeStamp + "_" + Path.GetFileName(lossRatioFilex.FileName);
            _lossRatioFilePath = path + "\\" + _lossRatioFileName;
            lossRatioFilex.SaveAs(_lossRatioFilePath);
        }
        Hashtable _hash = new Hashtable();
        _hash.Add("CRFileName", _CRFileName);
        _hash.Add("CRFilePath", _CRFilePath);
        _hash.Add("LossRatioFileName", _lossRatioFileName);
        _hash.Add("LossRatioFilePath", _lossRatioFilePath);
        return _hash;
    }
}