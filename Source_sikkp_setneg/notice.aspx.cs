///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : notice.aspx.cs                             (Pseudo code)

//        File terkait  : notice.aspx                                (Form)
//                        \App_LocalResources\notice.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\notice.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel Lembur (taLembur)

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
//        Versi 2.0.1   :Penyempurnaan Filter
//        Versi 2.0.2   :Implementasi AJAX
//        Versi 2.0.3   :Pengaturan sistem Validasi
//        Versi 2.0.4   :Pengaturan Hak Akses Halaman
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

        public partial class notice : BasePage
		{
            private void showGridView(Boolean show)
            {
                GvLembur.Visible = show;
                tableFilter.Visible = show;
                FvLembur.Visible = !show;
                if ((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "3"))
                {
                    lblTambah.Visible = show;
                    ImgbtnAdd.Visible = show;
                    if (Session["GradeID"].ToString() != "3")
                    {
                        btnSimpan.Visible = show;
                        chkCheckOrClearAll.Visible = show;
                    }
                }
            }

            protected void ddlFilterItem3_DataBound_SelectedChange(object sender, EventArgs e)
            {
                if (ddlFilterItem3.SelectedValue != "000")
                {
                    if (Session["GradeID"].ToString() == "2")
                    {
                        dsBagian.FilterExpression = "KODE_BIRO = '0000' OR (KODE_CABANG = '" + Session["CabangID"].ToString() + "' AND KODE_DEPUTI = '" + ddlFilterItem3.SelectedValue + "')";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        dsBagian.SelectCommand = "SELECT KODE_BIRO, NAMA_BIRO FROM q_BIRO";
                        dsBagian.SelectCommand += " WHERE KODE_BIRO = '0000' OR (KODE_BIRO IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "') AND KODE_DEPUTI = '" + ddlFilterItem3.SelectedValue + "')";
                    }
                    else
                    {
                        dsBagian.FilterExpression = "KODE_BIRO = '0000' OR KODE_DEPUTI = '" + ddlFilterItem3.SelectedValue + "'";
                    }
                }
                else
                {
                    if (Session["GradeID"].ToString() == "2")
                    {
                        dsBagian.FilterExpression = "KODE_BIRO = '0000' OR KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        dsBagian.SelectCommand = "SELECT KODE_BIRO, NAMA_BIRO FROM q_BIRO";
                        dsBagian.SelectCommand += " WHERE KODE_BIRO = '0000' OR KODE_BIRO IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                    }
                }
                ddlFilterItem4.DataBind();
            }

            private void doFiltering()
            {
                try
                {
                    string strFilter = "";

                    strFilter += " WHERE (TGL_SPL >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND TGL_SPL <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "')";

                    if (txtFilterItem2.Text.Trim() != "")
                    {
                        if (isEntryUseNIP())
                        {
                            if (strFilter != "")
                            {
                                strFilter += " AND (NIP = '" + txtFilterItem2.Text.Replace("'", "''") + "')";
                            }
                            else
                            {
                                strFilter += " WHERE (NIP = '" + txtFilterItem2.Text.Replace("'", "''") + "')";
                            }
                        }
                        else
                        {
                            txtFilterItem2.Text = azlib.FillNull(txtFilterItem2.Text, 10);
                            if (strFilter != "")
                            {
                                strFilter += " AND (PIN = '" + txtFilterItem2.Text.Replace("'", "''") + "')";
                            }
                            else
                            {
                                strFilter += " WHERE (PIN = '" + txtFilterItem2.Text.Replace("'", "''") + "')";
                            }
                        }
                    }

                    if ((ddlFilterItem3.SelectedValue != "000") && (ddlFilterItem3.SelectedValue != ""))
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND (KODE_DEPUTI = '" + ddlFilterItem3.SelectedValue + "')";
                        }
                        else
                        {
                            strFilter += " WHERE (KODE_DEPUTI = '" + ddlFilterItem3.SelectedValue + "')";
                        }
                    }

                    if ((ddlFilterItem4.SelectedValue != "0000") && (ddlFilterItem4.SelectedValue != ""))
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND (KODE_BIRO = '" + ddlFilterItem4.SelectedValue + "')";
                        }
                        else
                        {
                            strFilter += " WHERE (KODE_BIRO = '" + ddlFilterItem4.SelectedValue + "')";
                        }
                    }

                    if ((((ddlFilterItem3.SelectedValue == "000") || (ddlFilterItem3.SelectedValue == "")) && ((ddlFilterItem4.SelectedValue == "0000") || (ddlFilterItem4.SelectedValue == "")))) //Operator
                    {
                        if ((Session["GradeID"].ToString() == "2"))
                        {
                            if (strFilter != "")
                            {
                                strFilter += " AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                            }
                            else
                            {
                                strFilter += " WHERE KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                            }
                        }
                        else if ((Session["GradeID"].ToString().Substring(0, 1) == "3"))
                        {
                            if (strFilter != "")
                            {
                                strFilter += " AND KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                            }
                            else
                            {
                                strFilter += " WHERE KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                            }
                        }
                    }

                    if (ddlFilterItem5.SelectedValue != "-")
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND STATUS_LEMBUR = " + ddlFilterItem5.SelectedValue + "";
                        }
                        else
                        {
                            strFilter += " WHERE STATUS_LEMBUR = " + ddlFilterItem5.SelectedValue + "";
                        }
                    }

                    dsLembur.SelectCommand += strFilter + " ORDER BY TGL_SPL ASC";

                    if (strFilter != "")
                    {
                        Session["FilterAlasan"] = " AND " + strFilter.Substring(6, strFilter.Length - 6);
                    }
                    else
                    {
                        Session["FilterAlasan"] = strFilter;
                    }
                }
                catch (Exception ex)
                { }
            }
            
            private void setFilter()
            {
                txtFilterItem0.Text = azlib.FirstDate(DateTime.Now.Date, Session["strLang"].ToString()).ToShortDateString();
                txtFilterItem1.Text = azlib.LastDate(DateTime.Now.Date, Session["strLang"].ToString()).ToShortDateString();

                //SATU
                //valFilterItem1_1.ValueToCompare = azlib.FirstDate(DateAndTime.DateAdd(DateInterval.Month, -12, DateTime.Now).ToString(), Session["strLang"].ToString());
                //valFilterItem1_1.ErrorMessage = lblPeriode.Text + " ( < " + azlib.FirstDate(DateAndTime.DateAdd(DateInterval.Month, -12, DateTime.Now).ToString(), Session["strLang"].ToString()) + ")";
					
                if (Session["GradeID"].ToString() == "2")
                {
                    dsBiro.FilterExpression = "KODE_DEPUTI = '000' OR KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                }
                else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                {
                    dsBiro.SelectCommand = "SELECT KODE_DEPUTI, NAMA_DEPUTI FROM q_DEPUTI";
                    dsBiro.SelectCommand += " WHERE KODE_DEPUTI = '000' OR KODE_DEPUTI IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                }
                else if ((Session["GradeID"].ToString() == "3a") || (Session["GradeID"].ToString() == "4"))
                {
                    if (isEntryUseNIP())
                    {
                        txtFilterItem2.Text = Session["NIPID"].ToString();
                    }
                    else
                    {
                        txtFilterItem2.Text = Session["PINID"].ToString();
                    }
                    tableFilter.Visible = false;
                }

                if (Request.QueryString["process"] == "no")
                {
                    txtFilterItem0.Text = DateTime.Parse(Session["tglTutup"].ToString()).ToShortDateString();
                    ddlFilterItem5.SelectedIndex = 2;
                }
            }

            private void setComponent()
            {
                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2"))
                {
                    if (Session["GradeID"].ToString() != "3")
                    {
                        lblTambah.Visible = false;
                        ImgbtnAdd.Visible = false;
                        GvLembur.Columns[6].Visible = false;
                        GvLembur.Columns[7].Visible = false;
                        GvLembur.Columns[8].Visible = false;
                    }
                    btnSimpan.Visible = false;
                    chkCheckOrClearAll.Visible = false;
                }
                if ((Session["FilterAlasan"] != null) || (Session["CHECKED_ITEMS"] != null))
                {
                    Session.Remove("FilterAlasan");
                    Session.Remove("CHECKED_ITEMS");
                }
                BoundField Column0 = (BoundField)GvLembur.Columns[0];
                if (isEntryUseNIP())
                {
                    lblPIN.Visible = false;
                    Column0.HeaderText = "NIP";
                    Column0.SortExpression = "NIP";
                    Column0.DataField = "NIP";
                }
                else
                {
                    lblNIP.Visible = false;
                    Column0.HeaderText = "PIN";
                    Column0.SortExpression = "PIN";
                    Column0.DataField = "PIN";
                }
                Column0.ItemStyle.ForeColor = System.Drawing.Color.Black;
            }
			
			protected void Page_Load(object sender, EventArgs e)
			{
                //if (Session["CabangID"].ToString() == "003")
                //{
                    Response.Redirect("overtime.aspx");
                //}
				//jika userid kosong maka akan di link ke halaman awal
				if (! rtwin.azlib.AksesHalaman(16, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}
				
				//jika halaman bukan postback
				if (! Page.IsPostBack)
				{
                    setFilter();
                    setComponent();
                    showGridView(true);
				}

                doFiltering();
                doFilteringLookup();
			}

            protected void btnRefresh_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    //update ke grid
                    RememberOldValuesFirstTime();
                    GvLembur.DataBind();
                }
            }

            protected void lblTambah_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    FvLembur.DefaultMode = FormViewMode.Insert;
                    FvLembur.ChangeMode(FormViewMode.Insert);
                    showGridView(false);
                }
            }

            protected void ImgBtnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lblTambah_Click(sender, e);
            }

            protected void GvLembur_DataBound(object sender, EventArgs e)
            {
                if (!Page.IsPostBack)
                {
                    RememberOldValuesFirstTime();
                }
                else
                {
                    RePopulateValues();
                }
                
                GridViewRow rowPager = GvLembur.BottomPagerRow;

                if (rowPager != null)
                {
                    // get your controls from the gridview
                    TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                    Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                    txtHalaman.Text = (GvLembur.PageIndex + 1).ToString();
                    // populate page count
                    lblJumlahHalaman.Text = GvLembur.PageCount.ToString();
                }
                else
                {
                    return;
                }
            }

            //Menyisipkan javascript untuk confirm sebelum delete
            protected void GvLembur_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
            {
                //menambahkan State Row on Hover
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    GridView gv = ((GridView)sender);

                    String className = ((e.Row.RowState == DataControlRowState.Alternate) ? gv.AlternatingRowStyle.CssClass : gv.RowStyle.CssClass);

                    e.Row.Attributes.Add("onmouseover", "this.className='datagrid_hovcol';");

                    e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");

                    if (Session["GradeID"].ToString() != "1")
                    {
                        CheckBox chkSelect = (CheckBox)e.Row.Cells[6].FindControl("chkSelect");
                        ImageButton btnEdit = (ImageButton)e.Row.Cells[7].FindControl("imgEdit");
                        ImageButton btnDelete = (ImageButton)e.Row.Cells[8].FindControl("imgDelete");
                        Label lblTgl = (Label)e.Row.Cells[2].FindControl("lblCol2Item");

                        if (Session["GradeID"].ToString() != "2")
                        {
                            chkSelect.Enabled = false;
                            btnEdit.Enabled = !chkSelect.Checked;
                            btnDelete.Enabled = !chkSelect.Checked;
                        }

                        btnEdit.Enabled = btnEdit.Enabled && (DateTime.Parse(lblTgl.Text) >= DateTime.Parse(Session["tglTutup"].ToString()));
                        btnDelete.Enabled = btnEdit.Enabled && (DateTime.Parse(lblTgl.Text) >= DateTime.Parse(Session["tglTutup"].ToString()));
                    }
                }
            }

            protected void GvLembur_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    dsLembur.SelectCommand = "SELECT NIP, PIN, NAMA, TGL_SPL, JAM_AWAL_SPL, JAM_AKHIR_SPL, JENIS_KERJA_SPL, STATUS_LEMBUR FROM q_Lembur";
                    if (isEntryUseNIP())
                    {
                        dsLembur.SelectCommand += " WHERE NIP = '" + GvLembur.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_SPL = '" + DateTime.Parse(((Label)GvLembur.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                    }
                    else
                    {
                        dsLembur.SelectCommand += " WHERE PIN = '" + GvLembur.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_SPL = '" + DateTime.Parse(((Label)GvLembur.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                    }
                    e.Cancel = true;
                    FvLembur.DefaultMode = FormViewMode.Edit;
                    FvLembur.ChangeMode(FormViewMode.Edit);
                    showGridView(false);
                }
                else
                {
                    e.Cancel = true;
                }
            }

            protected void FvLembur_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel_Edit")
                {
                    showGridView(true);
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    setInitialComponent();
                    showGridView(true);
                }
            }

            protected void dsLemburEdit_Updating(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    TextBox jam_awal = (TextBox)FvLembur.FindControl("txtItem3FormView");
                    TextBox jam_akhir = (TextBox)FvLembur.FindControl("txtItem4FormView");

                    bool TimeSpanValidation = false;
                    
                    if ((jam_awal.Text.Trim() != "") && (jam_akhir.Text.Trim() != ""))
                    {
                        try
                        {
                            TimeSpan tsJamAwal = TimeSpan.Parse(jam_awal.Text);
                            TimeSpan tsJamAkhir = TimeSpan.Parse(jam_akhir.Text);
                        

                            TimeSpanValidation = true;
                        }
                        catch (Exception ex)
                        {
                            ExceptionDetails.Text = lblJamSalah2.Text;
                        }
                    }

                    if (TimeSpanValidation)
                    {
                        DateTime Tanggal_Fix = DateTime.Parse(((Label)FvLembur.FindControl("lblItem2FormView")).Text);
                        CheckBox ganti_hari = (CheckBox)FvLembur.FindControl("cbGantiHari");
                        string TanggalFix = "";

                        if (Session["strlang"].ToString() == "en")
                        {
                            TanggalFix = Tanggal_Fix.ToString("MM/dd/yyyy");
                        }
                        else
                        {
                            TanggalFix = Tanggal_Fix.ToString("dd/MM/yyyy");
                        }

                        string jamAwal;
                        string jamAkhir;

                        if ((TimeSpan.Parse(jam_awal.Text) <= TimeSpan.Parse(jam_akhir.Text)) && (!ganti_hari.Checked))
                        {
                            jamAwal = TanggalFix + " " + jam_awal.Text + ":00";
                            jamAkhir = TanggalFix + " " + jam_akhir.Text + ":00";
                        }
                        else
                        {
                            string TanggalFix2 = "";

                            if (Session["strlang"].ToString() == "en")
                            {
                                TanggalFix2 = Tanggal_Fix.AddDays(1).ToString("MM/dd/yyyy");
                            }
                            else
                            {
                                TanggalFix2 = Tanggal_Fix.AddDays(1).ToString("dd/MM/yyyy");
                            }

                            jamAwal = TanggalFix + " " + jam_awal.Text + ":00";
                            jamAkhir = TanggalFix2 + " " + jam_akhir.Text + ":00";
                        }

                        e.Command.Parameters["@JAM_AWAL_SPL"].Value = DateTime.Parse(jamAwal);
                        e.Command.Parameters["@JAM_AKHIR_SPL"].Value = DateTime.Parse(jamAkhir);
                    }
                    else
                    {
                        ExceptionDetails.Text = lblJamSalah2.Text;
                        e.Cancel = true;
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    e.Cancel = true;
                }
            }

            protected void dsLemburEdit_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2312", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_SPL"].Value.ToString(), Application["strCn"].ToString());                    
                }
                RememberOldValuesFirstTime();
                GvLembur.DataBind();
                showGridView(true);
            }

            protected void dsLembur_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2313", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_SPL"].Value.ToString(), Application["strCn"].ToString());
                }
                RememberOldValuesFirstTime();
                GvLembur.DataBind();
            }

            protected void FvLembur_DataBound(object sender, EventArgs e)
            {
                if (FvLembur.CurrentMode != FormViewMode.ReadOnly)
                {
                    if (FvLembur.CurrentMode == FormViewMode.Insert)
                    {
                        if (isEntryUseNIP())
                        {
                            ((Label)FvLembur.FindControl("lblPIN")).Visible = false;
                        }
                        else
                        {
                            ((Label)FvLembur.FindControl("lblNipEdit")).Visible = false;
                        }

                        if (ViewState["TglLembur"] != null)
                        {
                            ((TextBox)FvLembur.FindControl("txtItem2FormView")).Text = ViewState["TglLembur"].ToString();
                            ViewState.Remove("TglLembur");
                        }
                        else
                        {
                            ((TextBox)FvLembur.FindControl("txtItem2FormView")).Text = DateTime.Now.ToShortDateString();
                        }
                        //TIGA
                        RangeValidator ValTglAdd = (RangeValidator)FvLembur.FindControl("CompareValTglAdd");
                        ValTglAdd.MinimumValue = DateTime.Parse(Session["tglTutup"].ToString()).ToShortDateString();
                        //ValTglAdd.MaximumValue = Session["tglBatas"];
                        TextBox txtNip = (TextBox)FvLembur.FindControl("txtItem0FormView");
                        txtNip.Focus();
                    }
                    else if (FvLembur.CurrentMode == FormViewMode.Edit)
                    {
                        if (isEntryUseNIP())
                        {
                            ((Label)FvLembur.FindControl("lblPIN")).Visible = false;
                            ((Label)FvLembur.FindControl("lblItem0_FormView")).Visible = false;
                        }
                        else
                        {
                            ((Label)FvLembur.FindControl("lblNipEdit")).Visible = false;
                            ((Label)FvLembur.FindControl("lblItem0FormView")).Visible = false;
                        }
                    }

                    if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2"))
                    {
                        ((Label)FvLembur.FindControl("lblStatusIjinEdit")).Visible = false;
                        ((CheckBox)FvLembur.FindControl("chkItem6FormView")).Visible = false;
                    }
                    else
                    {
                        if (FvLembur.CurrentMode == FormViewMode.Insert)
                        {
                            ((CheckBox)FvLembur.FindControl("chkItem6FormView")).Checked = true;
                        }
                    }
                }
            }

            protected void dsLemburEdit_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    ViewState["TglLembur"] = ((TextBox)FvLembur.FindControl("txtItem2FormView")).Text;

                    string sNIP;
                    TextBox NIP = (TextBox)FvLembur.FindControl("txtItem0FormView");
                    TextBox jam_awal = (TextBox)FvLembur.FindControl("txtItem3FormView");
                    TextBox jam_akhir = (TextBox)FvLembur.FindControl("txtItem4FormView");
                    DateTime Tanggal_Fix = DateTime.Parse(((TextBox)FvLembur.FindControl("txtItem2FormView")).Text);

                    bool TimeSpanValidation = false;

                    if ((jam_awal.Text.Trim() != "") && (jam_akhir.Text.Trim() != ""))
                    {
                        try
                        {
                            TimeSpan tsJamAwal = TimeSpan.Parse(jam_awal.Text);
                            TimeSpan tsJamAkhir = TimeSpan.Parse(jam_akhir.Text);

                            TimeSpanValidation = true;
                        }
                        catch (Exception ex)
                        {
                            ExceptionDetails.Text = lblJamSalah2.Text;
                            e.Cancel = true;
                        }
                    }

                    if (TimeSpanValidation)
                    {
                        CheckBox ganti_hari = (CheckBox)FvLembur.FindControl("cbGantiHari");
                        string TanggalFix = "";

                        if (Session["strlang"].ToString() == "en")
                        {
                            TanggalFix = Tanggal_Fix.ToString("MM/dd/yyyy");
                        }
                        else
                        {
                            TanggalFix = Tanggal_Fix.ToString("dd/MM/yyyy");
                        }

                        string jamAwal;
                        string jamAkhir;

                        if ((TimeSpan.Parse(jam_awal.Text) <= TimeSpan.Parse(jam_akhir.Text)) && (!ganti_hari.Checked))
                        {
                            jamAwal = TanggalFix + " " + jam_awal.Text + ":00";
                            jamAkhir = TanggalFix + " " + jam_akhir.Text + ":00";
                        }
                        else
                        {
                            string TanggalFix2 = "";

                            if (Session["strlang"].ToString() == "en")
                            {
                                TanggalFix2 = Tanggal_Fix.AddDays(1).ToString("MM/dd/yyyy");
                            }
                            else
                            {
                                TanggalFix2 = Tanggal_Fix.AddDays(1).ToString("dd/MM/yyyy");
                            }

                            jamAwal = TanggalFix + " " + jam_awal.Text + ":00";
                            jamAkhir = TanggalFix2 + " " + jam_akhir.Text + ":00";
                        }

                        if (isEntryUseNIP())
                        {
                            sNIP = NIP.Text;
                        }
                        else
                        {
                            sNIP = azlib.getNIP(NIP.Text, Application["strCn"].ToString());
                        }

                        e.Command.Parameters["@NIP"].Value = sNIP;
                        e.Command.Parameters["@JAM_AWAL_SPL"].Value = DateTime.Parse(jamAwal);
                        e.Command.Parameters["@JAM_AKHIR_SPL"].Value = DateTime.Parse(jamAkhir);
                        e.Command.Parameters["@TGL_SPL"].Value = Tanggal_Fix;
                    }
                    else
                    {
                        ExceptionDetails.Text = lblJamSalah2.Text;
                        e.Cancel = true;
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    e.Cancel = true;
                }
            }

            protected void dsLemburEdit_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter insert maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text; //& " (" & e.Exception.Message & ")"
                    e.ExceptionHandled = true;
                    if (!isEntrySambung())
                    {
                        setInitialComponent();
                    }
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2311", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_SPL"].Value.ToString(), Application["strCn"].ToString());
                    ExceptionDetails.Text = "Data telah di simpan";

                    RememberOldValuesFirstTime();
                    GvLembur.DataBind();

                    setInitialComponent();
                }

                if (!isEntrySambung())
                {
                    showGridView(true);
                }
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvLembur.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvLembur.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        RememberOldValues();
                        GvLembur.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvLembur.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvLembur.PageIndex + 1).ToString();
                }
            }

            private void setInitialComponent()
            {
                ((TextBox)FvLembur.FindControl("txtItem0FormView")).Text = "";
                ((Label)FvLembur.FindControl("lblItem1FormView")).Text = "";
                ((TextBox)FvLembur.FindControl("txtItem2FormView")).Text = DateTime.Now.ToShortDateString();
                ((TextBox)FvLembur.FindControl("txtItem3FormView")).Text = "00:00";
                ((TextBox)FvLembur.FindControl("txtItem4FormView")).Text = "00:00";
                ((TextBox)FvLembur.FindControl("txtItem5FormView")).Text = "";
                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2"))
                {
                    ((CheckBox)FvLembur.FindControl("chkItem6FormView")).Checked = false;
                }
                else
                {
                    ((CheckBox)FvLembur.FindControl("chkItem6FormView")).Checked = true;
                }                
            }

            protected void btnImport_Click(object sender, EventArgs e)
			{
			}
			
			protected void lnkFilterItem2_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtFilterItem2";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
            }

            protected void lnkItem0FormView_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtItem0FormView";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
            }

            protected void txtItem0FormView_TextChanged(object sender, EventArgs e)
            {
                TextBox txtNIP = (TextBox)FvLembur.FindControl("txtItem0FormView");
                Label lblNama = (Label)FvLembur.FindControl("lblItem1FormView");
                setNama(txtNIP, lblNama);
            }

            private void setNama(TextBox txtNIP, Label lblNama)
            {
                string strSelect;
                if ((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "1a"))
                {
                    if (isEntryUseNIP())
                    {
                        strSelect = "SELECT NAMA FROM q_Karyawan WHERE NIP='" + txtNIP.Text.Replace("'", "''") + "'";
                    }
                    else
                    {
                        txtNIP.Text = azlib.FillNull(txtNIP.Text, 10);
                        strSelect = "SELECT NAMA FROM q_Karyawan WHERE NIP='" + azlib.getNIP(txtNIP.Text, Application["strCn"].ToString()).Trim() + "'";
                    }
                }
                else
                {
                    string strFilter = "";
                    if (Session["GradeID"].ToString() == "2")
                    {
                        strFilter += " AND KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        strFilter += " AND KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE USERNAME = '" + Session["UserID"].ToString() + "')";
                    }
                    else if (Session["GradeID"].ToString() == "4")
                    {
                        strFilter += " AND NIP = '" + Session["NIPID"].ToString() + "'";
                    }
                    if (isEntryUseNIP())
                    {
                        strSelect = "SELECT NAMA FROM q_Karyawan WHERE NIP='" + txtNIP.Text.Replace("'", "''") + "'" + strFilter;
                    }
                    else
                    {
                        txtNIP.Text = azlib.FillNull(txtNIP.Text, 10);
                        strSelect = "SELECT NAMA FROM q_Karyawan WHERE NIP='" + azlib.getNIP(txtNIP.Text, Application["strCn"].ToString()).Trim() + "'" + strFilter;
                    }
                }

                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                SqlDataAdapter adpSQL = new SqlDataAdapter(strSelect, Application["strCn"].ToString());
                DataSet dsPegawai = new DataSet();

                adpSQL.Fill(dsPegawai);
                int recordCount = dsPegawai.Tables[0].Rows.Count;
                if (recordCount > 0)
                {
                    lblNama.Text = dsPegawai.Tables[0].Rows[0][0].ToString();
                }
                else
                {
                    ExceptionDetails.Text = lblIDNotFound.Text;
                    ExceptionDetails.Visible = true;
                    txtNIP.Text = "";
                    lblNama.Text = "";
                    txtNIP.Focus();
                }
                cn.Close();
            }

            //Lookup Code
            private void doFilteringLookup()
            {
                string strFilter = "";

                if (txtLookupCariPegawai.Text.Trim() != "")
                {
                    strFilter = "NAMA LIKE '%" + txtLookupCariPegawai.Text + "%'";
                }
                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "1a"))
                {
                    if (strFilter != "")
                    {
                        strFilter += "AND ";
                    }
                    if (Session["GradeID"].ToString() == "2")
                    {
                        strFilter += "KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        strFilter += "KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE USERNAME = '" + Session["UserID"].ToString() + "')";
                    }
                    else if (Session["GradeID"].ToString() == "4")
                    {
                        strFilter += "NIP = '" + Session["NIPID"].ToString() + "'";
                    }
                }
                //dsLookup.FilterExpression = strFilter;
                dsLookup.SelectCommand = "SELECT NIP, PIN, NAMA FROM taKaryawan";
                if (strFilter != "")
                {
                    dsLookup.SelectCommand += " WHERE " + strFilter;
                }
                dsLookup.SelectCommand += " ORDER BY NIP";
            }

            protected void txtHalamanLookup_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvLookupPegawai.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvLookupPegawai.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvLookupPegawai.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvLookupPegawai.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvLookupPegawai.PageIndex + 1).ToString();
                }
            }

            protected void GvLookupPegawai_DataBound(object sender, EventArgs e)
            {
                //Data tidak kosong
                GridViewRow rowPager = GvLookupPegawai.BottomPagerRow;

                //seleksi pager Row apakah ada atau tidak
                if (rowPager != null)
                {
                    //set property control di pager Row
                    TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                    Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                    txtHalaman.Text = Convert.ToString(GvLookupPegawai.PageIndex + 1);
                    lblJumlahHalaman.Text = GvLookupPegawai.PageCount.ToString();
                }
            }

            private void setInitialLookupState()
            {
                txtLookupCariPegawai.Text = "";
                GvLookupPegawai.PageIndex = 0;
                GvLookupPegawai.SelectedIndex = -1;
            }

            protected void imgLookupCancel_Click(object sender, ImageClickEventArgs e)
            {
                lnkLookupClose_Click(sender, e);
            }

            protected void lnkLookupClose_Click(object sender, EventArgs e)
            {
                setInitialLookupState();
                UpdatePanel1.Update();
            }

            protected void btnLookupCari_Click(object sender, EventArgs e)
            {
                GvLookupPegawai.DataBind();
            }

            protected void GvLookupPegawai_SelectedIndexChanged(object sender, EventArgs e)
            {
                if (Session["Triger"] != null)
                {
                    if (Session["Triger"].ToString() == "txtFilterItem2")
                    {
                        if (isEntryUseNIP())
                        {
                            this.txtFilterItem2.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                        }
                        else
                        {
                            this.txtFilterItem2.Text = GvLookupPegawai.SelectedRow.Cells[1].Text;
                        }
                    }
                    else if (Session["Triger"].ToString() == "txtItem0FormView")
                    {
                        if (isEntryUseNIP())
                        {
                            ((TextBox)FvLembur.FindControl("txtItem0FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                            ((Label)FvLembur.FindControl("lblItem1FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;
                        }
                        else
                        {
                            ((TextBox)FvLembur.FindControl("txtItem0FormView")).Text = GvLookupPegawai.SelectedRow.Cells[1].Text;
                            ((Label)FvLembur.FindControl("lblItem1FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;
                        }
                    }

                    Session.Remove("Triger");
                }

                setInitialLookupState();
                UpdatePanel1.Update();
            }




            //Validator Code
            private void RememberOldValuesFirstTime()
            {
                ArrayList categoryIDList = new ArrayList();

                SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
                DataSet mydataset = new DataSet();
                SqlDataAdapter myadapter = new SqlDataAdapter();
                SqlCommand mycommand = new SqlCommand("Select NIP, TGL_SPL from q_Lembur WHERE STATUS_LEMBUR = 1" + Session["FilterAlasan"].ToString(), myconection);

                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taLembur");

                //Seleksi apakah hasil Query null atau tidak
                //jika null maka item hanya null
                //jika tidak null maka item diisi oleh kode range yang didapat
                if (mydataset.Tables["taLembur"].Rows.Count == 0)
                {
                    if (Session["CHECKED_ITEMS"] != null)
                    {
                        ((ArrayList)Session["CHECKED_ITEMS"]).Clear();
                    }
                    myadapter.Dispose();
                    mydataset.Clear();
                }
                else
                {
                    DataTable myTabel = mydataset.Tables["taLembur"];

                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_SPL"].ToString()).ToShortDateString());
                    }
                    if (categoryIDList != null)
                    {
                        if (categoryIDList.Count > 0)
                        {
                            Session["CHECKED_ITEMS"] = categoryIDList;
                        }
                    }
                    myadapter.Dispose();
                    mydataset.Clear();

                    if (Session["UNCHECK"] != null)
                    {
                        Session.Remove("UNCHECK");
                    }
                }
            }

            private void RememberOldValues()
            {
                ArrayList categoryIDList = new ArrayList();
                ArrayList categoryIDList2 = new ArrayList();
                string index;
                string index2;

                if (Session["CHECKED_ITEMS"] != null)
                {
                    categoryIDList = (ArrayList)(Session["CHECKED_ITEMS"]);
                }

                if (Session["UNCHECK"] != null)
                {
                    categoryIDList2 = (ArrayList)(Session["UNCHECK"]);
                }
                foreach (GridViewRow row in GvLembur.Rows)
                {
                    //index = ((Label)(GvLembur.Rows[row.RowIndex].Cells[0].FindControl("lblCol0Item"))).Text; //CType(GvIjinHari.DataKeys(row.RowIndex).Value, String)
                    index = GvLembur.DataKeys[row.RowIndex]["NIP"].ToString();
                    index2 = ((Label)(GvLembur.Rows[row.RowIndex].Cells[2].FindControl("lblCol2Item"))).Text; //CType(GvIjinHari.DataKeys(row.RowIndex).Value, String)

                    bool result = (((CheckBox)(row.FindControl("chkSelect")))).Checked;

                    if (result)
                    {
                        if (!categoryIDList.Contains(index + "," + index2))
                        {
                            categoryIDList.Add(index + "," + index2);
                        }
                        categoryIDList2.Remove(index + "," + index2);
                    }
                    else
                    {
                        categoryIDList.Remove(index + "," + index2);
                        if (!categoryIDList2.Contains(index + "," + index2))
                        {
                            categoryIDList2.Add(index + "," + index2);
                        }
                    }
                }

                if (categoryIDList != null)
                {
                    if (categoryIDList.Count > 0)
                    {
                        Session["CHECKED_ITEMS"] = categoryIDList;
                    }
                }
                if (categoryIDList2 != null)
                {
                    if (categoryIDList2.Count > 0)
                    {
                        Session["UNCHECK"] = categoryIDList2;
                    }
                }
            }

            private void RePopulateValues()
            {
                ArrayList categoryIDList = (ArrayList)(Session["CHECKED_ITEMS"]);

                if (categoryIDList != null)
                {
                    if (categoryIDList.Count > 0)
                    {

                        foreach (GridViewRow row in GvLembur.Rows)
                        {
                            //string index = ((Label)(GvLembur.Rows[row.RowIndex].Cells[0].FindControl("lblCol0Item"))).Text; //CType(GvIjinHari.DataKeys(row.RowIndex).Value, String)
                            string index = GvLembur.DataKeys[row.RowIndex]["NIP"].ToString();
                            string index2 = ((Label)(GvLembur.Rows[row.RowIndex].Cells[2].FindControl("lblCol2Item"))).Text; //CType(GvIjinHari.DataKeys(row.RowIndex).Value, String)

                            if (categoryIDList.Contains(index + "," + index2))
                            {
                                CheckBox myCheckBox = (CheckBox)(row.Cells[6].FindControl("chkSelect"));
                                myCheckBox.Checked = true;
                            }
                            else
                            {
                                CheckBox myCheckBox = (CheckBox)(row.Cells[6].FindControl("chkSelect"));
                                myCheckBox.Checked = false;
                            }
                        }
                    }
                }
                else
                {
                    foreach (GridViewRow row in GvLembur.Rows)
                    {
                        CheckBox myCheckBox = (CheckBox)(row.Cells[6].FindControl("chkSelect"));
                        myCheckBox.Checked = false;
                    }
                }
            }

            protected void GvLembur_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                if (e.CommandName == "Page")
                {
                    RememberOldValues();
                }
            }

            protected void btnSimpan_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    SqlConnection cn;
                    SqlCommand cmd = new SqlCommand();
                    cn = new SqlConnection(Application["strCn"].ToString());

                    RememberOldValues();

                    ArrayList categoryIDList2 = (ArrayList)(Session["UNCHECK"]);
                    int n;

                    if (categoryIDList2 != null)
                    {
                        if (categoryIDList2.Count > 0)
                        {
                            for (n = 0; n <= categoryIDList2.Count - 1; n++)
                            {
                                int j = categoryIDList2[n].ToString().IndexOf(",");
                                int x = categoryIDList2[n].ToString().Length;
                                string NIP = categoryIDList2[n].ToString().Substring(0, j);
                                string Tanggal_Ijin = categoryIDList2[n].ToString().Substring(j + 1, x - (j + 1));
                                cn.Open();
                                cmd.CommandText = "update taLembur set STATUS_LEMBUR = 0 where NIP = '" + NIP + "' And TGL_SPL = '" + (DateTime.Parse(Tanggal_Ijin)).ToString("MM/dd/yyyy") + "'";
                                cmd.CommandType = CommandType.Text;
                                cmd.Connection = cn;
                                try
                                {
                                    cmd.ExecuteNonQuery();
                                }
                                catch (Exception ex)
                                {
                                    ExceptionDetails.Text = ex.Message;
                                }
                                cn.Close();
                            }
                        }
                    }

                    ArrayList categoryIDList = (ArrayList)(Session["CHECKED_ITEMS"]);
                    int i;

                    if (categoryIDList != null)
                    {
                        if (categoryIDList.Count > 0)
                        {
                            for (i = 0; i <= categoryIDList.Count - 1; i++)
                            {
                                int j = categoryIDList[i].ToString().IndexOf(",");
                                int x = categoryIDList[i].ToString().Length;
                                string NIP = categoryIDList[i].ToString().Substring(0, j);
                                string Tanggal_Ijin = categoryIDList[i].ToString().Substring(j + 1, x - (j + 1));
                                cn.Open();
                                cmd.CommandText = "update taLembur set STATUS_LEMBUR = 1 where NIP = '" + NIP + "' And TGL_SPL = '" + (DateTime.Parse(Tanggal_Ijin)).ToString("MM/dd/yyyy") + "'";
                                cmd.CommandType = CommandType.Text;
                                cmd.Connection = cn;
                                try
                                {
                                    cmd.ExecuteNonQuery();
                                }
                                catch (Exception ex)
                                {
                                    ExceptionDetails.Text = ex.Message;
                                }
                                cn.Close();
                            }
                        }
                    }
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2316", "", Application["strCn"].ToString());
                    RememberOldValuesFirstTime();
                    GvLembur.DataBind();
                }
            }

            protected void chkCheckOrClearAll_CheckedChanged(object sender, EventArgs e)
            {
                if (chkCheckOrClearAll.Checked)
                {
                    btnCekAll_Click(sender, e);
                }
                else
                {
                    Uncek(sender, e);
                }
            }

            protected void btnCekAll_Click(object sender, EventArgs e)
            {
                ArrayList categoryIDList = new ArrayList();
                if (Session["CHECKED_ITEMS"] != null)
                {
                    categoryIDList = (ArrayList)(Session["CHECKED_ITEMS"]);
                }

                SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
                DataSet mydataset = new DataSet();
                SqlDataAdapter myadapter = new SqlDataAdapter();
                SqlCommand mycommand = new SqlCommand("Select NIP, TGL_SPL from q_Lembur WHERE" + Session["FilterAlasan"].ToString().Substring(4, Session["FilterAlasan"].ToString().Length - 4), myconection);
                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taLembur");

                //Seleksi apakah hasil Query null atau tidak
                //jika null maka item hanya null
                //jika tidak null maka item diisi oleh kode range yang didapat
                if (mydataset.Tables["taLembur"].Rows.Count == 0)
                {
                    myadapter.Dispose();
                    mydataset.Clear();
                }
                else
                {
                    DataTable myTabel = mydataset.Tables["taLembur"];

                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        if (categoryIDList != null)
                        {
                            if (!categoryIDList.Contains(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_SPL"].ToString()).ToShortDateString()))
                            {
                                categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_SPL"].ToString()).ToShortDateString());
                            }
                        }
                        else
                        {
                            categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_SPL"].ToString()).ToShortDateString());
                        }
                    }
                    if (categoryIDList != null)
                    {
                        if (categoryIDList.Count > 0)
                        {
                            Session["CHECKED_ITEMS"] = categoryIDList;
                        }
                    }
                    myadapter.Dispose();
                    mydataset.Clear();

                    if (Session["UNCHECK"] != null)
                    {
                        Session.Remove("UNCHECK");
                    }

                    GvLembur.DataBind();
                }
            }

            protected void Uncek(object sender, EventArgs e)
            {
                ArrayList categoryIDList = new ArrayList();
                ArrayList categoryIDList2 = new ArrayList();
                if (Session["CHECKED_ITEMS"] != null)
                {
                    categoryIDList2 = (ArrayList)(Session["CHECKED_ITEMS"]);
                }

                SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
                DataSet mydataset = new DataSet();
                SqlDataAdapter myadapter = new SqlDataAdapter();
                SqlCommand mycommand = new SqlCommand("Select NIP, TGL_SPL from q_Lembur WHERE" + Session["FilterAlasan"].ToString().Substring(4, Session["FilterAlasan"].ToString().Length - 4), myconection);

                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taLembur");

                //Seleksi apakah hasil Query null atau tidak
                //jika null maka item hanya null
                //jika tidak null maka item diisi oleh kode range yang didapat
                if (mydataset.Tables["taLembur"].Rows.Count == 0)
                {
                    myadapter.Dispose();
                    mydataset.Clear();
                }
                else
                {
                    DataTable myTabel = mydataset.Tables["taLembur"];

                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_SPL"].ToString()).ToShortDateString());
                        if (categoryIDList2 != null)
                        {
                            categoryIDList2.Remove(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_SPL"].ToString()).ToShortDateString());
                        }
                    }
                    if (categoryIDList != null)
                    {
                        if (categoryIDList.Count > 0)
                        {
                            Session["UNCHECK"] = categoryIDList;
                        }
                    }
                    myadapter.Dispose();
                    mydataset.Clear();

                    if (categoryIDList2.Count > 0)
                    {
                        Session.Remove("CHECKED_ITEMS");
                        Session["CHECKED_ITEMS"] = categoryIDList2;
                    }
                    else
                    {
                        Session.Remove("CHECKED_ITEMS");
                    }
                    //If Not Session("CHECKED_ITEMS2") Is Nothing Then
                    //    Session.Remove("CHECKED_ITEMS2")
                    //End If
                }

                GvLembur.DataBind();
            }
}
	}
