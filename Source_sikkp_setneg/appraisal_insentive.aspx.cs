using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Udev.MasterPageWithLocalization.Classes;

/*using System.Configuration;
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

using Udev.MasterPageWithLocalization.Classes;*/

///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : users.aspx.cs                                (Pseudo code)
//        File terkait  : users.aspx                                   (Form)
//                        \App_LocalResources\users.aspx.id.resx       (Display label bahasa Indonesia)
//                        \App_LocalResources\users.aspx.en.resx       (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                           (Library/class)
//                        \App_Code\comon.cs                           (Library/class)
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel users (taUsers)
//
// 2. Penulis Program
//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Retza Budiawan, Bayu Widiaiswara, Desmond
//
// 3. Tanggal update    : 20/11/2007
//
// 4. Versi             : 2.0.2
//
// 5. Historis revisi
//        Versi 2.0.1   : penambahan dokumentasi dan perbaikan bugs
//        Versi 2.0.2   : Pemisahan hak akses menu dari taUser menjadi taUserLevel
//
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	namespace rtwin
	{

        public partial class appraisal_insentive : BasePage
		{
            protected void DropBulan_DataBound_SelectedChange(object sender, EventArgs e)
            {
                ExceptionDetails.Text = "";
            }
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            //fungsi: mengatur isi dari dropdownlist cabang
            public void setCabang()
			{
                string strFilter = "";

                if (Session["GradeID"].ToString() != "1") //bukan admin
                {
                    strFilter += "KODE_CABANG ='" + Session["CabangID"].ToString() + "'";
                }

                 //dsCabang.FilterExpression = strFilter;
			}

            //fungsi: mengatur Filter dari Gridview
            private void doFiltering()
            {
                 
            }

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
       
            //fungsi: me reset password user otomatis
         
			private void Page_Load(object sender, EventArgs e)
			{
				if (! rtwin.azlib.AksesHalaman(22, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
						Response.Redirect("notauthorized.aspx");
				}
				else
				{
					if (Session["GradeID"].ToString() != "1")
					{
						if (Session["GradeID"].ToString() != "2")
						{
							Response.Redirect("notauthorized.aspx");
						}
					}
				}
				
				//jika halaman bukan postback
                //lakukan setCabang untuk user bukan admin
				if (! Page.IsPostBack)
				{
					setCabang();
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
				}
				
                //filter
                doFiltering();
                doFilteringLookup();
            //    Label8.Text = Session["CabangID"].ToString();
                //Set Bulan dan Tahun
              
			}
			
		 
            protected void lnkCol2Edit_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "nipLama";
               GvLookupPegawai.DataBind();
                LookupMPE.Show();
            }

            protected void lnkCol2Footer_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtCol2Footer";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
            }

            protected void lnkCol2FormView_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtCol2FormView";
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

         /*  protected void GvLookupPegawai_SelectedIndexChanged(object sender, EventArgs e)
            {
                if (Session["Triger"] != null)
                {
                    if (Session["Triger"].ToString() == "niplama")
                    {
                       TxtNIP.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                    }

                    Session.Remove("Triger");
                }

                setInitialLookupState();
                UpdatePanel1.Update();
            }
        */
            public void prosesApproval()
            {
                String tgl;
                String tgl2;
                string cabangId = Session["CabangID"].ToString();
                string empID = TxtNIP.Text;

                if (azlib.IsNumeric(ddlTahun.SelectedValue.ToString()))
                {
                    if (Session["strLang"].ToString() == "en")
                    {
                       tgl = DropBulan.SelectedValue + "/" + "1" + "/" + ddlTahun.SelectedValue;
                       tgl2 = azlib.LastDate(DateTime.Parse(tgl), "en").ToString("MM/dd/yyyy");
                        Session["strTgl"] = (DateTime.Parse(tgl)).ToString("MM/dd/yyyy");
                        Session["strTgl2"] = azlib.LastDate(DateTime.Parse(tgl), "en").ToString("MM/dd/yyyy");
                    }
                    else
                    {
                      
                        tgl = "1" + "/" + DropBulan.SelectedValue + "/" + ddlTahun.SelectedValue;
                       tgl2 = azlib.LastDate(DateTime.Parse(tgl), "id").ToString("dd/MM/yyyy");
                        Session["strTgl"] = (DateTime.Parse(tgl)).ToString("MM/dd/yyyy");
                        Session["strTgl2"] = azlib.LastDate(DateTime.Parse(tgl), "id").ToString("MM/dd/yyyy");
                        string strCn;
                        strCn = Application["strCn"].ToString();
                        SqlConnection cn;
                        cn = new SqlConnection(strCn);

                        if (empID == "")
                        {
                            SqlCommand cmd = new SqlCommand("proc_ProsesTK_Satker", cn);

                            cmd.CommandTimeout = 36000;
                            cmd.CommandType = System.Data.CommandType.StoredProcedure;


                            cmd.Parameters.Add(new SqlParameter("@dTglAwal", System.Data.SqlDbType.DateTime));
                            cmd.Parameters["@dTglAwal"].Value = DateTime.Parse(tgl);

                            cmd.Parameters.Add(new SqlParameter("@dTglAkhir", System.Data.SqlDbType.DateTime));
                            cmd.Parameters["@dTglAkhir"].Value = DateTime.Parse(tgl2);

                            cmd.Parameters.Add(new SqlParameter("@sKodeCabang", System.Data.SqlDbType.VarChar, 3));
                            cmd.Parameters["@sKodeCabang"].Value = cabangId;
                            cn.Open();
                            cmd.CommandTimeout = 36000;

                            try
                            {
                                cmd.ExecuteNonQuery();
                                ExceptionDetails.Text = "Proses Tunjangan Kinerja Berhasil";
                                // Label6.Text = Session["strTgl"].ToString();
                                // Label7.Text = Session["strTgl2"].ToString();
                                //rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4305", txtPIN.Text + "," + txtFilterItem0.Text, Application["strCn"].ToString());
                            }
                            catch (Exception ex)
                            {
                                ExceptionDetails.Text = ex.Message;
                                //Label3.Text = ;
                            }
                        }
                        else {
                            SqlCommand cmd = new SqlCommand("proc_ProsesTK_Individu", cn);

                            cmd.CommandTimeout = 36000;
                            cmd.CommandType = System.Data.CommandType.StoredProcedure;


                            cmd.Parameters.Add(new SqlParameter("@dTglAwal", System.Data.SqlDbType.DateTime));
                            cmd.Parameters["@dTglAwal"].Value = DateTime.Parse(tgl);

                            cmd.Parameters.Add(new SqlParameter("@dTglAkhir", System.Data.SqlDbType.DateTime));
                            cmd.Parameters["@dTglAkhir"].Value = DateTime.Parse(tgl2);

                            cmd.Parameters.Add(new SqlParameter("@sNIP", System.Data.SqlDbType.VarChar, 25));
                            cmd.Parameters["@sNIP"].Value = empID;

                            cn.Open();
                            cmd.CommandTimeout = 36000;
                            try
                            {
                                cmd.ExecuteNonQuery();
                                ExceptionDetails.Text = "Proses Tunjangan Kinerja Berhasil";
                                // Label6.Text = Session["strTgl"].ToString();
                                // Label7.Text = Session["strTgl2"].ToString();
                                //rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4305", txtPIN.Text + "," + txtFilterItem0.Text, Application["strCn"].ToString());
                            }
                            catch (Exception ex)
                            {
                                ExceptionDetails.Text = ex.Message;
                                //Label3.Text = ;
                            }
                        
                        } 
                        //.CommandText = ""
                        //.CommandType = CommandType.Text
                        //.Connection = cn
                        
                        cn.Close();

                    }
                 
                   
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
                    if (Session["Triger"].ToString() == "txtCol2Footer")
                    {
                     
                        TxtNIP.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                       LabelNama.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;

                    }
                     
                    Session.Remove("Triger");
                }

                setInitialLookupState(); 
                UpdatePanel1.Update();
            }
         
            protected void Button1_Click(object sender, EventArgs e)
            {
                prosesApproval();
            }
            protected void DropBulan_TextChanged(object sender, EventArgs e)
            {
                ExceptionDetails.Text = "";
            }
}
   
}
