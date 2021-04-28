///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : unit.aspx.cs                             (Pseudo code)
//        File terkait  : unit.aspx                                (Form)
//                        \App_LocalResources\unit.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\unit.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel unit (taUnit)
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
		public partial class unit : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;
            
            //fungsi: mengatur Filter dari Gridview
            private void doFiltering()
            {
                string strFilter = "";

                strFilter += "KODE_UNIT <> '-'";
                if (ddlItem0Filter.SelectedValue.Trim() != "-")
                {
                    strFilter += " AND KODE_INSTANSI = '" + ddlItem0Filter.SelectedValue + "'";
                }

                dsUnit.FilterExpression = strFilter;
            }

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GvUnit.Visible = show;
                FvUnit.Visible = !show;
                if (show)
                {
                    FvUnit.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //fungsi: mengatur state ketika page diload ex: seleksi izin akses dan otorisasi
            protected void Page_Load(object sender, System.EventArgs e)
			{
                //seleksi izin akses halaman
                if (!azlib.AksesHalaman(5, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    if (!Page.IsPostBack)
                    {
                        //seleksi jika selain Administrator (Administrator: Session["GradeID"] = 1)
                        if (Session["GradeID"].ToString() != "1")
                        {
                            lnkBtnInsert.Visible = false;
                            ImgBtnAdd.Visible = false;
                            GvUnit.Columns[4].Visible = false;
                            GvUnit.Columns[5].Visible = false;
                        }
                        else
                        {
                            lnkBtnInsert.Visible = false;
                            ImgBtnAdd.Visible = false;
                            GvUnit.Columns[5].Visible = false;
                        }
                    }

                    doFiltering();
                }
			}

            //fungsi: refresh gridview ketika filter berubah
            protected void ddlFilterItemChange(object sender, EventArgs e)
            {
                doFiltering();
                GvUnit.DataBind();
            }
			
            //fungsi: mengatur state Gridview setelah berhasil bound data
			protected void GvUnit_DataBound(object sender, System.EventArgs e)
			{
                //seleksi jumlah data kosong atau tidak
                if (GvUnit.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GvUnit.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GvUnit.PageIndex = GvUnit.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GvUnit.PageIndex + 1);
                        lblJumlahHalaman.Text = GvUnit.PageCount.ToString();
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
            protected void GvUnit_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                // Insert data if the CommandName == "Insert" and the validation controls indicate valid data...
                if (e.CommandName == "Insert" && Page.IsValid)
                {
                    // Insert new record
                    dsUnit.Insert();
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GvUnit.ShowFooter = false;
                }
            }

            //fungsi: mengatur state dari setiap Row pada Gridview
            protected void GvUnit_RowDataBound(object sender, GridViewRowEventArgs e)
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
            protected void GvUnit_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    GvUnit.EditIndex = e.NewEditIndex;
                    GvUnit.DataBind();
                    this.ScriptManager1.SetFocus(GvUnit.Rows[e.NewEditIndex].Cells[1].FindControl("txtCol1Edit").ClientID);
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
                    if (GvUnit.Rows.Count > 0)
                    {
                        //Data tidak kosong
                        sendToLastPage = true;
                        GvUnit.ShowFooter = true;
                        this.ScriptManager1.SetFocus(GvUnit.FooterRow.Cells[0].FindControl("txtCol0Footer").ClientID);
                    }
                    else
                    {
                        //Data Kosong
                        FvUnit.DefaultMode = FormViewMode.Insert;
                        FvUnit.DataBind();//diperlukan jika didalam formview terdapat dropdownlist
                        this.ScriptManager1.SetFocus(FvUnit.FindControl("txtCol0FormView"));
                    }
                }
            }

            //fungsi: menghandle ketika tambah data akan dilakukan
            protected void ImgBtnAdd_Click(object sender, ImageClickEventArgs e)
            {
                lnkBtnInsert_Click(sender, e);
            }

            //fungsi: menghandle ketika terjadi command pada FormView
            protected void FvUnit_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    FvUnit.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //fungsi: menghandle ketika datasource akan melakukan proses insert
            protected void dsUnit_Inserting(object sender, SqlDataSourceCommandEventArgs e)
            {
                //jika tambah data dilakukan melalui gridview/data pada gridview tidak kosong,
                //maka parameter-parameter datasource didapat dr control-control yg ada di footerrow
                //jika tambah data dilakukan melalui FormView,
                //maka parameter-parameter datasource didapat secara otomatis 
                //dr control-control yang sudah melakukan binding yg terdapat di formView 
                if (GvUnit.Rows.Count > 0)
                {
                    TextBox NewKode = (TextBox)GvUnit.FooterRow.FindControl("txtCol0Footer");
                    TextBox NewNamaUnit = (TextBox)GvUnit.FooterRow.FindControl("txtCol1Footer");
                    DropDownList NewKodeInstansi = (DropDownList)GvUnit.FooterRow.FindControl("ddlCol2Footer");
                    DropDownList NewKodeCabang = (DropDownList)GvUnit.FooterRow.FindControl("ddlCol3Footer");
                    
                    e.Command.Parameters["@kode_unit"].Value = NewKode.Text;
                    e.Command.Parameters["@nama_unit"].Value = NewNamaUnit.Text;
                    e.Command.Parameters["@kode_instansi"].Value = NewKodeInstansi.SelectedValue;
                    e.Command.Parameters["@kode_cabang"].Value = NewKodeCabang.SelectedValue;
                }
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses insert
            protected void dsUnit_Inserted(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "1231", e.Command.Parameters["@KODE_UNIT"].Value.ToString(), Application["strCn"].ToString());
                }
                GvUnit.ShowFooter = false;
                showGridView(true);
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses delete
            protected void dsUnit_Deleted(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "1233", e.Command.Parameters["@KODE_UNIT"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses update
            protected void dsUnit_Updated(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "1232", e.Command.Parameters["@KODE_UNIT"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: pindah halaman/index page dari gridview
            protected void txtHalaman_TextChanged(object sender, System.EventArgs e)
            {
                GridViewRow rowPager = GvUnit.BottomPagerRow;
                TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvUnit.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvUnit.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvUnit.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvUnit.PageIndex + 1).ToString();
                }
                
            }
}
}
