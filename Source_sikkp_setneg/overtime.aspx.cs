///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : overtime.aspx.cs                           (Pseudo code)

//        File terkait  : overtime.aspx                              (Form)
//                        \App_LocalResources\overtime.aspx.id.resx  (Display label bahasa Indonesia)
//                        \App_LocalResources\overtime.aspx.en.resx  (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel Lembur (taLembur)

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//
// 3. Tanggal update    : 11/12/2011
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

        public partial class overtime : BasePage
		{
            private void showGridView(Boolean show)
            {
                GvLembur.Visible = show;
                tableFilter.Visible = show;
                if ((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "3"))
                {
                    if (Session["GradeID"].ToString() != "3")
                    {
                        //btnSimpan.Visible = show;
                    }
                }
            }

            protected void ddlFilterItem3_DataBound_SelectedChange(object sender, EventArgs e)
            {
                if (ddlFilterItem3.SelectedValue != "000")
                {
                    if ((Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "1a"))
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
                    if ((Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "1a"))
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

                    if ((ddlFilterItem6.SelectedValue != "00000") && (ddlFilterItem6.SelectedValue != ""))
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND (KODE_BAGIAN = '" + ddlFilterItem6.SelectedValue + "')";
                        }
                        else
                        {
                            strFilter += " WHERE (KODE_BAGIAN = '" + ddlFilterItem6.SelectedValue + "')";
                        }
                    }

                    if ((((ddlFilterItem3.SelectedValue == "000") || (ddlFilterItem3.SelectedValue == "")) && ((ddlFilterItem4.SelectedValue == "0000") || (ddlFilterItem4.SelectedValue == "")) && ((ddlFilterItem6.SelectedValue == "00000") || (ddlFilterItem6.SelectedValue == "")))) //Operator
                    {
                    if ((Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "1a"))
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
                            strFilter += " AND " + ddlFilterItem5.SelectedValue + " LEMBUR_SKL IS NULL";
                        }
                        else
                        {
                            strFilter += " WHERE " + ddlFilterItem5.SelectedValue + " LEMBUR_SKL IS NULL";
                        }
                    }

                    //strFilter += " AND KODE_CABANG = '003'";
                    dsLembur.SelectCommand += strFilter + " ORDER BY TGL_MASUK ASC";

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
					
                if ((Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "1a"))
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
                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "2") && (Session["GradeID"].ToString() != "1a"))
                {
                    if (Session["GradeID"].ToString() != "3")
                    {
                        GvLembur.Columns[7].Visible = false;
                        GvLembur.Columns[8].Visible = false;
                        GvLembur.Columns[9].Visible = false;
                    }
                    //btnSimpan.Visible = false;
                    GvLemburValidasi.Columns[4].Visible = false;
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
                //dsLemburValidasi.SelectCommand = "SELECT * FROM taLemburValidasi WHERE KODE_DEPUTI IN (SELECT KODE_DEPUTI FROM q_Deputi WHERE KODE_CABANG = '" + Session["CabangID"].ToString() + "')";
			}

            protected void btnRefresh_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    //update ke grid
                    GvLembur.DataBind();
                }
            }

            protected void GvLembur_DataBound(object sender, EventArgs e)
            {
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

                    ImageButton btnEdit = (ImageButton)e.Row.Cells[7].FindControl("imgEdit");
                    ImageButton btnDelete = (ImageButton)e.Row.Cells[8].FindControl("imgDelete");
                    Label lblTgl = (Label)e.Row.Cells[2].FindControl("lblCol2Item");
                    ImageButton btnSisip = (ImageButton)e.Row.Cells[9].FindControl("imgSisip");
                    Label lblLembur = (Label)e.Row.Cells[6].FindControl("lblCol6Item");

                    if (Session["GradeID"].ToString() != "1")
                    {
                        //CheckBox chkSelect = (CheckBox)e.Row.Cells[6].FindControl("chkSelect");

                        if (Session["GradeID"].ToString() != "2")
                        {
                            //chkSelect.Enabled = false;
                            //btnEdit.Enabled = !chkSelect.Checked;
                            //btnDelete.Enabled = !chkSelect.Checked;
                        }
                    }
                    if (lblTgl != null)
                    {
                        btnEdit.Enabled = (DateTime.Parse(lblTgl.Text) > DateTime.Parse(Session["tglValidasiLembur"].ToString()));
                        btnDelete.Enabled = (DateTime.Parse(lblTgl.Text) > DateTime.Parse(Session["tglValidasiLembur"].ToString()));
                        btnSisip.Enabled = (DateTime.Parse(lblTgl.Text) > DateTime.Parse(Session["tglValidasiLembur"].ToString()));
                    }

                    if (lblLembur != null)
                    {
                        btnEdit.Visible = (lblLembur.Text != "");
                        btnDelete.Visible = (lblLembur.Text != "");
                        btnSisip.Visible = (lblLembur.Text == "");
                    }
                    else
                    {
                        btnDelete.Visible = false;
                        btnSisip.Visible = false;
                    }
                }
            }

            protected void GvLembur_RowEditing(object sender, GridViewEditEventArgs e)
            {
                //if (Page.IsValid)
                //{
                //    dsLembur.SelectCommand = "SELECT NIP, NAMA, TGL_MASUK, JAM_MASUK, JAM_KELUAR, TOTAL_LEMBUR, LEMBUR_SKL, PIN FROM q_skl";
                //    if (isEntryUseNIP())
                //    {
                //        dsLembur.SelectCommand += " WHERE NIP = '" + GvLembur.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_MASUK = '" + DateTime.Parse(((Label)GvLembur.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                //    }
                //    else
                //    {
                //        dsLembur.SelectCommand += " WHERE PIN = '" + GvLembur.Rows[e.NewEditIndex].Cells[0].Text + "' AND TGL_MASUK = '" + DateTime.Parse(((Label)GvLembur.Rows[e.NewEditIndex].Cells[2].FindControl("lblCol2Item")).Text).ToString("MM/dd/yyyy") + "'";
                //    }
                //    e.Cancel = true;
                //    showGridView(false);
                //}
                //else
                //{
                //    e.Cancel = true;
                //}
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvLembur.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvLembur.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvLembur.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvLembur.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvLembur.PageIndex + 1).ToString();
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
                    if ((Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "1a"))
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
                if ((Session["GradeID"].ToString() != "1") /*&& (Session["GradeID"].ToString() != "1a")*/)
                {
                    if (strFilter != "")
                    {
                        strFilter += "AND ";
                    }
                    if ((Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "1a"))
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


            //Validator Code
             protected void GvLembur_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                if (e.CommandName == "TambahLembur")
                {
                    ImageButton b = (ImageButton)e.CommandSource;
                    GridViewRow myRow = (GridViewRow)b.NamingContainer;

                    Label tglMasuk = (Label)(myRow.Cells[2].FindControl("lblCol2Item"));
                    Label TotalLembur = (Label)(myRow.Cells[5].FindControl("lblCol5Item"));

                    Session["sNIP"] = GvLembur.DataKeys[myRow.RowIndex].Value.ToString();
                    Session["sTglMasuk"] = tglMasuk.Text;
                    Session["sTotalLembur"] = TotalLembur.Text;

                    dsLembur.Insert();
                }
            }

            protected void dsLembur_Deleted(object sender, SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2313", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_MASUK"].Value.ToString(), Application["strCn"].ToString());
                }
                GvLembur.DataBind();
            }

            protected void dsLembur_Inserting(object sender, SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    e.Command.Parameters["@NIP"].Value = Session["sNIP"].ToString();
                    e.Command.Parameters["@TGL_MASUK"].Value = DateTime.Parse(Session["sTglMasuk"].ToString());
                    e.Command.Parameters["@TOTAL_LEMBUR"].Value = DateTime.Parse("01/01/1900 " + Session["sTotalLembur"].ToString());

                    Session.Remove("sNIP");
                    Session.Remove("sTglMasuk");
                    Session.Remove("sTotalLembur");
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text + " (" + ex.Message.ToString() + ")";
                    e.Cancel = true;
                }
            }

            protected void dsLembur_Inserted(object sender, SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter insert maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text + " (" + e.Exception.Message.ToString() + ")";
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2431", e.Command.Parameters["@NIP"].Value.ToString() + "," + e.Command.Parameters["@TGL_MASUK"].Value.ToString(), Application["strCn"].ToString());
                    ExceptionDetails.Text = "Data telah di simpan";

                    GvLembur.DataBind();
                }

                showGridView(true);

            }

            protected void GvLemburValidasi_RowUpdating(object sender, GridViewUpdateEventArgs e)
            {
                if (Page.IsValid)
                {
                    try
                    {
                        DateTime tanggalBaru = DateTime.Parse(((TextBox)(GvLemburValidasi.Rows[e.RowIndex].FindControl("txtCol1Edit"))).Text);
                        dsLemburValidasi.UpdateCommand = "UPDATE taLemburValidasi SET TGL_SKL = '" + tanggalBaru.ToString("MM/dd/yyyy") + "' WHERE KODE_DEPUTI = @KODE_DEPUTI";
                    }
                    catch (Exception ex)
                    {
                        ExceptionDetails.Text = lblCannotUpdate.Text;
                        e.Cancel = true;
                    }
                }
            }
            protected void txtHalaman2_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvLemburValidasi.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman2"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvLemburValidasi.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvLemburValidasi.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvLemburValidasi.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvLemburValidasi.PageIndex + 1).ToString();
                }
            }
            protected void GvLemburValidasi_DataBound(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvLemburValidasi.BottomPagerRow;

                if (rowPager != null)
                {
                    // get your controls from the gridview
                    TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman2"));
                    Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                    txtHalaman.Text = (GvLemburValidasi.PageIndex + 1).ToString();
                    // populate page count
                    lblJumlahHalaman.Text = GvLemburValidasi.PageCount.ToString();
                }
                else
                {
                    return;
                }
            }
            protected void ddlFilterItem4_SelectedIndexChanged(object sender, EventArgs e)
            {
                if (ddlFilterItem4.SelectedValue != "0000")
                {
                    if ((Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "1a"))
                    {
                        dsSubbagian.FilterExpression = "KODE_BAGIAN = '00000' OR (KODE_CABANG = '" + Session["CabangID"].ToString() + "' AND KODE_BIRO = '" + ddlFilterItem4.SelectedValue + "')";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        dsSubbagian.SelectCommand = "SELECT KODE_BAGIAN, NAMA_BAGIAN FROM q_BAGIAN";
                        dsSubbagian.SelectCommand += " WHERE KODE_BAGIAN = '00000' OR (KODE_BAGIAN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "') AND KODE_BIRO = '" + ddlFilterItem4.SelectedValue + "')";
                    }
                    else
                    {
                        dsSubbagian.FilterExpression = "KODE_BAGIAN = '00000' OR KODE_BIRO = '" + ddlFilterItem4.SelectedValue + "'";
                    }
                }
                else
                {
                    if ((Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "1a"))
                    {
                        dsSubbagian.FilterExpression = "KODE_BAGIAN = '00000' OR KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        dsSubbagian.SelectCommand = "SELECT KODE_BAGIAN, NAMA_BAGIAN FROM q_BAGIAN";
                        dsSubbagian.SelectCommand += " WHERE KODE_BAGIAN = '00000' OR KODE_BAGIAN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                    }
                }
                ddlFilterItem6.DataBind();
            }
}
	}
