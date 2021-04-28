///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : manual.aspx.cs                             (Pseudo code)

//        File terkait  : timeoff.aspx                                (Form)
//                        \App_LocalResources\timeoff.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\timeoff.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk entri ijin alasan ketidakhadiran per jam

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 11/09/2009
//
// 4. Versi             : 2.0.3
//
// 5. Historis revisi
//        Versi 2.0.1   : Penyempurnaan Filter
//        Versi 2.0.2   : Implementasi AJAX
//        Versi 2.0.3   : Pengaturan Hak Akses setiap Level
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

        public partial class timeoff : BasePage
		{
            private void showGridView(Boolean show)
            {
                GvAlasan.Visible = show;
                tableFilter.Visible = show;
                FvAlasan.Visible = !show;
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
                    string strJoin = "";

                    if (chkDuplikasi.Checked == true)
                    {
                        strJoin += " inner join (select nip, tgl_masuk from q_IjinGabung where tgl_masuk >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND tgl_masuk <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "' group by nip, tgl_masuk having count(*) > 1 ) as x on q_IjinJam.nip = x.nip and q_IjinJam.tgl_ijin = x.tgl_masuk";
                    }

                    strFilter += " WHERE (q_IjinJam.TGL_IJIN >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND q_IjinJam.TGL_IJIN <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "')";

                    if (txtFilterItem2.Text.Trim() != "")
                    {
                        if (isEntryUseNIP())
                        {
                            if (strFilter != "")
                            {
                                strFilter += " AND (q_IjinJam.NIP = '" + txtFilterItem2.Text.Replace("'", "''") + "')";
                            }
                            else
                            {
                                strFilter += " WHERE (q_IjinJam.NIP = '" + txtFilterItem2.Text.Replace("'", "''") + "')";
                            }
                        }
                        else
                        {
                            txtFilterItem2.Text = azlib.FillNull(txtFilterItem2.Text, 10);
                            if (strFilter != "")
                            {
                                strFilter += " AND (q_IjinJam.PIN = '" + txtFilterItem2.Text.Replace("'", "''") + "')";
                            }
                            else
                            {
                                strFilter += " WHERE (q_IjinJam.PIN = '" + txtFilterItem2.Text.Replace("'", "''") + "')";
                            }
                        }
                    }

                    if ((ddlFilterItem3.SelectedValue != "000") && (ddlFilterItem3.SelectedValue != ""))
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND (q_IjinJam.KODE_DEPUTI = '" + ddlFilterItem3.SelectedValue + "')";
                        }
                        else
                        {
                            strFilter += " WHERE (q_IjinJam.KODE_DEPUTI = '" + ddlFilterItem3.SelectedValue + "')";
                        }
                    }

                    if ((ddlFilterItem4.SelectedValue != "0000") && (ddlFilterItem4.SelectedValue != ""))
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND (q_IjinJam.KODE_BIRO = '" + ddlFilterItem4.SelectedValue + "')";
                        }
                        else
                        {
                            strFilter += " WHERE (q_IjinJam.KODE_BIRO = '" + ddlFilterItem4.SelectedValue + "')";
                        }
                    }

                    if ((((ddlFilterItem3.SelectedValue == "000") || (ddlFilterItem3.SelectedValue == "")) && ((ddlFilterItem4.SelectedValue == "0000") || (ddlFilterItem4.SelectedValue == "")))) //Operator
                    {
                        if ((Session["GradeID"].ToString() == "2"))
                        {
                            if (strFilter != "")
                            {
                                strFilter += " AND q_IjinJam.KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                            }
                            else
                            {
                                strFilter += " WHERE q_IjinJam.KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                            }
                        }
                        else if ((Session["GradeID"].ToString().Substring(0, 1) == "3"))
                        {
                            if (strFilter != "")
                            {
                                strFilter += " AND q_IjinJam.KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                            }
                            else
                            {
                                strFilter += " WHERE q_IjinJam.KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                            }
                        }
                    }

                    if (ddlFilterItem5.SelectedValue != "-")
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND q_IjinJam.STATUS_IJIN = " + ddlFilterItem5.SelectedValue + "";
                        }
                        else
                        {
                            strFilter += " WHERE q_IjinJam.STATUS_IJIN = " + ddlFilterItem5.SelectedValue + "";
                        }
                    }

                    dsAlasan.SelectCommand += strJoin + strFilter + " ORDER BY TGL_IJIN ASC";

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
                        GvAlasan.Columns[8].Visible = false;
                        GvAlasan.Columns[9].Visible = false;
                        GvAlasan.Columns[10].Visible = false;
                    }
                    btnSimpan.Visible = false;
                    chkCheckOrClearAll.Visible = false;
                    chkDuplikasi.Visible = false;
                }
                if ((Session["FilterAlasan"] != null) || (Session["CHECKED_ITEMS"] != null))
                {
                    Session.Remove("FilterAlasan");
                    Session.Remove("CHECKED_ITEMS");
                }
                BoundField Column0 = (BoundField)GvAlasan.Columns[0];
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

            private bool cekDayOff(string NIP, string TGL_IJIN)
            {
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                string strSelect = "";
                strSelect = "SELECT * FROM q_ijinhari WHERE (tgl_awal<='" + TGL_IJIN + "' AND tgl_akhir>='" + TGL_IJIN + "') AND nip='" + NIP + "'";
                DataSet dsMsg = new DataSet();
                SqlDataAdapter adpSQL = new SqlDataAdapter(strSelect, cn);
                adpSQL.Fill(dsMsg, "taIjin");
                int recordCount = dsMsg.Tables["taIjin"].Rows.Count;
                if (recordCount > 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }

            protected void Page_Load(object sender, EventArgs e)
			{
				//jika userid kosong maka akan di link ke halaman awal
				if (! rtwin.azlib.AksesHalaman(15, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
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
                    GvAlasan.DataBind();
                }
            }

            protected void lblTambah_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    FvAlasan.DefaultMode = FormViewMode.Insert;
                    FvAlasan.ChangeMode(FormViewMode.Insert);
                    showGridView(false);
                }
            }

            protected void ImgBtnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lblTambah_Click(sender, e);
            }

            protected void GvAlasan_DataBound(object sender, EventArgs e)
            {
                if (!Page.IsPostBack)
                {
                    RememberOldValuesFirstTime();
                }
                else
                {
                    RePopulateValues();
                }
                
                GridViewRow rowPager = GvAlasan.BottomPagerRow;

                if (rowPager != null)
                {
                    // get your controls from the gridview
                    TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                    Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                    txtHalaman.Text = (GvAlasan.PageIndex + 1).ToString();
                    // populate page count
                    lblJumlahHalaman.Text = GvAlasan.PageCount.ToString();
                }
                else
                {
                    return;
                }
            }

            //Menyisipkan javascript untuk confirm sebelum delete
            protected void GvAlasan_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
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
                        CheckBox chkSelect = (CheckBox)e.Row.Cells[8].FindControl("chkSelect");
                        ImageButton btnEdit = (ImageButton)e.Row.Cells[9].FindControl("imgEdit");
                        ImageButton btnDelete = (ImageButton)e.Row.Cells[10].FindControl("imgDelete");
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

            protected void GvAlasan_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    dsAlasan.SelectCommand = "SELECT NIP, PIN, NAMA, TGL_IJIN, JAM_AWAL_IJIN, JAM_AKHIR_IJIN, KODE_IJIN, KET_IJIN, ALASAN_IJIN, IJIN_DINAS, STATUS_IJIN, CASE WHEN IJIN_DINAS = 1 THEN 'Ya' ELSE 'Tidak' END AS KET_IJIN_DINAS FROM q_IjinJam";
                    if (isEntryUseNIP())
                    {
                        dsAlasan.SelectCommand += " WHERE NIP = '" + GvAlasan.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_IJIN = '" + DateTime.Parse(((Label)GvAlasan.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                    }
                    else
                    {
                        dsAlasan.SelectCommand += " WHERE PIN = '" + GvAlasan.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_IJIN = '" + DateTime.Parse(((Label)GvAlasan.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                    }
                    e.Cancel = true;
                    FvAlasan.DefaultMode = FormViewMode.Edit;
                    FvAlasan.ChangeMode(FormViewMode.Edit);
                    showGridView(false);
                }
                else
                {
                    e.Cancel = true;
                }
            }

            protected void FvAlasan_ItemCommand(object sender, FormViewCommandEventArgs e)
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

            protected void dsAlasanEdit_Updating(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    TextBox jam_awal = (TextBox)FvAlasan.FindControl("txtItem3FormView");
                    TextBox jam_akhir = (TextBox)FvAlasan.FindControl("txtItem4FormView");

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
                        DateTime Tanggal_Fix = DateTime.Parse(((Label)FvAlasan.FindControl("lblItem2FormView")).Text);
                        CheckBox ganti_hari = (CheckBox)FvAlasan.FindControl("cbGantiHari");
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

                        e.Command.Parameters["@JAM_AWAL_IJIN"].Value = DateTime.Parse(jamAwal);
                        e.Command.Parameters["@JAM_AKHIR_IJIN"].Value = DateTime.Parse(jamAkhir);
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    e.Cancel = true;
                }
            }

            protected void dsAlasanEdit_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2222", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_IJIN"].Value.ToString(), Application["strCn"].ToString());                    
                }
                RememberOldValuesFirstTime();
                GvAlasan.DataBind();
                showGridView(true);
            }

            protected void dsAlasan_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2223", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_IJIN"].Value.ToString(), Application["strCn"].ToString());
                }
                RememberOldValuesFirstTime();
                GvAlasan.DataBind();
            }

            protected void FvAlasan_DataBound(object sender, EventArgs e)
            {
                if (FvAlasan.CurrentMode != FormViewMode.ReadOnly)
                {
                    if (FvAlasan.CurrentMode == FormViewMode.Insert)
                    {
                        if (isEntryUseNIP())
                        {
                            ((Label)FvAlasan.FindControl("lblPIN")).Visible = false;
                        }
                        else
                        {
                            ((Label)FvAlasan.FindControl("lblNip")).Visible = false;
                        }

                        if (ViewState["TglIjin"] != null)
                        {
                            ((TextBox)FvAlasan.FindControl("txtItem2FormView")).Text = ViewState["TglIjin"].ToString();
                            ViewState.Remove("TglIjin");
                        }
                        else
                        {
                            ((TextBox)FvAlasan.FindControl("txtItem2FormView")).Text = DateTime.Now.ToShortDateString();
                        }
                        //TIGA
                        RangeValidator ValTglAdd = (RangeValidator)FvAlasan.FindControl("CompareValTglAdd");
                        ValTglAdd.MinimumValue = DateTime.Parse(Session["tglTutup"].ToString()).ToShortDateString();
                        //ValTglAdd.MaximumValue = Session["tglBatas"];
                        TextBox txtNip = (TextBox)FvAlasan.FindControl("txtItem0FormView");
                        txtNip.Focus();
                    }
                    else if (FvAlasan.CurrentMode == FormViewMode.Edit)
                    {
                        if (isEntryUseNIP())
                        {
                            ((Label)FvAlasan.FindControl("lblPIN")).Visible = false;
                            ((Label)FvAlasan.FindControl("lblItem0_FormView")).Visible = false;
                        }
                        else
                        {
                            ((Label)FvAlasan.FindControl("lblNip")).Visible = false;
                            ((Label)FvAlasan.FindControl("lblItem0FormView")).Visible = false;
                        }
                    }

                    if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2"))
                    {
                        ((Label)FvAlasan.FindControl("lblStatusIjin")).Visible = false;
                        ((CheckBox)FvAlasan.FindControl("chkItem8FormView")).Visible = false;
                    }
                    else
                    {
                        if (FvAlasan.CurrentMode == FormViewMode.Insert)
                        {
                            ((CheckBox)FvAlasan.FindControl("chkItem8FormView")).Checked = true;
                        }
                    }
                }
            }



            protected void ddlItem5FormView_SelectedIndexChanged(object sender, EventArgs e)
            {
                TextBox Jam_Awal_Ijin = (TextBox)FvAlasan.FindControl("txtItem3FormView");
                TextBox Jam_Akhir_Ijin = (TextBox)FvAlasan.FindControl("txtItem4FormView");
                RequiredFieldValidator Val_Jam_Awal_Ijin = (RequiredFieldValidator)FvAlasan.FindControl("valItem3FormView");
                RequiredFieldValidator Val_Jam_Akhir_Ijin = (RequiredFieldValidator)FvAlasan.FindControl("valItem4FormView");
                DropDownList Ket_Ijin = (DropDownList)FvAlasan.FindControl("ddlItem5FormView");
                CheckBox cbGantiHari = (CheckBox)FvAlasan.FindControl("cbGantiHari");

                string a;
                SqlConnection con = new SqlConnection(Application["strCn"].ToString());
                con.Open();
                SqlCommand pcom = new SqlCommand();
                SqlDataReader rdr;
                pcom = con.CreateCommand();
                pcom.CommandText = "select KODE_TIDAK_HADIR FROM taIjin WHERE KODE_IJIN = '" + Ket_Ijin.SelectedValue + "'";
                rdr = pcom.ExecuteReader();

                rdr.Read();
                a = rdr["KODE_TIDAK_HADIR"].ToString();

                rdr.Close();
                con.Close();

                if (a != "5")
                {
                    Jam_Awal_Ijin.Text = "";
                    Jam_Awal_Ijin.Enabled = false;
                    Jam_Akhir_Ijin.Text = "";
                    Jam_Akhir_Ijin.Enabled = false;
                    Val_Jam_Awal_Ijin.Enabled = false;
                    Val_Jam_Akhir_Ijin.Enabled = false;
                    cbGantiHari.Enabled = false;
                }
                else
                {
                    Jam_Awal_Ijin.Enabled = true;
                    Jam_Akhir_Ijin.Enabled = true;
                    Val_Jam_Awal_Ijin.Enabled = true;
                    Val_Jam_Akhir_Ijin.Enabled = true;
                    cbGantiHari.Enabled = true;
                }
            }

            protected void dsAlasanEdit_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    ViewState["TglIjin"] = ((TextBox)FvAlasan.FindControl("txtItem2FormView")).Text;

                    string sNIP;
                    TextBox NIP = (TextBox)FvAlasan.FindControl("txtItem0FormView");
                    TextBox jam_awal = (TextBox)FvAlasan.FindControl("txtItem3FormView");
                    TextBox jam_akhir = (TextBox)FvAlasan.FindControl("txtItem4FormView");
                    DateTime Tanggal_Fix = DateTime.Parse(((TextBox)FvAlasan.FindControl("txtItem2FormView")).Text);
                        
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
                        CheckBox ganti_hari = (CheckBox)FvAlasan.FindControl("cbGantiHari");
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

                        e.Command.Parameters["@JAM_AWAL_IJIN"].Value = DateTime.Parse(jamAwal);
                        e.Command.Parameters["@JAM_AKHIR_IJIN"].Value = DateTime.Parse(jamAkhir);
                    }

                    if (isEntryUseNIP())
                    {
                        sNIP = NIP.Text;
                    }
                    else
                    {
                        sNIP = azlib.getNIP(NIP.Text, Application["strCn"].ToString());
                    }

                    if (cekDayOff(sNIP, (Tanggal_Fix).ToString("MM/dd/yyyy")))
                    {
                    e.Command.Parameters["@NIP"].Value = sNIP;
                    e.Command.Parameters["@TGL_IJIN"].Value = Tanggal_Fix;                        
                    }
                    else
                    {
                        ExceptionDetails.Text = "Tidak dapat entry karena sudah terdapat ijin per hari";
                        e.Cancel = true;
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    e.Cancel = true;
                }
            }

            protected void dsAlasanEdit_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter insert maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;// +" (" + e.Exception.Message + ")";
                    e.ExceptionHandled = true;
                    if (!isEntrySambung())
                    {
                        setInitialComponent();
                    }
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2221", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_IJIN"].Value.ToString(), Application["strCn"].ToString());
                    ExceptionDetails.Text = "Data telah di simpan";
                    
                    RememberOldValuesFirstTime();
                    GvAlasan.DataBind();

                    setInitialComponent();
                }

                if (!isEntrySambung())
                {
                    showGridView(true);
                }
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvAlasan.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvAlasan.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        RememberOldValues();
                        GvAlasan.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvAlasan.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvAlasan.PageIndex + 1).ToString();
                }
            }

            private void setInitialComponent()
            {
                ((TextBox)FvAlasan.FindControl("txtItem0FormView")).Text = "";
                ((Label)FvAlasan.FindControl("lblItem1FormView")).Text = "";
                ((TextBox)FvAlasan.FindControl("txtItem2FormView")).Text = DateTime.Now.ToShortDateString();
                ((TextBox)FvAlasan.FindControl("txtItem3FormView")).Text = "";
                ((TextBox)FvAlasan.FindControl("txtItem4FormView")).Text = "";
                ((CheckBox)FvAlasan.FindControl("cbGantiHari")).Checked = false;
                ((DropDownList)FvAlasan.FindControl("ddlItem5FormView")).SelectedIndex = 0;
                ((TextBox)FvAlasan.FindControl("txtItem6FormView")).Text = "";
                ((CheckBox)FvAlasan.FindControl("chkItem7FormView")).Checked = false;                
                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2"))
                {
                    ((CheckBox)FvAlasan.FindControl("chkItem8FormView")).Checked = false;
                }
                else
                {
                    ((CheckBox)FvAlasan.FindControl("chkItem8FormView")).Checked = true;
                }
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
                TextBox txtNIP = (TextBox)FvAlasan.FindControl("txtItem0FormView");
                Label lblNama = (Label)FvAlasan.FindControl("lblItem1FormView");
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
                            ((TextBox)FvAlasan.FindControl("txtItem0FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                            ((Label)FvAlasan.FindControl("lblItem1FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;
                        }
                        else
                        {
                            ((TextBox)FvAlasan.FindControl("txtItem0FormView")).Text = GvLookupPegawai.SelectedRow.Cells[1].Text;
                            ((Label)FvAlasan.FindControl("lblItem1FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;
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
                string strJoin = "";

                if (chkDuplikasi.Checked == true)
                {
                    strJoin = " inner join (select nip, tgl_masuk from q_IjinGabung where tgl_masuk >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND tgl_masuk <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "' group by nip, tgl_masuk having count(*) > 1 ) as x on q_IjinJam.nip = x.nip and q_IjinJam.tgl_ijin = x.tgl_masuk";
                }

                ArrayList categoryIDList = new ArrayList();

                SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
                DataSet mydataset = new DataSet();
                SqlDataAdapter myadapter = new SqlDataAdapter();
                SqlCommand mycommand = new SqlCommand("Select q_IjinJam.NIP, q_IjinJam.TGL_IJIN from q_IjinJam " + strJoin + " WHERE STATUS_IJIN = 1" + Session["FilterAlasan"].ToString(), myconection);

                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taIjinJam");

                //Seleksi apakah hasil Query null atau tidak
                //jika null maka item hanya null
                //jika tidak null maka item diisi oleh kode range yang didapat
                if (mydataset.Tables["taIjinJam"].Rows.Count == 0)
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
                    DataTable myTabel = mydataset.Tables["taIjinJam"];

                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_IJIN"].ToString()).ToShortDateString());
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
                foreach (GridViewRow row in GvAlasan.Rows)
                {
                    //index = ((Label)(GvAlasan.Rows[row.RowIndex].Cells[0].FindControl("lblCol0Item"))).Text; //CType(GvIjinHari.DataKeys(row.RowIndex).Value, String)
                    index = GvAlasan.DataKeys[row.RowIndex]["NIP"].ToString();
                    index2 = ((Label)(GvAlasan.Rows[row.RowIndex].Cells[2].FindControl("lblCol2Item"))).Text; //CType(GvIjinHari.DataKeys(row.RowIndex).Value, String)

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

                        foreach (GridViewRow row in GvAlasan.Rows)
                        {
                            //string index = ((Label)(GvAlasan.Rows[row.RowIndex].Cells[0].FindControl("lblCol0Item"))).Text; //CType(GvIjinHari.DataKeys(row.RowIndex).Value, String)
                            string index = GvAlasan.DataKeys[row.RowIndex]["NIP"].ToString();
                            string index2 = ((Label)(GvAlasan.Rows[row.RowIndex].Cells[2].FindControl("lblCol2Item"))).Text; //CType(GvIjinHari.DataKeys(row.RowIndex).Value, String)

                            if (categoryIDList.Contains(index + "," + index2))
                            {
                                CheckBox myCheckBox = (CheckBox)(row.Cells[8].FindControl("chkSelect"));
                                myCheckBox.Checked = true;
                            }
                            else
                            {
                                CheckBox myCheckBox = (CheckBox)(row.Cells[8].FindControl("chkSelect"));
                                myCheckBox.Checked = false;
                            }
                        }
                    }
                }
                else
                {
                    foreach (GridViewRow row in GvAlasan.Rows)
                    {
                        CheckBox myCheckBox = (CheckBox)(row.Cells[8].FindControl("chkSelect"));
                        myCheckBox.Checked = false;
                    }
                }
            }

            protected void GvAlasan_RowCommand(object sender, GridViewCommandEventArgs e)
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
                                cmd.CommandText = "update taIjinJam set STATUS_IJIN = 0 where NIP = '" + NIP + "' And TGL_IJIN = '" + (DateTime.Parse(Tanggal_Ijin)).ToString("MM/dd/yyyy") + "'";
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
                                cmd.CommandText = "update taIjinJam set STATUS_IJIN = 1 where NIP = '" + NIP + "' And TGL_IJIN = '" + (DateTime.Parse(Tanggal_Ijin)).ToString("MM/dd/yyyy") + "'";
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2226", "", Application["strCn"].ToString());
                    RememberOldValuesFirstTime();
                    GvAlasan.DataBind();
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
                SqlCommand mycommand = new SqlCommand("Select NIP, TGL_IJIN from q_IjinJam WHERE" + Session["FilterAlasan"].ToString().Substring(4, Session["FilterAlasan"].ToString().Length - 4), myconection);
                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taIjinJam");

                //Seleksi apakah hasil Query null atau tidak
                //jika null maka item hanya null
                //jika tidak null maka item diisi oleh kode range yang didapat
                if (mydataset.Tables["taIjinJam"].Rows.Count == 0)
                {
                    myadapter.Dispose();
                    mydataset.Clear();
                }
                else
                {
                    DataTable myTabel = mydataset.Tables["taIjinJam"];

                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        if (categoryIDList != null)
                        {
                            if (!categoryIDList.Contains(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_IJIN"].ToString()).ToShortDateString()))
                            {
                                categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_IJIN"].ToString()).ToShortDateString());
                            }
                        }
                        else
                        {
                            categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_IJIN"].ToString()).ToShortDateString());
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

                    GvAlasan.DataBind();
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
                SqlCommand mycommand = new SqlCommand("Select NIP, TGL_IJIN from q_IjinJam WHERE" + Session["FilterAlasan"].ToString().Substring(4, Session["FilterAlasan"].ToString().Length - 4), myconection);

                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taIjinJam");

                //Seleksi apakah hasil Query null atau tidak
                //jika null maka item hanya null
                //jika tidak null maka item diisi oleh kode range yang didapat
                if (mydataset.Tables["taIjinJam"].Rows.Count == 0)
                {
                    myadapter.Dispose();
                    mydataset.Clear();
                }
                else
                {
                    DataTable myTabel = mydataset.Tables["taIjinJam"];

                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_IJIN"].ToString()).ToShortDateString());
                        if (categoryIDList2 != null)
                        {
                            categoryIDList2.Remove(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_IJIN"].ToString()).ToShortDateString());
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

                GvAlasan.DataBind();
            }
}
	}
