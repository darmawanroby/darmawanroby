///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : eselon.aspx.cs                             (Pseudo code)
//        File terkait  : eselon.aspx                                (Form)
//                        \App_LocalResources\eselon.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\eselon.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel Eselon (taEselon)
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
    public partial class eselon : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GvEchelon.Visible = show;
                FvEchelon.Visible = !show;
                if (show)
                {
                    FvEchelon.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //fungsi: mengatur state ketika page diload ex: seleksi izin akses dan otorisasi
            protected void Page_Load(object sender, System.EventArgs e)
			{
                //seleksi izin akses halaman
                if (!azlib.AksesHalaman(9, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    //seleksi jika selain Administrator (Administrator: Session["GradeID"] = 1)
                    if ((!Page.IsPostBack) && (Session["GradeID"].ToString() != "1"))
                    {
                        lnkBtnInsert.Visible = false;
                        ImgBtnAdd.Visible = false;
                        GvEchelon.Columns[2].Visible = false;
                        GvEchelon.Columns[3].Visible = false;
                    }
                }
			}
			
            //fungsi: mengatur state Gridview setelah berhasil bound data
			protected void GvEchelon_DataBound(object sender, System.EventArgs e)
			{
                //seleksi jumlah data kosong atau tidak
                if (GvEchelon.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GvEchelon.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GvEchelon.PageIndex = GvEchelon.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GvEchelon.PageIndex + 1);
                        lblJumlahHalaman.Text = GvEchelon.PageCount.ToString();
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
            protected void GvEchelon_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                // Insert data if the CommandName == "Insert" and the validation controls indicate valid data...
                if (e.CommandName == "Insert" && Page.IsValid)
                {
                    // Insert new record
                    dsEchelon.Insert();
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GvEchelon.ShowFooter = false;
                }
            }

            //fungsi: mengatur state dari setiap Row pada Gridview
            protected void GvEchelon_RowDataBound(object sender, GridViewRowEventArgs e)
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
            protected void GvEchelon_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    GvEchelon.EditIndex = e.NewEditIndex;
                    GvEchelon.DataBind();
                    this.ScriptManager1.SetFocus(GvEchelon.Rows[e.NewEditIndex].Cells[1].FindControl("txtCol1Edit").ClientID);
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
                    if (GvEchelon.Rows.Count > 0)
                    {
                        //Data tidak kosong
                        sendToLastPage = true;
                        GvEchelon.ShowFooter = true;
                        this.ScriptManager1.SetFocus(GvEchelon.FooterRow.Cells[0].FindControl("txtCol0Footer").ClientID);
                    }
                    else
                    {
                        //Data Kosong
                        FvEchelon.DefaultMode = FormViewMode.Insert;
                        this.ScriptManager1.SetFocus(FvEchelon.FindControl("txtCol0FormView"));
                    }
                }
            }

            //fungsi: menghandle ketika tambah data akan dilakukan
            protected void ImgBtnAdd_Click(object sender, ImageClickEventArgs e)
            {
                lnkBtnInsert_Click(sender, e);
            }

            //fungsi: menghandle ketika terjadi command pada FormView
            protected void FvEchelon_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    FvEchelon.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //fungsi: menghandle ketika datasource akan melakukan proses insert
            protected void dsEchelon_Inserting(object sender, SqlDataSourceCommandEventArgs e)
            {
                //jika tambah data dilakukan melalui gridview/data pada gridview tidak kosong,
                //maka parameter-parameter datasource didapat dr control-control yg ada di footerrow
                //jika tambah data dilakukan melalui FormView,
                //maka parameter-parameter datasource didapat secara otomatis 
                //dr control-control yang sudah melakukan binding yg terdapat di formView 
                if (GvEchelon.Rows.Count > 0)
                {
                    TextBox NewKode = (TextBox)GvEchelon.FooterRow.FindControl("txtCol0Footer");
                    TextBox NewNamaEselon = (TextBox)GvEchelon.FooterRow.FindControl("txtCol1Footer");

                    e.Command.Parameters["@kode_eselon"].Value = NewKode.Text;
                    e.Command.Parameters["@nama_eselon"].Value = NewNamaEselon.Text;
                }
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses insert
            protected void dsEchelon_Inserted(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "12B1", e.Command.Parameters["@KODE_ESELON"].Value.ToString(), Application["strCn"].ToString());
                }
                GvEchelon.ShowFooter = false;
                showGridView(true);
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses delete
            protected void dsEchelon_Deleted(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "12B3", e.Command.Parameters["@KODE_ESELON"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses update
            protected void dsEchelon_Updated(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "12B2", e.Command.Parameters["@KODE_ESELON"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: pindah halaman/index page dari gridview
            protected void txtHalaman_TextChanged(object sender, System.EventArgs e)
            {
                GridViewRow rowPager = GvEchelon.BottomPagerRow;
                TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvEchelon.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvEchelon.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvEchelon.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvEchelon.PageIndex + 1).ToString();
                }                
            }
}
}
