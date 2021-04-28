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
using System.Configuration;
using System.Collections;
using System.Data;
using System.Web.Caching;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Diagnostics;
using System.Web.Security;
using System;
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : dayoff.aspx.cs                             (Pseudo code)

//        File terkait  : dayoff.aspx                                (Form)
//                        \App_LocalResources\dayoff.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\dayoff.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk Entri Alasan Ketidakhadiran per hari

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
//        Versi 2.0.3   : Set kondisi komponen untuk setiap level yg ada
//
//
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	namespace rtwin
	{

        public partial class dayoff : BasePage
		{
            private void showGridView(Boolean show)
            {
                GvAlasan.Visible = show;
                tableFilter.Visible = show;
                tblFormView.Visible = !show;
                if ((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "1a") || (Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "3"))
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

                    //strFilter += " WHERE ((TGL_AWAL >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND TGL_AWAL <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "') OR (TGL_AKHIR >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND TGL_AKHIR <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "'))";
                    strFilter += " WHERE ((((TGL_AWAL >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND TGL_AWAL <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "') OR (TGL_AKHIR >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND TGL_AKHIR <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "'))) OR (TGL_AWAL <= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND TGL_AKHIR >= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "'))";

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
                            strFilter += " AND STATUS_IJIN = " + ddlFilterItem5.SelectedValue;
                        }
                        else
                        {
                            strFilter += " WHERE STATUS_IJIN = " + ddlFilterItem5.SelectedValue;
                        }
                    }

                    if (cbFilterItem6.Checked)
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND KODE_IJIN = '" + ddlFilterItem6.SelectedValue + "'";
                        }
                        else
                        {
                            strFilter += " WHERE KODE_IJIN = '" + ddlFilterItem6.SelectedValue + "'";
                        }
                    }

                    dsAlasan.SelectCommand += strFilter + " ORDER BY TGL_AWAL ASC";

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
                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "1a") && (Session["GradeID"].ToString() != "2"))
                {
                    //if (Session["GradeID"].ToString() != "3")
                    //{
                    //    lblTambah.Visible = false;
                    //    ImgbtnAdd.Visible = false;
                    //    GvAlasan.Columns[9].Visible = false;
                    //    GvAlasan.Columns[10].Visible = false;
                    //    GvAlasan.Columns[11].Visible = false;
                    //}
                    //   
                    btnUploadDayoff.Visible = false;
                    if (Session["GradeID"].ToString() == "4")
                    {
                        txtFilterItem2.Enabled = false;
                        lnkFilterItem2.Visible = false;
                        lblBiro.Visible = false;
                        ddlFilterItem3.Visible = false;
                        lblBagian.Visible = false;
                        ddlFilterItem4.Visible = false;
                        lblStatusAlasan.Visible = false;
                        ddlFilterItem5.Visible = false;
                        cbFilterItem6.Checked = true;
                        //cbFilterItem6.Visible = false;
                        //ddlFilterItem6.Visible = false;
                        cbFilterItem6.Enabled = false;
                        ddlFilterItem6.Enabled = false;

                    }
                    btnSimpan.Visible = false;
                    chkCheckOrClearAll.Visible = false;
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

            private bool cekKredit(string kode_ijin)
            {
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                string strSelect = "";
                strSelect = "SELECT KREDIT FROM taIjin WHERE (KODE_IJIN = '" + kode_ijin + "')";
                DataSet dsMsg = new DataSet();
                SqlDataAdapter adpSQL = new SqlDataAdapter(strSelect, cn);
                adpSQL.Fill(dsMsg, "taKreditIjin");
                DataRow myRow = dsMsg.Tables["taKreditIjin"].Rows[0];
                if (myRow["KREDIT"].ToString() != "1")
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
				if (! rtwin.azlib.AksesHalaman(14, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
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
            
                if (Session["GradeID"].ToString() == "1a")
                {
                    dsIjin.SelectCommand = "SELECT KODE_IJIN, '[' + KODE_IJIN + '] ' + KET_IJIN AS KET_IJIN FROM taIjin WHERE (KODE_IJIN = 'PD')";
                }
                else if (Session["GradeID"].ToString() == "4")
                {
                    dsIjin.SelectCommand = "SELECT KODE_IJIN, '[' + KODE_IJIN + '] ' + KET_IJIN AS KET_IJIN FROM taIjin WHERE (KODE_IJIN = 'CT')";
                }
                else
                {
                    dsIjin.SelectCommand = "SELECT KODE_IJIN, '[' + KODE_IJIN + '] ' + KET_IJIN AS KET_IJIN FROM taIjin WHERE (KODE_TIDAK_HADIR = '1') ORDER BY KODE_IJIN";
                }
                dsIjin.DataBind();
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
                        CheckBox chkSelect = (CheckBox)e.Row.Cells[9].FindControl("chkSelect");
                        ImageButton btnEdit = (ImageButton)e.Row.Cells[10].FindControl("imgEdit");
                        ImageButton btnDelete = (ImageButton)e.Row.Cells[11].FindControl("imgDelete");
                        Label lblTgl = (Label)e.Row.Cells[3].FindControl("lblCol3Item");
                        Label lblKodeCuti = (Label)e.Row.Cells[4].FindControl("lblCol4Item");

                        if (Session["GradeID"].ToString() != "2")
                        {
                            chkSelect.Enabled = false;
                            if (Session["GradeID"].ToString() != "1a")
                            {
                                btnEdit.Enabled = !chkSelect.Checked;
                                btnDelete.Enabled = !chkSelect.Checked;
                            }
                            else if (Session["GradeID"].ToString() == "4")
                            {
                                btnEdit.Enabled = lblKodeCuti.Text == "CT";
                                btnDelete.Enabled = lblKodeCuti.Text == "CT";
                            }
                            else
                            {
                                btnEdit.Enabled = lblKodeCuti.Text == "PD";
                                btnDelete.Enabled = lblKodeCuti.Text == "PD";
                            }
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
                    dsAlasan.SelectCommand = "SELECT NIP, PIN, NAMA, TGL_AWAL, TGL_AKHIR, KODE_IJIN, KET_IJIN, JML_HARI, TGL_JATAH, BUKTI_IJIN, KET_STATUS, STATUS_IJIN, PERHITUNGAN, LAMA_IJIN, TGL_BERSALIN FROM q_IjinHari";
                    if (isEntryUseNIP())
                    {
                        dsAlasan.SelectCommand += " WHERE NIP = '" + GvAlasan.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_AWAL = '" + DateTime.Parse(((Label)GvAlasan.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                    }
                    else
                    {
                        dsAlasan.SelectCommand += " WHERE PIN = '" + GvAlasan.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_AWAL = '" + DateTime.Parse(((Label)GvAlasan.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
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
                    Label NIP = (Label)FvAlasan.FindControl("lblItem0FormView");
                    Label NAMA = (Label)FvAlasan.FindControl("lblItem1FormView");
                    Label TGL_AWAL = (Label)FvAlasan.FindControl("lblItem2FormView");
                    TextBox TGL_AKHIR = (TextBox)FvAlasan.FindControl("txtItem3FormView");                    
                    DropDownList KODE_IJIN = (DropDownList)FvAlasan.FindControl("ddlItem4FormView");
                    TextBox BUKTI_IJIN = (TextBox)FvAlasan.FindControl("txtItem5FormView");
                    CheckBox STATUS_IJIN = (CheckBox)FvAlasan.FindControl("chkItem6FormView");
                    TextBox TGL_BERSALIN = (TextBox)FvAlasan.FindControl("txtItem4aFormView");

                    getSession(NIP.Text, NAMA.Text, TGL_AWAL.Text, TGL_AKHIR.Text, KODE_IJIN.SelectedValue, BUKTI_IJIN.Text, STATUS_IJIN.Checked);


                    if (cekTimeOff(NIP.Text, DateTime.Parse(TGL_AWAL.Text).ToString("MM/dd/yyyy"), DateTime.Parse(TGL_AKHIR.Text).ToString("MM/dd/yyyy")))
                    {
                    if (cekContinueLeave(NIP.Text, DateTime.Parse(TGL_AWAL.Text).ToString("MM/dd/yyyy"), DateTime.Parse(TGL_AKHIR.Text).ToString("MM/dd/yyyy"),KODE_IJIN.SelectedValue,1))
                    {
                    if (cekBeforeInsertOrUpdate(NIP.Text, DateTime.Parse(TGL_AWAL.Text).ToString("MM/dd/yyyy"), DateTime.Parse(TGL_AKHIR.Text).ToString("MM/dd/yyyy"), 1))
                    {
                        e.Command.Parameters["@TGL_AKHIR"].Value = DateTime.Parse(TGL_AKHIR.Text);
                        if (KODE_IJIN.Text == "CBS")
                        {
                            e.Command.Parameters["@TGL_BERSALIN"].Value = DateTime.Parse(TGL_BERSALIN.Text);
                        }
                        else
                        {
                            e.Command.Parameters["@TGL_BERSALIN"].Value = DBNull.Value;
                        }
                    }
                    else
                    {
                        ExceptionDetails.Text = lblDuplicateInput.Text;
                        e.Cancel = true;
                    }
                    }
                    else
                    {
                        ExceptionDetails.Text = "Jenis ijin/cuti sama dengan entry sehari sebelum/sesudah yang diinput.";
                        e.Cancel = true;
                    }
                    }
                    else
                    {
                        ExceptionDetails.Text = "Tidak dapat entry karena sudah terdapat ijin per jam";
                        e.Cancel = true;
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblWrongDate.Text;
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2212", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_AWAL"].Value.ToString(), Application["strCn"].ToString());
                    dropSession();
                    RememberOldValuesFirstTime();
                    GvAlasan.DataBind();
                    showGridView(true);
                }
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2213", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_AWAL"].Value.ToString(), Application["strCn"].ToString());
                }
                RememberOldValuesFirstTime();
                GvAlasan.DataBind();
            }

            protected void FvAlasan_DataBound(object sender, EventArgs e)
            {
                if (FvAlasan.CurrentMode != FormViewMode.ReadOnly)
                {
                    /*
                    if (Session["GradeID"].ToString() == "1a")
                    {
                        dsIjin.SelectCommand = "SELECT KODE_IJIN, '[' + KODE_IJIN + '] ' + KET_IJIN AS KET_IJIN FROM taIjin WHERE (KODE_IJIN = 'PD')";
                    }
                    else
                    {
                        dsIjin.SelectCommand = "SELECT KODE_IJIN, '[' + KODE_IJIN + '] ' + KET_IJIN AS KET_IJIN FROM taIjin WHERE (KODE_TIDAK_HADIR = '1') ORDER BY KODE_IJIN";
                    }
                    dsIjin.DataBind();
                    */
                    if (FvAlasan.CurrentMode == FormViewMode.Insert)
                    {
                        if (isEntryUseNIP())
                        {
                            ((Label)FvAlasan.FindControl("lblPIN")).Visible = false;
                        }
                        else
                        {
                            ((Label)FvAlasan.FindControl("lblNipEdit")).Visible = false;
                        }
                        ((TextBox)FvAlasan.FindControl("txtItem2FormView")).Text = DateTime.Now.ToShortDateString();
                        ((TextBox)FvAlasan.FindControl("txtItem3FormView")).Text = DateTime.Now.ToShortDateString();
                        //TIGA
                        RangeValidator ValTglAdd = (RangeValidator)FvAlasan.FindControl("CompareValTglAdd");
                        ValTglAdd.MinimumValue = DateTime.Parse(Session["tglTutup"].ToString()).ToShortDateString();
                        //ValTglAdd.MaximumValue = Session["tglBatas"];
                        TextBox txtNip = (TextBox)FvAlasan.FindControl("txtItem0FormView");

                        if (Session["GradeID"].ToString() == "4")
                        {
                            if (isEntryUseNIP())
                            {
                                ((TextBox)FvAlasan.FindControl("txtItem0FormView")).Text = Session["NIPID"].ToString();
                            }
                            else
                            {
                                ((TextBox)FvAlasan.FindControl("txtItem0FormView")).Text = Session["PINID"].ToString();
                            }
                            ((TextBox)FvAlasan.FindControl("txtItem0FormView")).Enabled = false;
                            TextBox txtNIP = (TextBox)FvAlasan.FindControl("txtItem0FormView");
                            Label lblNama = (Label)FvAlasan.FindControl("lblItem1FormView");
                            setNama(txtNIP, lblNama);
                            ((LinkButton)FvAlasan.FindControl("lnkItem0FormView")).Visible = false;
                            ((DropDownList)FvAlasan.FindControl("ddlItem4FormView")).SelectedValue = "CT";
                            getSaldoIjin();
                            //ddlItem4FormView_SelectedIndexChanged(sender, e);

                        }
                        else
                        {
                            txtNip.Focus();
                        }
                        setComponentWithSession(0);
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
                            ((Label)FvAlasan.FindControl("lblNipEdit")).Visible = false;
                            ((Label)FvAlasan.FindControl("lblItem0FormView")).Visible = false;
                        }
                        setComponentWithSession(1);
                    }
                    dropSession();

                    if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2"))
                    {
                        ((Label)FvAlasan.FindControl("lblStatusIjinEdit")).Visible = false;
                        ((CheckBox)FvAlasan.FindControl("chkItem6FormView")).Visible = false;
                    }
                    else
                    {
                        if (FvAlasan.CurrentMode == FormViewMode.Insert)
                        {
                            ((CheckBox)FvAlasan.FindControl("chkItem6FormView")).Checked = true;
                        }
                    }
                }
            }

            private bool cekBeforeInsertOrUpdate(string NIP, string TGL_AWAL, string TGL_AKHIR,int TYPE)
            {
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                string strSelect = "";
                if (TYPE == 0)//before insert
                {
                    strSelect = "SELECT * FROM q_ijinhari WHERE ((tgl_awal>='" + TGL_AWAL + "' AND tgl_awal<='" + TGL_AKHIR + "') OR (tgl_akhir>='" + TGL_AWAL + "' AND tgl_akhir<='" + TGL_AKHIR + "') OR (tgl_awal<='" + TGL_AWAL + "' AND tgl_akhir>='" + TGL_AKHIR + "')) AND nip='" + NIP + "'";
                }
                else if (TYPE == 1)//before Update
                {
                    strSelect = "SELECT * FROM q_ijinhari WHERE ((tgl_awal>='" + TGL_AWAL + "' AND tgl_awal<='" + TGL_AKHIR + "') OR (tgl_akhir>='" + TGL_AWAL + "' AND tgl_akhir<='" + TGL_AKHIR + "') OR (tgl_awal<='" + TGL_AWAL + "' AND tgl_akhir>='" + TGL_AKHIR + "')) AND nip='" + NIP + "' AND TGL_AWAL <> '" + TGL_AWAL + "'";
                }
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

            private bool cekContinueLeave(string NIP, string TGL_AWAL, string TGL_AKHIR, string KODE_IJIN, int TYPE)
            {
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                string strSelect = "";
                if (TYPE == 0)//before insert
                {
                    strSelect = "SELECT * FROM taIjinHari WHERE (tgl_akhir = DATEADD(day,-1,'" + TGL_AWAL + "') OR tgl_awal= DATEADD(day,1,'" + TGL_AKHIR + "')) AND nip='" + NIP + "' AND kode_ijin='" + KODE_IJIN + "' AND KODE_IJIN IN (SELECT KODE_IJIN FROM taIjin WHERE POTONGAN_TKK > 0)";
                }
                else if (TYPE == 1)//before Update
                {
                    strSelect = "SELECT * FROM taIjinHari WHERE (tgl_akhir = DATEADD(day,-1,'" + TGL_AWAL + "') OR tgl_awal= DATEADD(day,1,'" + TGL_AKHIR + "')) AND nip='" + NIP + "' AND kode_ijin='" + KODE_IJIN + "' AND KODE_IJIN IN (SELECT KODE_IJIN FROM taIjin WHERE POTONGAN_TKK > 0) AND TGL_AWAL <> '" + TGL_AWAL + "'";
                }
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

            private bool cekTimeOff(string NIP, string TGL_AWAL, string TGL_AKHIR)
            {
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                string strSelect = "";
                strSelect = "SELECT * FROM q_ijinjam WHERE (tgl_ijin>='" + TGL_AWAL + "' AND tgl_ijin<='" + TGL_AKHIR + "') AND nip='" + NIP + "'";
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

            private void getSession(string NIP, string NAMA, string TGL_AWAL, string TGL_AKHIR, string KODE_IJIN, string BUKTI_IJIN, bool STATUS_IJIN)
            {
                Session["sesNIPInsertIjin"] = NIP;
                Session["sesNAMAInsertIjin"] = NAMA;
                Session["sesTGL_AWALInsertIjin"] = TGL_AWAL;
                Session["sesTGL_AKHIRInsertIjin"] = TGL_AKHIR;
                Session["sesKODE_IJINInsertIjin"] = KODE_IJIN;
                Session["sesBUKTI_IJINInsertIjin"] = BUKTI_IJIN;
                Session["sesSTATUS_IJINInsertIjin"] = STATUS_IJIN;
            }

            private void setComponentWithSession(int Type)
            {
                if (Session["sesNIPInsertIjin"] != null)
                {
                    if (Type == 0)//insert
                    {
                        ((TextBox)FvAlasan.FindControl("txtItem0FormView")).Text = Session["sesNIPInsertIjin"].ToString();
                        ((TextBox)FvAlasan.FindControl("txtItem2FormView")).Text = Session["sesTGL_AWALInsertIjin"].ToString();
                    }
                    else if (Type == 1)
                    {
                        ((Label)FvAlasan.FindControl("lblItem0FormView")).Text = Session["sesNIPInsertIjin"].ToString();
                        ((Label)FvAlasan.FindControl("lblItem2FormView")).Text = Session["sesTGL_AWALInsertIjin"].ToString();
                    }
                    ((Label)FvAlasan.FindControl("lblItem1FormView")).Text = Session["sesNAMAInsertIjin"].ToString();
                    ((TextBox)FvAlasan.FindControl("txtItem3FormView")).Text = Session["sesTGL_AKHIRInsertIjin"].ToString();
                    ((DropDownList)FvAlasan.FindControl("ddlItem4FormView")).SelectedValue = Session["sesKODE_IJINInsertIjin"].ToString();
                    ((TextBox)FvAlasan.FindControl("txtItem5FormView")).Text = Session["sesBUKTI_IJINInsertIjin"].ToString();
                    ((CheckBox)FvAlasan.FindControl("chkItem6FormView")).Checked = (bool)Session["sesSTATUS_IJINInsertIjin"];
                }

                if ((ViewState["TglAwal"] != null) && (ViewState["TglAkhir"] != null))
                {
                    ((TextBox)FvAlasan.FindControl("txtItem2FormView")).Text = ViewState["TglAwal"].ToString();
                    ((TextBox)FvAlasan.FindControl("txtItem3FormView")).Text = ViewState["TglAkhir"].ToString();

                    ViewState.Remove("TglAwal");
                    ViewState.Remove("TglAkhir");
                }
            }

            private void dropSession()
            {
                Session.Remove("sesNIPInsertIjin");
                Session.Remove("sesNAMAInsertIjin");
                Session.Remove("sesTGL_AWALInsertIjin");
                Session.Remove("sesTGL_AKHIRInsertIjin");
                Session.Remove("sesKODE_IJINInsertIjin");
                Session.Remove("sesBUKTI_IJINInsertIjin");
                Session.Remove("sesSTATUS_IJINInsertIjin");
            }

            protected void dsAlasanEdit_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    string sNIP;
                    TextBox NIP = (TextBox)FvAlasan.FindControl("txtItem0FormView");
                    Label NAMA = (Label)FvAlasan.FindControl("lblItem1FormView");
                    TextBox TGL_AWAL = (TextBox)FvAlasan.FindControl("txtItem2FormView");
                    TextBox TGL_AKHIR = (TextBox)FvAlasan.FindControl("txtItem3FormView");
                    DropDownList KODE_IJIN = (DropDownList)FvAlasan.FindControl("ddlItem4FormView");
                    TextBox BUKTI_IJIN = (TextBox)FvAlasan.FindControl("txtItem5FormView");
                    CheckBox STATUS_IJIN = (CheckBox)FvAlasan.FindControl("chkItem6FormView");
                    TextBox TGL_BERSALIN = (TextBox)FvAlasan.FindControl("txtItem4aFormView");

                    ViewState["TglAwal"] = TGL_AWAL.Text;
                    ViewState["TglAkhir"] = TGL_AKHIR.Text;

                    if (isEntryUseNIP())
                    {
                        sNIP = NIP.Text;                        
                    }
                    else
                    {
                        sNIP = azlib.getNIP(NIP.Text, Application["strCn"].ToString());
                    }

                    getSession(NIP.Text, NAMA.Text, TGL_AWAL.Text, TGL_AKHIR.Text, KODE_IJIN.SelectedValue, BUKTI_IJIN.Text, STATUS_IJIN.Checked);

                    if (cekTimeOff(sNIP, DateTime.Parse(TGL_AWAL.Text).ToString("MM/dd/yyyy"), DateTime.Parse(TGL_AKHIR.Text).ToString("MM/dd/yyyy")))
                    {
                    if (cekContinueLeave(sNIP, DateTime.Parse(TGL_AWAL.Text).ToString("MM/dd/yyyy"), DateTime.Parse(TGL_AKHIR.Text).ToString("MM/dd/yyyy"),KODE_IJIN.SelectedValue,0))
                    {
                    //cek before insert
                    if (cekBeforeInsertOrUpdate(sNIP, DateTime.Parse(TGL_AWAL.Text).ToString("MM/dd/yyyy"), DateTime.Parse(TGL_AKHIR.Text).ToString("MM/dd/yyyy"),0))
                    {
                        e.Command.Parameters["@NIP"].Value = sNIP;
                        e.Command.Parameters["@TGL_AWAL"].Value = DateTime.Parse(TGL_AWAL.Text);
                        e.Command.Parameters["@TGL_AKHIR"].Value = DateTime.Parse(TGL_AKHIR.Text);
                        if (KODE_IJIN.Text == "CBS")
                        {
                            e.Command.Parameters["@TGL_BERSALIN"].Value = DateTime.Parse(TGL_BERSALIN.Text);
                        }
                        else
                        {
                            e.Command.Parameters["@TGL_BERSALIN"].Value = DBNull.Value;
                        }
                    }
                    else
                    {
                        ExceptionDetails.Text = lblDuplicateInput.Text;
                        e.Cancel = true;
                    }
                    }
                    else
                    {
                        ExceptionDetails.Text = "Jenis ijin/cuti sama dengan entry sehari sebelum/sesudah yang diinput.";
                        e.Cancel = true;
                    }
                    }
                    else
                    {
                        ExceptionDetails.Text = "Tidak dapat entry karena sudah terdapat ijin per jam";
                        e.Cancel = true;
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblWrongDate.Text;
                    e.Cancel = true;
                }
            }

            protected void dsAlasanEdit_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter insert maka terjadi error
                if (e.AffectedRows == 0)
                {
                    if (e.Exception.Message.Contains("Jumlah ijin yang diambil melebihi jatah"))
                    {
                        ExceptionDetails.Text = lblIjinKurang.Text;
                    }
                    else if (e.Exception.Message.Contains("Tidak Ada Hak Ijin"))
                    {
                        ExceptionDetails.Text = "Tidak Ada Hak Ijin";
                    }
                    else
                    {
                        ExceptionDetails.Text = e.Exception.Message.ToString(); // lblCannotUpdate.Text;
                    }
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2211", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_AWAL"].Value.ToString(), Application["strCn"].ToString());
                    ExceptionDetails.Text = "Data telah di simpan";
                    //Diluar If
                    dropSession();
                    RememberOldValuesFirstTime();
                    GvAlasan.DataBind();
                    setInitialComponent();

                    if (!isEntrySambung())
                    {
                        showGridView(true);
                    }
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
                ((TextBox)FvAlasan.FindControl("txtItem3FormView")).Text = DateTime.Now.ToShortDateString();
                ((DropDownList)FvAlasan.FindControl("ddlItem4FormView")).SelectedIndex = 0;
                ((TextBox)FvAlasan.FindControl("txtItem5FormView")).Text = "";
                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2"))
                {
                    ((CheckBox)FvAlasan.FindControl("chkItem6FormView")).Checked = false;
                }
                else
                {
                    ((CheckBox)FvAlasan.FindControl("chkItem6FormView")).Checked = true;
                }

                lblTitleSisaIjinDetail.Visible = false;
                GvSisaIjinDetail.Visible = false;
                //((Button)FvAlasan.FindControl("btnRefreshGridSisaIjin")).Visible = false;
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
                ArrayList categoryIDList = new ArrayList();

                SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
                DataSet mydataset = new DataSet();
                SqlDataAdapter myadapter = new SqlDataAdapter();
                SqlCommand mycommand = new SqlCommand("Select NIP, TGL_AWAL from q_IjinHari WHERE STATUS_IJIN = 1" + Session["FilterAlasan"].ToString(), myconection);

                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taIjinHari");

                //Seleksi apakah hasil Query null atau tidak
                //jika null maka item hanya null
                //jika tidak null maka item diisi oleh kode range yang didapat
                if (mydataset.Tables["taIjinHari"].Rows.Count == 0)
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
                    DataTable myTabel = mydataset.Tables["taIjinHari"];

                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_AWAL"].ToString()).ToShortDateString());
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
                    //index = ((Label)(GvAlasan.Rows[row.RowIndex].Cells[0].FindControl("lblCol0Item"))).Text;
                    index = GvAlasan.DataKeys[row.RowIndex]["NIP"].ToString();
                    index2 = ((Label)(GvAlasan.Rows[row.RowIndex].Cells[2].FindControl("lblCol2Item"))).Text;

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
                                CheckBox myCheckBox = (CheckBox)(row.Cells[9].FindControl("chkSelect"));
                                myCheckBox.Checked = true;
                            }
                            else
                            {
                                CheckBox myCheckBox = (CheckBox)(row.Cells[9].FindControl("chkSelect"));
                                myCheckBox.Checked = false;
                            }
                        }
                    }
                }
                else
                {
                    foreach (GridViewRow row in GvAlasan.Rows)
                    {
                        CheckBox myCheckBox = (CheckBox)(row.Cells[9].FindControl("chkSelect"));
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
                                cmd.CommandText = "update taIjinHari set STATUS_IJIN = 0 where NIP = '" + NIP + "' And TGL_AWAL = '" + (DateTime.Parse(Tanggal_Ijin)).ToString("MM/dd/yyyy") + "'";
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
                                cmd.CommandText = "update taIjinHari set STATUS_IJIN = 1 where NIP = '" + NIP + "' And TGL_AWAL = '" + (DateTime.Parse(Tanggal_Ijin)).ToString("MM/dd/yyyy") + "'";
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2216", "", Application["strCn"].ToString());
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
                SqlCommand mycommand = new SqlCommand("Select NIP, TGL_AWAL from q_IjinHari WHERE" + Session["FilterAlasan"].ToString().Substring(4, Session["FilterAlasan"].ToString().Length - 4), myconection);
                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taIjinHari");

                //Seleksi apakah hasil Query null atau tidak
                //jika null maka item hanya null
                //jika tidak null maka item diisi oleh kode range yang didapat
                if (mydataset.Tables["taIjinHari"].Rows.Count == 0)
                {
                    myadapter.Dispose();
                    mydataset.Clear();
                }
                else
                {
                    DataTable myTabel = mydataset.Tables["taIjinHari"];

                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        if (categoryIDList != null)
                        {
                            if (!categoryIDList.Contains(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_AWAL"].ToString()).ToShortDateString()))
                            {
                                categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_AWAL"].ToString()).ToShortDateString());
                            }
                        }
                        else
                        {
                            categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_AWAL"].ToString()).ToShortDateString());
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
                SqlCommand mycommand = new SqlCommand("Select NIP, TGL_AWAL from q_IjinHari WHERE" + Session["FilterAlasan"].ToString().Substring(4, Session["FilterAlasan"].ToString().Length - 4), myconection);

                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taIjinHari");

                //Seleksi apakah hasil Query null atau tidak
                //jika null maka item hanya null
                //jika tidak null maka item diisi oleh kode range yang didapat
                if (mydataset.Tables["taIjinHari"].Rows.Count == 0)
                {
                    myadapter.Dispose();
                    mydataset.Clear();
                }
                else
                {
                    DataTable myTabel = mydataset.Tables["taIjinHari"];

                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        categoryIDList.Add(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_AWAL"].ToString()).ToShortDateString());
                        if (categoryIDList2 != null)
                        {
                            categoryIDList2.Remove(myRow["NIP"].ToString() + "," + DateTime.Parse(myRow["TGL_AWAL"].ToString()).ToShortDateString());
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

            private void getSaldoIjin()
            {
                //Button btnRefreshGridSisaIjin = (Button)FvAlasan.FindControl("btnRefreshGridSisaIjin");
                try
                {
                    string NIP = "";
                    string TGL_AWAL = "";
                    if (FvAlasan.CurrentMode == FormViewMode.Insert)
                    {
                        if (isEntryUseNIP())
                        {
                            NIP = ((TextBox)FvAlasan.FindControl("txtItem0FormView")).Text;
                        }
                        else
                        {
                            NIP = azlib.getNIP(((TextBox)FvAlasan.FindControl("txtItem0FormView")).Text, Application["strCn"].ToString());
                        }
                        TGL_AWAL = DateTime.Parse(((TextBox)FvAlasan.FindControl("txtItem2FormView")).Text).ToString("MM/dd/yyyy");
                    }
                    else if (FvAlasan.CurrentMode == FormViewMode.Edit)
                    {
                        //NIP = ((Label)FvAlasan.FindControl("lblItem0FormView")).Text;
                        NIP = FvAlasan.DataKey["NIP"].ToString();
                        TGL_AWAL = DateTime.Parse(((Label)FvAlasan.FindControl("lblItem2FormView")).Text).ToString("MM/dd/yyyy");
                    }
                    string KODE_IJIN = ((DropDownList)FvAlasan.FindControl("ddlItem4FormView")).SelectedValue;
                    if ((NIP.Trim() != "") && (TGL_AWAL.Trim() != "") && (cekKredit(KODE_IJIN)))
                    {
                        dsSisaIjin.SelectCommand = "SELECT DATEPART(YEAR, TGL_AWAL) AS TAHUN, SISA_IJIN FROM taJatahIjin WHERE (NIP = '" + NIP + "') AND (KODE_IJIN = '" + KODE_IJIN + "') AND (SISA_IJIN > 0) AND (EXPIRED >= '" + TGL_AWAL + "')";
                        dsSisaIjin.DataBind();
                        lblTitleSisaIjinDetail.Visible = true;
                        GvSisaIjinDetail.Visible = true;
                        //btnRefreshGridSisaIjin.Visible = true;
                    }
                    else
                    {
                        lblTitleSisaIjinDetail.Visible = false;
                        GvSisaIjinDetail.Visible = false;
                        //btnRefreshGridSisaIjin.Visible = false;
                    }
                    if (KODE_IJIN == "CBS")
                    {
                        ((TextBox)FvAlasan.FindControl("txtItem4aFormView")).Visible = true;
                        ((Label)FvAlasan.FindControl("lblTglBersalin")).Visible = true;
                    }
                    else
                    {
                        ((TextBox)FvAlasan.FindControl("txtItem4aFormView")).Visible = false;
                        ((Label)FvAlasan.FindControl("lblTglBersalin")).Visible = false;
                    }
                }
                catch (Exception ex)
                {
                    lblTitleSisaIjinDetail.Visible = false;
                    GvSisaIjinDetail.Visible = false;
                    //btnRefreshGridSisaIjin.Visible = false;
                }
            }

            protected void ddlItem4FormView_SelectedIndexChanged(object sender, EventArgs e)
            {
                getSaldoIjin();
            }

            protected void btnRefreshGridSisaIjin_Click(object sender, EventArgs e)
            {
                ddlItem4FormView_SelectedIndexChanged(sender, e);
                //string NIP = ((TextBox)FvAlasan.FindControl("txtItem0FormView")).Text;
                //string TGL_AWAL = DateTime.Parse(((TextBox)FvAlasan.FindControl("txtItem2FormView")).Text).ToString("MM/dd/yyyy");
                //string KODE_IJIN = ((DropDownList)FvAlasan.FindControl("ddlItem4FormView")).SelectedValue;
                //if ((NIP.Trim() != "") && (TGL_AWAL.Trim() != "") && (cekKredit(KODE_IJIN)))
                //{
                //    dsSisaIjin.SelectCommand = "SELECT DATEPART(YEAR, TGL_AWAL) AS TAHUN, SISA_IJIN FROM taJatahIjin WHERE (NIP = '" + NIP + "') AND (KODE_IJIN = '" + KODE_IJIN + "') AND (SISA_IJIN > 0) AND (EXPIRED <= '" + TGL_AWAL + "')";
                //    dsSisaIjin.DataBind();
                //    lblTitleSisaIjinDetail.Visible = true;
                //    GvSisaIjinDetail.Visible = true;
                //}
            }
            protected void Button1_Click(object sender, EventArgs e)
            {
                Response.Redirect("upload_dayoff.aspx");
            }
}
	}
