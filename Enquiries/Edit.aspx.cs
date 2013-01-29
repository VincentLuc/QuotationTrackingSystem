using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QuotationTrackingSystemDBModel;
using System.Data;
using System.Collections;

public partial class Enquiries_Edit : System.Web.UI.Page
{
    protected QuotationTrackingSystemDBEntities _quotationTrackingSystemDBEntities;
    public Enquiry enquiry;
    protected tblUser _tblUser;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack){
            hdnEnquiryId.Value = Request.QueryString["id"];
            var CurrentUserId = CurrentUser.Id();
            int enquiryId = int.Parse(hdnEnquiryId.Value);
            _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
            enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.CreatedBy == CurrentUserId).Where(x => x.Id == enquiryId).FirstOrDefault();
            if (enquiry == null){
                Session["ErrorMessage"] = "Enquiry not found !";
                Response.Redirect("Index.aspx");
                return;
            }
            BindDdlUnerderWritersDropDown();
            BindDdInsuranceTypesDropDown();
            ddlUnderwriterId.SelectedValue = enquiry.UnderWriterId.ToString();
            ddlInsuranceType.SelectedValue = enquiry.InsuranceType;
            txtClientName.Text = enquiry.ClientName;
            txtContactPersonName.Text = enquiry.ContactPersonName;
            txtPhone.Text = enquiry.Phone;
            txtPolicyStartAt.Text = DateTimeHelper.ConvertToString(enquiry.PolicyStartAt.ToString());
            txtAddress.Text = enquiry.Address;
            txtRemarks.Text = enquiry.Remarks;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        HttpPostedFile fileCRCopy = Request.Files["fileCRCopy"];
        HttpPostedFile lossRatioFile = Request.Files["fileLossRatioReport"];
        
        _quotationTrackingSystemDBEntities = new QuotationTrackingSystemDBEntities();
        var enquiryId = int.Parse(hdnEnquiryId.Value);
        var _enquiry = _quotationTrackingSystemDBEntities.Enquiries.Where(x => x.Id == enquiryId).FirstOrDefault();
        _enquiry.PolicyStartAt = DateTimeHelper.ConvertToDate(txtPolicyStartAt.Text);
        _enquiry.ClientName = txtClientName.Text.Trim();
        _enquiry.ContactPersonName = txtContactPersonName.Text.Trim();
        _enquiry.Phone = txtPhone.Text.Trim();
        _enquiry.InsuranceType = ddlInsuranceType.SelectedValue;
        _enquiry.UnderWriterId = int.Parse(ddlUnderwriterId.SelectedValue);
        _enquiry.Address = txtAddress.Text.Trim();
        _enquiry.Remarks = txtRemarks.Text.Trim();
        _enquiry.UpdatedAt = DateTime.Now;
        Hashtable hash = FileHelper.GetFilesDetails(fileCRCopy, lossRatioFile, _enquiry);
        if (fileCRCopy != null && fileCRCopy.ContentLength > 0){
            _enquiry.CRCopyName = hash["CRFileName"].ToString();
            _enquiry.CRCopyPath = hash["CRFilePath"].ToString();
        }
        if (lossRatioFile != null && lossRatioFile.ContentLength > 0){
            _enquiry.LossRatioReportName = hash["LossRatioFileName"].ToString();
            _enquiry.LossRatioReportPath = hash["LossRatioFilePath"].ToString();
        }
        _quotationTrackingSystemDBEntities.SaveChanges();
        Session["NoticeMessage"] = "Successfully updated enquiry !";
        Response.Redirect("Details.aspx?id="+_enquiry.Id);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Details.aspx?id=" + hdnEnquiryId.Value);
    }

    protected void BindDdlUnerderWritersDropDown() {
        var _users = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Role == "UnderWriter");
        DataTable table = new DataTable();
        table.Columns.Add("Text");
        table.Columns.Add("Value");
        DataRow defaultRow = table.NewRow();
        defaultRow["Text"] = "Select";
        defaultRow["Value"] = 0;
        table.Rows.Add(defaultRow);
        foreach (var x in _users)
        {
            DataRow dr = table.NewRow();
            dr["Value"] = x.Id;
            dr["Text"] = x.UserName;
            table.Rows.Add(dr);
        }
        ddlUnderwriterId.DataSource = table;
        ddlUnderwriterId.DataTextField = table.Columns["Text"].ColumnName;
        ddlUnderwriterId.DataValueField = table.Columns["Value"].ColumnName;
        ddlUnderwriterId.DataBind();
    }

    protected void BindDdInsuranceTypesDropDown()
    {
        var _users = _quotationTrackingSystemDBEntities.tblUsers.Where(x => x.Role == "UnderWriter");
        string[] text = {"Motor", "Group Medical", "Property", "General Accident", "Marine", "Engineering"};
        string[] values = { "Motor", "GroupMedical", "Property", "GeneralAccident", "Marine", "Engineering" };
        DataTable table = new DataTable();
        table.Columns.Add("Text");
        table.Columns.Add("Value");
        DataRow defaultRow = table.NewRow();
        defaultRow["Text"] = "Select";
        defaultRow["Value"] = 0;
        table.Rows.Add(defaultRow);
        int i = 0;
        foreach (var x in text){
            DataRow dr = table.NewRow();
            dr["Value"] = values[i];
            dr["Text"] = x;
            table.Rows.Add(dr);
            i += 1;
        }
        ddlInsuranceType.DataSource = table;
        ddlInsuranceType.DataTextField = table.Columns["Text"].ColumnName;
        ddlInsuranceType.DataValueField = table.Columns["Value"].ColumnName;
        ddlInsuranceType.DataBind();
    }
   
}