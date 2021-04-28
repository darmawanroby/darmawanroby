///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : subdivision.aspx.cs                             (Pseudo code)
//        File terkait  : subdivision.aspx                                (Form)
//                        \App_LocalResources\subdivision.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\subdivision.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel Sub Bagian (taSubBagian)
//
// 2. Penulis Program
//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 11/09/2009
//
// 4. Versi             : 2.0.3
//
// 5. Historis revisi
//        Versi 2.0.1   : Pembatasan hak entry tambah, edit, hapus menjadi read-only keuali bagi administrator
//        Versi 2.0.2   : Menggunakan AJAX
//        Versi 2.0.2   : Penyempurnaan Filter
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
    public partial class subdivision : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;
            
            //fungsi: mengatur Filter dari Gridview
            private void doFiltering()
            {
                string strFilter = "";

                strFilter += "KODE_SUBBAGIAN <> '000000'";
                if (ddlItem0Filter.SelectedValue.Trim() != "-")
                {
                    strFilter += " AND KODE_INSTANSI = '" + ddlItem0Filter.SelectedValue + "'";
                }

                if (ddlItem1Filter.SelectedValue.Trim() != "-")
                {
                        strFilter += " AND KODE_UNIT = '" + ddlItem1Filter.SelectedValue + "'";
                }

                if (ddlItem2Filter.SelectedValue.Trim() != "000")
                {
                        strFilter += " AND KODE_DEPUTI = '" + ddlItem2Filter.SelectedValue + "'";
                }

                if (ddlItem3Filter.SelectedValue.Trim() != "0000")
                {
                        strFilter += " AND KODE_BIRO = '" + ddlItem3Filter.SelectedValue + "'";
                }

                if (ddlItem4Filter.SelectedValue.Trim() != "00000")
                {
                        strFilter += " AND KODE_BAGIAN = '" + ddlItem4Filter.SelectedValue + "'";
                }

                dsSubDivision.FilterExpression = strFilter;
            }

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GvSubBagian.Visible = show;
                FvSubBagian.Visible = !show;
                if (show)
                {
                    FvSubBagian.DefaultMode = FormViewMode.ReadOnly;
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
                    //seleksi jika selain Administrator (Administrator: Session["GradeID"] = 1)
                    //if (Session["GradeID"].ToString() != "1")
                    //{
                    if (!Page.IsPostBack)
                    {
                        lnkBtnInsert.Visible = false;
                        ImgBtnAdd.Visible = false;
                        GvSubBagian.Columns[3].Visible = false;
                        GvSubBagian.Columns[4].Visible = false;
                    }
                    //}
                }

                doFiltering();
            }

            //fungsi: refresh Dropdownlist
            protected void ddlItem0Filter_SelectedIndexChanged(object sender, EventArgs e)
            {
                string Filter = "";
                ViewState["strDSUnitFilter"] = "SELECT KODE_UNIT FROM taUnit";
                if (ddlItem0Filter.SelectedValue.Trim() != "-")
                {
                    Filter = " WHERE KODE_INSTANSI = '" + ddlItem0Filter.SelectedValue + "' or KODE_UNIT = '-'";
                    dsUnitFilter.SelectCommand += Filter;
                    ViewState["strDSUnitFilter"] = ViewState["strDSUnitFilter"].ToString() + Filter;
                }
                ddlItem1Filter.DataBind();
            }

            //fungsi: refresh Dropdownlist
            protected void ddlItem1Filter_SelectedIndexChanged(object sender, EventArgs e)
            {
                string Filter = "";
                ViewState["strDSDeputiFilter"] = "SELECT KODE_DEPUTI FROM taDeputi";
                if (ddlItem1Filter.SelectedValue.Trim() != "-")
                {
                    Filter = " WHERE KODE_UNIT = '" + ddlItem1Filter.SelectedValue + "' or KODE_DEPUTI = '000'";
                    dsDeputiFilter.SelectCommand += Filter;
                    ViewState["strDSDeputiFilter"] = ViewState["strDSDeputiFilter"].ToString() + Filter;
                }
                else
                {
                    Filter = " WHERE KODE_UNIT IN (" + ViewState["strDSUnitFilter"].ToString() + ")";
                    dsDeputiFilter.SelectCommand += Filter;
                    ViewState["strDSDeputiFilter"] = ViewState["strDSDeputiFilter"].ToString() + Filter;
                }
                ddlItem2Filter.DataBind();
            }

            //fungsi: refresh Dropdownlist
            protected void ddlItem2Filter_SelectedIndexChanged(object sender, EventArgs e)
            {
                string Filter = "";
                ViewState["strDSBiroFilter"] = "SELECT KODE_BIRO from taBiro";
                if (ddlItem2Filter.SelectedValue.Trim() != "000")
                {
                    Filter = " WHERE KODE_DEPUTI = '" + ddlItem2Filter.SelectedValue + "' or KODE_BIRO = '0000'";
                    dsBiroFilter.SelectCommand += Filter;
                    ViewState["strDSBiroFilter"] = ViewState["strDSBiroFilter"].ToString() + Filter;
                }
                else
                {
                    Filter = " WHERE KODE_DEPUTI IN (" + ViewState["strDSDeputiFilter"].ToString() + ")";
                    dsBiroFilter.SelectCommand += Filter;
                    ViewState["strDSBiroFilter"] = ViewState["strDSBiroFilter"].ToString() + Filter;
                }
                ddlItem3Filter.DataBind();
            }

            //fungsi: refresh Dropdownlist
            protected void ddlItem3Filter_SelectedIndexChanged(object sender, EventArgs e)
            {
                string Filter = "";
                ViewState["strDSDivisionFilter"] = "SELECT KODE_BAGIAN FROM taBagian";
                if (ddlItem3Filter.SelectedValue.Trim() != "0000")
                {
                    Filter = " WHERE KODE_BIRO = '" + ddlItem3Filter.SelectedValue + "' or KODE_BAGIAN = '00000'";
                    dsDivisionFilter.SelectCommand += Filter;
                    ViewState["strDSDivisionFilter"] = ViewState["strDSDivisionFilter"].ToString() + Filter;
                }
                else
                {
                    Filter = " WHERE KODE_BIRO IN (" + ViewState["strDSBiroFilter"].ToString() + ")";
                    dsDivisionFilter.SelectCommand += Filter;
                    ViewState["strDSDivisionFilter"] = ViewState["strDSDivisionFilter"].ToString() + Filter;
                }
                ddlItem4Filter.DataBind();
            }

            //fungsi: refresh gridview ketika filter berubah
            protected void ddlFilterItemChange(object sender, EventArgs e)
            {
                doFiltering();
                GvSubBagian.DataBind();
            }
			
            //fungsi: mengatur state Gridview setelah berhasil bound data
			protected void GvSubBagian_DataBound(object sender, System.EventArgs e)
			{
                //seleksi jumlah data kosong atau tidak
                if (GvSubBagian.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GvSubBagian.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GvSubBagian.PageIndex = GvSubBagian.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GvSubBagian.PageIndex + 1);
                        lblJumlahHalaman.Text = GvSubBagian.PageCount.ToString();
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
            protected void GvSubBagian_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                // Insert data if the CommandName == "Insert" and the validation controls indicate valid data...
                if (e.CommandName == "Insert" && Page.IsValid)
                {
                    // Insert new record
                    dsSubDivision.Insert();
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GvSubBagian.ShowFooter = false;
                }
            }

            //fungsi: mengatur state dari setiap Row pada Gridview
            protected void GvSubBagian_RowDataBound(object sender, GridViewRowEventArgs e)
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
            protected void GvSubBagian_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    GvSubBagian.EditIndex = e.NewEditIndex;
                    GvSubBagian.DataBind();
                    this.ScriptManager1.SetFocus(GvSubBagian.Rows[e.NewEditIndex].Cells[1].FindControl("txtCol1Edit").ClientID);
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
                    if (GvSubBagian.Rows.Count > 0)
                    {
                        //Data tidak kosong
                        sendToLastPage = true;
                        GvSubBagian.ShowFooter = true;
                        this.ScriptManager1.SetFocus(GvSubBagian.FooterRow.Cells[0].FindControl("txtCol0Footer").ClientID);
                    }
                    else
                    {
                        //Data Kosong
                        FvSubBagian.DefaultMode = FormViewMode.Insert;
                        FvSubBagian.DataBind();//diperlukan jika didalam formview terdapat dropdownlist
                        this.ScriptManager1.SetFocus(FvSubBagian.FindControl("txtCol0FormView"));
                    }
                }
            }

            //fungsi: menghandle ketika tambah data akan dilakukan
            protected void ImgBtnAdd_Click(object sender, ImageClickEventArgs e)
            {
                lnkBtnInsert_Click(sender, e);
            }

            //fungsi: menghandle ketika terjadi command pada FormView
            protected void FvSubBagian_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    FvSubBagian.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //fungsi: menghandle ketika datasource akan melakukan proses insert
            protected void dsSubBagian_Inserting(object sender, SqlDataSourceCommandEventArgs e)
            {
                //jika tambah data dilakukan melalui gridview/data pada gridview tidak kosong,
                //maka parameter-parameter datasource didapat dr control-control yg ada di footerrow
                //jika tambah data dilakukan melalui FormView,
                //maka parameter-parameter datasource didapat secara otomatis 
                //dr control-control yang sudah melakukan binding yg terdapat di formView 
                if (GvSubBagian.Rows.Count > 0)
                {
                    TextBox NewKode = (TextBox)GvSubBagian.FooterRow.FindControl("txtCol0Footer");
                    TextBox NewNamaSubBagian = (TextBox)GvSubBagian.FooterRow.FindControl("txtCol1Footer");
                    DropDownList NewKodeBagian = (DropDownList)GvSubBagian.FooterRow.FindControl("ddlCol2Footer");
                    
                    e.Command.Parameters["@kode_subbagian"].Value = NewKode.Text;
                    e.Command.Parameters["@nama_subbagian"].Value = NewNamaSubBagian.Text;
                    e.Command.Parameters["@kode_bagian"].Value = NewKodeBagian.SelectedValue;
                }
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses insert
            protected void dsSubBagian_Inserted(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "1271", e.Command.Parameters["@KODE_SUBBAGIAN"].Value.ToString(), Application["strCn"].ToString());
                }
                GvSubBagian.ShowFooter = false;
                showGridView(true);
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses delete
            protected void dsSubBagian_Deleted(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "1273", e.Command.Parameters["@KODE_SUBBAGIAN"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: menghandle ketika datasource telah selesai melakukan proses update
            protected void dsSubBagian_Updated(object sender, SqlDataSourceStatusEventArgs e)
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
                    azlib.AddUserAct(Session["UserID"].ToString(), "1272", e.Command.Parameters["@KODE_SUBBAGIAN"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //fungsi: pindah halaman/index page dari gridview
            protected void txtHalaman_TextChanged(object sender, System.EventArgs e)
            {
                GridViewRow rowPager = GvSubBagian.BottomPagerRow;
                TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvSubBagian.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvSubBagian.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvSubBagian.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvSubBagian.PageIndex + 1).ToString();
                }
            }
}
}
