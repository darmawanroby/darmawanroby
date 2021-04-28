///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : change_shift.aspx.cs                             (Pseudo code)

//        File terkait  : change_shift.aspx                                (Form)
//                        \App_LocalResources\change_shift.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\change_shift.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah perubahan pola karyawan

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
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
		
		public partial class change_shift : BasePage
		{
            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GvChangeShift.Visible = show;
                tableFilter.Visible = show;
                FvChangeShift.Visible = !show;
                if ((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "3"))
                {
                    lblTambah.Visible = show;
                    ImgbtnAdd.Visible = show;
                }
            }

            //fungsi: Handle Ketika Dropdownlist Biro mengalami perubahan
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

            //fungsi: Filter Gridview
            private void doFiltering()
            {
                try
                {

                    string strFilter = "";

                    strFilter += " WHERE (TGL_AWAL >= '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND TGL_AWAL <= '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "')";


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

                    dsChangeShift.SelectCommand += strFilter + " ORDER BY TGL_AWAL ASC";
                }
                catch (Exception ex)
                { }
            }
            
            //fungsi: set Kondisi Awal Komponen Filter
            private void setFilter()
            {
                txtFilterItem0.Text = azlib.FirstDate(DateTime.Now.Date, Session["strLang"].ToString()).ToShortDateString();
                txtFilterItem1.Text = azlib.LastDate(DateTime.Now.Date, Session["strLang"].ToString()).ToShortDateString();

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

            //Fungsi: set Kondisi awal komponen sesuai hak akses level
            private void setComponent()
            {
                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2") && (Session["GradeID"].ToString() != "3"))
                {
                    lblTambah.Visible = false;
                    ImgbtnAdd.Visible = false;
                    GvChangeShift.Columns[5].Visible = false;
                    GvChangeShift.Columns[6].Visible = false;
                }

                BoundField Column0 = (BoundField)GvChangeShift.Columns[0];
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
				if (! rtwin.azlib.AksesHalaman(19, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
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

            //fungsi: Refresh GridView
            protected void btnRefresh_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    //update ke grid
                    GvChangeShift.DataBind();
                }
            }

            //fungsi: Handle Permintaan Tambah data, Tampilkan FormView
            protected void lblTambah_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    FvChangeShift.DefaultMode = FormViewMode.Insert;
                    FvChangeShift.ChangeMode(FormViewMode.Insert);
                    showGridView(false);
                }
            }

            //fungsi: Handle Permintaan Tambah data, Tampilkan FormView
            protected void ImgBtnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lblTambah_Click(sender, e);
            }

            protected void GvChangeShift_DataBound(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvChangeShift.BottomPagerRow;

                if (rowPager != null)
                {
                    // get your controls from the gridview
                    TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                    Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                    txtHalaman.Text = (GvChangeShift.PageIndex + 1).ToString();
                    // populate page count
                    lblJumlahHalaman.Text = GvChangeShift.PageCount.ToString();
                }
                else
                {
                    return;
                }
            }

            protected void GvChangeShift_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
            {
                //menambahkan State Row on Hover
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    GridView gv = ((GridView)sender);

                    String className = ((e.Row.RowState == DataControlRowState.Alternate) ? gv.AlternatingRowStyle.CssClass : gv.RowStyle.CssClass);

                    e.Row.Attributes.Add("onmouseover", "this.className='datagrid_hovcol';");

                    e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");

                    //mengatur Enable Button Edit dan Delete sesuai hak akses
                    if (Session["GradeID"].ToString() != "1")
                    {
                        ImageButton btnEdit = (ImageButton)e.Row.Cells[5].FindControl("imgEdit");
                        ImageButton btnDelete = (ImageButton)e.Row.Cells[6].FindControl("imgDelete");
                        Label lblTgl = (Label)e.Row.Cells[2].FindControl("lblCol2Item");

                        btnEdit.Enabled = btnEdit.Enabled && (DateTime.Parse(lblTgl.Text) >= DateTime.Parse(Session["tglTutup"].ToString()));
                        btnDelete.Enabled = btnEdit.Enabled && (DateTime.Parse(lblTgl.Text) >= DateTime.Parse(Session["tglTutup"].ToString()));
                    }
                }
            }

            //fungsi: Handle ketika tombol Edit di GridView di tekan
            protected void GvChangeShift_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    dsChangeShift.SelectCommand = "SELECT NIP, PIN, NAMA, TGL_AWAL, TGL_AKHIR, KODE_SHIFT FROM q_UbahPola";
                    if (isEntryUseNIP())
                    {
                        dsChangeShift.SelectCommand += " WHERE NIP = '" + GvChangeShift.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_AWAL = '" + DateTime.Parse(((Label)GvChangeShift.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                    }
                    else
                    {
                        dsChangeShift.SelectCommand += " WHERE PIN = '" + GvChangeShift.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_AWAL = '" + DateTime.Parse(((Label)GvChangeShift.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                    }
                    e.Cancel = true;
                    FvChangeShift.DefaultMode = FormViewMode.Edit;
                    FvChangeShift.ChangeMode(FormViewMode.Edit);
                    showGridView(false);
                }
                else
                {
                    e.Cancel = true;
                }
            }

            //fungsi: Handle ketika terjadi Perintah pada FormView
            protected void FvChangeShift_ItemCommand(object sender, FormViewCommandEventArgs e)
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

            //fungsi: Handle Ketika akan mengupdate data pada database
            protected void dsChangeShiftEdit_Updating(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    TextBox TGL_AKHIR = (TextBox)FvChangeShift.FindControl("txtItem3FormView");
                    e.Command.Parameters["@TGL_AKHIR"].Value = DateTime.Parse(TGL_AKHIR.Text);
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblWrongDate.Text;
                    e.Cancel = true;
                }
            }

            //fungsi: Handle Ketika data pada database telah diupdate
            protected void dsChangeShiftEdit_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2432", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_AWAL"].Value.ToString(), Application["strCn"].ToString());                    
                }
                GvChangeShift.DataBind();
                showGridView(true);
            }

            //fungsi: Handle Ketika data pada database telah didelete
            protected void dsChangeShift_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2433", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_AWAL"].Value.ToString(), Application["strCn"].ToString());
                }
                GvChangeShift.DataBind();
            }

            protected void FvChangeShift_DataBound(object sender, EventArgs e)
            {
                if (FvChangeShift.CurrentMode == FormViewMode.Insert)
                {
                    if (isEntryUseNIP())
                    {
                        ((Label)FvChangeShift.FindControl("lblPIN")).Visible = false;
                    }
                    else
                    {
                        ((Label)FvChangeShift.FindControl("lblNip")).Visible = false;
                    }

                    if ((ViewState["TglAwal"] != null) && (ViewState["TglAkhir"] != null))
                    {
                        ((TextBox)FvChangeShift.FindControl("txtItem2FormView")).Text = ViewState["TglAwal"].ToString();
                        ((TextBox)FvChangeShift.FindControl("txtItem3FormView")).Text = ViewState["TglAkhir"].ToString();
                        ViewState.Remove("TglAwal");
                        ViewState.Remove("TglAkhir");
                    }
                    else
                    {
                        ((TextBox)FvChangeShift.FindControl("txtItem2FormView")).Text = DateTime.Now.ToShortDateString();
                        ((TextBox)FvChangeShift.FindControl("txtItem3FormView")).Text = DateTime.Now.ToShortDateString();
                    }

                    //TIGA
                    RangeValidator ValTglAdd = (RangeValidator)FvChangeShift.FindControl("CompareValTglAdd");
                    ValTglAdd.MinimumValue = DateTime.Parse(Session["tglTutup"].ToString()).ToShortDateString();
                        
                    TextBox txtNip = (TextBox)FvChangeShift.FindControl("txtItem0FormView");
                    txtNip.Focus();
                }
                else if (FvChangeShift.CurrentMode == FormViewMode.Edit)
                {
                    if (isEntryUseNIP())
                    {
                        ((Label)FvChangeShift.FindControl("lblPIN")).Visible = false;
                        ((Label)FvChangeShift.FindControl("lblItem0_FormView")).Visible = false;
                    }
                    else
                    {
                        ((Label)FvChangeShift.FindControl("lblNip")).Visible = false;
                        ((Label)FvChangeShift.FindControl("lblItem0FormView")).Visible = false;
                    }
                }
            }
            //fungsi: Handle Ketika akan insert database
            protected void dsChangeShiftEdit_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    ViewState["TglAwal"] = ((TextBox)FvChangeShift.FindControl("txtItem2FormView")).Text;
                    ViewState["TglAkhir"] = ((TextBox)FvChangeShift.FindControl("txtItem3FormView")).Text;


                    string sNIP;
                    TextBox NIP = (TextBox)FvChangeShift.FindControl("txtItem0FormView");
                    if (isEntryUseNIP())
                    {
                        sNIP = NIP.Text;
                    }
                    else
                    {
                        sNIP = azlib.getNIP(NIP.Text, Application["strCn"].ToString());
                    }
                    TextBox TGL_AWAL = (TextBox)FvChangeShift.FindControl("txtItem2FormView");
                    TextBox TGL_AKHIR = (TextBox)FvChangeShift.FindControl("txtItem3FormView");
                    e.Command.Parameters["@NIP"].Value = sNIP;
                    e.Command.Parameters["@TGL_AWAL"].Value = DateTime.Parse(TGL_AWAL.Text);
                    e.Command.Parameters["@TGL_AKHIR"].Value = DateTime.Parse(TGL_AKHIR.Text);
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblWrongDate.Text;
                    e.Cancel = true;
                }
            }

            //fungsi: Handle Ketika data pada database telah ditambahkan
            protected void dsChangeShiftEdit_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2431", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_AWAL"].Value.ToString(), Application["strCn"].ToString());
                    ExceptionDetails.Text = "Data telah di simpan";

                    GvChangeShift.DataBind();
                    setInitialComponent();
                }

                if (!isEntrySambung())
                {
                    showGridView(true);
                }

            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvChangeShift.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvChangeShift.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvChangeShift.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvChangeShift.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvChangeShift.PageIndex + 1).ToString();
                }
            }

            //fungsi: set kondisi awal komponen di FormView
            private void setInitialComponent()
            {
                ((TextBox)FvChangeShift.FindControl("txtItem0FormView")).Text = "";
                ((Label)FvChangeShift.FindControl("lblItem1FormView")).Text = "";
                ((TextBox)FvChangeShift.FindControl("txtItem2FormView")).Text = DateTime.Now.ToShortDateString();
                ((TextBox)FvChangeShift.FindControl("txtItem3FormView")).Text = DateTime.Now.ToShortDateString();
                ((DropDownList)FvChangeShift.FindControl("ddlItem4FormView")).SelectedIndex = 0;
            }

            //fungsi: Tampilkan Lookup pegawai
			protected void lnkFilterItem2_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtFilterItem2";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
            }

            //fungsi: Tampilkan Lookup pegawai
            protected void lnkItem0FormView_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtItem0FormView";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
            }

            //fungsi: Set Nama ketika NIP berubah
            protected void txtItem0FormView_TextChanged(object sender, EventArgs e)
            {
                TextBox txtNIP = (TextBox)FvChangeShift.FindControl("txtItem0FormView");
                Label lblNama = (Label)FvChangeShift.FindControl("lblItem1FormView");
                setNama(txtNIP, lblNama);
            }

            //fungsi: Ambil nama dari database berdasarkan NIP, lalu ubah properti Label yg dituju
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
                        strSelect = "SELECT NAMA FROM q_Karyawan WHERE NIP='" + azlib.getNIP(txtNIP.Text.Replace("'", "''"),Application["strCn"].ToString()) + "'";
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
                        strSelect = "SELECT NAMA FROM q_Karyawan WHERE NIP='" + azlib.getNIP(txtNIP.Text.Replace("'", "''"), Application["strCn"].ToString()) + "'" + strFilter;
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
                            ((TextBox)FvChangeShift.FindControl("txtItem0FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                            ((Label)FvChangeShift.FindControl("lblItem1FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;
                        }
                        else
                        {
                            ((TextBox)FvChangeShift.FindControl("txtItem0FormView")).Text = GvLookupPegawai.SelectedRow.Cells[1].Text;
                            ((Label)FvChangeShift.FindControl("lblItem1FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;
                        }
                    }

                    Session.Remove("Triger");
                }

                setInitialLookupState();
                UpdatePanel1.Update();
            }
}
	}
