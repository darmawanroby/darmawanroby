using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Udev.MasterPageWithLocalization.Classes;

/*using System.Configuration;
using System.Collections;
using System.Data;
using System.Web.Caching;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Diagnostics;
using System.Web.Security;
using System;
using System.Text;
using Microsoft.VisualBasic;
using System.Web.UI.HtmlControls;
using System.Web.SessionState;
using System.Text.RegularExpressions;
using System.Web.Profile;
using System.Collections.Generic;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Specialized;
using System.Web;

using Udev.MasterPageWithLocalization.Classes;*/

///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : users.aspx.cs                                (Pseudo code)
//        File terkait  : users.aspx                                   (Form)
//                        \App_LocalResources\users.aspx.id.resx       (Display label bahasa Indonesia)
//                        \App_LocalResources\users.aspx.en.resx       (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                           (Library/class)
//                        \App_Code\comon.cs                           (Library/class)
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel users (taUsers)
//
// 2. Penulis Program
//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Retza Budiawan, Bayu Widiaiswara, Desmond
//
// 3. Tanggal update    : 20/11/2007
//
// 4. Versi             : 2.0.2
//
// 5. Historis revisi
//        Versi 2.0.1   : penambahan dokumentasi dan perbaikan bugs
//        Versi 2.0.2   : Pemisahan hak akses menu dari taUser menjadi taUserLevel
//
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	namespace rtwin
	{
		
		public partial class users : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            //fungsi: mengatur isi dari dropdownlist cabang
            public void setCabang()
			{
                string strFilter = "";

                if (Session["GradeID"].ToString() != "1") //bukan admin
                {
                    strFilter += "KODE_CABANG ='" + Session["CabangID"].ToString() + "'";
                }

                dsCabang.FilterExpression = strFilter;
			}

            //fungsi: mengatur Filter dari Gridview
            private void doFiltering()
            {
                string strFilter = "";

                if (ddlFilterItem0.SelectedValue != "---")
                {
                    strFilter += "KODE_CABANG = '" + ddlFilterItem0.SelectedValue + "'";
                }
                if (txtFilterItem1.Text.Trim() != "")
                {
                    if (strFilter != "")
                    {
                        strFilter += " AND NAMA LIKE '%" + txtFilterItem1.Text + "%'";
                    }
                    else
                    {
                        strFilter += "NAMA LIKE '%" + txtFilterItem1.Text + "%'";
                    }
                }
                if (cbLevel.Checked)
                {
                    if (strFilter != "")
                    {
                        strFilter += " AND KODE_LEVEL = '" + ddlFilterItem2.SelectedValue + "'";
                    }
                    else
                    {
                        strFilter += "KODE_LEVEL = '" + ddlFilterItem2.SelectedValue + "'";
                    }
                }
                dsUsers.FilterExpression = strFilter;
            }

            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GvUsers.Visible = show;
                FvUsers.Visible = !show;
                if (show)
                {
                    FvUsers.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //fungsi: me reset password user otomatis
            private void resetPassword(GridViewCommandEventArgs e)
            {
                ImageButton b = (ImageButton)e.CommandSource;
                GridViewRow myRow = (GridViewRow)b.NamingContainer;
                string pass = common.CreateRandomPassword(8);

                SqlConnection cn2 = new SqlConnection(Application["strCn"].ToString());
                SqlCommand cmd = new SqlCommand();

                //buka koneksi database
                cn2.Open();
                //query update taUsers berdasrkan username
                cmd.CommandText = "UPDATE taUsers SET passw = '" + common.cekuser(pass) + "' WHERE username = '" + GvUsers.DataKeys[myRow.RowIndex].Value.ToString() + "'";
                cmd.CommandType = CommandType.Text;
                cmd.Connection = cn2;
                try
                {
                    cmd.ExecuteNonQuery();
                    ExceptionDetails.Text = "Username: '" + GvUsers.DataKeys[myRow.RowIndex].Value.ToString() + "' Password : '" + pass + "'";
                    ExceptionDetails.Visible = true;
                    //mencatat event user
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4115", Session["UserID"].ToString(), Application["strCn"].ToString());
                }
                catch (Exception)
                {
                    //jika terdapat kegagalan update maka akan memunculkan info password tidak dapat diubah
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    ExceptionDetails.Visible = true;
                }
                //tutup koneksi database
                cn2.Close();
            }
			
			private void Page_Load(object sender, EventArgs e)
			{
				if (! rtwin.azlib.AksesHalaman(25, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
						Response.Redirect("notauthorized.aspx");
				}
				else
				{
					if (!((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "2")))
					{
						Response.Redirect("password.aspx");
					}
				}
				
				//jika halaman bukan postback
                //lakukan setCabang untuk user bukan admin
				if (! Page.IsPostBack)
				{
					setCabang();					
				}
				
                //filter
                doFiltering();
                doFilteringLookup();
                btnGenerateUsers.Visible = (Session["GradeID"].ToString() == "1");
			}
			
			protected void GvUsers_DataBound(object sender, EventArgs e)
			{
                //seleksi jumlah data kosong atau tidak
                if (GvUsers.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GvUsers.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GvUsers.PageIndex = GvUsers.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GvUsers.PageIndex + 1);
                        lblJumlahHalaman.Text = GvUsers.PageCount.ToString();
                    }
                    showGridView(true);
                }
                else
                {
                    //Data kosong, set gridview visible false, formview visible true
                    showGridView(false);
                }
			}

            protected void GvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                if (e.CommandName == "Insert" && Page.IsValid)
                {
                    dsUsers.Insert();
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GvUsers.ShowFooter = false;
                }
                else if (e.CommandName == "Reset")
                {
                    resetPassword(e);
                }
                else if (e.CommandName == "Select")
                {
                    setHakAkses(e);
                }
            }

            protected void GvUsers_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
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
                    e.Row.FindControl("Item2").Visible = false;
                    e.Row.FindControl("btnReset").Visible = false;

                }
            }

            //fungsi: menghandle ketika tambah data akan dilakukan
            protected void lblTambah_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    //Seleksi apakah data kosong atau tidak, 
                    //jika kosong maka proses tambah data dilakukan melalui formView, 
                    //jika tidak kosong maka proses tambah data dilakukan melalui GridView, 
                    if (GvUsers.Rows.Count > 0)
                    {
                        //Data tidak kosong
                        sendToLastPage = true;
                        GvUsers.ShowFooter = true;
                        this.ScriptManager1.SetFocus(GvUsers.FooterRow.Cells[0].FindControl("txtCol0Footer").ClientID);
                    }
                    else
                    {
                        //Data Kosong
                        FvUsers.DefaultMode = FormViewMode.Insert;
                        FvUsers.DataBind();//diperlukan jika didalam formview terdapat dropdownlist
                        this.ScriptManager1.SetFocus(FvUsers.FindControl("txtCol0FormView"));
                    }
                }
            }

            protected void ImgBtnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lblTambah_Click(sender, e);
            }

            protected void FvUsers_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    FvUsers.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            protected void dsUsers_Inserting(object sender, System.Web.UI.WebControls.SqlDataSourceCommandEventArgs e)
            {
                //jika tambah data dilakukan melalui gridview/data pada gridview tidak kosong,
                //maka parameter-parameter datasource didapat dr control-control yg ada di footerrow
                //jika tambah data dilakukan melalui FormView,
                //maka parameter-parameter datasource didapat secara otomatis 
                //dr control-control yang sudah melakukan binding yg terdapat di formView 
                TextBox userName;

                if (GvUsers.Rows.Count > 0)
                {
                    userName = (TextBox)(GvUsers.FooterRow.FindControl("txtCol0Footer"));
                    DropDownList level = (DropDownList)(GvUsers.FooterRow.FindControl("ddlCol1Footer"));
                    TextBox NIP = (TextBox)(GvUsers.FooterRow.FindControl("txtCol2Footer"));

                    e.Command.Parameters["@USERNAME"].Value = userName.Text;
                    e.Command.Parameters["@KODE_LEVEL"].Value = level.SelectedValue;
                    e.Command.Parameters["@NIP"].Value = NIP.Text;
                }
                else
                {
                    userName = (TextBox)(FvUsers.FindControl("txtCol0FormView"));
                }

                string pass = common.CreateRandomPassword(8);
                e.Command.Parameters["@PASSW"].Value = common.cekuser(pass);
                ExceptionDetails.Text = "User Name: " + userName.Text + " Password: " + pass;
                ExceptionDetails.Visible = true;                 
            }

            protected void dsUsers_Inserted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4121", e.Command.Parameters["@USERNAME"].Value.ToString(), Application["strCn"].ToString());
                }
                GvUsers.ShowFooter = false;
                showGridView(true);
            }

            protected void dsUsers_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter delete maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text; //& " (" & e.Exception.Message & ")"
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4123", e.Command.Parameters["@USERNAME"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            protected void dsUsers_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter update maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text; //& " (" & e.Exception.Message & ")"
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4122", e.Command.Parameters["@USERNAME"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvUsers.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvUsers.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvUsers.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvUsers.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvUsers.PageIndex + 1).ToString();
                }
            }

            private void setHakAkses(GridViewCommandEventArgs e)
			{
                LinkButton b = (LinkButton)e.CommandSource;
                GridViewRow myRow = (GridViewRow)b.NamingContainer;

                Session["strUser"] = ((Label)myRow.Cells[0].FindControl("lblCol0Item")).Text;
                string strLevelAkses;
                strLevelAkses = ((Label)myRow.Cells[0].FindControl("lblCol1Item")).Text;
                ExceptionDetails.Text = strLevelAkses;
                if ((strLevelAkses == "Operator Kepegawaian") || (strLevelAkses == "Viewer Laporan"))
                {
                    Response.Redirect("grant_department.aspx");
                }
                else if (strLevelAkses == "Operator Keuangan")
                {
                    Response.Redirect("grant_branch.aspx");
                }
            }
            
            protected void lblGantiPassword_Click(object sender, EventArgs e)
			{
				Response.Redirect("password.aspx");
			}
            
            protected void btnRefresh_Click(object sender, EventArgs e)
			{
                doFiltering();
				GvUsers.DataBind();
			}
			
			protected void txtCol2Footer_TextChanged(object sender, EventArgs e)
			{
                TextBox txtNIP = (TextBox)GvUsers.FooterRow.FindControl("txtCol2Footer");
                Label lblNama = (Label)GvUsers.FooterRow.FindControl("lblCol3Footer");
                setNama(txtNIP, lblNama);
            }

            protected void txtCol2Edit_TextChanged(object sender, EventArgs e)
            {
                TextBox txtNIP = (TextBox)GvUsers.Rows[GvUsers.EditIndex].Cells[2].FindControl("txtCol2Edit");
                Label lblNama = (Label)GvUsers.Rows[GvUsers.EditIndex].Cells[3].FindControl("lblCol3Edit");
                setNama(txtNIP, lblNama);
            }

            protected void txtCol2FormView_TextChanged(object sender, EventArgs e)
            {
                TextBox txtNIP = (TextBox)FvUsers.FindControl("txtCol2FormView");
                Label lblNama = (Label)FvUsers.FindControl("lblCol3FormView");
                setNama(txtNIP, lblNama);
            }

            private void setNama(TextBox txtNIP, Label lblNama)
            {
                string strSelect;
                if ((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "1a"))
                {
                    strSelect = "SELECT NAMA FROM q_Karyawan WHERE NIP='" + txtNIP.Text.Replace("'", "''") + "'";
                }
                else
                {
                    string strFilter = "";
                    if (Session["GradeID"].ToString() == "2")
                    {
                        strFilter += " AND KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        strFilter += " AND KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE USERNAME = '" + Session["UserID"].ToString() + "')";
                    }
                    else if (Session["GradeID"].ToString() == "4")
                    {
                        strFilter += " AND NIP = '" + Session["NIPID"].ToString() + "'";
                    }
                    strSelect = "SELECT NAMA FROM q_Karyawan WHERE NIP='" + txtNIP.Text.Replace("'", "''") + "'" + strFilter;
                }

                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                SqlDataAdapter adpSQL = new SqlDataAdapter(strSelect, Application["strCn"].ToString());
                DataSet dsPegawai = new DataSet();

                adpSQL.Fill(dsPegawai);
                int recordCount = dsPegawai.Tables[0].Rows.Count;
                if (recordCount > 0)
                {
                    lblNama.Text = dsPegawai.Tables[0].Rows[0][0].ToString();
                }
                else
                {
                    ExceptionDetails.Text = lblIDNotFound.Text;
                    ExceptionDetails.Visible = true;
                    txtNIP.Text = "";
                    lblNama.Text = "";
                    txtNIP.Focus();
                }
                cn.Close();
            }

            protected void lnkCol2Edit_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtCol2Edit";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
            }

            protected void lnkCol2Footer_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtCol2Footer";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
            }

            protected void lnkCol2FormView_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtCol2FormView";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
            }

            //Lookup Code
            private void doFilteringLookup()
            {
                string strFilter = "";

                if (txtLookupCariPegawai.Text.Trim() != "")
                {
                    strFilter = "NAMA LIKE '%" + txtLookupCariPegawai.Text + "%'";
                }
                if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "1a"))
                {
                    if (strFilter != "")
                    {
                        strFilter += "AND ";
                    }
                    if (Session["GradeID"].ToString() == "2")
                    {
                        strFilter += "KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        strFilter += "KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE USERNAME = '" + Session["UserID"].ToString() + "')";
                    }
                    else if (Session["GradeID"].ToString() == "4")
                    {
                        strFilter += "NIP = '" + Session["NIPID"].ToString() + "'";
                    }
                }
                //dsLookup.FilterExpression = strFilter;
                dsLookup.SelectCommand = "SELECT NIP, PIN, NAMA FROM taKaryawan";
                if (strFilter != "")
                {
                    dsLookup.SelectCommand += " WHERE " + strFilter;
                }
                dsLookup.SelectCommand += " ORDER BY NIP";
            }

            protected void txtHalamanLookup_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GvLookupPegawai.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvLookupPegawai.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvLookupPegawai.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvLookupPegawai.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GvLookupPegawai.PageIndex + 1).ToString();
                }
            }

            protected void GvLookupPegawai_DataBound(object sender, EventArgs e)
            {
                //Data tidak kosong
                GridViewRow rowPager = GvLookupPegawai.BottomPagerRow;

                //seleksi pager Row apakah ada atau tidak
                if (rowPager != null)
                {
                    //set property control di pager Row
                    TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                    Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                    txtHalaman.Text = Convert.ToString(GvLookupPegawai.PageIndex + 1);
                    lblJumlahHalaman.Text = GvLookupPegawai.PageCount.ToString();
                }
            }

            private void setInitialLookupState()
            {
                txtLookupCariPegawai.Text = "";
                GvLookupPegawai.PageIndex = 0;
                GvLookupPegawai.SelectedIndex = -1;
            }

            protected void imgLookupCancel_Click(object sender, ImageClickEventArgs e)
            {
                lnkLookupClose_Click(sender, e);
            }

            protected void lnkLookupClose_Click(object sender, EventArgs e)
            {
                setInitialLookupState();
                UpdatePanel1.Update();
            }

            protected void btnLookupCari_Click(object sender, EventArgs e)
            {
                GvLookupPegawai.DataBind();
            }

            protected void GvLookupPegawai_SelectedIndexChanged(object sender, EventArgs e)
            {
                if (Session["Triger"] != null)
                {
                    if (Session["Triger"].ToString() == "txtCol2Edit")
                    {
                        ((TextBox)GvUsers.Rows[GvUsers.EditIndex].Cells[2].FindControl("txtCol2Edit")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                        ((Label)GvUsers.Rows[GvUsers.EditIndex].Cells[3].FindControl("lblCol3Edit")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;

                    }
                    else if (Session["Triger"].ToString() == "txtCol2Footer")
                    {
                        ((TextBox)GvUsers.FooterRow.Cells[2].FindControl("txtCol2Footer")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                        ((Label)GvUsers.FooterRow.Cells[3].FindControl("lblCol3Footer")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;
                    }
                    else if (Session["Triger"].ToString() == "txtCol2FormView")
                    {
                        ((TextBox)FvUsers.FindControl("txtCol2FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                        ((Label)FvUsers.FindControl("lblCol3FormView")).Text = ((Label)GvLookupPegawai.SelectedRow.Cells[2].FindControl("Label2")).Text;

                    }
                    Session.Remove("Triger");
                }

                setInitialLookupState(); 
                UpdatePanel1.Update();
            }
            protected void btnGenerateUsers_Click(object sender, EventArgs e)
            {
                CreateUsers();
            }

            public void CreateUsers()
            {
                string strCn;
                strCn = Application["strCn"].ToString();
                SqlConnection cn;
                cn = new SqlConnection(strCn);

                SqlCommand cmd = new SqlCommand("proc_create_users", cn);

                cmd.CommandTimeout = 36000;
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cn.Open();
                cmd.CommandTimeout = 36000;

                try
                {
                    cmd.ExecuteNonQuery();
                    ExceptionDetails.Text = "Proses Generate Users Berhasil";
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = ex.Message;
                }

                cn.Close();
            }

}
   
}
