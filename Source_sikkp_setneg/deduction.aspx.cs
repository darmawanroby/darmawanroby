///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : deduction.aspx.cs                             (Pseudo code)
//        File terkait  : deduction.aspx                                (Form)
//                        \App_LocalResources\deduction.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\deduction.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan daftar nilai potongan kedisiplinan
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
//        Versi 2.0.1   : Pembatasan hak entry tambah, edit, hapus menjadi read-only keuali bagi administrator
//        Versi 2.0.2   : Menggunakan AJAX
//
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;

namespace rtwin
	{
		public partial class group : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GvPotongan.Visible = show;
                FvPotongan.Visible = !show;
                if (show)
                {
                    FvPotongan.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //fungsi: mengatur state ketika page diload ex: seleksi izin akses dan otorisasi
            protected void Page_Load(object sender, System.EventArgs e)
			{
                //seleksi izin akses halaman
                if (!azlib.AksesHalaman(31, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    //seleksi jika selain Administrator (Administrator: Session["GradeID"] = 1)
                    if (Session["GradeID"].ToString() != "1")
                    {
                        lnkBtnInsert.Visible = false;
                        ImgBtnAdd.Visible = false;
                        GvPotongan.Columns[4].Visible = false;
                        GvPotongan.Columns[5].Visible = false;
                    }
                }
			}
			
            //fungsi: mengatur state Gridview setelah berhasil bound data
			protected void GvPotongan_DataBound(object sender, System.EventArgs e)
			{
                //seleksi jumlah data kosong atau tidak
                if (GvPotongan.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GvPotongan.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GvPotongan.PageIndex = GvPotongan.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GvPotongan.PageIndex + 1);
                        lblJumlahHalaman.Text = GvPotongan.PageCount.ToString();
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
            protected void GvPotongan_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                // Insert data if the CommandName == "Insert" and the validation controls indicate valid data...
                if (e.CommandName == "Insert" && Page.IsValid)
                {
                    // Insert new record
                    dsPotongan.Insert();
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GvPotongan.ShowFooter = false;
                }
            }

            //fungsi: mengatur state dari setiap Row pada Gridview
            protected void GvPotongan_RowDataBound(object sender, GridViewRowEventArgs e)
            {
                //menambahkan State Row on Hover
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    GridView gv = ((GridView)sender);

                    String className = ((e.Row.RowState == DataControlRowState.Alternate) ? gv.AlternatingRowStyle.CssClass : gv.RowStyle.CssClass);

                    e.Row.Attributes.Add("onmouseover", "this.className='datagrid_hovcol';");

                    e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");

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
            protected void GvPotongan_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    GvPotongan.EditIndex = e.NewEditIndex;
                    GvPotongan.DataBind();
                    this.ScriptManager1.SetFocus(GvPotongan.Rows[e.NewEditIndex].Cells[1].FindControl("txtCol1Edit").ClientID);
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
                    if (GvPotongan.Rows.Count > 0)
                    {
                        //Data tidak kosong
                        sendToLastPage = true;
                        GvPotongan.ShowFooter = true;
                        this.ScriptManager1.SetFocus(GvPotongan.FooterRow.Cells[0].FindControl("txtCol0Footer").ClientID);
                    }
                    else
                    {
                        //Data Kosong
                        FvPotongan.DefaultMode = FormViewMode.Insert;
                        this.ScriptManager1.SetFocus(FvPotongan.FindControl("txtCol0FormView"));
                    }
                }
            }

            //fungsi: menghandle ketika tambah data akan dilakukan
            protected void ImgBtnAdd_Click(object sender, ImageClickEventArgs e)
            {
                lnkBtnInsert_Click(sender, e);
            }

            //fungsi: menghandle ketika terjadi command pada FormView
            protected void FvPotongan_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    FvPotongan.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //fungsi: menghandle ketika datasource akan melakukan proses insert
            protected void dsPotongan_Inserting(object sender, SqlDataSourceCommandEventArgs e)
            {
                //jika tambah data dilakukan melalui gridview/data pada gridview tidak kosong,
                //maka parameter-parameter datasource didapat dr control-control yg ada di footerrow
                //jika tambah data dilakukan melalui FormView,
                //maka parameter-parameter datasource didapat secara otomatis 
                //dr control-control yang sudah melakukan binding yg terdapat di formView 
                if (GvPotongan.Rows.Count > 0)
                {
                    TextBox NewKode = (TextBox)GvPotongan.FooterRow.FindControl("txtCol0Footer");
                    TextBox NewKetPotongan = (TextBox)GvPotongan.FooterRow.FindControl("txtCol1Footer");
                    TextBox NewPersenPotongan= (TextBox)GvPotongan.FooterRow.FindControl("txtCol2Footer");
                    DropDownList NewTipePotongan = (DropDownList)GvPotongan.FooterRow.FindControl("ddlCol3Footer");

                    e.Command.Parameters["@KODE_POTONGAN"].Value = NewKode.Text;
                    e.Command.Parameters["@KET_POTONGAN"].Value = NewKetPotongan.Text;
                    if (NewPersenPotongan.Text.Trim() != "")
                    {
                        e.Command.Parameters["@PERSEN_POTONGAN"].Value = int.Parse(NewPersenPotongan.Text);
                    }
                    e.Command.Parameters["@TIPE_POTONGAN"].Value = NewTipePotongan.SelectedValue;
                }
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses insert
            protected void dsPotongan_Inserted(object sender, SqlDataSourceStatusEventArgs e)
            {
                //seleksi apakah ada error (ditandai dengan jumlah baris yg terkena efek, 
                //jika = 0 / tidak ada yg terkena efek maka terjadi error)
                //jika tidak ada error / affectedRow > 0 maka lakukan penulisan log/userAct ke database
                if (e.AffectedRows == 0)
                {
                    //kemungkinan terjadi error
                    ExceptionDetails.Text = lblError.Text;
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Tidak terjadi Error, lakukan penulisan log/userAct ke database
                    azlib.AddUserAct(Session["UserID"].ToString(), "1291", e.Command.Parameters["@KODE_POTONGAN"].Value.ToString(), Application["strCn"].ToString());
                }
                GvPotongan.ShowFooter = false;
                showGridView(true);
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses delete
            protected void dsPotongan_Deleted(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "1293", e.Command.Parameters["@KODE_POTONGAN"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses update
            protected void dsPotongan_Updated(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "1292", e.Command.Parameters["@KODE_POTONGAN"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: pindah halaman/index page dari gridview
            protected void txtHalaman_TextChanged(object sender, System.EventArgs e)
            {
                GridViewRow rowPager = GvPotongan.BottomPagerRow;
                TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvPotongan.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvPotongan.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvPotongan.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvPotongan.PageIndex + 1).ToString();
                }
            }
 }
}
