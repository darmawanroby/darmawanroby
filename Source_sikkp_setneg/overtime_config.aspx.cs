///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : overtime_config.aspx.cs                             (Pseudo code)

//        File terkait  : overtime_config.aspx                                (Form)
//                        overtime_config.aspx.cs                             (pseudo code)
//                        \App_LocalResources\overtime_config.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\overtime_config.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                                  (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : mengedit tabel Variabel (taVariabel)

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 11/09/2009
//
// 4. Versi             : 2.0.1
//
// 5. Historis revisi
//        Versi 2.0.1   : Implementasi Ajax
//
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
		
		public partial class overtime_config : BasePage
		{
			
			
			
			#region  Web Form Designer Generated Code
			
			//This call is required by the Web Form Designer.
			[System.Diagnostics.DebuggerStepThrough()]private void InitializeComponent()
			{
				
			}
			
			
			private void Page_Init(object sender, EventArgs e)
			{
				//CODEGEN: This method call is required by the Web Form Designer
				//Do not modify it using the code editor.
				InitializeComponent();
			}
			
			#endregion
			
			public void setAksesNotAdmin()
			{
				GvParamLembur.Columns[3].Visible = false;
				Button1.Visible = false;
				txtCol1Item0.Enabled = false;
                txtCol1Item1.Enabled = false;
                txtCol1Item2.Enabled = false;
                txtCol1Item3.Enabled = false;
                txtCol1Item4.Enabled = false;
                txtCol1Item5.Enabled = false;
                txtCol1Item6.Enabled = false;
			}
			
			private void Page_Load(object sender, EventArgs e)
			{
				if (! rtwin.azlib.AksesHalaman(30, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}
				if (! Page.IsPostBack)
				{
					SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                    string strSelect = "Select MIN_LEMBUR,MAKS_LEMBUR,MIN_LEMBUR_LIBUR,MAKS_LEMBUR_LIBUR,MAKS_TOTAL_LEMBUR,BATAS_TERIMA_UANG_MAKAN_LEMBUR,TARIF_UANG_MAKAN_LEMBUR from taVariabel";
					DataSet dsMsg = new DataSet();
					SqlDataAdapter adpSQL = new SqlDataAdapter(strSelect, cn);
					adpSQL.Fill(dsMsg, "taVariabel");
					int recordCount = dsMsg.Tables["taVariabel"].Rows.Count;
					if (recordCount == 1)
					{
                        txtCol1Item0.Text = DateTime.Parse(dsMsg.Tables["taVariabel"].Rows[0]["MIN_LEMBUR"].ToString()).ToString("HH:mm");
                        txtCol1Item1.Text = DateTime.Parse(dsMsg.Tables["taVariabel"].Rows[0]["MAKS_LEMBUR"].ToString()).ToString("HH:mm");
                        txtCol1Item2.Text = DateTime.Parse(dsMsg.Tables["taVariabel"].Rows[0]["MIN_LEMBUR_LIBUR"].ToString()).ToString("HH:mm");
                        txtCol1Item3.Text = DateTime.Parse(dsMsg.Tables["taVariabel"].Rows[0]["MAKS_LEMBUR_LIBUR"].ToString()).ToString("HH:mm");
                        txtCol1Item4.Text = dsMsg.Tables["taVariabel"].Rows[0]["MAKS_TOTAL_LEMBUR"].ToString();
                        txtCol1Item5.Text = dsMsg.Tables["taVariabel"].Rows[0]["BATAS_TERIMA_UANG_MAKAN_LEMBUR"].ToString();
                        txtCol1Item6.Text = dsMsg.Tables["taVariabel"].Rows[0]["TARIF_UANG_MAKAN_LEMBUR"].ToString();
					}
					else
					{
                        txtCol1Item0.Text = "00:00";
                        txtCol1Item1.Text = "00:00";
                        txtCol1Item2.Text = "00:00";
                        txtCol1Item3.Text = "00:00";
                        txtCol1Item4.Text = "0";
                        txtCol1Item5.Text = "0";
                        txtCol1Item6.Text = "0";
					}
					if (System.Convert.ToInt32(Session["GradeID"])> 1)
					{
						setAksesNotAdmin();
					}
					Session.Remove("pageCommand");
				}
			}
			
			protected void dsParamLembur_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
			{
				if (e.AffectedRows == 0)
				{
					ExceptionDetails.Text = lblNotSaved.Text + " (" + e.Exception.Message + ")";
					e.ExceptionHandled = true;
				}
				else
				{
                    TextBox Kode = (TextBox)GvParamLembur.FooterRow.FindControl("txtKode");
					azlib.AddUserAct(Session["UserID"].ToString(), "1154", e.Command.Parameters["@KODE_LEMBUR"].Value.ToString(), Application["strCn"].ToString());
				}
			}
			
			protected void txtHalaman_TextChanged(object sender, EventArgs e)
			{
                GridViewRow rowPager = GvParamLembur.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvParamLembur.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvParamLembur.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvParamLembur.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvParamLembur.PageIndex + 1).ToString();
                }
			}

            protected void GvParamLembur_DataBound(object sender, EventArgs e)
			{
				GridViewRow rowPager = GvParamLembur.BottomPagerRow;
				
				if (rowPager != null)
				{
					// get your controls from the gridview
					TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));
					Label lblJumlahHalaman = (Label) (rowPager.Cells[0].FindControl("lblJumlahHalaman"));
					
					txtHalaman.Text = (GvParamLembur.PageIndex + 1).ToString();
					// populate page count
					lblJumlahHalaman.Text = GvParamLembur.PageCount.ToString();
				}
				else
				{
					return;
				}
				
			}
			
			protected void Button1_Click(object sender, EventArgs e)
			{
                if (Page.IsValid)
                {
                    SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                    SqlCommand cmd = new SqlCommand();
                    cn.Open();
                    cmd.CommandText = "update taVariabel set MIN_LEMBUR = '1/1/1900 " + txtCol1Item0.Text + ":00',MAKS_LEMBUR = '1/1/1900 " + txtCol1Item1.Text + ":00',MIN_LEMBUR_LIBUR = '1/1/1900 " + txtCol1Item2.Text + ":00',MAKS_LEMBUR_LIBUR = '1/1/1900 " + txtCol1Item3.Text + ":00',MAKS_TOTAL_LEMBUR = " + txtCol1Item4.Text + ",BATAS_TERIMA_UANG_MAKAN_LEMBUR = " + txtCol1Item5.Text + ",TARIF_UANG_MAKAN_LEMBUR = " + txtCol1Item6.Text + "";
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = cn;
                    try
                    {
                        cmd.ExecuteNonQuery();
                        ExceptionDetails2.Text = lblConfigUpdated.Text;
                        rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1155", "", Application["strCn"].ToString());
                    }
                    catch (Exception ex)
                    {
                        ExceptionDetails2.Text = lblConfigNotUpdated.Text + ex.Message;
                    }
                    cn.Close();
                    Button1.Focus();
                }
			}

            protected void GvParamLembur_RowDataBound(object sender, GridViewRowEventArgs e)
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

            protected void GVCabang_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (GVCabang.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GVCabang.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GVCabang.PageIndex + 1);
                        lblJumlahHalaman.Text = GVCabang.PageCount.ToString();
                    }
                }
            }
            protected void GVCabang_RowDataBound(object sender, GridViewRowEventArgs e)
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
}
		
	}
