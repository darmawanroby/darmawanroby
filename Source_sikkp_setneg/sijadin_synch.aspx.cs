using rtwin;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class sijadin_synch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!azlib.AksesHalaman(6, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
        {
            Response.Redirect("notauthorized.aspx");
        }
    }
}