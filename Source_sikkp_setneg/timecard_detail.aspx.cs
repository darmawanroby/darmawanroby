///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : timecard_detail.aspx.cs                             (Pseudo code)

//        File terkait  : timecard_detail.aspx                                (Form)
//                        \App_LocalResources\timecard_detail.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\timecard_detail.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                           (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk mengelompokan waktu kerja

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 11/09/2009
//
// 4. Versi             : 2.0.2
//
// 5. Historis revisi
//        Versi 2.0.1   : Penyempurnaan Filter
//        Versi 2.0.2   : Implementasi AJAX
//
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;
using System.Web.UI;

namespace rtwin
	{
		
		public partial class timecard_detail : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            //fungsi: mengatur Filter dari Gridview
            private void doFiltering()
            {
                string strFilter = "";

                if (ddlItem0Filter.SelectedValue.Trim() != "")
                {
                    strFilter += "KODE_RANGE = '" + ddlItem0Filter.SelectedValue + "'";
                }

                if (ddlItem1Filter.SelectedValue.Trim() != "")
                {
                    if (strFilter != "")
                    {
                        strFilter += " AND KODE_DEPARTEMEN = '" + ddlItem1Filter.SelectedValue + "'";
                    }
                    else
                    {
                        strFilter += "KODE_DEPARTEMEN = '" + ddlItem1Filter.SelectedValue + "'";
                    }
                }
                dsRangeDetail.FilterExpression = strFilter;
            }

            protected void ddlItem0Filter_DataBound(object sender, EventArgs e)
            {
                doFiltering();
                GvTimeCardDetail.DataBind();
            }

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GvTimeCardDetail.Visible = show;
                FvTimeCardDetail.Visible = !show;
                if (show)
                {
                    FvTimeCardDetail.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //method yang di eksekusi ketika halaman di load
			protected void Page_Load(object sender, EventArgs e)
            {
                //Seleksi Hak akses Halaman
                if (!rtwin.azlib.AksesHalaman(1, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    //Redirect ke page notauthorized.aspx bila tidak berhak mengakses
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    if (!Page.IsPostBack)
                    {
                        //seleksi jika selain Administrator (Administrator: Session["GradeID"] = 1)
                        if (Session["GradeID"].ToString() != "1")
                        {
                            lnkBtnInsert.Visible = false;
                            ImgBtnAdd.Visible = false;
                            GvTimeCardDetail.Columns[3].Visible = false;
                            GvTimeCardDetail.Columns[4].Visible = false;
                        }

                        GvTimeCardDetail.Columns[5].Visible = false;
                    }

                    doFiltering();
                }
            }

            protected void lnkBtnInsert_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    //Seleksi apakah data kosong atau tidak, 
                    //jika kosong maka proses tambah data dilakukan melalui formView, 
                    //jika tidak kosong maka proses tambah data dilakukan melalui GridView, 
                    if (GvTimeCardDetail.Rows.Count > 0)
                    {
                        //Data tidak kosong
                        sendToLastPage = true;
                        GvTimeCardDetail.ShowFooter = true;
                        this.ScriptManager1.SetFocus(GvTimeCardDetail.FooterRow.Cells[0].FindControl("txtCol2Footer").ClientID);
                    }
                    else
                    {
                        //Data Kosong
                        FvTimeCardDetail.DefaultMode = FormViewMode.Insert;
                        FvTimeCardDetail.DataBind();
                        this.ScriptManager1.SetFocus(FvTimeCardDetail.FindControl("txtCol2FormView").ClientID);
                    }
                }
            }

            protected void ImgBtnAdd_Click(object sender, ImageClickEventArgs e)
            {
                lnkBtnInsert_Click(sender, e);
            }

            protected void GridView1_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (GvTimeCardDetail.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GvTimeCardDetail.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GvTimeCardDetail.PageIndex = GvTimeCardDetail.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GvTimeCardDetail.PageIndex + 1);
                        lblJumlahHalaman.Text = GvTimeCardDetail.PageCount.ToString();
                    }
                    showGridView(true);
                }
                else
                {
                    //Data kosong, set gridview visible false, formview visible true
                    showGridView(false);
                }
            }

            protected void GridView1_RowCommand1(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
            {
                if (e.CommandName == "Insert")
                {
                    if (Page.IsValid)
                    {
                        dsRangeDetail.Insert();
                    }
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GvTimeCardDetail.ShowFooter = false;
                }
            }

            protected void GridView1_RowDataBound1(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
            {
                //menambahkan State Row on Hover
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    GridView gv = ((GridView)sender);

                    String className = ((e.Row.RowState == DataControlRowState.Alternate) ? gv.AlternatingRowStyle.CssClass : gv.RowStyle.CssClass);

                    e.Row.Attributes.Add("onmouseover", "this.className='datagrid_hovcol';");

                    e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");
                }
                //Menghilangkan tombol delete dan set focus ke isian textbox saat row pada kondisi edit
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    e.Row.FindControl("imgDelete").Visible = false;

                    //this.ScriptManager1.SetFocus(e.Row.FindControl("txtCol1Edit").ClientID);
                }
            }

            protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    GvTimeCardDetail.EditIndex = e.NewEditIndex;
                    GvTimeCardDetail.DataBind();
                    this.ScriptManager1.SetFocus(GvTimeCardDetail.Rows[e.NewEditIndex].Cells[2].FindControl("txtCol2Edit").ClientID);
                }
                else
                {
                    e.Cancel = true;
                }
            }

            protected void GvTimeCardDetail_RowUpdating(object sender, GridViewUpdateEventArgs e)
            {
                string kode_range = ((DropDownList)(GvTimeCardDetail.Rows[e.RowIndex].FindControl("ddlCol0Edit"))).SelectedValue;
                string kode_departemen = ((DropDownList)(GvTimeCardDetail.Rows[e.RowIndex].FindControl("ddlCol1Edit"))).SelectedValue;
                dsRangeDetail.UpdateCommand = "update taRangeDetail set KODE_RANGE = '" + kode_range + "', KODE_DEPARTEMEN='" + kode_departemen + "', KET_RANGE=@KET_RANGE WHERE KODE_RANGE=@KODE_RANGE AND KODE_DEPARTEMEN=@KODE_DEPARTEMEN";
            }
            
            protected void FvTimeCardDetail_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    FvTimeCardDetail.DefaultMode = FormViewMode.ReadOnly;
                }
            }			
			
			protected void txtHalaman_TextChanged1(object sender, EventArgs e)
			{
				GridViewRow rowPager = GvTimeCardDetail.BottomPagerRow;
				TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));
				
				try
				{
                    if (int.Parse(txtHalaman.Text) <= GvTimeCardDetail.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
					{
                        GvTimeCardDetail.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvTimeCardDetail.DataBind();
					}
				}
				catch (Exception)
				{
                    txtHalaman.Text = (GvTimeCardDetail.PageIndex + 1).ToString();
				}
			}
			
			protected void dsRangeDetail_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
			{
                if (GvTimeCardDetail.Rows.Count > 0)
                {
                    e.Command.Parameters["@KODE_RANGE"].Value = ((DropDownList)(GvTimeCardDetail.FooterRow.FindControl("ddlCol0Footer"))).SelectedValue;
                    e.Command.Parameters["@KODE_DEPARTEMEN"].Value = ((DropDownList)(GvTimeCardDetail.FooterRow.FindControl("ddlCol1Footer"))).SelectedValue;
                    e.Command.Parameters["@KET_RANGE"].Value = ((TextBox)(GvTimeCardDetail.FooterRow.FindControl("txtCol2Footer"))).Text;
                }
			}
			
			protected void dsRangeDetail_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
			{
				if (e.AffectedRows == 0)
				{
					ExceptionDetails.Text = e.Exception.Message;
					ExceptionDetails.Visible = true;
					e.ExceptionHandled = true;
				}
				else
				{
					rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1151", e.Command.Parameters["@KODE_RANGE"].Value + " , " + e.Command.Parameters["@KODE_DEPARTEMEN"].Value, Application["strCn"].ToString());
				}
                GvTimeCardDetail.ShowFooter = false;
                showGridView(true);
			}
			
			protected void dsRangeDetail_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
			{
				if (e.AffectedRows == 0)
				{
					ExceptionDetails.Text = e.Exception.Message;
					ExceptionDetails.Visible = true;
					e.ExceptionHandled = true;
				}
				else
				{
					rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1152", e.Command.Parameters["@KODE_RANGE_AWAL"].Value + " --> " + e.Command.Parameters["@KODE_RANGE"].Value + " , " + e.Command.Parameters["@KODE_DEPARTEMEN_AWAL"].Value + " --> " + e.Command.Parameters["@KODE_DEPARTEMEN"].Value, Application["strCn"].ToString());
				}
			}
            
            protected void dsRangeDetail_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
			{
				if (e.AffectedRows != 0)
				{
					rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1153", e.Command.Parameters["@KODE_RANGE"].Value + " , " + e.Command.Parameters["@KODE_DEPARTEMEN"].Value, Application["strCn"].ToString());
				}
				else
				{
					ExceptionDetails.Text = lblCannotUpdate.Text + " --> " + e.Exception.Message;
					ExceptionDetails.Visible = true;
					e.ExceptionHandled = true;
				}
			}
}
	}
