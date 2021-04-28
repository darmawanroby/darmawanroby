///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : leave_accrual.aspx.cs                             (Pseudo code)

//        File terkait  : leave_accrual.aspx                                (Form)
//                        \App_LocalResources\leave_accrual.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\leave_accrual.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan Saldo Cuti/ Ijin

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
//        Versi 2.0.3   : Penambahan Proses
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

        public partial class leave_accrual : BasePage
		{
            private void generateDropDownTahun(DropDownList ddlTahun)
            {
                ListItem li = new ListItem(Convert.ToString(DateTime.Now.Year - 2), Convert.ToString(DateTime.Now.Year - 2));
                ddlTahun.Items.Add(li);
                li = new ListItem(Convert.ToString(DateTime.Now.Year - 1), Convert.ToString(DateTime.Now.Year - 1));
                ddlTahun.Items.Add(li);
                li = new ListItem(DateTime.Now.Year.ToString(), DateTime.Now.Year.ToString());
                ddlTahun.Items.Add(li);
                li = new ListItem(Convert.ToString(DateTime.Now.Year + 1), Convert.ToString(DateTime.Now.Year + 1));
                ddlTahun.Items.Add(li);
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

                    if ((ddlFilterItem0.SelectedValue.Trim() != "") && (ddlFilterItem1.SelectedValue.Trim() != ""))
                    {
                        strFilter += " WHERE (TGL_AKHIR >= '1/1/" + ddlFilterItem0.SelectedValue + "' AND TGL_AKHIR <= '12/31/" + ddlFilterItem1.SelectedValue + "')";
                    }

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

                    if (ddlFilterItem5.SelectedValue.Trim() != "")
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND KODE_IJIN = '" + ddlFilterItem5.SelectedValue + "'";
                        }
                        else
                        {
                            strFilter += " WHERE KODE_IJIN = '" + ddlFilterItem5.SelectedValue + "'";
                        }
                    }

                    if (chkExpired.Checked)
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND EXPIRED " + ddlOperasiBatas.SelectedValue + " '" + DateTime.Parse(txtTglBatas.Text).ToString("MM/dd/yyyy") + "'";
                        }
                        else
                        {
                            strFilter += " WHERE EXPIRED " + ddlOperasiBatas.SelectedValue + " '" + DateTime.Parse(txtTglBatas.Text).ToString("MM/dd/yyyy") + "'";
                        }
                    }

                    if (chkLamaKerja.Checked)
                    {
                        int MasaKerja = Convert.ToInt32(txtMasaKerja.Text);
                        if (strFilter != "")
                        {
                            strFilter += " AND LAMA_KERJA " + ddlOperasiBatasMasaKerja.SelectedValue + " " + Convert.ToString(MasaKerja);
                        }
                        else
                        {
                            strFilter += " WHERE LAMA_KERJA " + ddlOperasiBatasMasaKerja.SelectedValue + " " + Convert.ToString(MasaKerja);
                        }
                    }

                    if (chkJatahIjin.Checked)
                    {
                        int JatahIjin = Convert.ToInt32(txtJatahIjin.Text);
                        if (strFilter != "")
                        {
                            strFilter += " AND JATAH_IJIN " + ddlOperasiBatasJatahIjin.SelectedValue + " " + Convert.ToString(JatahIjin);
                        }
                        else
                        {
                            strFilter += " WHERE JATAH_IJIN " + ddlOperasiBatasJatahIjin.SelectedValue + " " + Convert.ToString(JatahIjin);
                        }
                    }

                    if (chkDiambil.Checked)
                    {
                        int Diambil = Convert.ToInt32(txtDiambil.Text);
                        if (strFilter != "")
                        {
                            strFilter += " AND DIAMBIL " + ddlOperasiBatasDiambil.SelectedValue + " " + Convert.ToString(Diambil);
                        }
                        else
                        {
                            strFilter += " WHERE DIAMBIL " + ddlOperasiBatasDiambil.SelectedValue + " " + Convert.ToString(Diambil);
                        }
                    }

                    if (chkTidakDiambil.Checked)
                    {
                        int TidakDiambil = Convert.ToInt32(txtHangus.Text);
                        if (strFilter != "")
                        {
                            strFilter += " AND TIDAK_DIAMBIL " + ddlOperasiBatasHangus.SelectedValue + " " + Convert.ToString(TidakDiambil);
                        }
                        else
                        {
                            strFilter += " WHERE TIDAK_DIAMBIL " + ddlOperasiBatasHangus.SelectedValue + " " + Convert.ToString(TidakDiambil);
                        }
                    }

                    if (chkSisaIjin.Checked)
                    {
                        int SisaIjin = Convert.ToInt32(txtSisa.Text);
                        if (strFilter != "")
                        {
                            strFilter += " AND SISA_IJIN " + ddlOperasiBatasSisa.SelectedValue + " " + Convert.ToString(SisaIjin);
                        }
                        else
                        {
                            strFilter += " WHERE SISA_IJIN " + ddlOperasiBatasSisa.SelectedValue + " " + Convert.ToString(SisaIjin);
                        }
                    }

                    dsSaldoIjin.SelectCommand += strFilter + " ORDER BY NIP ASC";
                }
                catch (Exception ex)
                { }
            }

            private void setFilter()
            {
                txtTglBatas.Text = DateTime.Now.ToShortDateString();

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
                    //tableFilter.Visible = false;
                    lblNIP.Visible = false;
                    txtFilterItem2.Enabled = false;
                    lnkFilterItem2.Visible = false;
                    lblBiro.Visible = false;
                    ddlFilterItem3.Visible = false;
                    lblBagian.Visible = false;
                    ddlFilterItem4.Visible = false;
                    pnlColabsibleControl.Visible = false;
                    GvSaldoIjin.Columns[0].Visible = false;
                    GvSaldoIjin.Columns[1].Visible = false;
                    GvSaldoIjin.Columns[2].Visible = false;
                    GvSaldoIjin.Columns[3].Visible = false;
                    GvSaldoIjin.Columns[4].Visible = false;
                    pnlProses.Visible = false;
                }
            }

            private void setComponent()
            {
                generateDropDownTahun(ddlFilterItem0);
                ddlFilterItem0.SelectedValue = DateTime.Now.Year.ToString();
                generateDropDownTahun(ddlFilterItem1);
                ddlFilterItem1.SelectedValue = DateTime.Now.Year.ToString();

                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2"))
                {
                    pnlProses.Visible = false;
                }

                if (isEntryUseNIP())
                {
                    lblPIN.Visible = false;
                    GvSaldoIjin.Columns[1].Visible = false;
                }
                else
                {
                    lblNIP.Visible = false;
                    GvSaldoIjin.Columns[0].Visible = false;
                }

                setInitialStateOfParameterValidator();
            }

            private void setProsesComponentEnable()
            {
                if (ddlFilterItem0.SelectedValue == ddlFilterItem1.SelectedValue)
                {
                    pnlProses.Enabled = true;
                }
                else
                {
                    pnlProses.Enabled = false;
                }
            }

			protected void Page_Load(object sender, EventArgs e)
			{
				//jika userid kosong maka akan di link ke halaman awal
                if (! rtwin.azlib.AksesHalaman(12, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}
				
				//jika halaman bukan postback
				if (! Page.IsPostBack)
				{
                    setFilter();
                    setComponent();
				}

                doFiltering();
                doFilteringLookup();
                setProsesComponentEnable();
			}

            protected void btnRefresh_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    //update ke grid
                    GvSaldoIjin.DataBind();
                    lblTitleRincianJatahIjin.Visible = false;
                    gvIjinRinci.Visible = false;
                }
            }

            protected void GvSaldoIjin_DataBound(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvSaldoIjin.BottomPagerRow;

                if (rowPager != null)
                {
                    // get your controls from the gridview
                    TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                    Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                    txtHalaman.Text = (GvSaldoIjin.PageIndex + 1).ToString();
                    // populate page count
                    lblJumlahHalaman.Text = GvSaldoIjin.PageCount.ToString();
                }
                else
                {
                    return;
                }
            }

            //Menyisipkan javascript untuk confirm sebelum delete
            protected void GvSaldoIjin_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
            {
                //menambahkan State Row on Hover
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    GridView gv = ((GridView)sender);

                    if ((e.Row.RowState == DataControlRowState.Normal) || (e.Row.RowState == DataControlRowState.Alternate))
                    {
                        String className = ((e.Row.RowState == DataControlRowState.Alternate) ? gv.AlternatingRowStyle.CssClass : gv.RowStyle.CssClass);

                        e.Row.Attributes.Add("onmouseover", "this.className='datagrid_hovcol';");

                        e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");

                        if ((Session["GradeID"].ToString() == "3a") || (Session["GradeID"].ToString() == "4"))
                        {
                            ((Label)e.Row.Cells[5].FindControl("lblCol4Item")).Visible = false;
                            ((LinkButton)e.Row.Cells[5].FindControl("lnkCol4Item")).Visible = true;
                        }
                        else
                        {
                            ((Label)e.Row.Cells[5].FindControl("lblCol4Item")).Visible = true;
                            ((LinkButton)e.Row.Cells[5].FindControl("lnkCol4Item")).Visible = false;
                        }
                    }
                    else if (e.Row.RowState == DataControlRowState.Selected)
                    {
                        String className = gv.SelectedRowStyle.CssClass;

                        e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");

                        e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");

                        if ((Session["GradeID"].ToString() == "3a") || (Session["GradeID"].ToString() == "4"))
                        {
                            ((Label)e.Row.Cells[5].FindControl("lblCol4Item")).Visible = false;
                            ((LinkButton)e.Row.Cells[5].FindControl("lnkCol4Item")).Visible = true;
                        }
                        else
                        {
                            ((Label)e.Row.Cells[5].FindControl("lblCol4Item")).Visible = true;
                            ((LinkButton)e.Row.Cells[5].FindControl("lnkCol4Item")).Visible = false;
                        }
                    }
                    /*
                    //DUA
                    ImageButton btnEdit = e.Row.FindControl("imgEdit");
                    ImageButton btnDelete = e.Row.FindControl("imgDelete");
                    Label lblTgl = e.Row.FindControl("lblCol2Item");

                    btnEdit.Enabled = btnEdit.Enabled && (DateTime.Parse(lblTgl.Text) >= Session["tglTutup"]);
                    btnDelete.Enabled = btnEdit.Enabled && (DateTime.Parse(lblTgl.Text) >= Session["tglTutup"]);*/
                }
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvSaldoIjin.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvSaldoIjin.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvSaldoIjin.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvSaldoIjin.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvSaldoIjin.PageIndex + 1).ToString();
                }
            }

            protected void lnkFilterItem2_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtFilterItem2";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
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
                    ExceptionDetails.Text = lblPerpanjangJumlahJatahIjin.Text;
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

                    Session.Remove("Triger");
                }

                setInitialLookupState();
                UpdatePanel1.Update();
            }

            protected void chkExpired_CheckedChanged(object sender, EventArgs e)
            {
                valTglBatas0.Enabled = chkExpired.Checked;
                valTglBatas1.Enabled = chkExpired.Checked;
            }

            protected void chkLamaKerja_CheckedChanged(object sender, EventArgs e)
            {
                RequiredFieldValidator1.Enabled = chkLamaKerja.Checked;
                CompareValidator1.Enabled = chkLamaKerja.Checked;                                
            }

            protected void chkJatahIjin_CheckedChanged(object sender, EventArgs e)
            {
                RequiredFieldValidator2.Enabled = chkJatahIjin.Checked;
                CompareValidator2.Enabled = chkLamaKerja.Checked;                                
            }

            protected void chkDiambil_CheckedChanged(object sender, EventArgs e)
            {
                RequiredFieldValidator3.Enabled = chkDiambil.Checked;
                CompareValidator3.Enabled = chkLamaKerja.Checked;                                
            }

            protected void chkTidakDiambil_CheckedChanged(object sender, EventArgs e)
            {
                RequiredFieldValidator4.Enabled = chkTidakDiambil.Checked;
                CompareValidator4.Enabled = chkLamaKerja.Checked;                                
            }

            protected void chkSisaIjin_CheckedChanged(object sender, EventArgs e)
            {
                RequiredFieldValidator5.Enabled = chkSisaIjin.Checked;
                CompareValidator5.Enabled = chkLamaKerja.Checked;                                
            }

            private void setEnableValidatorParameterInteger(bool state)
            {
                valTxtInputParameterInteger0.Enabled = state;
                valTxtInputParameterInteger1.Enabled = state;
                valTxtInputParameterTanggal0.Enabled = !state;
                valTxtInputParameterTanggal1.Enabled = !state;
            }

            private void setInitialStateOfParameterValidator()
            {
                txtInputParameterInteger.Text = "0";
                txtInputParameterTanggal.Text = DateTime.Now.ToShortDateString();
                valTxtInputParameterInteger0.Enabled = false;
                valTxtInputParameterInteger1.Enabled = false;
                valTxtInputParameterTanggal0.Enabled = false;
                valTxtInputParameterTanggal1.Enabled = false;
            }

            private void setTextOfPopUp()
            {
                if (radProsesUpdateJatahIjin.Checked)
                {
                    lblConfirmProses.Text = lblConfirmUpdateJatahIjin.Text;
                }
                else if (radHangusJatahIjin.Checked)
                {
                    lblConfirmProses.Text = lblConfirmHangusJatahIjin.Text;
                }

                if (radTambahJatahIjin.Checked)
                {
                    lblTanyaParameterInteger.Text = lblTambahJumlahJatahIjin.Text;
                }
                else if (radPotongJatahIjin.Checked)
                {
                    lblTanyaParameterInteger.Text = lblPotongJumlahJatahIjin.Text;
                }
                else if (radPotongSisaJatahIjin.Checked)
                {
                    lblTanyaParameterInteger.Text = lblPotongSisaJumlahJatahIjin.Text;
                }
                else if (radPerpanjangJatahIjin.Checked)
                {
                    lblTanyaParameterInteger.Text = lblPerpanjangJumlahJatahIjin.Text;
                }
            }

            protected void btnProses_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    if (radSetExpiredJatahIjin.Checked)
                    {
                        setEnableValidatorParameterInteger(false);
                        mpeParameterTanggal.Show();
                    }
                    else if ((radProsesUpdateJatahIjin.Checked) || (radHangusJatahIjin.Checked))
                    {
                        setTextOfPopUp();
                        mpeConfirmation.Show();
                    }
                    else
                    {
                        setTextOfPopUp();
                        setEnableValidatorParameterInteger(true);
                        mpeParameterInteger.Show();
                    }
                }
            }

            protected void cancelInputParameter(object sender, EventArgs e)
            {
                setInitialStateOfParameterValidator();
            }

            protected void btnOK_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    if (radProsesUpdateJatahIjin.Checked)
                    {
                        doProses("proc_UpdateJatahIjin", "1401");
                    }
                    else if (radTambahJatahIjin.Checked)
                    {
                        doProsesParameterInteger("proc_TambahJatahIjin", "@iJmlTambah", "1402");
                    }
                    else if (radPotongJatahIjin.Checked)
                    {
                        doProsesParameterInteger("proc_PotongJatahIjin", "@iJmlPotong", "1403");
                    }
                    else if (radPotongSisaJatahIjin.Checked)
                    {
                        doProsesParameterInteger("proc_PotongSisaJatahIjin", "@iJmlSisa", "1404");
                    }
                    else if (radSetExpiredJatahIjin.Checked)
                    {
                        doProsesParameterTanggal("proc_SetExpiredJatahIjin", "@dTglExpired", "1405");
                    }
                    else if (radPerpanjangJatahIjin.Checked)
                    {
                        doProsesParameterInteger("proc_PerpanjangJatahIjin", "@iLamaBln", "1406");
                    }
                    else if (radHangusJatahIjin.Checked)
                    {
                        doProses("proc_HangusJatahIjin", "1407");
                    }
                    GvSaldoIjin.DataBind();
                }
                setInitialStateOfParameterValidator();
            }

            private string getFilter()
            {
                string strFilter = "";

                if (txtFilterItem2.Text.Trim() != "")
                {
                    if (isEntryUseNIP())
                    {
                        strFilter += " AND (taKaryawan.NIP = '" + txtFilterItem2.Text.Replace("'", "''") + "')";
                    }
                    else
                    {
                        txtFilterItem2.Text = azlib.FillNull(txtFilterItem2.Text, 10);
                        strFilter += " AND (taKaryawan.NIP = '" + azlib.getNIP(txtFilterItem2.Text.Replace("'", "''"),Application["strCn"].ToString()) + "')";
                    }
                }

                if ((ddlFilterItem3.SelectedValue != "000") && (ddlFilterItem3.SelectedValue != ""))
                {
                    strFilter += " AND (taKaryawan.KODE_DEPUTI = '" + ddlFilterItem3.SelectedValue + "')";
                }

                if ((ddlFilterItem4.SelectedValue != "0000") && (ddlFilterItem4.SelectedValue != ""))
                {
                    strFilter += " AND (taKaryawan.KODE_BIRO = '" + ddlFilterItem4.SelectedValue + "')";
                }

                if ((((ddlFilterItem3.SelectedValue == "000") || (ddlFilterItem3.SelectedValue == "")) && ((ddlFilterItem4.SelectedValue == "0000") || (ddlFilterItem4.SelectedValue == "")))) //Operator
                {
                    if ((Session["GradeID"].ToString() == "2"))
                    {
                        strFilter += " AND taKaryawan.KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                    }
                    else if ((Session["GradeID"].ToString().Substring(0, 1) == "3"))
                    {
                        strFilter += " AND taKaryawan.KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                    }
                }

                if (chkExpired.Checked)
                {
                    strFilter += " AND taJatahIjin.EXPIRED " + ddlOperasiBatas.SelectedValue + " '" + DateTime.Parse(txtTglBatas.Text).ToString("MM/dd/yyyy") + "'";
                }

                if (chkLamaKerja.Checked)
                {
                    strFilter += " AND YEAR(dbo.taJatahIjin.TGL_AKHIR) - YEAR(dbo.taKaryawan.TMT) " + ddlOperasiBatasMasaKerja.SelectedValue + " " + txtMasaKerja.Text;
                }

                if (chkJatahIjin.Checked)
                {
                    strFilter += " AND taJatahIjin.JATAH_IJIN " + ddlOperasiBatasJatahIjin.SelectedValue + " " + txtJatahIjin.Text;
                }

                if (chkDiambil.Checked)
                {
                    strFilter += " AND taJatahIjin.DIAMBIL " + ddlOperasiBatasDiambil.SelectedValue + " " + txtDiambil.Text;
                }

                if (chkTidakDiambil.Checked)
                {
                    strFilter += " AND taJatahIjin.TIDAK_DIAMBIL " + ddlOperasiBatasHangus.SelectedValue + " " + txtHangus.Text;
                }

                if (chkSisaIjin.Checked)
                {
                    strFilter += " AND taJatahIjin.SISA_IJIN " + ddlOperasiBatasSisa.SelectedValue + " " + txtSisa.Text;
                }

                return strFilter;
            }

            public void doProses(string spName,string userActCode)
            {
                string strCn = Application["strCn"].ToString();
                SqlConnection cn = new SqlConnection(strCn);

                SqlCommand cmd = new SqlCommand(spName, cn);
                cmd.CommandTimeout = 0;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@iTahun", System.Data.SqlDbType.SmallInt));
                cmd.Parameters["@iTahun"].Value = int.Parse(ddlFilterItem0.SelectedValue);
                cmd.Parameters.Add(new SqlParameter("@sKodeIjin", System.Data.SqlDbType.VarChar, 3));
                cmd.Parameters["@sKodeIjin"].Value = ddlFilterItem5.SelectedValue;
                cmd.Parameters.Add(new SqlParameter("@sSqlFilter", System.Data.SqlDbType.VarChar, 100));
                cmd.Parameters["@sSqlFilter"].Value = getFilter();

                cn.Open();
                //cmd.CommandTimeout = 600
                //.CommandText = ""
                //.CommandType = CommandType.Text
                //.Connection = cn
                try
                {
                    cmd.ExecuteNonQuery();
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), userActCode, "Thn: " + ddlFilterItem0.SelectedValue + " Kd: " + ddlFilterItem5.SelectedValue, Application["strCn"].ToString());
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblProsesGagal.Text;
                }
                cn.Close();
            }

            public void doProsesParameterInteger(string spName, string paramName, string userActCode)
            {
                string strCn = Application["strCn"].ToString();
                SqlConnection cn = new SqlConnection(strCn);

                SqlCommand cmd = new SqlCommand(spName, cn);
                cmd.CommandTimeout = 0;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@iTahun", System.Data.SqlDbType.SmallInt));
                cmd.Parameters["@iTahun"].Value = int.Parse(ddlFilterItem0.SelectedValue);
                cmd.Parameters.Add(new SqlParameter("@sKodeIjin", System.Data.SqlDbType.VarChar,3));
                cmd.Parameters["@sKodeIjin"].Value = ddlFilterItem5.SelectedValue;
                cmd.Parameters.Add(new SqlParameter("@sSqlFilter", System.Data.SqlDbType.VarChar,100));
                cmd.Parameters["@sSqlFilter"].Value = getFilter();
                cmd.Parameters.Add(new SqlParameter(paramName, System.Data.SqlDbType.TinyInt));
                cmd.Parameters[paramName].Value = int.Parse(txtInputParameterInteger.Text);

                cn.Open();
                //cmd.CommandTimeout = 600
                //.CommandText = ""
                //.CommandType = CommandType.Text
                //.Connection = cn
                try
                {
                    cmd.ExecuteNonQuery();
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), userActCode, "Thn: " + ddlFilterItem0.SelectedValue + " Kd: " + ddlFilterItem5.SelectedValue + " Jml: " + txtInputParameterInteger.Text, Application["strCn"].ToString());
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblProsesGagal.Text;
                }
                cn.Close();
            }

            public void doProsesParameterTanggal(string spName, string paramName, string userActCode)
            {
                string strCn = Application["strCn"].ToString();
                SqlConnection cn = new SqlConnection(strCn);

                SqlCommand cmd = new SqlCommand(spName, cn);
                cmd.CommandTimeout = 0;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@iTahun", System.Data.SqlDbType.SmallInt));
                cmd.Parameters["@iTahun"].Value = int.Parse(ddlFilterItem0.SelectedValue);
                cmd.Parameters.Add(new SqlParameter("@sKodeIjin", System.Data.SqlDbType.VarChar, 3));
                cmd.Parameters["@sKodeIjin"].Value = ddlFilterItem5.SelectedValue;
                cmd.Parameters.Add(new SqlParameter("@sSqlFilter", System.Data.SqlDbType.VarChar, 100));
                cmd.Parameters["@sSqlFilter"].Value = getFilter();
                cmd.Parameters.Add(new SqlParameter(paramName, System.Data.SqlDbType.SmallDateTime));
                cmd.Parameters[paramName].Value = DateTime.Parse(txtInputParameterTanggal.Text);

                cn.Open();
                //cmd.CommandTimeout = 600
                //.CommandText = ""
                //.CommandType = CommandType.Text
                //.Connection = cn
                try
                {
                    cmd.ExecuteNonQuery();
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), userActCode, "Thn: " + ddlFilterItem0.SelectedValue + " Kd: " + ddlFilterItem5.SelectedValue + " Tgl: " + DateTime.Parse(txtInputParameterTanggal.Text).ToString("MM/dd/yyyy"), Application["strCn"].ToString());
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblProsesGagal.Text;
                }
                cn.Close();
            }

            protected void GvSaldoIjin_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                if (e.CommandName == "Show")
                {
                    if (Page.IsValid)
                    {
                        GridViewRow row = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer;
                        GvSaldoIjin.SelectedIndex = row.RowIndex;
                        GvSaldoIjin.DataBind();
                        dsIjinRinci.SelectCommand = "select TGL_PROSES, KET_JATAH, KREDIT, DEBIT from q_JatahIjinRinci where NIP = '" + ((LinkButton)row.Cells[0].FindControl("lnkCol0Item")).Text + "' AND KODE_IJIN = '" + ddlFilterItem5.SelectedValue + "' AND TGL_JATAH = '" + DateTime.Parse(((Label)row.Cells[13].FindControl("lblCol13Item")).Text).ToString("MM/dd/yyyy") + "' ORDER BY TGL_PROSES, KODE_JATAH";
                        dsIjinRinci.DataBind();
                        lblTitleRincianJatahIjin.Visible = true;
                        gvIjinRinci.Visible = true;
                    }
                }
            }
}
	}
