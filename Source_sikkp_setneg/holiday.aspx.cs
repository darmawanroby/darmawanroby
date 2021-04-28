///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : holiday.aspx.cs                             (Pseudo code)

//        File terkait  : holiday.aspx                                (Form)
//                        \App_LocalResources\holiday.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\holiday.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                          (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel Hari Libur (taLibur)
//                        Berfungsi sebagai ketentuan hari libur yang berlaku

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
//        Versi 2.0.1   : Penambahan filter tahun
//        Versi 2.0.2   : Implementasi AJAX
//
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;

    namespace rtwin
	{
		public partial class holiday : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            //fungsi: mengatur Filter dari Gridview
            private void doFiltering()
            {
                try
                {
                    int Tahun = int.Parse(txtTahun.Text);

                    string strFilter = "";

                    if (Session["strlang"].ToString() == "en")
                    {
                        strFilter += "TGL_LIBUR >= '1/1/" + txtTahun.Text + "' AND TGL_LIBUR <= '12/31/" + Convert.ToString(Tahun) + "'";
                    }
                    else
                    {
                        strFilter += "TGL_LIBUR >= '1/1/" + txtTahun.Text + "' AND TGL_LIBUR <= '31/12/" + Convert.ToString(Tahun) + "'";
                    }
                    dsHoliday.FilterExpression = strFilter;
                }
                catch (Exception ex)
                { }
            }

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GVHoliday.Visible = show;
                FvHoliday.Visible = !show;
                if (show)
                {
                    FvHoliday.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //Method yang dieksekusi ketika page di load
            protected void Page_Load(object sender, EventArgs e)
            {                
                //Seleksi Hak akses Halaman
                if (!rtwin.azlib.AksesHalaman(3, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    //Redirect ke page notauthorized.aspx bila tidak berhak mengakses
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    //jika page di postback maka label error visible = false
                    if (!Page.IsPostBack)
                    {
                        txtTahun.Text = DateTime.Now.ToString("yyyy");
                        
                        if (Session["GradeID"].ToString() != "1")
                        {
                            btnAdd.Visible = false;
                            lblTambah.Visible = false;
                            GVHoliday.Columns[2].Visible = false;
                            GVHoliday.Columns[3].Visible = false;
                        }

                        //txtTahun.Focus();
                    }

                    doFiltering();
                }
            }

            protected void txtTahun_TextChanged(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    doFiltering();
                    GVHoliday.DataBind();
                }
            }

            protected void btnDown_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    try
                    {
                        txtTahun.Text = Convert.ToString(int.Parse(txtTahun.Text) - 1);
                        txtTahun_TextChanged(sender, e);
                    }
                    catch (Exception)
                    {
                        txtTahun.Text = DateTime.Now.ToString("yyyy");
                    }
                }
            }
            
            protected void btnUp_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    try
                    {
                        txtTahun.Text = Convert.ToString(int.Parse(txtTahun.Text) + 1);
                        txtTahun_TextChanged(sender, e);
                    }
                    catch (Exception)
                    {
                        txtTahun.Text = DateTime.Now.ToString("yyyy");
                    }
                }
            }

            protected void lblTambah_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    //Seleksi apakah data kosong atau tidak, 
                    //jika kosong maka proses tambah data dilakukan melalui formView, 
                    //jika tidak kosong maka proses tambah data dilakukan melalui GridView, 
                    if (GVHoliday.Rows.Count > 0)
                    {
                        //Data tidak kosong
                        sendToLastPage = true;
                        GVHoliday.ShowFooter = true;
                        this.ScriptManager1.SetFocus(GVHoliday.FooterRow.Cells[1].FindControl("txtCol1Footer").ClientID);
                    }
                    else
                    {
                        //Data Kosong
                        FvHoliday.DefaultMode = FormViewMode.Insert;
                        this.ScriptManager1.SetFocus(FvHoliday.FindControl("txtCol1FormView").ClientID);
                    }
                }
            }
			
			//Method untuk menambahkan Baris untuk penginputan ke database
			protected void btnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
			{
                lblTambah_Click(sender, e);
			}

            protected void GVHoliday_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (GVHoliday.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GVHoliday.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GVHoliday.PageIndex = GVHoliday.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GVHoliday.PageIndex + 1);
                        lblJumlahHalaman.Text = GVHoliday.PageCount.ToString();
                    }
                    showGridView(true);
                }
                else
                {
                    //Data kosong, set gridview visible false, formview visible true
                    showGridView(false);
                }

            }

            //Method yang dieksekusi ketika terjadi command pada row gridview
            protected void GridView1_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
            {
                if (e.CommandName == "Insert")
                {
                    if (Page.IsValid)
                    {
                        dsHoliday.Insert();
                    }
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GVHoliday.ShowFooter = false;
                }
            }

            //method yang dieksekusi Ketika Gridview melakukan Bound perbaris
            //Fungsinya menyisipkan Javascript untuk konfirmasi button Delete
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
                //Menghilangkan tombol delete dan set focus ke isian textbox saat row pada kondisi edit
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    e.Row.FindControl("imgDelete").Visible = false;

                    //this.ScriptManager1.SetFocus(e.Row.FindControl("txtCol1Edit").ClientID);
                }
            }

            protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    GVHoliday.EditIndex = e.NewEditIndex;
                    GVHoliday.DataBind();
                    this.ScriptManager1.SetFocus(GVHoliday.Rows[e.NewEditIndex].Cells[1].FindControl("txtCol1Edit").ClientID);
                }
                else
                {
                    e.Cancel = true;
                }
            }

            //Method yang dieksekusi ketika Gridview akan melakukan Update
            //fungsinya untuk mengambil nilai-nilai dari kontrol-kontrol, memanipulasi lalu
            //memasukannya pada parameter Query database
            protected void GridView1_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
            {
                if (Page.IsValid)
                {
                    try
                    {
                        DateTime tanggalBaru = DateTime.Parse(((TextBox)(GVHoliday.Rows[e.RowIndex].FindControl("txtCol0Edit"))).Text);
                        dsHoliday.UpdateCommand = "UPDATE taLibur SET TGL_LIBUR = '" + tanggalBaru.ToString("MM/dd/yyyy") + "', KET_LIBUR = @KET_LIBUR WHERE (TGL_LIBUR = @TGL_LIBUR)";
                    }
                    catch (Exception ex)
                    {
                        ExceptionDetails.Text = lblNotSaved.Text;
                        e.Cancel = true;
                    }
                }
            }

            //Method yang di eksekusi ketika telah mendelete record di database
            protected void ds_holiday_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1133", e.Command.Parameters["@TGL_LIBUR"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //Method yang dieksekusi sebelum melakukan penambahan pada database
            //Fungsinya untuk mengambil nilai dari kontrol-kontrol lalu di masukan pada Parameter Query
            protected void ds_holiday_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                if (GVHoliday.Rows.Count > 0)
                {
                    try
                    {
                        //Pengambilan Nilai dari Kontrol-kontrol
                        TextBox Tanggal = (TextBox)GVHoliday.FooterRow.FindControl("txtCol0Footer");
                        TextBox txtHoliday = (TextBox)GVHoliday.FooterRow.FindControl("txtCol1Footer");

                        //Penginputan nilai ke Parameter DataBase
                        e.Command.Parameters["@TGL_LIBUR"].Value = DateTime.Parse(Tanggal.Text);
                        e.Command.Parameters["@KET_LIBUR"].Value = txtHoliday.Text;
                    }
                    catch (Exception ex)
                    {
                        ExceptionDetails.Text = lblNotSaved.Text;
                        e.Cancel = true;
                    }
                }
                else
                {
                    try
                    {
                        //Pengambilan Nilai dari Kontrol-kontrol
                        DateTime Tanggal = DateTime.Parse(((TextBox)FvHoliday.FindControl("txtCol0FormView")).Text);
                    }
                    catch (Exception ex)
                    {
                        ExceptionDetails.Text = lblNotSaved.Text;
                        e.Cancel = true;
                    }
                }
            }
            
            //Method yang dieksekusi setelah melakukan input pada database
            //Fungsinya untuk memerikasa apakah terjadi Error
            protected void ds_holiday_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblNotSaved.Text + " (" + e.Exception.Message + ")";
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1131", e.Command.Parameters["@TGL_LIBUR"].Value.ToString(), Application["strCn"].ToString());
                }
                GVHoliday.ShowFooter = false;
                showGridView(true);
            }

            //Method yang dieksekusi setelah melakukan update pada database
            protected void ds_holiday_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1132", e.Command.Parameters["@TGL_LIBUR"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            protected void FvHoliday_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    FvHoliday.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GVHoliday.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GVHoliday.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GVHoliday.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GVHoliday.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GVHoliday.PageIndex + 1).ToString();
                }
            }
}
	}
