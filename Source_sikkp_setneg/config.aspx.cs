///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : config.aspx.cs                  (Pseudo code)

//        File terkait  : config.aspx                                (Form)
//                        config.aspx.cs                             (pseudo code)
//                        \App_LocalResources\config.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\config.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                        (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : mengedit tabel Variabel (taVariabel)

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 11/09/2009
//
// 4. Versi             : 2.0.2
//
// 5. Historis revisi
//        Versi 2.0.1   : Validasi Update Config
//        Versi 2.0.2   : Implementasi AJAX
//
//
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;

	namespace rtwin
	{
		
		public partial class config : BasePage
		{
			
			private void Page_Load(object sender, EventArgs e)
			{
				if (! rtwin.azlib.AksesHalaman(29, Session["UserID"].ToString().ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}
                else if (Session["GradeID"].ToString() == "1a") //keuangan
                {
                    Response.Redirect("config2.aspx");
                }

			}

            protected void dsVariable_Updated(object sender, SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter update maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblConfigNotUpdated.Text + " - " + e.Exception.Message; //& " (" & e.Exception.Message & ")"
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4405", "", Application["strCn"].ToString().ToString());
                    ExceptionDetails.Text = lblConfigUpdated.Text;
                }
            }

            protected void dsVariable_Updating(object sender, SqlDataSourceCommandEventArgs e)
            {
                try
                {
                    TextBox TutupPeriode = (TextBox)FvVariable.FindControl("txtCol1Item1");
                    TextBox DefLimitAwal = (TextBox)FvVariable.FindControl("txtCol1Item2");
                    TextBox DefLimitAkhir = (TextBox)FvVariable.FindControl("txtCol1Item3");
                    TextBox BatasMasukUlang = (TextBox)FvVariable.FindControl("txtCol1Item4");

                    if (TutupPeriode.Text.Trim() != "")
                    { 
                        e.Command.Parameters["@TUTUP_PERIODE"].Value = DateTime.Parse(TutupPeriode.Text);
                    }
                    if (DefLimitAwal.Text.Trim() != "")
                    {
                        e.Command.Parameters["@DEF_LIMIT_AWAL"].Value = DateTime.Parse("1/1/1900 " + DefLimitAwal.Text + ":00");
                    }
                    if (DefLimitAkhir.Text.Trim() != "")
                    {
                        e.Command.Parameters["@DEF_LIMIT_AKHIR"].Value = DateTime.Parse("1/1/1900 " + DefLimitAkhir.Text + ":00");
                    }
                    if (BatasMasukUlang.Text.Trim() != "")
                    {
                        e.Command.Parameters["@BATAS_MASUK_ULANG"].Value = DateTime.Parse("1/1/1900 " + BatasMasukUlang.Text + ":00");
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblConfigNotUpdated.Text + " (" + ex.Message + ")";
                    e.Cancel = true;
                }
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GVCabang.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GVCabang.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GVCabang.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GVCabang.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GVCabang.PageIndex + 1).ToString();
                }
            }

            protected void GVCabang_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (GVCabang.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GVCabang.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GVCabang.PageIndex + 1);
                        lblJumlahHalaman.Text = GVCabang.PageCount.ToString();
                    }
                }
            }

            protected void GVCabang_RowDataBound(object sender, GridViewRowEventArgs e)
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
            protected void btnUpdateFlexi_Click(object sender, EventArgs e)
            {
                UpdateFlexi();
            }

            public void UpdateFlexi()
            {
                string strCn;
                strCn = Application["strCn"].ToString();
                SqlConnection cn;
                cn = new SqlConnection(strCn);

                SqlCommand cmd = new SqlCommand("proc_update_flexi", cn);

                cmd.CommandTimeout = 36000;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cn.Open();
                cmd.CommandTimeout = 36000;

                try
                {
                    cmd.ExecuteNonQuery();
                    ExceptionDetails.Text = "Proses Update Flexi Berhasil";
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = ex.Message;
                }

                cn.Close();
            }

        }
		
	}
