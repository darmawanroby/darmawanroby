///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : upload_report.aspx.cs                              (Pseudo code)

//        File terkait  : upload_report.aspx                                 (Form)
//                        \App_LocalResources\upload_report.aspx.id.resx     (Display label bahasa Indonesia)
//                        \App_LocalResources\upload_report.aspx.en.resx     (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                                 (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan data report entry dan pengolahannya

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 12/09/2009
//
// 4. Versi             : 2.0.3
//
// 5. Historis revisi
//        Versi 2.0.1   : Implementasi AJAX
//        Versi 2.0.2   : Penambahan Tanda Tangan Pengesahan
//
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

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
		
		public partial class upload_report : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            //fungsi: Filter Gridview
            private void doFiltering()
            {
                if ((ddlFilterSatker.SelectedValue != "---") && (ddlFilterSatker.SelectedValue != ""))
                { 
                    dsLaporanPengesahan.FilterExpression = "KODE_CABANG = '" + ddlFilterSatker.SelectedValue + "'";
                    //dsLaporanPengesahan.SelectCommand = "SELECT taLaporanPengesahan.KODE_LAPORAN, taLaporanPengesahan.KODE_CABANG, taLaporanPengesahan.TTD1_HEADER, taLaporanPengesahan.TTD1, taLaporanPengesahan.TTD2_HEADER, taLaporanPengesahan.TTD2, taLaporanPengesahan.TTD3_HEADER, taLaporanPengesahan.TTD3, taCabang.NAMA_CABANG FROM taLaporanPengesahan INNER JOIN taCabang ON taLaporanPengesahan.KODE_CABANG = taCabang.KODE_CABANG WHERE taLaporanPengesahan.KODE_CABANG = '" + ddlFilterSatker.SelectedValue + "'";
                }
            }

			protected void Page_Load(object sender, EventArgs e)
			{
				//jika User yang login tidak memiliki hak untuk mengakses halaman ini maka akan di link halaman Informasi
				if (! rtwin.azlib.AksesHalaman(30, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}

                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2"))
                {
                    Response.Redirect("notauthorized.aspx");
                }
                else if (Session["GradeID"].ToString() == "2")
                {
                    dsCabang.SelectCommand = "SELECT [KODE_CABANG], [NAMA_CABANG] FROM [taCabang] where [KODE_CABANG] = '" + Session["CabangID"].ToString() + "' ORDER BY [KODE_CABANG]";
                    dsCabang2.SelectCommand = "SELECT [KODE_CABANG], [NAMA_CABANG] FROM [taCabang] where [KODE_CABANG] = '" + Session["CabangID"].ToString() + "' ORDER BY [KODE_CABANG]";
                }

                doFiltering();
			}
			
			protected void GvLaporan_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
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

            //fungsi: Handle ketika terjadi Perintah pada GridView
			protected void GvLaporan_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
			{
				//seleksi kemungkinan perintah pada datarow
				if (e.CommandName == "Insert")
				{
					//memanggil procedure insert
					DsReport.Insert();
				}
                else if (e.CommandName == "Cancel_Insert")
                {
                    GvLaporan.ShowFooter = false;
                }
			}

            //fungsi: Handle Permintaan Tambah data, Tampilkan FormView
            protected void ImgAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
			{
				//visibel=true pada penambahan data
                LinkButton1_Click(sender, e);
            }

            //fungsi: Handle Permintaan Tambah data, Tampilkan FormView
            protected void LinkButton1_Click(object sender, EventArgs e)
            {
                GvLaporan.ShowFooter = true;
            }

            //fungsi: Handle Ketika data pada database telah didelete
			protected void DsReport_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
			{
				//Seleksi apakah terjadi error atau tidak
				//jika tidak ada record yang ter delete maka terjadi error
				if (e.AffectedRows == 0)
				{
					ExceptionDetails.Text = lblCannotUpdate.Text;
					e.ExceptionHandled = true;
				}
				else
				{
					//Catat ke Log
					azlib.AddUserAct(Session["UserID"].ToString(), "3303", e.Command.Parameters["@KODE_LAPORAN"].Value.ToString(), Application["strCn"].ToString());
				}
			}

            //fungsi: Handle Ketika data pada database telah ditambahkan
			protected void DsReport_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
			{
				if (e.AffectedRows == 0)
				{
					//menampilkan kesalahan user
					ExceptionDetails.Text = lblNotSaved.Text + " (" + e.Exception.Message + ")";
					e.ExceptionHandled = true;
				}
				else
				{
					//procedure untuk mencatat event user insert data
					azlib.AddUserAct(Session["UserID"].ToString(), "3301", e.Command.Parameters["@KODE_LAPORAN"].Value.ToString(), Application["strCn"].ToString());
				}
				GvLaporan.ShowFooter = false;
			}

            //fungsi: Handle Ketika akan insert database
			protected void DsReport_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
			{
				//mendeklarasikam objek yang berada di grid view
                TextBox txtkode = (TextBox)GvLaporan.FooterRow.FindControl("txtkode");
                TextBox txtNamaLaporan = (TextBox)GvLaporan.FooterRow.FindControl("txtNamaLaporan");
                TextBox txtNamaLaporanEn = (TextBox)GvLaporan.FooterRow.FindControl("txtNamaLaporanEn");
                TextBox txtKolom = (TextBox)GvLaporan.FooterRow.FindControl("txtKolom");
                TextBox txtKolomGroup = (TextBox)GvLaporan.FooterRow.FindControl("txtKolomGroup");
                TextBox txtKolomFilter = (TextBox)GvLaporan.FooterRow.FindControl("txtKolomFilter");
                TextBox txtFileLaporan = (TextBox)GvLaporan.FooterRow.FindControl("txtFileLaporan");
                DropDownList ddlTipeLaporan = (DropDownList)GvLaporan.FooterRow.FindControl("ddlTipeLaporan");
                DropDownList ddlPeriodeLaporan = (DropDownList)GvLaporan.FooterRow.FindControl("ddlPeriodeLaporan");
                CheckBox cbLapAdm = (CheckBox)GvLaporan.FooterRow.FindControl("cbLapAdm");
                CheckBox cbLapAdm2 = (CheckBox)GvLaporan.FooterRow.FindControl("cbLapAdm2");
                CheckBox cbLapUser = (CheckBox)GvLaporan.FooterRow.FindControl("cbLapUser");
				//menyimpan value pada parameter query
				e.Command.Parameters["@KODE_LAPORAN"].Value = txtkode.Text;
				e.Command.Parameters["@NAMA_LAPORAN"].Value = txtNamaLaporan.Text;
				e.Command.Parameters["@NAMA_LAPORAN_en"].Value = txtNamaLaporanEn.Text;
				e.Command.Parameters["@KOLOM"].Value = txtKolom.Text;
				e.Command.Parameters["@KOLOM_GROUP"].Value = txtKolomGroup.Text;
				e.Command.Parameters["@KOLOM_FILTER"].Value = txtKolomFilter.Text;
				e.Command.Parameters["@FILE_LAPORAN"].Value = txtFileLaporan.Text;
				e.Command.Parameters["@TIPE_LAPORAN"].Value = ddlTipeLaporan.SelectedValue;
				e.Command.Parameters["@PERIODE_LAPORAN"].Value = ddlPeriodeLaporan.SelectedValue;
				e.Command.Parameters["@LAP_ADMIN"].Value = cbLapAdm.Checked;
				e.Command.Parameters["@LAP_OPERATOR"].Value = cbLapAdm2.Checked;
				e.Command.Parameters["@LAP_USER"].Value = cbLapUser.Checked;
			}

            //fungsi: Handle Ketika data pada database telah diupdate
			protected void DsReport_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
			{
				//Seleksi apakah terjadi error atau tidak
				//jika tidak ada record yang ter update maka terjadi error
				if (e.AffectedRows == 0)
				{
					ExceptionDetails.Text = lblCannotUpdate.Text; //& " (" & e.Exception.Message & ")"
					e.ExceptionHandled = true;
				}
				else
				{
					//Catat ke Log
					azlib.AddUserAct(Session["UserID"].ToString(), "3302", e.Command.Parameters["@KODE_LAPORAN"].Value.ToString(), Application["strCn"].ToString());
				}
			}
			
            //fungsi: Handle Upload Report
			protected void Submit1_ServerClick(object sender, EventArgs e)
			{
				if (File1.PostedFile != null&& File1.PostedFile.ContentLength > 0)
				{
					ExceptionDetails.Visible = true;
					string fn = System.IO.Path.GetFileName(File1.PostedFile.FileName);
					string SaveLocation = Server.MapPath("App_Data") + "\\" + fn;
					try
					{
						File1.PostedFile.SaveAs(SaveLocation);
						ExceptionDetails.Text = "The file has been uploaded.";
					}
					catch (Exception Exc)
					{
						ExceptionDetails.Text = "Error: " + Exc.Message;
					}
				}
				else
				{
					ExceptionDetails.Text = "Please select a file to upload.";
				}
			}
			
			protected void GvLaporan_DataBound(object sender, EventArgs e)
			{
				GridViewRow rowPager = GvLaporan.BottomPagerRow;
				
				if (rowPager != null)
				{
					// get your controls from the gridview
					TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));
					Label lblJumlahHalaman = (Label) (rowPager.Cells[0].FindControl("lblJumlahHalaman"));
					
					txtHalaman.Text = (GvLaporan.PageIndex + 1).ToString();
					// populate page count
					lblJumlahHalaman.Text = GvLaporan.PageCount.ToString();
				}
				else
				{
					return;
				}
			}
			
			protected void txtHalaman_TextChanged(object sender, EventArgs e)
			{
                GridViewRow rowPager = GvLaporan.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvLaporan.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvLaporan.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvLaporan.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvLaporan.PageIndex + 1).ToString();
                }
			}

            protected void txtHalaman_TextChanged1(object sender, EventArgs e)
            {
                GridViewRow rowPager = gvLaporanPengesahan.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= gvLaporanPengesahan.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        gvLaporanPengesahan.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        gvLaporanPengesahan.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (gvLaporanPengesahan.PageIndex + 1).ToString();
                }
            }
            protected void gvLaporanPengesahan_DataBound(object sender, EventArgs e)
            {
                if (gvLaporanPengesahan.Rows.Count > 0)
                {
                    GridViewRow rowPager = gvLaporanPengesahan.BottomPagerRow;

                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            gvLaporanPengesahan.PageIndex = gvLaporanPengesahan.PageCount - 1;
                        }

                        // get your controls from the gridview
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = (gvLaporanPengesahan.PageIndex + 1).ToString();
                        // populate page count
                        lblJumlahHalaman.Text = gvLaporanPengesahan.PageCount.ToString();
                    }
                    showGridView(true);
                }
                else
                {
                    //Data kosong, set gridview visible false, formview visible true
                    showGridView(false);
                } 
            }

            //fungsi: Handle ketika terjadi Perintah pada GridView
            protected void gvLaporanPengesahan_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                //seleksi kemungkinan perintah pada datarow
                if (e.CommandName == "Insert")
                {
                    //memanggil procedure insert
                    dsLaporanPengesahan.Insert();
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    gvLaporanPengesahan.ShowFooter = false;
                }
            }

            //fungsi: Handle Permintaan Tambah data, Tampilkan FormView
            protected void imgBtnAddSignVal_Click(object sender, ImageClickEventArgs e)
            {
                lnkBtnAddSignVal_Click(sender, e);
            }

            //fungsi: Handle Permintaan Tambah data, Tampilkan FormView
            protected void lnkBtnAddSignVal_Click(object sender, EventArgs e)
            {
                //Seleksi apakah data kosong atau tidak, 
                //jika kosong maka proses tambah data dilakukan melalui formView, 
                //jika tidak kosong maka proses tambah data dilakukan melalui GridView, 
                if (gvLaporanPengesahan.Rows.Count > 0)
                {
                    //Data tidak kosong
                    sendToLastPage = true;
                    gvLaporanPengesahan.ShowFooter = true;
                }
                else
                {
                    //Data Kosong
                    FvLaporanPengesahan.DefaultMode = FormViewMode.Insert;
                    FvLaporanPengesahan.DataBind();//diperlukan jika didalam formview terdapat dropdownlist
                }
            }

            //fungsi: Handle Perubahan Satker
            protected void ddlFilterSatKer_ValueChange(object sender, EventArgs e)
            {
                doFiltering();
                gvLaporanPengesahan.DataBind();
            }

            //fungsi: Handle Ketika akan insert database
            protected void dsLaporanPengesahan_Inserting(object sender, SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    if (gvLaporanPengesahan.Rows.Count > 0)
                    {
                        DropDownList ddlCol0Footer = (DropDownList)gvLaporanPengesahan.FooterRow.Cells[0].FindControl("ddlCol0Footer");
                        DropDownList ddlCol1Footer = (DropDownList)gvLaporanPengesahan.FooterRow.Cells[1].FindControl("ddlCol1Footer");
                        TextBox txtCol2Footer = (TextBox)gvLaporanPengesahan.FooterRow.Cells[2].FindControl("txtCol2Footer");
                        TextBox txtCol3Footer = (TextBox)gvLaporanPengesahan.FooterRow.Cells[3].FindControl("txtCol3Footer");
                        TextBox txtCol4Footer = (TextBox)gvLaporanPengesahan.FooterRow.Cells[4].FindControl("txtCol4Footer");
                        TextBox txtCol5Footer = (TextBox)gvLaporanPengesahan.FooterRow.Cells[5].FindControl("txtCol5Footer");
                        TextBox txtCol6Footer = (TextBox)gvLaporanPengesahan.FooterRow.Cells[6].FindControl("txtCol6Footer");
                        TextBox txtCol7Footer = (TextBox)gvLaporanPengesahan.FooterRow.Cells[7].FindControl("txtCol7Footer");

                        e.Command.Parameters["@KODE_LAPORAN"].Value = ddlCol0Footer.SelectedValue;
                        e.Command.Parameters["@KODE_CABANG"].Value = ddlCol1Footer.SelectedValue;
                        e.Command.Parameters["@TTD1_HEADER"].Value = txtCol2Footer.Text;
                        e.Command.Parameters["@TTD1"].Value = txtCol3Footer.Text;
                        e.Command.Parameters["@TTD2_HEADER"].Value = txtCol4Footer.Text;
                        e.Command.Parameters["@TTD2"].Value = txtCol5Footer.Text;
                        e.Command.Parameters["@TTD3_HEADER"].Value = txtCol6Footer.Text;
                        e.Command.Parameters["@TTD3"].Value = txtCol7Footer.Text;
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = ex.Message;
                }
            }

            //fungsi: Handle Ketika data pada database telah didelete
            protected void dsLaporanPengesahan_Deleted(object sender, SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter delete maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails2.Text = lblCannotUpdate.Text;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    azlib.AddUserAct(Session["UserID"].ToString(), "3303", e.Command.Parameters["@KODE_LAPORAN"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: Handle Ketika data pada database telah ditambahkan
            protected void dsLaporanPengesahan_Inserted(object sender, SqlDataSourceStatusEventArgs e)
            {
                if (e.AffectedRows == 0)
                {
                    //menampilkan kesalahan user
                    if (e.Exception.Message.Contains("Violation of PRIMARY KEY"))
                    {
                        ExceptionDetails2.Text = "Duplikasi Data!";
                    }
                    else
                    {
                        ExceptionDetails2.Text = "Data gagal disimpan";
                    }
                    e.ExceptionHandled = true;
                }
                else
                {
                    //procedure untuk mencatat event user insert data
                    azlib.AddUserAct(Session["UserID"].ToString(), "3301", e.Command.Parameters["@KODE_LAPORAN"].Value.ToString(), Application["strCn"].ToString());
                }
                gvLaporanPengesahan.DataBind();
                gvLaporanPengesahan.ShowFooter = false;
                showGridView(true);
            }

            //fungsi: Handle Ketika data pada database telah diupdate
            protected void dsLaporanPengesahan_Updated(object sender, SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter update maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails2.Text = lblCannotUpdate.Text; //& " (" & e.Exception.Message & ")"
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    azlib.AddUserAct(Session["UserID"].ToString(), "3302", e.Command.Parameters["@KODE_LAPORAN"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: Handle ketika terjadi Perintah pada FormView
            protected void FvLaporanPengesahan_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    FvLaporanPengesahan.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                gvLaporanPengesahan.Visible = show;
                FvLaporanPengesahan.Visible = !show;
                if (show)
                {
                    FvLaporanPengesahan.DefaultMode = FormViewMode.ReadOnly;
                }
            }
}
	}
