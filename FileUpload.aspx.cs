using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class FileUpload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnUploadClick(object sender, EventArgs e)
    {
        HttpPostedFile file = Request.Files["myFile"];
        string fnamex = Path.GetFileName(file.FileName);
        Session["NoticeMessage"] = fnamex;
        //check file was submitted
        if (file != null && file.ContentLength > 0)
        {
            string fname = Path.GetFileName(file.FileName);
            file.SaveAs(Server.MapPath(Path.Combine("~/App_Data/", fname)));
        }

    }
}