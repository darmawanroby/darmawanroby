///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : allowance_recapitulation.aspx.cs                             (Pseudo code)
//        File terkait  : allowance_recapitulation.aspx                                (Form)
//                        \App_LocalResources\allowance_recapitulation.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\allowance_recapitulation.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel Golongan (taGolongan)
//
// 2. Penulis Program
//        Programer     : Asep Saepulloh
//        Co-Programmer : -
//
// 3. Tanggal update    : 04/04/2018
//
// 4. Versi             : 1.0.1
//
//
//
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;

namespace rtwin
	{
    public partial class allowrekap : BasePage
		{


            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GvAllowanceRecap.Visible = show;
               
            }

            //fungsi: mengatur state ketika page diload ex: seleksi izin akses dan otorisasi
            protected void Page_Load(object sender, System.EventArgs e)
			{
                //seleksi izin akses halaman
                if (!azlib.AksesHalaman(23, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    //seleksi jika selain Administrator (Administrator: Session["GradeID"] = 1)
                    if ((!Page.IsPostBack) && (Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "1a"))
                    {
                        lnkBtnInsert.Visible = false;
                        ImgBtnAdd.Visible = false;
                        if (Session["GradeID"].ToString() == "2") {
                            lnkBtnInsert.Visible = false;
                            GvAllowanceRecap.Columns[4].Visible = false;
                        }
                       
                    }
                     
                }


                //Set Bulan dan Tahun
                int bln = DateTime.Now.Month;

                byte i;
                ListItem li = new ListItem();
                for (i = 1; i <= 12; i++)
                {
                    li = new ListItem((DateTime.Parse(i.ToString() + "/" + i.ToString() + " /1900")).ToString("MMMM"), (DateTime.Parse(i.ToString() + "/" + i.ToString() + " /1900")).ToString("MM")); 
                   
                    ddlBulanAwal.Items.Add(li);
                    ddlBulanAkhir.Items.Add(li);
                }

                //ddlBulanAwal.SelectedValue = bln.ToString();

                //ddlBulanAwal.SelectedValue = bln.ToString();
                //ddlBulanAkhir.SelectedValue = bln.ToString();
                txtTahun.Text = DateTime.Now.Year.ToString();
			}
			
            //fungsi: mengatur state Gridview setelah berhasil bound data
			protected void GvGolongan_DataBound(object sender, System.EventArgs e)
			{
                //seleksi jumlah data kosong atau tidak
                if (GvAllowanceRecap.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GvAllowanceRecap.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GvAllowanceRecap.PageIndex = GvAllowanceRecap.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GvAllowanceRecap.PageIndex + 1);
                        lblJumlahHalaman.Text = GvAllowanceRecap.PageCount.ToString();
                    }
                    showGridView(true);
                }
                else
                {
                    //Data kosong, set gridview visible false, formview visible true
                    showGridView(false);
                }                
			}

            //fungsi: meng-handle jika terjadi command pada gridview
            protected void GvGolongan_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                // Insert data if the CommandName == "Insert" and the validation controls indicate valid data...
                if (e.CommandName == "Insert" && Page.IsValid)
                {
                    // Insert new record
                    dsAllowanceRecap.Insert();
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GvAllowanceRecap.ShowFooter = false;
                }
            }

            //fungsi: mengatur state dari setiap Row pada Gridview
            protected void GvGolongan_RowDataBound(object sender, GridViewRowEventArgs e)
            {
                //menambahkan State Row on Hover
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    GridView gv = ((GridView)sender);

                    String className = ((e.Row.RowState == DataControlRowState.Alternate) ? gv.AlternatingRowStyle.CssClass : gv.RowStyle.CssClass);

                    e.Row.Attributes.Add("onmouseover", "this.className='datagrid_hovcol';");

                    e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");

                    //Rubah $ jadi Rp
                    if ((e.Row.RowState == DataControlRowState.Normal) || (e.Row.RowState == DataControlRowState.Alternate))
                    {
                        Label lblTarifLembur = (Label)e.Row.FindControl("lblCol2Item");
                        String a = lblTarifLembur.Text;
                        if (a.Contains("$"))
                        {
                            a = a.Replace("$", "Rp");
                            int i = a.IndexOf(".");
                            a = a.Substring(0, i);
                            a = a.Replace(",", ".");
                            lblTarifLembur.Text = a;
                        }
                    }
                }
                //Menghilangkan tombol delete dan set focus ke isian textbox saat row pada kondisi edit
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    e.Row.FindControl("imgDelete").Visible = false;

                    //this.ScriptManager1.SetFocus(e.Row.FindControl("txtCol1Edit").ClientID);
                }
            }

            //fungsi: menghandle ketika row pada gridview akan di edit,
            //set fokus pada isian di gridview
            protected void GvGolongan_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    GvAllowanceRecap.EditIndex = e.NewEditIndex;
                    GvAllowanceRecap.DataBind();
                    this.ScriptManager1.SetFocus(GvAllowanceRecap.Rows[e.NewEditIndex].Cells[1].FindControl("txtCol1Edit").ClientID);
                }
                else
                {
                    e.Cancel = true;
                }
            }

            //fungsi: menghandle ketika tambah data akan dilakukan
            protected void lnkBtnInsert_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    //Seleksi apakah data kosong atau tidak, 
                    //jika kosong maka proses tambah data dilakukan melalui formView, 
                    //jika tidak kosong maka proses tambah data dilakukan melalui GridView, 
                   
                }
            }

            //fungsi: menghandle ketika tambah data akan dilakukan
            protected void ImgBtnAdd_Click(object sender, ImageClickEventArgs e)
            {
                lnkBtnInsert_Click(sender, e);
            }

          

            //fungsi: menghandle ketika datasource akan melakukan proses insert
            protected void dsAllowanceRecap_Inserting(object sender, SqlDataSourceCommandEventArgs e)
            {
                 
                 
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses insert
            protected void dsAllowanceRecap_Inserted(object sender, SqlDataSourceStatusEventArgs e)
            {
                
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses delete
            protected void dsAllowanceRecap_Deleted(object sender, SqlDataSourceStatusEventArgs e)
            {
                //seleksi apakah ada error (ditandai dengan jumlah baris yg terkena efek, 
                //jika = 0 / tidak ada yg terkena efek maka terjadi error)
                //jika tidak ada error / affectedRow > 0 maka lakukan penulisan log/userAct ke database
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblError.Text;
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Tidak terjadi Error, lakukan penulisan log/userAct ke database
                    azlib.AddUserAct(Session["UserID"].ToString(), "1293", e.Command.Parameters["@KODE_GOLONGAN"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses update
            protected void dsAllowanceRecap_Updated(object sender, SqlDataSourceStatusEventArgs e)
            {
                //seleksi apakah ada error (ditandai dengan jumlah baris yg terkena efek, 
                //jika = 0 / tidak ada yg terkena efek maka terjadi error)
                //jika tidak ada error / affectedRow > 0 maka lakukan penulisan log/userAct ke database
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblError.Text;
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Tidak terjadi Error, lakukan penulisan log/userAct ke database
                    azlib.AddUserAct(Session["UserID"].ToString(), "1292", e.Command.Parameters["@KODE_GOLONGAN"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: pindah halaman/index page dari gridview
            protected void txtHalaman_TextChanged(object sender, System.EventArgs e)
            {
                GridViewRow rowPager = GvAllowanceRecap.BottomPagerRow;
                TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvAllowanceRecap.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvAllowanceRecap.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvAllowanceRecap.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvAllowanceRecap.PageIndex + 1).ToString();
                }
            }
            protected void Button1_Click(object sender, EventArgs e)
            {
                int i;
                int blnAwal = Int32.Parse(ddlBulanAwal.SelectedValue);
                int blnAkhir = Int32.Parse(ddlBulanAkhir.SelectedValue);
                string kodeRapel =  txtTahun.Text.ToString() + "" + ddlBulanAwal.SelectedValue.ToString() + "" + ddlBulanAkhir.SelectedValue.ToString();
                string ckDuplikat = "select COUNT(*) from taRapelTKLog where KODE_RAPEL='" + txtTahun.Text.ToString() + "" + ddlBulanAwal.SelectedValue.ToString() + "" + ddlBulanAkhir.SelectedValue.ToString() + "'";
               
                string sql = "insert into taRapelTKLog (KODE_RAPEL,TAHUN,BULAN_AWAL,BULAN_AKHIR,WAKTU_SIMPAN) VALUES ('" + txtTahun.Text.ToString() + "" + ddlBulanAwal.SelectedValue.ToString() + "" + ddlBulanAkhir.SelectedValue.ToString() + "','" + txtTahun.Text.ToString() + "','0" + ddlBulanAwal.SelectedValue.ToString() + "','"+ddlBulanAkhir.SelectedValue.ToString()+"',GetDate())";

                //proses transaksi perhitungan rapel tunjangan kinerja

                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                using(SqlConnection openCon=new SqlConnection(Application["strCn"].ToString()))
                {
                  using (SqlCommand cekDuplikat = new SqlCommand(ckDuplikat)){
                      cekDuplikat.Connection = openCon;
                      openCon.Open();
                      int userCount = (int)cekDuplikat.ExecuteScalar();
                      if (userCount > 0)
                      {
                          ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "alert('Terdapat Periode Rapel Tunjangan Kinerja Yang Sama');", true);
                         // Response.Write("aya data");
                      }
                      else {
                          for (i = blnAwal; i <= blnAkhir; i++) {
                              using (SqlCommand cmdHitungTK = new SqlCommand("proc_rapel_tk", cn))
                              {
                                  cmdHitungTK.Connection = openCon;
                                  cmdHitungTK.CommandType = CommandType.StoredProcedure;
                                  cmdHitungTK.Parameters.AddWithValue("@KodeRapel", kodeRapel.ToString());
                                  cmdHitungTK.Parameters.AddWithValue("@Bulan", i);
                                  cmdHitungTK.Parameters.AddWithValue("@Tahun", txtTahun.Text);
                                  cmdHitungTK.Parameters.AddWithValue("@Potongan", '1');
                                  cmdHitungTK.Parameters.AddWithValue("@sSqlFilter", "");
                                  cmdHitungTK.CommandTimeout = 1000;
                                  cmdHitungTK.ExecuteNonQuery();

                              }
                          }
                          using (SqlCommand cmdHitungKurang = new SqlCommand("proc_rapel_kekurangan_tk", cn))
                          {
                              cmdHitungKurang.Connection = openCon;
                              cmdHitungKurang.CommandType = CommandType.StoredProcedure;
                              cmdHitungKurang.Parameters.AddWithValue("@KodeRapel", kodeRapel.ToString());
                               
                              cmdHitungKurang.CommandTimeout = 1000;
                              cmdHitungKurang.ExecuteNonQuery();

                          }
                         
                         
                         
                            using(SqlCommand cmd = new SqlCommand(sql))
                                {
                                      cmd.Connection=openCon;
                                     // openCon.Open();
                                      cmd.ExecuteNonQuery();
                                      openCon.Close();
                                }
                      
                      }
                  
                  }

                 
                }
                 
                  dsAllowanceRecap.DataBind();  
                  GvAllowanceRecap.DataBind();

                
            
            }
            protected void GvAllowanceRecap_RowEditing(object sender, GridViewEditEventArgs e)
            {

            }
            protected void GvAllowanceRecap_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                if (e.CommandName == "CetakIndividu")
                {
                    ImageButton b = (ImageButton)e.CommandSource;
                    GridViewRow myRow = (GridViewRow)b.NamingContainer;
                    string KodeRapel = GvAllowanceRecap.DataKeys[myRow.RowIndex].Value.ToString();
                    Session["strKodeRapel"] = KodeRapel;
                    Session["tipeRekap"] = "1";
                    Response.Redirect("allowance_rekap_report.aspx");
                }
                if (e.CommandName == "CetakRekap")
                {
                    ImageButton b = (ImageButton)e.CommandSource;
                    GridViewRow myRow = (GridViewRow)b.NamingContainer;
                    string KodeRapel = GvAllowanceRecap.DataKeys[myRow.RowIndex].Value.ToString();
                    Session["strKodeRapel"] = KodeRapel;
                    Session["tipeRekap"] = "2";
                    Response.Redirect("allowance_rekap_report.aspx");
                }
                if (e.CommandName == "CetakRekapSatker")
                {
                    ImageButton b = (ImageButton)e.CommandSource;
                    GridViewRow myRow = (GridViewRow)b.NamingContainer;
                    string KodeRapel = GvAllowanceRecap.DataKeys[myRow.RowIndex].Value.ToString();
                    Session["strKodeRapel"] = KodeRapel;
                    Session["tipeRekap"] = "3";
                    Response.Redirect("allowance_rekap_report.aspx");
                }
            }
}
}
