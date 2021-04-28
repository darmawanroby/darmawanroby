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
		
		public partial class change_empid : BasePage
		{
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
						Response.Redirect("password.aspx");
					}
				}
				
				//jika halaman bukan postback
                //lakukan setCabang untuk user bukan admin
				if (! Page.IsPostBack)
				{
					setCabang();					
				}
				
                //filter
                doFiltering();
                doFilteringLookup();
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
            
            public void UbahNIP()
            {
                string strCn;
                strCn = Application["strCn"].ToString();
                SqlConnection cn;
                cn = new SqlConnection(strCn);
                SqlCommand cmd = new SqlCommand("proc_GantiNIP", cn);
                cmd.CommandTimeout = 0;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@sNIPlama", System.Data.SqlDbType.VarChar, 25));
                cmd.Parameters["@sNIPlama"].Value = nipLama.Text;
                cmd.Parameters.Add(new SqlParameter("@sNIPbaru", System.Data.SqlDbType.VarChar, 25));
                cmd.Parameters["@sNIPbaru"].Value = nipBaru.Text;
             //   cmd.Parameters.Add(new SqlParameter("@dTglAkhir", System.Data.SqlDbType.DateTime));
               // cmd.Parameters["@dTglAkhir"].Value = DateTime.Parse(txtFilterItem1.Text);

                cn.Open();
                //cmd.CommandTimeout = 600
                //.CommandText = ""
                //.CommandType = CommandType.Text
                //.Connection = cn
                try
                {
                    cmd.ExecuteNonQuery();
                   ExceptionDetails.Text = "Proses Ubah NIP Berhasil";
                  //Label3.Text = nipLama.Text;
                    //rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4305", txtPIN.Text + "," + txtFilterItem0.Text, Application["strCn"].ToString());
                }
                catch (Exception)
                {
                   ExceptionDetails.Text = "Proses Ubah NIP Gagal";
                }
                cn.Close();
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
                    if (Session["Triger"].ToString() == "nipLama")
                    {
                     
                      nipLama.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                        LabelNama.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;

                    }
                     
                    Session.Remove("Triger");
                }

                setInitialLookupState(); 
                UpdatePanel1.Update();
            }
            protected void Button1_Click(object sender, EventArgs e)
            {
                UbahNIP();
            }
}
   
}
