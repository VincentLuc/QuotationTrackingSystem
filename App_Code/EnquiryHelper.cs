using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using QuotationTrackingSystemDBModel;
using System.Collections;

/// <summary>
/// Summary description for EnquiryHelper
/// </summary>
public static class EnquiryHelper
{
    public static Hashtable CanAccessEnquiry(int _userId, int _enquiryId, bool forSaleUser) {
        bool _returnValue;
        Hashtable hash = new Hashtable();
        Hashtable _returnHash;
        _returnHash = HasDirectAccess(_userId, _enquiryId, forSaleUser);
        _returnValue = (bool)_returnHash["Access"];
        if (_returnValue) {
            hash.Add("CanAccess", _returnValue);
            hash.Add("DirectAccess", _returnValue);
            hash.Add("InDirectAccess", false);
            hash.Add("Enquiry", _returnHash["Enquiry"]);
            return hash;
        }
        _returnHash = HasInDirectAccess(_userId, _enquiryId, forSaleUser);
        _returnValue = (bool)_returnHash["Access"];
        hash.Add("CanAccess", _returnValue);
        hash.Add("DirectAccess", false);
        hash.Add("InDirectAccess", _returnValue);
        hash.Add("Enquiry", _returnHash["Enquiry"]);
        return hash;
    }

    public static Hashtable HasDirectAccess(int _userId, int _enquiryId, bool forSaleUser)
    {
        QuotationTrackingSystemDBEntities _entity = new QuotationTrackingSystemDBEntities();
        Enquiry _enquiry;
        if(forSaleUser){
          _enquiry = _entity.Enquiries.Where(x => x.CreatedBy == _userId).Where(x => x.Id == _enquiryId).FirstOrDefault();
        }else{
          _enquiry = _entity.Enquiries.Where(x => x.UnderWriterId == _userId).Where(x => x.Id == _enquiryId).FirstOrDefault();
        }
        var _returnValue = _enquiry == null ? false : true;
        Hashtable hash = new Hashtable();
        hash.Add("Access", _returnValue);
        hash.Add("Enquiry", _enquiry);
        return hash;
    }

    public static Hashtable HasInDirectAccess(int _userId, int _enquiryId, bool forSaleUser)
    {
        QuotationTrackingSystemDBEntities _entity = new QuotationTrackingSystemDBEntities();
        EnquiryUser _enquiryUser = _entity.EnquiryUsers.Where(x => x.UserId == _userId).Where(x => x.EnquiryId == _enquiryId).FirstOrDefault();
        var _returnValue = _enquiryUser == null ? false : true;
        Hashtable hash = new Hashtable();
        hash.Add("Access", _returnValue);
        if (_returnValue) {
            Enquiry _enquiry = _entity.Enquiries.Where(x => x.Id == _enquiryId).First();
            hash.Add("Enquiry", _enquiry);
        } else {
            hash.Add("Enquiry", null);
        }
        return hash;
    }

    public static void SendNotifications(QuotationTrackingSystemDBEntities _entity, Enquiry _enquiry, string _currentUserName, string _notificationText, bool forSaleUser) {
        Notification notification;
        var _currentUserId = CurrentUser.Id();
        if (forSaleUser){
            notification = new Notification { IsRead = "False", UserId = _enquiry.CreatedBy, CreatedAt = DateTime.Now, CreatedBy = _currentUserName, Text = _notificationText, EnquiryId = _enquiry.Id };
        }else{
            notification = new Notification { IsRead = "False", UserId = _enquiry.UnderWriterId, CreatedAt = DateTime.Now, CreatedBy = _currentUserName, Text = _notificationText, EnquiryId = _enquiry.Id };
        }
        _entity.AddToNotifications(notification);
        foreach (var x in _entity.EnquiryUsers.Where(x => x.EnquiryId == _enquiry.Id).ToList()) {
            if (_currentUserId != x.UserId){
                notification = new Notification { IsRead = "False", UserId = x.UserId, CreatedAt = DateTime.Now, CreatedBy = _currentUserName, Text = _notificationText, EnquiryId = _enquiry.Id };
                _entity.AddToNotifications(notification);
            }
        }
    }

    public static string EnquiryUnderWriterName(Enquiry _enquiry) {
        QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        return _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Id == _enquiry.UnderWriterId).First().UserName;
    }
}