///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : shift.aspx.cs                             (Pseudo code)

//        File terkait  : shift.aspx                                (Form)
//                        \App_LocalResources\shift.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\shift.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                        (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel Pola (taPola)

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
//        Versi 2.0.1   : Penambahan kolom libur nasional
//        Versi 2.0.2   : Penambahan kolom direktorat / satker
//        Versi 2.0.3   : Penggabungan halaman Insert,Edit dan View
//        Versi 2.0.4   : Implementasi AJAX
//
//
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;
using System.Collections;

	namespace rtwin
	{		
		public partial class shift : BasePage
		{
            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                gvMingguan.Visible = show;
                fvInsertMingguan.Visible = !show;
                gvHarian.Visible = show;
                fvInsertHarian.Visible = !show;
            }

            private void setTitleMingguan(Boolean state)
            {
                LblTitle.Visible = state;
                Label23.Visible = !state;
            }

            //method yang dieksekusi ketika halaman di load
            protected void Page_Load(object sender, EventArgs e)
            {
                //Seleksi Hak akses Halaman
                if (!rtwin.azlib.AksesHalaman(2, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    //Redirect ke page notauthorized.aspx bila tidak berhak mengakses
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    if (!Page.IsPostBack)
                    {
                        MultiView1.ActiveViewIndex = 0;
                        setTitleMingguan(true);

                        if (Session["GradeID"].ToString() != "1")
                        {
                            lblTambah_1.Visible = false;
                            btnAdd.Visible = false;
                            lblTambah_2.Visible = false;
                            btnAdd2.Visible = false;
                            gvMingguan.Columns[11].Visible = false;
                            gvMingguan.Columns[12].Visible = false;
                            gvHarian.Columns[36].Visible = false;
                            gvHarian.Columns[37].Visible = false;
                        }
                    }
                }
            }

            //method yang berfungsi untuk men-set view menunjuk ke view Mingguan
            protected void LinkButton1_Click(object sender, EventArgs e)
            {
                MultiView1.ActiveViewIndex = 0;
            }

            //method yang berfungsi untuk men-set view menunjuk ke view harian
            protected void LinkButton2_Click(object sender, EventArgs e)
            {
                MultiView1.ActiveViewIndex = 1;
            }

            protected void lblTambah_1_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    fvInsertMingguan.DefaultMode = FormViewMode.Insert;
                    fvInsertMingguan.ChangeMode(FormViewMode.Insert);
                    showGridView(false);
                }
            }

            protected void lblTambah_2_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    fvInsertHarian.DefaultMode = FormViewMode.Insert;
                    fvInsertHarian.ChangeMode(FormViewMode.Insert);
                    showGridView(false);
                }
            }

            //method yang dieksekusi ketika button add di klik
            //fungsinya untuk menampilkan formview lalu menghide gridview
            protected void btnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lblTambah_1_Click(sender, e);
            }

            protected void btnAdd2_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lblTambah_2_Click(sender, e);
            }

            protected void MultiView1_ActiveViewChanged(object sender, EventArgs e)
            {
                showGridView(true);
                if (MultiView1.ActiveViewIndex == 0)
                {
                    setTitleMingguan(true);
                }
                else
                {
                    setTitleMingguan(false);
                }
            }

            protected void gvMingguan_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (gvMingguan.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = gvMingguan.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(gvMingguan.PageIndex + 1);
                        lblJumlahHalaman.Text = gvMingguan.PageCount.ToString();
                    }
                    showGridView(true);
                }
                else
                {
                    //Data kosong, set gridview visible false, formview visible true
                    showGridView(false);
                }
            }

            protected void gvHarian_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (gvHarian.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = gvHarian.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(gvHarian.PageIndex + 1);
                        lblJumlahHalaman.Text = gvHarian.PageCount.ToString();
                    }
                    showGridView(true);
                }
                else
                {
                    //Data kosong, set gridview visible false, formview visible true
                    showGridView(false);
                }
            }

            //method yang berfungsi untuk menyisipkan javascript pada button delete
            //agar menampilkan message dialog terlebih dahulu
            protected void GridView1_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
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

            //method yang dieksekusi ketika selesai melakukan peng hapusan dari database
            protected void ds_Shift_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter delete maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotEditApproved.Text; //& "(" & e.Exception.Message & ")"
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1123", e.Command.Parameters["@KODE_SHIFT"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //method yang dieksekusi setelah melakukan penginputan ke database
            //setelah input seleksi apakah terjadi error atau tidak
            //jika tidak terjadi error maka catat ke log
            protected void ds_shift2_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text; //+ " (" & e.Exception.Message & ")"
                    ExceptionDetails.Visible = true;
                    //Session["salahInput"] = lblCannotUpdate.Text; //& " (" & e.Exception.Message & ")"
                    e.ExceptionHandled = true;
                }
                else
                {
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1121", e.Command.Parameters["@KODE_SHIFT"].Value.ToString(), Application["strCn"].ToString());
                    //gvMingguan.DataBind()
                }
                //Server.Transfer("shift.aspx");
                clearFormMingguan();
                showGridView(true);
            }

            //method yang dieksekusi sebelum melakukan penginputan ke database
            //sebelum input mengambil nilai-nilai dari dropdownlist
            //untuk diinputkan ke parameter pada query database
            protected void ds_shift2_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                TextBox txtGroup = (TextBox)fvInsertMingguan.FindControl("txtGroup");
                DropDownList DropMinggu = (DropDownList)fvInsertMingguan.FindControl("DropDownList1");
                DropDownList DropSenin = (DropDownList)fvInsertMingguan.FindControl("DropDownList2");
                DropDownList DropSelasa = (DropDownList)fvInsertMingguan.FindControl("DropDownList3");
                DropDownList DropRabu = (DropDownList)fvInsertMingguan.FindControl("DropDownList4");
                DropDownList DropKamis = (DropDownList)fvInsertMingguan.FindControl("DropDownList5");
                DropDownList DropJumat = (DropDownList)fvInsertMingguan.FindControl("DropDownList6");
                DropDownList DropSabtu = (DropDownList)fvInsertMingguan.FindControl("DropDownList7");

                string kode_shift = "M" + txtGroup.Text;
                string Format = DropMinggu.SelectedValue + DropSenin.SelectedValue + DropSelasa.SelectedValue + DropRabu.SelectedValue + DropKamis.SelectedValue + DropJumat.SelectedValue + DropSabtu.SelectedValue;
                e.Command.Parameters["@KODE_SHIFT"].Value = kode_shift;
                e.Command.Parameters["@FORMAT"].Value = Format;
            }

            //method yang dieksekusi setelah melakukan pengupdatean ke database
            protected void ds_Shift_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                if (e.AffectedRows == 0)
                {
                    //seleksi apakah terdapat error atau tidak
                    //jika tidak terdapat error maka catat ke log lalu redirect ke shift.aspx
                    ExceptionDetails.Text = lblCannotUpdate.Text;// +" (" + e.Exception.Message + ")";
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1122", e.Command.Parameters["@KODE_SHIFT"].Value.ToString(), Application["strCn"].ToString());                    
                }
                //clearFormMingguan(false);
                showGridView(true);
            }

            protected void ds_Shift_Updating(object sender, SqlDataSourceCommandEventArgs e)
            {
                DropDownList DropMinggu = (DropDownList)fvInsertMingguan.FindControl("DropDownList1");
                DropDownList DropSenin = (DropDownList)fvInsertMingguan.FindControl("DropDownList2");
                DropDownList DropSelasa = (DropDownList)fvInsertMingguan.FindControl("DropDownList3");
                DropDownList DropRabu = (DropDownList)fvInsertMingguan.FindControl("DropDownList4");
                DropDownList DropKamis = (DropDownList)fvInsertMingguan.FindControl("DropDownList5");
                DropDownList DropJumat = (DropDownList)fvInsertMingguan.FindControl("DropDownList6");
                DropDownList DropSabtu = (DropDownList)fvInsertMingguan.FindControl("DropDownList7");

                string Format = DropMinggu.SelectedValue + DropSenin.SelectedValue + DropSelasa.SelectedValue + DropRabu.SelectedValue + DropKamis.SelectedValue + DropJumat.SelectedValue + DropSabtu.SelectedValue;
                e.Command.Parameters["@FORMAT"].Value = Format;
            }

            protected void fvInsertMingguan_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel_Mingguan")
                {
                    clearFormMingguan();
                    showGridView(true);
                }
                else if (e.CommandName == "Cancel_Edit_Mingguan")
                {
                    showGridView(true);
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    clearFormHarian();
                    showGridView(true);
                }
                else if (e.CommandName == "Cancel_Edit_Harian")
                {
                    showGridView(true);
                }
            }

            protected void gvMingguan_RowCommand(object sender, GridViewCommandEventArgs e)
            {

                if (e.CommandName == "Edit_Mingguan")
                {
                    if (Page.IsValid)
                    {
                        fvInsertMingguan.DefaultMode = FormViewMode.Edit;
                        fvInsertMingguan.ChangeMode(FormViewMode.Edit);
                        ds_Shift.FilterExpression = "SUBSTRING(KODE_SHIFT, 1, 1) = 'M' AND KODE_SHIFT = '" + e.CommandArgument.ToString() + "'";
                        showGridView(false);
                    }
                }
                else if (e.CommandName == "Edit_Harian")
                {
                    if (Page.IsValid)
                    {
                        fvInsertHarian.DefaultMode = FormViewMode.Edit;
                        fvInsertHarian.ChangeMode(FormViewMode.Edit);
                        ds_shift3.FilterExpression = "SUBSTRING(KODE_SHIFT, 1, 1) = 'N' AND KODE_SHIFT = '" + e.CommandArgument.ToString() + "'";
                        showGridView(false);
                    }
                }
            }            

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = gvMingguan.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= gvMingguan.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        gvMingguan.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        gvMingguan.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (gvMingguan.PageIndex + 1).ToString();
                }                
            }

            protected void txhal_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = gvHarian.BottomPagerRow;
                TextBox txhal = (TextBox)(rowPager.Cells[0].FindControl("txHal"));

                try
                {
                    if (int.Parse(txhal.Text) <= gvHarian.PageCount + 1 && int.Parse(txhal.Text) > 0)
                    {
                        gvHarian.PageIndex = (int.Parse(txhal.Text)) - 1;
                        gvHarian.DataBind();
                    }
                }
                catch (Exception)
                {
                    txhal.Text = (gvHarian.PageIndex + 1).ToString();
                }
                
            }

            //method yang dieksekusi setelah melakukan penginputan ke database
            //setelah input seleksi apakah terjadi error atau tidak
            //jika tidak terjadi error maka catat ke log
            protected void ds_shift3_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                if (e.AffectedRows == 0)
                {
                    //Session["salahInput"] = lblCannotUpdate.Text; //& " (" & e.Exception.Message & ")"
                    ExceptionDetails.Text = lblCannotUpdate.Text + " (" + e.Exception.Message + ")";
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1121", e.Command.Parameters["@KODE_SHIFT"].Value.ToString(), Application["strCn"].ToString());
                }
                clearFormHarian();
                showGridView(true);
            }

            //method yang dieksekusi sebelum melakukan penginputan ke database
            //sebelum input mengambil nilai-nilai dari dropdownlist
            //untuk diinputkan ke parameter pada query database
            protected void ds_shift3_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                string grup = ((TextBox)(fvInsertHarian.FindControl("TextBox1"))).Text;
                TextBox tanggal = (TextBox)fvInsertHarian.FindControl("ASPxdeTglMulai");

                //format diambil dari dropdownlist2 yang ada
                //string format = drop1.SelectedValue + drop2.SelectedValue + drop3.SelectedValue + drop4.SelectedValue + drop5.SelectedValue + drop6.SelectedValue + drop7.SelectedValue + drop8.SelectedValue + drop9.SelectedValue + drop10.SelectedValue + drop11.SelectedValue + drop12.SelectedValue + drop13.SelectedValue + drop14.SelectedValue + drop15.SelectedValue + drop16.SelectedValue + drop17.SelectedValue + drop18.SelectedValue + drop19.SelectedValue + drop20.SelectedValue + drop21.SelectedValue + drop22.SelectedValue + drop23.SelectedValue + drop24.SelectedValue + drop25.SelectedValue + drop26.SelectedValue + drop27.SelectedValue + drop28.SelectedValue + drop29.SelectedValue + drop30.SelectedValue + drop31.SelectedValue;
                string format = ((DropDownList)fvInsertHarian.FindControl("DropDownlist1")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist2")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist3")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist4")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist5")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist6")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist7")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist8")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist9")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist10")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist11")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist12")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist13")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist14")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist15")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist16")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist17")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist18")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist19")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist20")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist21")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist22")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist23")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist24")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist25")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist26")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist27")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist28")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist29")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist30")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist31")).SelectedValue;

                //jika format null maka batalkan penginputan
                //jika format tidak sama dengan null maka isikan nilai KODE_SHIFT dan FORMAT
                if (format == "")
                {
                    ExceptionDetails.Text = lblCannotNull.Text;
                    ExceptionDetails.Visible = true;
                    e.Cancel = true;                    
                    showGridView(true);
                }
                else
                {
                    e.Command.Parameters["@KODE_SHIFT"].Value = "N" + grup;
                    e.Command.Parameters["@FORMAT"].Value = format;
                    e.Command.Parameters["@TGL_MULAI"].Value = DateTime.Parse(tanggal.Text);
                }
            }

            protected void ds_shift3_Updating(object sender, SqlDataSourceCommandEventArgs e)
            {
                TextBox tanggal = (TextBox)fvInsertHarian.FindControl("ASPxdeTglMulai");

                //format diambil dari dropdownlist2 yang ada
                //string format = drop1.SelectedValue + drop2.SelectedValue + drop3.SelectedValue + drop4.SelectedValue + drop5.SelectedValue + drop6.SelectedValue + drop7.SelectedValue + drop8.SelectedValue + drop9.SelectedValue + drop10.SelectedValue + drop11.SelectedValue + drop12.SelectedValue + drop13.SelectedValue + drop14.SelectedValue + drop15.SelectedValue + drop16.SelectedValue + drop17.SelectedValue + drop18.SelectedValue + drop19.SelectedValue + drop20.SelectedValue + drop21.SelectedValue + drop22.SelectedValue + drop23.SelectedValue + drop24.SelectedValue + drop25.SelectedValue + drop26.SelectedValue + drop27.SelectedValue + drop28.SelectedValue + drop29.SelectedValue + drop30.SelectedValue + drop31.SelectedValue;
                string format = ((DropDownList)fvInsertHarian.FindControl("DropDownlist1")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist2")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist3")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist4")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist5")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist6")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist7")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist8")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist9")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist10")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist11")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist12")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist13")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist14")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist15")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist16")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist17")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist18")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist19")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist20")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist21")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist22")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist23")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist24")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist25")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist26")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist27")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist28")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist29")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist30")).SelectedValue +
                    ((DropDownList)fvInsertHarian.FindControl("DropDownlist31")).SelectedValue;

                //jika format null maka batalkan penginputan
                //jika format tidak sama dengan null maka isikan nilai KODE_SHIFT dan FORMAT
                if (format == "")
                {
                    ExceptionDetails.Text = lblCannotNull.Text;
                    ExceptionDetails.Visible = true;
                    e.Cancel = true;
                    showGridView(true);
                }
                else
                {
                    e.Command.Parameters["@FORMAT"].Value = format;
                    e.Command.Parameters["@TGL_MULAI"].Value = DateTime.Parse(tanggal.Text);
                }
            }

            //Method yang dieksekusi ketika fvInsertharian di load
            //fungsinya untuk menset item pada drop down list
            protected void FormView2_Load(object sender, EventArgs e)
            {
                if (fvInsertHarian.CurrentMode == FormViewMode.Insert)
                {
                    TextBox ASPxdeTglMulai = (TextBox)fvInsertHarian.FindControl("ASPxdeTglMulai");
                    ASPxdeTglMulai.Text = DateTime.Now.ToShortDateString();
                }
            }

            private void clearFormMingguan()
            {
                ((TextBox)fvInsertMingguan.FindControl("txtGroup")).Text = "";
                ((TextBox)fvInsertMingguan.FindControl("Nama_GroupTextBox")).Text = "";
                ((DropDownList)fvInsertMingguan.FindControl("DropDownList32")).SelectedIndex = 0;
                ((CheckBox)fvInsertMingguan.FindControl("CheckBox1")).Checked = false;
                ((DropDownList)fvInsertMingguan.FindControl("DropDownList1")).SelectedIndex = 0;
                ((DropDownList)fvInsertMingguan.FindControl("DropDownList2")).SelectedIndex = 0;
                ((DropDownList)fvInsertMingguan.FindControl("DropDownList3")).SelectedIndex = 0;
                ((DropDownList)fvInsertMingguan.FindControl("DropDownList4")).SelectedIndex = 0;
                ((DropDownList)fvInsertMingguan.FindControl("DropDownList5")).SelectedIndex = 0;
                ((DropDownList)fvInsertMingguan.FindControl("DropDownList6")).SelectedIndex = 0;
                ((DropDownList)fvInsertMingguan.FindControl("DropDownList7")).SelectedIndex = 0;                
                
            }

            private void clearFormHarian()
            {
                ((TextBox)fvInsertHarian.FindControl("TextBox1")).Text = "";
                ((TextBox)fvInsertHarian.FindControl("ASPxdeTglMulai")).Text = DateTime.Now.ToShortDateString();
                ((TextBox)fvInsertHarian.FindControl("NAMA_GROUPTextBox")).Text = "";
                ((DropDownList)fvInsertHarian.FindControl("DropDownList32")).SelectedIndex = 0;
                ((CheckBox)fvInsertHarian.FindControl("CheckBox2")).Checked = false;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist1")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist2")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist3")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist4")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist5")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist6")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist7")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist8")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist9")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist10")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist11")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist12")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist13")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist14")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist15")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist16")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist17")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist18")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist19")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist20")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist21")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist22")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist23")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist24")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist25")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist26")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist27")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist28")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist29")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist30")).SelectedIndex = 0;
                ((DropDownList)fvInsertHarian.FindControl("DropDownlist31")).SelectedIndex = 0;
            }
}
	}
