///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : rawdata.aspx.cs                             (Pseudo code)

//        File terkait  : rawdata.aspx                                (Form)
//                        \App_LocalResources\rawdata.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\rawdata.aspx.en.resx    (Display label bahasa Inggris)
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
		public partial class rawdata : BasePage
		{
			//fungsi: Hitung Jumlah Data
			public string count(string q)
			{
				string a;
				SqlConnection con = new SqlConnection(Application["strCn"].ToString());
				con.Open();
				SqlCommand pcom = new SqlCommand();
				SqlDataReader rdr;
				pcom = con.CreateCommand();
                pcom.CommandText = "select count(tgl) as jml from q_DataMurni" + q;
				rdr = pcom.ExecuteReader();
				
				rdr.Read();
				a = rdr["jml"].ToString();
				
				rdr.Close();
				con.Close();
				return a;
			}

            //fungsi: Filter GridView
            private void doFiltering()
            {
                try
                {
                    string strFilter = "";
                    strFilter += " WHERE ([TGL] between '" + DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy") + "' AND '" + DateTime.Parse(txtFilterItem1.Text).ToString("MM/dd/yyyy") + "')";

                    if (cbPIN.Checked)
                    {
                        strFilter += " AND PIN='" + azlib.FillNull(txtPIN.Text.Replace("'", "''"), 10) + "'";
                    }
                    if (cbAlamatKoneksi.Checked)
                    {
                        //strFilter += " AND ALAMAT_KONEKSI='" & DropAlamatKoneksi.SelectedValue & "'"
                        strFilter += " AND KODE_LOKASI='" + DropAlamatKoneksi.SelectedValue + "'";
                    }
                    if (cbStatusMesin.Checked)
                    {
                        strFilter += " AND KODE_STATUS_MESIN='" + ddlStatusMesin.SelectedValue + "'";
                    }

                    if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "3a"))
                    {
                        strFilter += " AND KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                    }
                    else if ((Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString()/*.Substring(0, 1)*/ == "3")) //Operator
                    //if ((Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString().Substring(0, 1) == "3")) //Operator
                    {
                        strFilter += " AND KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                    }


                    lblJmlRecord.Text = count(strFilter);
                    dsDataMurni.SelectCommand += strFilter;
                }
                catch (Exception ex)
                { }
            }

            //fungsi: set kondisi awal Komponen Filter
            private void setFilter()
            {
            }

            //fungsi: atur Enable Button Revisi, jika NIP terisi maka Enable = true
            private void setEnableGrabButton()
            {
                if (cbPIN.Checked && (txtPIN.Text != ""))
                {
                    btnGrab.Enabled = true;
                }
                else
                {
                    btnGrab.Enabled = false;
                }
            }
			
			protected void Page_Load(object sender, EventArgs e)
			{
				//jika userid kosong maka akan di link ke halaman awal
				if (! rtwin.azlib.AksesHalaman(27, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}
				
				//jika halaman bukan postback
				if (! Page.IsPostBack)
				{
					txtFilterItem0.Text = DateTime.Now.ToShortDateString();
                    txtFilterItem1.Text = DateTime.Now.ToShortDateString();
                    setFilter();
				}
                doFilteringLookup();
                doFiltering();
                setEnableGrabButton();
			}
			
            //fungsi: proses GRAB
			public void Grab()
			{
				string strCn;
				strCn = Application["strCn"].ToString();
				SqlConnection cn;
				cn = new SqlConnection(strCn);
				SqlCommand cmd = new SqlCommand("proc_Grab", cn);
				cmd.CommandTimeout = 0;
				cmd.CommandType = System.Data.CommandType.StoredProcedure;
				cmd.Parameters.Add(new SqlParameter("@sPinStr", System.Data.SqlDbType.VarChar, 10));
				cmd.Parameters["@sPinStr"].Value = azlib.FillNull(txtPIN.Text.Replace("'", "''"), 10);
				cmd.Parameters.Add(new SqlParameter("@dTglAwal", System.Data.SqlDbType.DateTime));
				cmd.Parameters["@dTglAwal"].Value = DateTime.Parse(txtFilterItem0.Text);
				cmd.Parameters.Add(new SqlParameter("@dTglAkhir", System.Data.SqlDbType.DateTime));
                cmd.Parameters["@dTglAkhir"].Value = DateTime.Parse(txtFilterItem1.Text);
				
				cn.Open();
				//cmd.CommandTimeout = 600
				//.CommandText = ""
				//.CommandType = CommandType.Text
				//.Connection = cn
				try
				{
					cmd.ExecuteNonQuery();
					ExceptionDetails.Text = lblRevisiOk.Text;
					rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4305", txtPIN.Text + "," + txtFilterItem0.Text, Application["strCn"].ToString());
				}
				catch (Exception)
				{
					ExceptionDetails.Text = lblRevisiNotOk.Text;
				}
				cn.Close();
			}
			
            //fungsi: Panggil proses GRAB
			protected void btnGrab_Click(object sender, EventArgs e)
			{
                if (Page.IsValid)
                {
                    if (DateTime.Parse(txtFilterItem1.Text) > DateTime.Parse(txtFilterItem0.Text).AddDays(10))
                    {
                        ExceptionDetails.Text = lblValidRange.Text;
                    }
                    else if (DateTime.Parse(txtFilterItem0.Text) < DateTime.Parse(Session["tglTutup"].ToString()))
                    {
                        ExceptionDetails.Text = lblPeriode.Text;
                    }
                    else
                    {
                        Grab();
                    }
                }
				
			}
			
			protected void txtHalaman_TextChanged(object sender, EventArgs e)
			{
                GridViewRow rowPager = GvDataMurni.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvDataMurni.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvDataMurni.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvDataMurni.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvDataMurni.PageIndex + 1).ToString();
                }
			}
            
            protected void GvDataMurni_DataBound(object sender, EventArgs e)
			{
				GridViewRow rowPager = GvDataMurni.BottomPagerRow;
				
				if (rowPager != null)
				{
					// get your controls from the gridview
					TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));
					Label lblJumlahHalaman = (Label) (rowPager.Cells[0].FindControl("lblJumlahHalaman"));
					txtHalaman.Text = (GvDataMurni.PageIndex + 1).ToString();
					// populate page count
					lblJumlahHalaman.Text = GvDataMurni.PageCount.ToString();
					
					Label lbljml = (Label) (rowPager.Cells[0].FindControl("lbljml"));
					lbljml.Text = "Jumlah Record : " + lblJmlRecord.Text; //((GvDataMurni.PageCount - 1) * GvDataMurni.PageSize + GvDataMurni.Rows.Count).ToString()
				}
				else
				{
					return;
				}
			}
			
            //fungsi: Refresh GridView
			protected void btnRefresh_Click(object sender, EventArgs e)
			{
                if (Page.IsValid)
                {
                    GvDataMurni.DataBind();
                }
			}

            protected void GvDataMurni_RowDataBound(object sender, GridViewRowEventArgs e)
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

            protected void lnkCol2Footer_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtFilterItem0";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
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
                    if (Session["Triger"].ToString() == "txtFilterItem0")
                    {
                        this.txtPIN.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("LabelPINItem")).Text;
                        this.Label12.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label2")).Text;
                    }

                    Session.Remove("Triger");
                }

                setInitialLookupState();
                UpdatePanel1.Update();
            }
}
		
	}
