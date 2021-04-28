///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : Leave.aspx.cs                              (Pseudo code)

//        File terkait  : Leave.aspx                                 (Form)
//                        \App_LocalResources\Leave.aspx.id.resx     (Display label bahasa Indonesia)
//                        \App_LocalResources\Leave.aspx.en.resx     (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan data master ijin dan pengolahannya

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 11/09/2009
//
// 4. Versi             : 2.0.4
//
// 5. Historis revisi
//        Versi 2.0.1   : Perbaikan bug
//        Versi 2.0.2   : Modifikasi kolom KODE_TIDAK_HADIR
//        Versi 2.0.3   : Penyesuaian kolom
//        Versi 2.0.4   : Implementasi AJAX
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;

	namespace rtwin
	{
		
		public partial class pph_status : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, BULAN_AKHIR sebaliknya
            private void showGridView(Boolean show)
            {
                GvPPHStatus.Visible = show;
            }            
			
			protected void Page_Load(object sender, EventArgs e)
			{
				//jika User yang login tidak memiliki hak untuk mengakses halaman ini maka akan di link halaman Informasi
                if (!rtwin.azlib.AksesHalaman(7, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    if (!Page.IsPostBack)
                    {
                        if (Session["GradeID"].ToString() != "1")
                        {
                            GvPPHStatus.Columns[8].Visible = false;
                            GvPPHStatus.Columns[9].Visible = false;
                        }
                        else
                        {
                            GvPPHStatus.Columns[9].Visible = false;
                        }
                    }
                }
			}

            protected void grdijin_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (GvPPHStatus.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GvPPHStatus.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GvPPHStatus.PageIndex = GvPPHStatus.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GvPPHStatus.PageIndex + 1);
                        lblJumlahHalaman.Text = GvPPHStatus.PageCount.ToString();
                    }
                    showGridView(true);
                }
                else
                {
                    //Data kosong, set gridview visible false, formview visible true
                    showGridView(false);
                }
            }

            protected void grdijin_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
            {
                if (e.CommandName == "Insert")
                {
                    if (Page.IsValid)
                    {
                        dsPPHSTatus.Insert();
                    }
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GvPPHStatus.ShowFooter = false;
                }
            }

            protected void grdijin_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
            {
                //menambahkan State Row on Hover
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    GridView gv = ((GridView)sender);

                    String className = ((e.Row.RowState == DataControlRowState.Alternate) ? gv.AlternatingRowStyle.CssClass : gv.RowStyle.CssClass);

                    e.Row.Attributes.Add("onmouseover", "this.className='datagrid_hovcol';");

                    e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");

                    if ((e.Row.RowState == DataControlRowState.Normal) || (e.Row.RowState == DataControlRowState.Alternate))
                    {
                        if (((Label)e.Row.Cells[3].FindControl("lblCol3Item")).Text == "Bulanan")
                        {
                            ((Label)e.Row.Cells[4].FindControl("lblCol4Item")).Visible = false;
                            ((Label)e.Row.Cells[5].FindControl("lblCol5Item")).Visible = false;
                            ((Label)e.Row.Cells[6].FindControl("lblCol6Item")).Visible = false;
                            ((Label)e.Row.Cells[7].FindControl("lblCol7Item")).Visible = false;
                        }
                        else
                        {
                            ((Label)e.Row.Cells[4].FindControl("lblCol4Item")).Visible = true;
                            ((Label)e.Row.Cells[5].FindControl("lblCol5Item")).Visible = true;
                            ((Label)e.Row.Cells[6].FindControl("lblCol6Item")).Visible = true;
                            ((Label)e.Row.Cells[7].FindControl("lblCol7Item")).Visible = true;
                        }
                    }
                }
                
                //Menghilangkan tombol delete dan set focus ke isian textbox saat row pada kondisi edit
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    e.Row.FindControl("imgDelete").Visible = false;

                    //this.ScriptManager1.SetFocus(e.Row.FindControl("txtCol1Edit").ClientID);

                    //Label lblTahun = (Label)e.Row.Cells[0].FindControl("lblCol0Edit");
                    //Label lblBulan = (Label)e.Row.Cells[1].FindControl("lblCol1Edit");
                    /*
                    DropDownList ddlTipePajak = (DropDownList)e.Row.Cells[3].FindControl("ddlCol3Edit");
                    GridViewRow row = e.Row;
                    if (ddlTipePajak.SelectedValue == "0")
                    {
                        ((DropDownList)row.Cells[4].FindControl("ddlCol4Edit")).Enabled = false;
                        ((TextBox)row.Cells[5].FindControl("txtCol5Edit")).Enabled = false;
                        ((DropDownList)row.Cells[6].FindControl("ddlCol4Edit")).Enabled = false;
                        ((TextBox)row.Cells[7].FindControl("txtCol5Edit")).Enabled = false;
                    }
                    else
                    {
                        //((DropDownList)row.Cells[4].FindControl("ddlCol4Edit")).SelectedValue = lblBulan.Text;
                        //((TextBox)row.Cells[5].FindControl("txtCol5Edit")).Text = lblTahun.Text;
                        //((DropDownList)row.Cells[6].FindControl("ddlCol6Edit")).SelectedValue = lblBulan.Text;
                        //((TextBox)row.Cells[7].FindControl("txtCol7Edit")).Text = lblTahun.Text;
                        ((DropDownList)row.Cells[4].FindControl("ddlCol4Edit")).Enabled = true;
                        ((TextBox)row.Cells[5].FindControl("txtCol5Edit")).Enabled = true;
                        ((DropDownList)row.Cells[6].FindControl("ddlCol4Edit")).Enabled = true;
                        ((TextBox)row.Cells[7].FindControl("txtCol5Edit")).Enabled = true;
                    }
                     */
                }
            }

            protected void GvPPHStatus_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    GvPPHStatus.EditIndex = e.NewEditIndex;
                    GvPPHStatus.DataBind();
                    this.ScriptManager1.SetFocus(GvPPHStatus.Rows[e.NewEditIndex].Cells[0].FindControl("ddlCol3Edit").ClientID);
                }
                else
                {
                    e.Cancel = true;
                }
            }

            protected void dsijin_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter delete maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4912", e.Command.Parameters["@TAHUN"].Value.ToString() + '-' + e.Command.Parameters["@BULAN"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            protected void dsijin_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter update maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text; //+ " (" + e.Exception.Message + ")";
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4912", e.Command.Parameters["@TAHUN"].Value.ToString() + '-' + e.Command.Parameters["@BULAN"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            protected void dsijin_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                if (e.AffectedRows == 0)
                {
                    //menampilkan kesalahan user
                    ExceptionDetails.Text = lblNotSaved.Text + " (" + e.Exception.Message + ")";
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //procedure untuk mencatat event user insert data
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4911", e.Command.Parameters["@TAHUN"].Value.ToString() + '-' + e.Command.Parameters["@BULAN"].Value.ToString(), Application["strCn"].ToString());
                }
                GvPPHStatus.ShowFooter = false;
                showGridView(true);
            }

            protected void dsijin_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
			{
                GridViewRow rowPager = GvPPHStatus.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvPPHStatus.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvPPHStatus.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvPPHStatus.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvPPHStatus.PageIndex + 1).ToString();
                }
			}

}
	}
