///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : ceremony_manual.aspx.cs                             (Pseudo code)

//        File terkait  : ceremony_manual.aspx                                (Form)
//                        \App_LocalResources\ceremony_manual.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\ceremony_manual.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel Absen (taTmpAbsenUpacara)

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 14/03/2012
//
// 4. Versi             : 1.0.0
//
// 5. Historis revisi
//
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

        public partial class ceremony_manual : BasePage
		{
            private void showGridView(Boolean show)
            {
                Gvceremony_manual.Visible = show;
                tableFilter.Visible = show;
                Fvceremony_manual.Visible = !show;
                //if ((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "3"))
                //{
                //    lblTambah.Visible = show;
                //    ImgbtnAdd.Visible = show;
                //}
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

                    strFilter += " WHERE (TGL_MASUK >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND TGL_MASUK <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "')";

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

                    if (chkFilterItem5.Checked)
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND ISI_MANUAL = 'Y'";
                        }
                        else
                        {
                            strFilter += " WHERE ISI_MANUAL = 'Y'";
                        }
                    }

                    dsceremony_manual.SelectCommand += strFilter + " ORDER BY TGL_MASUK ASC";
                }
                catch (Exception ex)
                {}
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
            }

            private void setComponent()
            {
                if ((Session["GradeID"].ToString() != "1"))
                {
                    lblTambah.Visible = false;
                    ImgbtnAdd.Visible = false;
                    Gvceremony_manual.Columns[6].Visible = false;
                    Gvceremony_manual.Columns[7].Visible = false;
                }

                BoundField Column0 = (BoundField)Gvceremony_manual.Columns[0];
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
				//jika userid kosong maka akan di link ke halaman awal
				if (! rtwin.azlib.AksesHalaman(13, Session["UserID"].ToString().ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
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
                    Gvceremony_manual.DataBind();
                }
            }

            protected void lblTambah_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    Fvceremony_manual.DefaultMode = FormViewMode.Insert;
                    Fvceremony_manual.ChangeMode(FormViewMode.Insert);
                    showGridView(false);
                }
            }

            protected void ImgBtnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lblTambah_Click(sender, e);
            }

            protected void Gvceremony_manual_DataBound(object sender, EventArgs e)
            {
                GridViewRow rowPager = Gvceremony_manual.BottomPagerRow;

                if (rowPager != null)
                {
                    // get your controls from the gridview
                    TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                    Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                    txtHalaman.Text = (Gvceremony_manual.PageIndex + 1).ToString();
                    // populate page count
                    lblJumlahHalaman.Text = Gvceremony_manual.PageCount.ToString();
                }
                else
                {
                    return;
                }
            }

            //Menyisipkan javascript untuk confirm sebelum delete
            protected void Gvceremony_manual_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
            {
                //menambahkan State Row on Hover
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    GridView gv = ((GridView)sender);

                    String className = ((e.Row.RowState == DataControlRowState.Alternate) ? gv.AlternatingRowStyle.CssClass : gv.RowStyle.CssClass);

                    e.Row.Attributes.Add("onmouseover", "this.className='datagrid_hovcol';");

                    e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");

                    //if (Session["GradeID"].ToString() != "1")
                    //{
                        ImageButton btnEdit = (ImageButton)e.Row.FindControl("imgEdit");
                        ImageButton btnDelete = (ImageButton)e.Row.FindControl("imgDelete");
                        Label lblTgl = (Label)e.Row.FindControl("lblCol2Item");
                        Label lblJamAbsen = (Label)e.Row.FindControl("lblCol4Item");

                        btnEdit.Enabled = btnEdit.Enabled && (lblJamAbsen.Text != "") && (DateTime.Parse(lblTgl.Text) >= DateTime.Parse(Session["tglTutup"].ToString()));
                        btnDelete.Enabled = btnEdit.Enabled && (DateTime.Parse(lblTgl.Text) >= DateTime.Parse(Session["tglTutup"].ToString()));
                    //}
                }
            }

            protected void Gvceremony_manual_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    dsceremony_manual.SelectCommand = "SELECT NIP, PIN , NAMA, TGL_MASUK, KODE_RANGE, JAM_MASUK, JAM_KELUAR FROM q_Absen";
                    if (isEntryUseNIP())
                    {
                        dsceremony_manual.SelectCommand += " WHERE NIP = '" + Gvceremony_manual.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_MASUK = '" + DateTime.Parse(((Label)Gvceremony_manual.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                    }
                    else
                    {
                        dsceremony_manual.SelectCommand += " WHERE PIN = '" + Gvceremony_manual.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_MASUK = '" + DateTime.Parse(((Label)Gvceremony_manual.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                    }
                    e.Cancel = true;
                    Fvceremony_manual.DefaultMode = FormViewMode.Edit;
                    Fvceremony_manual.ChangeMode(FormViewMode.Edit);
                    showGridView(false);
                }
                else
                {
                    e.Cancel = true;
                }
            }

            protected void Fvceremony_manual_ItemCommand(object sender, FormViewCommandEventArgs e)
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

            protected void dsceremony_manualEdit_Updating(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    TextBox jam_awal = (TextBox)Fvceremony_manual.FindControl("txtItem3FormView");
                    TextBox jam_akhir = (TextBox)Fvceremony_manual.FindControl("txtItem4FormView");

                    bool TimeSpanValidation = false;

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

                    if (TimeSpanValidation)
                    {
                        DateTime Tanggal_Fix = DateTime.Parse(((Label)Fvceremony_manual.FindControl("lblItem2FormView")).Text);
                        CheckBox ganti_hari = (CheckBox)Fvceremony_manual.FindControl("cbGantiHari");
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

                        e.Command.Parameters["@JAM_MASUK"].Value = DateTime.Parse(jamAwal);
                        e.Command.Parameters["@JAM_KELUAR"].Value = DateTime.Parse(jamAkhir);
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    e.Cancel = true;
                }
            }

            protected void dsceremony_manualEdit_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2102", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_MASUK"].Value.ToString(), Application["strCn"].ToString());                    
                }
                Gvceremony_manual.DataBind();
                showGridView(true);
            }

            protected void dsceremony_manual_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2103", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_MASUK"].Value.ToString(), Application["strCn"].ToString());
                }
                Gvceremony_manual.DataBind();
            }

            protected void Fvceremony_manual_DataBound(object sender, EventArgs e)
            {
                if (Fvceremony_manual.CurrentMode == FormViewMode.Insert)
                {
                    if (isEntryUseNIP())
                    {
                        ((Label)Fvceremony_manual.FindControl("lblPIN")).Visible = false;
                    }
                    else
                    {
                        ((Label)Fvceremony_manual.FindControl("lblNIP")).Visible = false;
                    }

                    if (ViewState["TglHadir"] != null)
                    {
                        ((TextBox)Fvceremony_manual.FindControl("txtItem2FormView")).Text = ViewState["TglHadir"].ToString();
                        ViewState.Remove("TglHadir");
                    }
                    else
                    {
                        ((TextBox)Fvceremony_manual.FindControl("txtItem2FormView")).Text = DateTime.Now.ToShortDateString();
                    }
                    //TIGA
                    RangeValidator ValTglAdd = (RangeValidator)Fvceremony_manual.FindControl("CompareValTglAdd");
                    ValTglAdd.MinimumValue = DateTime.Parse(Session["tglTutup"].ToString()).ToShortDateString();
                    //ValTglAdd.MaximumValue = Session["tglBatas"];
                    TextBox txtNip = (TextBox)Fvceremony_manual.FindControl("txtItem0FormView");
                    txtNip.Focus();
                }
                else if (Fvceremony_manual.CurrentMode == FormViewMode.Edit)
                {
                    if (isEntryUseNIP())
                    {
                        ((Label)Fvceremony_manual.FindControl("lblPIN")).Visible = false;
                        ((Label)Fvceremony_manual.FindControl("lblItem0_FormView")).Visible = false;
                    }
                    else
                    {
                        ((Label)Fvceremony_manual.FindControl("lblNip")).Visible = false;
                        ((Label)Fvceremony_manual.FindControl("lblItem0FormView")).Visible = false;
                    }
                }
            }

            protected void dsceremony_manualEdit_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    ViewState["TglHadir"] = ((TextBox)Fvceremony_manual.FindControl("txtItem2FormView")).Text;

                    TextBox jam_awal = (TextBox)Fvceremony_manual.FindControl("txtItem3FormView");
                    TextBox jam_akhir = (TextBox)Fvceremony_manual.FindControl("txtItem4FormView");

                    bool TimeSpanValidation = false;

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

                    if (TimeSpanValidation)
                    {
                        string sNIP;
                        DateTime Tanggal_Fix = DateTime.Parse(((TextBox)Fvceremony_manual.FindControl("txtItem2FormView")).Text);
                        CheckBox ganti_hari = (CheckBox)Fvceremony_manual.FindControl("cbGantiHari");
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
                            sNIP = ((TextBox)Fvceremony_manual.FindControl("txtItem0FormView")).Text;
                        }
                        else
                        {
                            sNIP = azlib.getNIP(((TextBox)Fvceremony_manual.FindControl("txtItem0FormView")).Text, Application["strCn"].ToString());
                        }
                        e.Command.Parameters["@NIP"].Value = sNIP;
                        e.Command.Parameters["@TGL_MASUK"].Value = Tanggal_Fix;
                        e.Command.Parameters["@JAM_MASUK"].Value = DateTime.Parse(jamAwal);
                        e.Command.Parameters["@JAM_KELUAR"].Value = DateTime.Parse(jamAkhir);
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    e.Cancel = true;
                }
            }

            protected void dsceremony_manualEdit_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2101", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_MASUK"].Value.ToString(), Application["strCn"].ToString());
                    ExceptionDetails.Text = "Data telah di simpan";

                    Gvceremony_manual.DataBind();

                    setInitialComponent();
                }                                
                
                if (!isEntrySambung())
                {
                    showGridView(true);
                }
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = Gvceremony_manual.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= Gvceremony_manual.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        Gvceremony_manual.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        Gvceremony_manual.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (Gvceremony_manual.PageIndex + 1).ToString();
                }
            }

            private void setInitialComponent()
            {
                ((TextBox)Fvceremony_manual.FindControl("txtItem0FormView")).Text = "";
                ((Label)Fvceremony_manual.FindControl("lblItem1FormView")).Text = "";
                ((TextBox)Fvceremony_manual.FindControl("txtItem2FormView")).Text = DateTime.Now.ToShortDateString();
                ((TextBox)Fvceremony_manual.FindControl("txtItem3FormView")).Text = "";
                ((TextBox)Fvceremony_manual.FindControl("txtItem4FormView")).Text = "";
                ((CheckBox)Fvceremony_manual.FindControl("cbGantiHari")).Checked = false;
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
                TextBox txtNIP = (TextBox)Fvceremony_manual.FindControl("txtItem0FormView");
                Label lblNama = (Label)Fvceremony_manual.FindControl("lblItem1FormView");
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
                        strSelect = "SELECT NAMA FROM q_Karyawan WHERE NIP='" + azlib.getNIP(txtNIP.Text,Application["strCn"].ToString()).Trim() + "'";
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
                SqlDataAdapter adpSQL = new SqlDataAdapter(strSelect, Application["strCn"].ToString().ToString());
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
                            this.txtFilterItem2.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[1].FindControl("Label3")).Text;
                        }
                    }
                    else if (Session["Triger"].ToString() == "txtItem0FormView")
                    {
                        if (isEntryUseNIP())
                        {
                            ((TextBox)Fvceremony_manual.FindControl("txtItem0FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                            ((Label)Fvceremony_manual.FindControl("lblItem1FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;
                        }
                        else
                        {
                            ((TextBox)Fvceremony_manual.FindControl("txtItem0FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[1].FindControl("Label3")).Text;
                            ((Label)Fvceremony_manual.FindControl("lblItem1FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;
                        }                        
                    }

                    Session.Remove("Triger");
                }

                setInitialLookupState();
                UpdatePanel1.Update();
            }
}
	}
