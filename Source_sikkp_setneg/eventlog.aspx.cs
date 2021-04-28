///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : eventlog.aspx.cs                                (Pseudo code)
//
//        File terkait  : eventlog.aspx                                   (Form)
//                        \App_LocalResources\eventlog.aspx.id.resx       (Display label bahasa Indonesia)
//                        \App_LocalResources\eventlog.aspx.en.resx       (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                              (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan tabel log (taLog)
//
//
// 2. Penulis Program
//
//        Programer     : Aas meinardi
//
// 3. Tanggal update    : 12/09/2009
//
// 4. Versi             : 2.0.2
//
// 5. Historis revisi
//        Versi 2.0.1   : Penyempurnaan Filter
//        Versi 2.0.2   : Implementasi AJAX
//
//
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System.Configuration;
using System.Collections;
using System.Data;
using System.Web.Caching;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Diagnostics;
using System.Web.Security;
using System;
using System.Text;
using Microsoft.VisualBasic;
using System.Web.UI.HtmlControls;
using System.Web.SessionState;
using System.Text.RegularExpressions;
using System.Web.Profile;
using System.Collections.Generic;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Specialized;
using System.Web;
using System.Data.SqlClient;
using Udev.MasterPageWithLocalization.Classes;

	namespace rtwin
	{
		public partial class log : BasePage
		{
            //fungsi: Filter GridView
            private void doFiltering()
            {
                try
                {
                    string strFilter = "";

                    strFilter += " AND (TGL >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND TGL <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "')";

                    if (cbCabang.Checked)
                    {
                        if (dropCabang.SelectedValue != "---")
                        {
                            strFilter += " AND KODE_CABANG='" + dropCabang.SelectedValue + "'";
                        }
                    }

                    if (cbUsername.Checked)
                    {
                        strFilter += " AND USERNAME='" + ddlUsername.SelectedValue + "'";
                    }

                    if (cbAktivitas.Checked)
                    {
                        strFilter += " AND KODE_AKTIVITAS='" + ddlAktivitas.SelectedValue + "'";
                    }

                    if (cbTarget.Checked)
                    {
                        strFilter += " AND TARGET LIKE '%" + txtTarget.Text.Replace("'", "''") + "%'";
                    }

                    dsLog.SelectCommand += strFilter;
                }
                catch (Exception ex)
                { }
            }

            //fungsi: set Kondisi Awal Komponen Filter
            private void setFilter()
            {
                string strFilter = "";
                string strFilter2 = "";
                if (Session["GradeID"].ToString() != "1")
                {
                    strFilter += " AND KODE_CABANG ='" + Session["CabangID"].ToString() + "'";
                    strFilter2 += " WHERE KODE_CABANG ='" + Session["CabangID"].ToString() + "'";
                }
                dsActionList.SelectCommand += strFilter;
                dsUserList.SelectCommand += strFilter2 + " ORDER BY USERNAME";
                dsCabang.SelectCommand += strFilter2;
            }
			
			protected void Page_Load(object sender, EventArgs e)
			{
				
				//jika userid kosong maka akan di link ke halaman awal
				if (! rtwin.azlib.AksesHalaman(26, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}
				
				//jika halaman bukan postback
				if (! Page.IsPostBack)
				{
					txtFilterItem0.Text = DateTime.Now.ToShortDateString();
					txtFilterItem1.Text = DateTime.Now.ToShortDateString();
                    setFilter();
				}
				
                doFiltering();
			}
			
			protected void txtHalaman_TextChanged(object sender, EventArgs e)
			{
                GridViewRow rowPager = GvLog.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvLog.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvLog.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvLog.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvLog.PageIndex + 1).ToString();
                }
			}
			
			protected void GvLog_DataBound(object sender, EventArgs e)
			{
				GridViewRow rowPager = GvLog.BottomPagerRow;
				
				if (rowPager != null)
				{
					// get your controls from the gridview
					TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));
					Label lblJumlahHalaman = (Label) (rowPager.Cells[0].FindControl("lblJumlahHalaman"));
					
					txtHalaman.Text = (GvLog.PageIndex + 1).ToString();
					// populate page count
					lblJumlahHalaman.Text = GvLog.PageCount.ToString();
				}
				else
				{
					return;
				}
			}

            protected void GvLog_RowDataBound(object sender, GridViewRowEventArgs e)
            {
                //menambahkan State Row on Hover
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    GridView gv = ((GridView)sender);

                    String className = ((e.Row.RowState == DataControlRowState.Alternate) ? gv.AlternatingRowStyle.CssClass : gv.RowStyle.CssClass);

                    e.Row.Attributes.Add("onmouseover", "this.className='datagrid_hovcol';");

                    e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");
                }
            }

            //fungsi: Refresh GridView
            protected void btnRefresh_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    GvLog.DataBind();
                }
            }
}
		
	}
