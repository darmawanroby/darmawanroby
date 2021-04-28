
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;

namespace rtwin
	{
    public partial class wfhschedule : BasePage
		{
             

            //fungsi: mengatur state ketika page diload ex: seleksi izin akses dan otorisasi
            protected void Page_Load(object sender, System.EventArgs e)
			{
                
                if (!azlib.AksesHalaman(14, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    //seleksi jika selain Administrator (Administrator: Session["GradeID"] = 1)
                    if ((!Page.IsPostBack) && (Session["GradeID"].ToString() != "1"))
                    {
                        
                    }
                }
                int bln = DateTime.Now.Month;

                byte i;
                ListItem li = new ListItem();
                for (i = 1; i <= 12; i++)
                {
                    li = new ListItem((DateTime.Parse(i.ToString() + "/" + i.ToString() + " /1900")).ToString("MMMM"), i.ToString()); //Format(DateTime.Parse(CStr(i) & "/" & CStr(i) & " /1900"), "MMMM"), CStr(i))
                    blnFilter.Items.Add(li);
                }

                blnFilter.Value = bln.ToString();

                li = new ListItem(System.Convert.ToString(DateTime.Now.Year - 3), System.Convert.ToString(DateTime.Now.Year - 3));
                thnFilter.Items.Add(li);
                li = new ListItem(System.Convert.ToString(DateTime.Now.Year - 2), System.Convert.ToString(DateTime.Now.Year - 2));
                thnFilter.Items.Add(li);
                li = new ListItem(System.Convert.ToString(DateTime.Now.Year - 1), System.Convert.ToString(DateTime.Now.Year - 1));
                thnFilter.Items.Add(li);
                li = new ListItem(DateTime.Now.Year.ToString(), DateTime.Now.Year.ToString());
                thnFilter.Items.Add(li);
                thnFilter.Value = DateTime.Now.Year.ToString();

			}
			
        }
}
