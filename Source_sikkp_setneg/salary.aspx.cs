///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : loan.aspx.cs                             (Pseudo code)

//        File terkait  : loan.aspx                                (Form)
//                        \App_LocalResources\loan.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\loan.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                                        (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan daftar pinjaman karyawan

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Asep Saepulloh
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
        //fungsi: mengatur visible gridview dan formview
        //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
        public partial class salary : BasePage
		{
            private void showGridView(Boolean show)
            {
                GvSalary.Visible = show;
                tableFilter.Visible = show;
            }

             
            //fungsi: Filter Gridview
            private void doFiltering()
            {
                try
                {
                    string strFilter = "";

                    strFilter += " WHERE Bulan= '" + DropBulan.SelectedValue + "' and tahun= '" + ddlTahun.Text + "'";

                     

                   dsSalary.SelectCommand += strFilter + " ORDER BY NIP ASC";
                }
                catch (Exception ex)
                { }
            }

          

            //Fungsi: set Kondisi awal komponen sesuai hak akses level
            private void setComponent()
            {
                BoundField Column0 = (BoundField)GvSalary.Columns[0];
                if (isEntryUseNIP())
                {
              //    lblPIN.Visible = false;
                    Column0.HeaderText = "NIP";
                    Column0.SortExpression = "NIP";
                    Column0.DataField = "NIP";
                }
                else
                {
                //    lblNIP.Visible = false;
                    Column0.HeaderText = "PIN";
                    Column0.SortExpression = "PIN";
                    Column0.DataField = "PIN";
                }
                Column0.ItemStyle.ForeColor = System.Drawing.Color.Black;
            }
			
			protected void Page_Load(object sender, EventArgs e)
			{
				//jika userid kosong maka akan di link ke halaman awal
                if (Session["GradeID"].ToString().Substring(0, 1) != "1")
                // if (!rtwin.azlib.AksesHalaman(32, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}
				
				//jika halaman bukan postback
				if (! Page.IsPostBack)
				{
                    //Set Bulan dan Tahun
                    int bln = DateTime.Now.Month;

                    byte i;
                    ListItem li = new ListItem();
                    for (i = 1; i <= 12; i++)
                    {
                        li = new ListItem((DateTime.Parse(i.ToString() + "/" + i.ToString() + " /1900")).ToString("MMMM"), i.ToString()); //Format(DateTime.Parse(CStr(i) & "/" & CStr(i) & " /1900"), "MMMM"), CStr(i))
                        DropBulan.Items.Add(li);
                    }

                    DropBulan.SelectedValue = bln.ToString();

                    li = new ListItem(System.Convert.ToString(DateTime.Now.Year - 1), System.Convert.ToString(DateTime.Now.Year - 1));
                    ddlTahun.Items.Add(li);
                    li = new ListItem(DateTime.Now.Year.ToString(), DateTime.Now.Year.ToString());
                    ddlTahun.Items.Add(li);
                    ddlTahun.SelectedValue = DateTime.Now.Year.ToString();

          //          setFilter();
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
                    GvSalary.DataBind();
                }
            }

            protected void GvSalary_DataBound(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvSalary.BottomPagerRow;

                if (rowPager != null)
                {
                    // get your controls from the gridview
                    TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                    Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                    txtHalaman.Text = (GvSalary.PageIndex + 1).ToString();
                    // populate page count
                    lblJumlahHalaman.Text = GvSalary.PageCount.ToString();
                }
                else
                {
                    return;
                }
            }

            protected void GvSalary_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
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

            //fungsi: Handle ketika tombol Edit di GridView di tekan
            protected void GvSalary_RowEditing(object sender, GridViewEditEventArgs e)
            {
            }

            //fungsi: Handle ketika terjadi Perintah pada FormView
            protected void Fvperformance_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel_Edit")
                {
                    showGridView(true);
                }
            }

            //fungsi: Handle Ketika akan mengupdate data pada database
            protected void dsperformanceEdit_Updating(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
            }

            //fungsi: Handle Ketika data pada database telah diupdate
            protected void dsperformanceEdit_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
            }

            //fungsi: Handle Ketika data pada database telah didelete
            protected void dsperformance_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
            }

            //fungsi: Handle Ketika akan insert database
            protected void dsperformanceEdit_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
            }

            //fungsi: Handle Ketika data pada database telah ditambahkan
            protected void dsperformanceEdit_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvSalary.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvSalary.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvSalary.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvSalary.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvSalary.PageIndex + 1).ToString();
                }
            }

            //fungsi: set kondisi awal komponen di FormView
            private void setInitialComponent()
            {
            }

            //fungsi: Tampilkan Lookup pegawai
            protected void lnkFilterItem2_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtFilterItem2";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
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
                        strSelect = "SELECT NAMA FROM q_Karyawan WHERE PIN='" + txtNIP.Text.Replace("'", "''") + "'";
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
                        strSelect = "SELECT NAMA FROM q_Karyawan WHERE PIN='" + txtNIP.Text.Replace("'", "''") + "'" + strFilter;
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
                dsLookup.SelectCommand = "SELECT NIP, PIN, NAMA FROM taKaryawan WHERE NON_AKTIF IS NULL";
                if (strFilter != "")
                {
                    dsLookup.SelectCommand += " AND " + strFilter;
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
                            //this.txtFilterItem2.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                        }
                        else
                        {
                            //this.txtFilterItem2.Text = GvLookupPegawai.SelectedRow.Cells[1].Text;
                        }
                    }

                    Session.Remove("Triger");
                }

                setInitialLookupState();
                UpdatePanel1.Update();
            }

            protected void Button1_Click(object sender, EventArgs e)
            {

                string strSqlDelete = "";
   
                 strSqlDelete += " Delete from taTunjanganKhusus WHERE Bulan= '" + DropBulan.SelectedValue + "' and tahun= '" + ddlTahun.Text + "'";

                // SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                 //SqlDataAdapter adpSQL = new SqlDataAdapter(strSqlDelete, Application["strCn"].ToString());


                SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
               SqlCommand mycomand = new SqlCommand("delete from taPinjaman where (bulan = '" + DropBulan.SelectedValue + "' and tahun = '" + ddlTahun.Text + "')", myconection);
					
					mycomand.Connection.Open();
					mycomand.ExecuteNonQuery();
					mycomand.Connection.Close();
					
					//catat ke log pen-deletan data pada taPolaIndividu
					//rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2603", nip, Application["strCn"].ToString());
					
					//btnGenerate_Click(sender, e);
				}
		 
        }
 
	}
