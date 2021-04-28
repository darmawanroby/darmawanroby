///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : ceremony.aspx.cs                             (Pseudo code)

//        File terkait  : ceremony.aspx                                (Form)
//                        \App_LocalResources\ceremony.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\ceremony.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                          (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel Hari upacara (taUpacara)
//                        Berfungsi sebagai ketentuan hari upacara yang berlaku

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 14/03/2012
//
// 4. Versi             : 1.0.0
//
// 5. Historis revisi
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
		public partial class ceremony : BasePage
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
                        strFilter += "TGL_UPACARA >= '1/1/" + txtTahun.Text + "' AND TGL_UPACARA <= '12/31/" + Convert.ToString(Tahun) + "'";
                    }
                    else
                    {
                        strFilter += "TGL_UPACARA >= '1/1/" + txtTahun.Text + "' AND TGL_UPACARA <= '31/12/" + Convert.ToString(Tahun) + "'";
                    }
                    dsceremony.FilterExpression = strFilter;
                }
                catch (Exception ex)
                { }
            }

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GVceremony.Visible = show;
                Fvceremony.Visible = !show;
                if (show)
                {
                    Fvceremony.DefaultMode = FormViewMode.ReadOnly;
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
                            GVceremony.Columns[3].Visible = false;
                            GVceremony.Columns[4].Visible = false;
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
                    GVceremony.DataBind();
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
                    if (GVceremony.Rows.Count > 0)
                    {
                        //Data tidak kosong
                        sendToLastPage = true;
                        GVceremony.ShowFooter = true;
                        this.ScriptManager1.SetFocus(GVceremony.FooterRow.Cells[1].FindControl("txtCol1Footer").ClientID);
                    }
                    else
                    {
                        //Data Kosong
                        Fvceremony.DefaultMode = FormViewMode.Insert;
                        this.ScriptManager1.SetFocus(Fvceremony.FindControl("txtCol1FormView").ClientID);
                    }
                }
            }
			
			//Method untuk menambahkan Baris untuk penginputan ke database
			protected void btnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
			{
                lblTambah_Click(sender, e);
			}

            protected void GVceremony_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (GVceremony.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GVceremony.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GVceremony.PageIndex = GVceremony.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GVceremony.PageIndex + 1);
                        lblJumlahHalaman.Text = GVceremony.PageCount.ToString();
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
                        dsceremony.Insert();
                    }
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GVceremony.ShowFooter = false;
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
                    GVceremony.EditIndex = e.NewEditIndex;
                    GVceremony.DataBind();
                    this.ScriptManager1.SetFocus(GVceremony.Rows[e.NewEditIndex].Cells[1].FindControl("txtCol1Edit").ClientID);
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
                        DateTime tanggalBaru = DateTime.Parse(((TextBox)(GVceremony.Rows[e.RowIndex].FindControl("txtCol0Edit"))).Text);
                        dsceremony.UpdateCommand = "UPDATE taUpacara SET TGL_UPACARA = '" + tanggalBaru.ToString("MM/dd/yyyy") + "', KET_UPACARA = @KET_UPACARA, KODE_RANGE = @KODE_RANGE WHERE (TGL_UPACARA = @TGL_UPACARA)";
                    }
                    catch (Exception ex)
                    {
                        ExceptionDetails.Text = lblNotSaved.Text;
                        e.Cancel = true;
                    }
                }
            }

            //Method yang di eksekusi ketika telah mendelete record di database
            protected void ds_ceremony_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1133", e.Command.Parameters["@TGL_UPACARA"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            //Method yang dieksekusi sebelum melakukan penambahan pada database
            //Fungsinya untuk mengambil nilai dari kontrol-kontrol lalu di masukan pada Parameter Query
            protected void ds_ceremony_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                if (GVceremony.Rows.Count > 0)
                {
                    try
                    {
                        //Pengambilan Nilai dari Kontrol-kontrol
                        TextBox Tanggal = (TextBox)GVceremony.FooterRow.FindControl("txtCol0Footer");
                        TextBox txtceremony = (TextBox)GVceremony.FooterRow.FindControl("txtCol1Footer");
                        DropDownList ddlRange = (DropDownList)GVceremony.FooterRow.FindControl("ddlCol2Footer");

                        //Penginputan nilai ke Parameter DataBase
                        e.Command.Parameters["@TGL_UPACARA"].Value = DateTime.Parse(Tanggal.Text);
                        e.Command.Parameters["@KET_UPACARA"].Value = txtceremony.Text;
                        e.Command.Parameters["@KODE_RANGE"].Value = ddlRange.SelectedValue;
                    }
                    catch (Exception ex)
                    {
                        //ExceptionDetails.Text = lblNotSaved.Text;
                        ExceptionDetails.Text = lblNotSaved.Text + " (" + ex.Message + ")";
                        e.Cancel = true;
                    }
                }
                else
                {
                    try
                    {
                        //Pengambilan Nilai dari Kontrol-kontrol
                        DateTime Tanggal = DateTime.Parse(((TextBox)Fvceremony.FindControl("txtCol0FormView")).Text);
                    }
                    catch (Exception ex)
                    {
                        ExceptionDetails.Text = lblNotSaved.Text + " (" + ex.Message + ")";
                        //ExceptionDetails.Text = lblNotSaved.Text;
                        e.Cancel = true;
                    }
                }
            }
            
            //Method yang dieksekusi setelah melakukan input pada database
            //Fungsinya untuk memerikasa apakah terjadi Error
            protected void ds_ceremony_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblNotSaved.Text + " (" + e.Exception.Message + ")";
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1131", e.Command.Parameters["@TGL_UPACARA"].Value.ToString(), Application["strCn"].ToString());
                }
                GVceremony.ShowFooter = false;
                showGridView(true);
            }

            //Method yang dieksekusi setelah melakukan update pada database
            protected void ds_ceremony_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1132", e.Command.Parameters["@TGL_UPACARA"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            protected void Fvceremony_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    Fvceremony.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GVceremony.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GVceremony.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GVceremony.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GVceremony.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GVceremony.PageIndex + 1).ToString();
                }
            }
}
	}
