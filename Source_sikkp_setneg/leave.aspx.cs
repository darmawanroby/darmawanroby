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
		
		public partial class leave : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GvIjin.Visible = show;
                FvIjin.Visible = !show;
                if (show)
                {
                    FvIjin.DefaultMode = FormViewMode.ReadOnly;
                }
            }            
			
			protected void Page_Load(object sender, EventArgs e)
			{
				//jika User yang login tidak memiliki hak untuk mengakses halaman ini maka akan di link halaman Informasi
                if (!rtwin.azlib.AksesHalaman(4, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    if (!Page.IsPostBack)
                    {
                        if (Session["GradeID"].ToString() != "1")
                        {
                            imgTambah.Visible = false;
                            lblTambah.Visible = false;
                            GvIjin.Columns[13].Visible = false;
                            GvIjin.Columns[14].Visible = false;
                        }
                        else
                        {
                            imgTambah.Visible = false;
                            lblTambah.Visible = false;
                            GvIjin.Columns[14].Visible = false;
                        }
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
                    if (GvIjin.Rows.Count > 0)
                    {
                        //Data tidak kosong
                        sendToLastPage = true;
                        GvIjin.ShowFooter = true;
                        this.ScriptManager1.SetFocus(GvIjin.FooterRow.Cells[0].FindControl("txtCol0Footer").ClientID);
                    }
                    else
                    {
                        //Data Kosong
                        FvIjin.DefaultMode = FormViewMode.Insert;
                        FvIjin.DataBind();
                        this.ScriptManager1.SetFocus(FvIjin.FindControl("txtCol0FormView").ClientID);
                    }
                }
            }

            protected void btnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lblTambah_Click(sender, e);
            }

            protected void grdijin_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (GvIjin.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GvIjin.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GvIjin.PageIndex = GvIjin.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GvIjin.PageIndex + 1);
                        lblJumlahHalaman.Text = GvIjin.PageCount.ToString();
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
                        dsijin.Insert();
                    }
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GvIjin.ShowFooter = false;
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
                        if (((Label)e.Row.Cells[5].FindControl("lblCol5Item")).Text == "Manual")
                        {
                            ((Label)e.Row.Cells[6].FindControl("lblCol6Item")).Visible = false;
                            ((Label)e.Row.Cells[7].FindControl("lblCol7Item")).Visible = false;
                            ((Label)e.Row.Cells[8].FindControl("lblCol8Item")).Visible = false;
                        }
                        else
                        {
                            ((Label)e.Row.Cells[6].FindControl("lblCol6Item")).Visible = true;
                            ((Label)e.Row.Cells[7].FindControl("lblCol7Item")).Visible = true;
                            ((Label)e.Row.Cells[8].FindControl("lblCol8Item")).Visible = true;
                        }
                    }
                }
                
                //Menghilangkan tombol delete dan set focus ke isian textbox saat row pada kondisi edit
                if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                {
                    e.Row.FindControl("imgDelete").Visible = false;

                    //this.ScriptManager1.SetFocus(e.Row.FindControl("txtCol1Edit").ClientID);

                    DropDownList ddlKredit = (DropDownList)e.Row.Cells[5].FindControl("ddlCol5Edit");
                    GridViewRow row = e.Row;
                    if (ddlKredit.SelectedValue == "0")
                    {
                        ((TextBox)row.Cells[6].FindControl("txtCol6Edit")).Text = "0";
                        ((TextBox)row.Cells[6].FindControl("txtCol6Edit")).Enabled = false;
                        ((DropDownList)row.Cells[7].FindControl("ddlCol7Edit")).SelectedValue = "0";
                        ((DropDownList)row.Cells[7].FindControl("ddlCol7Edit")).Enabled = false;
                        ((DropDownList)row.Cells[8].FindControl("ddlCol8Edit")).SelectedValue = "1";
                        ((DropDownList)row.Cells[8].FindControl("ddlCol8Edit")).Enabled = false;
                    }
                    else
                    {
                        ((TextBox)row.Cells[6].FindControl("txtCol6Edit")).Enabled = true;
                        ((DropDownList)row.Cells[7].FindControl("ddlCol7Edit")).Enabled = true;
                        ((DropDownList)row.Cells[8].FindControl("ddlCol8Edit")).Enabled = true;
                    }
                }
            }

            protected void GvIjin_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    GvIjin.EditIndex = e.NewEditIndex;
                    GvIjin.DataBind();
                    this.ScriptManager1.SetFocus(GvIjin.Rows[e.NewEditIndex].Cells[0].FindControl("txtCol1Edit").ClientID);
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1143", e.Command.Parameters["@KODE_IJIN"].Value.ToString(), Application["strCn"].ToString());
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1142", e.Command.Parameters["@KODE_IJIN"].Value.ToString(), Application["strCn"].ToString());
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1141", e.Command.Parameters["@KODE_IJIN"].Value.ToString(), Application["strCn"].ToString());
                }
                GvIjin.ShowFooter = false;
                showGridView(true);
            }

            protected void dsijin_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                if (GvIjin.Rows.Count > 0)
                {
                    //mendeklarasikam objek yang berada di grid view
                    TextBox txtCol0Footer = (TextBox)GvIjin.FooterRow.FindControl("txtCol0Footer");
                    TextBox txtCol1Footer = (TextBox)GvIjin.FooterRow.FindControl("txtCol1Footer");
                    DropDownList ddlCol2Footer = (DropDownList)GvIjin.FooterRow.FindControl("ddlCol2Footer");
                    DropDownList ddlCol3Footer = (DropDownList)GvIjin.FooterRow.FindControl("ddlCol3Footer");
                    TextBox txtCol4Footer = (TextBox)GvIjin.FooterRow.FindControl("txtCol4Footer");
                    DropDownList ddlCol5Footer = (DropDownList)GvIjin.FooterRow.FindControl("ddlCol5Footer");
                    TextBox txtCol6Footer = (TextBox)GvIjin.FooterRow.FindControl("txtCol6Footer");
                    DropDownList ddlCol7Footer = (DropDownList)GvIjin.FooterRow.FindControl("ddlCol7Footer");
                    DropDownList ddlCol8Footer = (DropDownList)GvIjin.FooterRow.FindControl("ddlCol8Footer");
                    DropDownList ddlCol9Footer = (DropDownList)GvIjin.FooterRow.FindControl("ddlCol9Footer");
                    CheckBox chkCol10Footer = (CheckBox)GvIjin.FooterRow.FindControl("chkCol10Footer");
                    CheckBox chkCol11Footer = (CheckBox)GvIjin.FooterRow.FindControl("chkCol11Footer");
                    TextBox txtCol12Footer = (TextBox)GvIjin.FooterRow.FindControl("txtCol12Footer");

                    //menyimpan value pada parameter query
                    e.Command.Parameters["@KODE_IJIN"].Value = txtCol0Footer.Text;
                    e.Command.Parameters["@KET_IJIN"].Value = txtCol1Footer.Text;
                    e.Command.Parameters["@PERHITUNGAN"].Value = ddlCol2Footer.SelectedValue;
                    e.Command.Parameters["@KETENTUAN"].Value = ddlCol3Footer.SelectedValue;
                    e.Command.Parameters["@JATAH_IJIN"].Value = txtCol4Footer.Text;
                    e.Command.Parameters["@KREDIT"].Value = ddlCol5Footer.SelectedValue;
                    e.Command.Parameters["@BERLAKU"].Value = txtCol6Footer.Text;
                    e.Command.Parameters["@DASAR"].Value = ddlCol7Footer.SelectedValue;
                    e.Command.Parameters["@PROSES_DI_AWAL"].Value = ddlCol8Footer.SelectedValue;
                    e.Command.Parameters["@KODE_TIDAK_HADIR"].Value = ddlCol9Footer.SelectedValue;
                    e.Command.Parameters["@HITUNG_HARI_KERJA"].Value = chkCol10Footer.Checked;
                    e.Command.Parameters["@HITUNG_JAM_KERJA"].Value = chkCol11Footer.Checked;
                    e.Command.Parameters["@POTONGAN_TKK"].Value = txtCol12Footer.Text;
                }

            }

            protected void FvIjin_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    FvIjin.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
			{
                GridViewRow rowPager = GvIjin.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvIjin.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvIjin.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvIjin.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvIjin.PageIndex + 1).ToString();
                }
			}

            protected void ddlCol5EditFooter_SelectedIndexChanged(object sender, EventArgs e)
            {
                DropDownList ddlKredit = (DropDownList)sender;
                GridViewRow row = (GridViewRow)ddlKredit.NamingContainer;
                
                string txtCol6 = "", ddlCol7 = "", ddlCol8 = "";
                
                if (ddlKredit.ClientID.ToString().Contains("ddlCol5Edit"))
                {
                    txtCol6 = "txtCol6Edit";
                    ddlCol7 = "ddlCol7Edit";
                    ddlCol8 = "ddlCol8Edit";
                }
                else if (ddlKredit.ClientID.ToString().Contains("ddlCol5Footer"))
                {
                    txtCol6 = "txtCol6Footer";
                    ddlCol7 = "ddlCol7Footer";
                    ddlCol8 = "ddlCol8Footer";
                }

                if (ddlKredit.SelectedValue == "0")
                {
                    ((TextBox)row.Cells[6].FindControl(txtCol6)).Text = "0";
                    ((TextBox)row.Cells[6].FindControl(txtCol6)).Enabled = false;
                    ((DropDownList)row.Cells[7].FindControl(ddlCol7)).SelectedValue = "0";
                    ((DropDownList)row.Cells[7].FindControl(ddlCol7)).Enabled = false;
                    ((DropDownList)row.Cells[8].FindControl(ddlCol8)).SelectedValue = "1";
                    ((DropDownList)row.Cells[8].FindControl(ddlCol8)).Enabled = false;                    
                }
                else
                {
                    ((TextBox)row.Cells[6].FindControl(txtCol6)).Enabled = true;
                    ((DropDownList)row.Cells[7].FindControl(ddlCol7)).Enabled = true;
                    ((DropDownList)row.Cells[8].FindControl(ddlCol8)).Enabled = true;                    
                }
            }

            protected void ddlCol5FormView_SelectedIndexChanged(object sender, EventArgs e)
            {
                DropDownList ddlKredit = (DropDownList)sender;
                if (ddlKredit.SelectedValue == "0")
                {
                    ((TextBox)FvIjin.FindControl("txtCol6FormView")).Text = "0";
                    ((TextBox)FvIjin.FindControl("txtCol6FormView")).Enabled = false;
                    ((DropDownList)FvIjin.FindControl("ddlCol7FormView")).SelectedValue = "0";
                    ((DropDownList)FvIjin.FindControl("ddlCol7FormView")).Enabled = false;
                    ((DropDownList)FvIjin.FindControl("ddlCol8FormView")).SelectedValue = "1";
                    ((DropDownList)FvIjin.FindControl("ddlCol8FormView")).Enabled = false;
                }
                else
                {
                    ((TextBox)FvIjin.FindControl("txtCol6FormView")).Enabled = true;
                    ((DropDownList)FvIjin.FindControl("ddlCol7FormView")).Enabled = true;
                    ((DropDownList)FvIjin.FindControl("ddlCol8FormView")).Enabled = true;
                }
            }
}
	}
