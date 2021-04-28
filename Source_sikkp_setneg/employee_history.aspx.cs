///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : employee.aspx.cs                             (Pseudo code)
//        File terkait  : employee.aspx                                (Form)
//                        \App_LocalResources\employee.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\employee.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                           (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk mengelola data pegawai
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
//        Versi 2.0.3   : Pengaturan Hak Akses untuk setiap level
//
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Udev.MasterPageWithLocalization.Classes;
using Microsoft.SqlServer.Server;
using Microsoft.SqlServer.Dts.Runtime;

	namespace rtwin
	{
		public partial class employee_history : BasePage
		{
            public string count(string q)
            {
                string a;
                SqlConnection con = new SqlConnection(Application["strCn"].ToString());
                con.Open();
                SqlCommand pcom = new SqlCommand();
                SqlDataReader rdr;
                pcom = con.CreateCommand();
                pcom.CommandText = "select count(*) as jml FROM [q_Karyawan]" + q;
                rdr = pcom.ExecuteReader();

                rdr.Read();
                a = rdr["jml"].ToString();

                rdr.Close();
                con.Close();
                return a;
            }

            private void showGridView(Boolean show)
            {
                GvKaryawan.Visible = show;
                tableFilter.Visible = show;
                FvKaryawan.Visible = !show;
            }
			
            private void doFiltering()
            {
                string strFilter = "";

                if (txtFilterItem0.Text.Trim() != "")
                {
                  //  strFilter += " WHERE (NIP = '" + txtFilterItem0.Text.Replace("'", "''") + "')" string strFilter = "";
                 //   strFilter += "where BULAN=";

                    strFilter += " WHERE NIP = '" + txtFilterItem0.Text + "'";
                    dsKaryawan.SelectCommand += strFilter + "AND TAHUN ='" + ddlTahun.SelectedValue + "' order by BULAN DESC";
                    //GvKaryawan.DataBind();
                    //GvKaryawan.Visible = true;

                }

                if ((ddlFilterItem1.SelectedValue != "0000") && (ddlFilterItem1.SelectedValue != ""))
                {
                    if (strFilter != "")
                    {
                        strFilter += " AND (KODE_BIRO = '" + ddlFilterItem1.SelectedValue + "')";
                    }
                    else
                    {
                        strFilter += " WHERE (KODE_BIRO = '" + ddlFilterItem1.SelectedValue + "')";
                    }
                }

                if ((ddlFilterItem2.SelectedValue != "00000") && (ddlFilterItem2.SelectedValue != ""))
                {
                    if (strFilter != "")
                    {
                        strFilter += " AND (KODE_BAGIAN = '" + ddlFilterItem2.SelectedValue + "')";
                    }
                    else
                    {
                        strFilter += " WHERE (KODE_BAGIAN = '" + ddlFilterItem2.SelectedValue + "')";
                    } 
                }

                if ((((ddlFilterItem1.SelectedValue == "0000") || (ddlFilterItem1.SelectedValue == "")) && ((ddlFilterItem2.SelectedValue == "00000") || (ddlFilterItem2.SelectedValue == "")))) //Operator
                {
                    if ((Session["GradeID"].ToString() == "2"))
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                        }
                        else
                        {
                            strFilter += " WHERE KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                        }
                    }
                    else if ((Session["GradeID"].ToString().Substring(0,1) == "3"))
                    {
                        if (strFilter != "")
                        {
                            strFilter += " AND KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                        }
                        else
                        {
                            strFilter += " WHERE KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                        }
                    }
                }				
				
                if (ddlFilterItem3.SelectedValue == "1")
                {
                    if (strFilter != "")
                    {
                        strFilter += " AND Not TEMPLATE is NULL";
                    }
                    else
                    {
                        strFilter += " WHERE Not TEMPLATE is NULL";
                    }                    
                }
                else if (ddlFilterItem3.SelectedValue == "2")
                {
                    if (strFilter != "")
                    {
                        strFilter += " AND TEMPLATE is NULL";
                    }
                    else
                    {
                        strFilter += " WHERE TEMPLATE is NULL";
                    }
                }

                lblJmlRecord.Text = count(strFilter);

              //  dsKaryawan.SelectCommand += strFilter + " order by KODE_GRADE DESC, KODE_JABATAN, KODE_GOLONGAN DESC";
            }

            private void setFilter()
            {
                if (Session["GradeID"].ToString() == "2")
                {
                    dsBiro.FilterExpression = "KODE_BIRO = '0000' OR KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                }
                else if (Session["GradeID"].ToString().Substring(0,1) == "3")
                {
                    dsBiro.SelectCommand = "SELECT KODE_BIRO, NAMA_BIRO FROM q_Biro";
                    dsBiro.SelectCommand += " WHERE KODE_BIRO = '0000' OR KODE_BIRO IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                }
                else if ((Session["GradeID"].ToString() == "3a") || (Session["GradeID"].ToString() == "4"))
                {
                    txtFilterItem0.Text = Session["NIPID"].ToString();
                    tableFilter.Visible = false;
                }
            }

            protected void ddlFilterItem1_DataBound_SelectedChange(object sender, EventArgs e)
            {
                if (ddlFilterItem1.SelectedValue != "0000")
                {
                    if (Session["GradeID"].ToString() == "2")
                    {
                        dsBagian.FilterExpression = "KODE_BAGIAN = '00000' OR (KODE_CABANG = '" + Session["CabangID"].ToString() + "' AND KODE_BIRO = '" + ddlFilterItem1.SelectedValue + "')";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        dsBagian.SelectCommand = "SELECT KODE_BAGIAN, NAMA_BAGIAN FROM q_Bagian";
                        dsBagian.SelectCommand += " WHERE KODE_BAGIAN = '00000' OR (KODE_BAGIAN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "') AND KODE_BIRO = '" + ddlFilterItem1.SelectedValue + "')";
                    }
                    else
                    {
                        dsBagian.FilterExpression = "KODE_BAGIAN = '00000' OR KODE_BIRO = '" + ddlFilterItem1.SelectedValue + "'";
                    }
                }
                else
                {
                    if (Session["GradeID"].ToString() == "2")
                    {
                        dsBagian.FilterExpression = "KODE_BAGIAN = '00000' OR KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        dsBagian.SelectCommand = "SELECT KODE_BAGIAN, NAMA_BAGIAN FROM q_Bagian";
                        dsBagian.SelectCommand += " WHERE KODE_BAGIAN = '00000' OR KODE_BAGIAN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                    }
                }
                ddlFilterItem2.DataBind();
            }

            private void setComponent()
            {
                if ((Session["GradeID"].ToString() == "3") || (Session["GradeID"].ToString() == "3a") || (Session["GradeID"].ToString() == "4"))
                {
                    lblTambah.Visible = false;
                    ImgbtnAdd.Visible = false;
                 //   GvKaryawan.Columns[8].Visible = false;
                   // GvKaryawan.Columns[9].Visible = false;
                }
                //else if (Session["GradeID"].ToString() == "1a")
                //{
                //   lblTambah.Visible = false;
                //    ImgbtnAdd.Visible = false;
                //    GvKaryawan.Columns[9].Visible = false;
                //}
            }
			
			protected void Page_Load(object sender, EventArgs e)
			{
				//jika userid kosong maka akan di link ke halaman awal
                if (!rtwin.azlib.AksesHalaman(11, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    Response.Redirect("notauthorized.aspx");
                }
				
				//jika halaman bukan postback
				if (! Page.IsPostBack)
				{
                    setFilter();
                    setComponent();
                    GvKaryawan.Visible = false;
                    FvKaryawan.Visible = false;
                    int bln = DateTime.Now.Month;

                    byte i;
                    ListItem li = new ListItem();
                    for (i = 1; i <= 12; i++)
                    {
                        li = new ListItem((DateTime.Parse(i.ToString() + "/" + i.ToString() + " /1900")).ToString("MMMM"), i.ToString()); //Format(DateTime.Parse(CStr(i) & "/" & CStr(i) & " /1900"), "MMMM"), CStr(i))
                        DropBulan.Items.Add(li);
                    }

                    //    DropBulan.SelectedValue = bln.ToString();

                    li = new ListItem(System.Convert.ToString(DateTime.Now.Year - 1), System.Convert.ToString(DateTime.Now.Year - 1));
                    ddlTahun.Items.Add(li);
                    li = new ListItem(DateTime.Now.Year.ToString(), DateTime.Now.Year.ToString());
                    ddlTahun.Items.Add(li);
                    ddlTahun.SelectedValue = DateTime.Now.Year.ToString();
				}

                doFiltering();
                doFilteringLookup();
            }

            protected void btnRefresh_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                //    string strFilter = "";
                 //   strFilter += "where BULAN=";

                  //  strFilter += " WHERE NIP = '" + txtFilterItem0.Text + "'";
                   // dsKaryawan.SelectCommand += strFilter;
                    GvKaryawan.DataBind();
                    GvKaryawan.Visible = true;
                    // GvKaryawan.DataBind();
                }
            }

            protected void lblTambah_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    FvKaryawan.DefaultMode = FormViewMode.Insert;
                    FvKaryawan.ChangeMode(FormViewMode.Insert);
                    showGridView(false);
                }
            }

            protected void ImgbtnAdd_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lblTambah_Click(sender, e);
            }

            protected void GvKaryawan_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (GvKaryawan.Rows.Count > 0)
                {
                    GridViewRow rowPager = GvKaryawan.BottomPagerRow;

                    if (rowPager != null)
                    {
                        // get your controls from the gridview
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = (GvKaryawan.PageIndex + 1).ToString();
                        // populate page count
                        lblJumlahHalaman.Text = GvKaryawan.PageCount.ToString();

                        Label lbljml = (Label)(rowPager.Cells[0].FindControl("lbljml"));
                        lbljml.Text = "Jumlah Record : " + lblJmlRecord.Text;
                    }
                    //showGridView(true);
                }
                else
                {
                    //Data kosong, set gridview visible false, formview visible true
                    //showGridView(false);
                }
            }
			
			//Menyisipkan javascript untuk confirm sebelum delete
			protected void GvKaryawan_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
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

            protected void GvKaryawan_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    dsKaryawanManajemen.FilterExpression = "NIP = '" + ((Label)GvKaryawan.Rows[e.NewEditIndex].Cells[0].FindControl("lblCol0Item")).Text + "' AND BULAN='" + ((Label)GvKaryawan.Rows[e.NewEditIndex].Cells[0].FindControl("Label38")).Text + "' and TAHUN='" + ddlTahun.SelectedValue + "'";
                    e.Cancel = true;
                    FvKaryawan.DefaultMode = FormViewMode.Edit;
                    FvKaryawan.ChangeMode(FormViewMode.Edit);
                    showGridView(false);
                }
                else
                {
                    e.Cancel = true;
                }
            }

            protected void GvKaryawan_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                if (e.CommandName == "Detail")
                {
                    if (Page.IsValid)
                    {
                        FvKaryawan.DefaultMode = FormViewMode.ReadOnly;
                        FvKaryawan.ChangeMode(FormViewMode.ReadOnly);
                        dsKaryawanManajemen.FilterExpression = "NIP = '" + ((Label)((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).Cells[0].FindControl("lblCol0Item")).Text + "'  AND TAHUN='" + ddlTahun.SelectedValue + "' AND BULAN = '" + ((Label)((GridViewRow)((ImageButton)e.CommandSource).NamingContainer).Cells[0].FindControl("Label38")).Text + "'";
                        showGridView(false);
                    }
                }
            }

            protected void FvKaryawan_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if ((e.CommandName == "Cancel_Detail") || (e.CommandName == "Cancel_Edit"))
                {
                    showGridView(true);
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    setInitialComponent();
                    showGridView(true);
                }
                else if (e.CommandName == "Edit_Detail")
                {
                    if (Page.IsValid)
                    {
                        dsKaryawanManajemen.FilterExpression = "NIP = '" + ((Label)FvKaryawan.FindControl("lblNIP")).Text + "' AND BULAN= '" + ((Label)FvKaryawan.FindControl("Label42")).Text + "'";
                        FvKaryawan.DefaultMode = FormViewMode.Edit;
                        FvKaryawan.ChangeMode(FormViewMode.Edit);
                    }
                }
            }

            protected void dsKaryawan_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
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
					rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1303", e.Command.Parameters["@NIP"].Value.ToString(), Application["strCn"].ToString());
				}
			}
			
				protected void txtHalaman_TextChanged(object sender, EventArgs e)
			{
				GridViewRow rowPager = GvKaryawan.BottomPagerRow;
				TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GvKaryawan.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GvKaryawan.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GvKaryawan.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    txtHalaman.Text = (GvKaryawan.PageIndex + 1).ToString();
                }
			}

            protected void ddlKodeUnit_DataBound(object sender, EventArgs e)
            {
                DropDownList ddlKodeUnit = (DropDownList)FvKaryawan.FindControl("ddlKodeUnit");
                DropDownList ddlKodeDeputi = (DropDownList)FvKaryawan.FindControl("ddlKodeDeputi");
                if (ddlKodeUnit.SelectedValue.Trim() != "-")
                {
                    dsDeputi.SelectCommand += " WHERE KODE_UNIT = '" + ddlKodeUnit.SelectedValue + "' or KODE_DEPUTI = '000'";
                }
                ddlKodeDeputi.DataBind();
            }

            protected void ddlKodeDeputi_DataBound(object sender, EventArgs e)
            {
                DropDownList ddlKodeDeputi = (DropDownList)FvKaryawan.FindControl("ddlKodeDeputi");
                DropDownList ddlBiro = (DropDownList)FvKaryawan.FindControl("ddlBiro");

                if (ddlKodeDeputi.SelectedValue.Trim() != "000")
                {
                    dsBiroManajemen.SelectCommand += " WHERE KODE_DEPUTI = '" + ddlKodeDeputi.SelectedValue + "' or KODE_BIRO = '0000'";
                }
                ddlBiro.DataBind();
            }

            protected void ddlBiro_DataBound(object sender, EventArgs e)
            {
                DropDownList ddlBiro = (DropDownList)FvKaryawan.FindControl("ddlBiro");
                DropDownList ddlBagian = (DropDownList)FvKaryawan.FindControl("ddlBagian");

                if (ddlBiro.SelectedValue.Trim() != "0000")
                {
                    dsBagianManajemen.SelectCommand += " WHERE KODE_BIRO = '" + ddlBiro.SelectedValue + "' or KODE_BAGIAN = '00000'";
                }
                ddlBagian.DataBind();
            }

            protected void ddlBagian_DataBound(object sender, EventArgs e)
            {
                DropDownList ddlBagian = (DropDownList)FvKaryawan.FindControl("ddlBagian");
                DropDownList ddlSubBagian = (DropDownList)FvKaryawan.FindControl("ddlSubBagian");

                if (ddlBagian.SelectedValue.Trim() != "00000")
                {
                    dsSubBagian.SelectCommand += " WHERE KODE_BAGIAN = '" + ddlBagian.SelectedValue + "' or KODE_SUBBAGIAN = '000000'";
                }
                ddlSubBagian.DataBind();
            }

            protected void dsKaryawanManajemen_Inserting(object sender, SqlDataSourceCommandEventArgs e)
            {
                DropDownList ddlKodeUnit = (DropDownList)FvKaryawan.FindControl("ddlKodeUnit");
                DropDownList ddlKodeDeputi = (DropDownList)FvKaryawan.FindControl("ddlKodeDeputi");
                DropDownList ddlBiro = (DropDownList)FvKaryawan.FindControl("ddlBiro");
                DropDownList ddlBagian = (DropDownList)FvKaryawan.FindControl("ddlBagian");
                DropDownList ddlSubBagian = (DropDownList)FvKaryawan.FindControl("ddlSubBagian");

                SqlConnection con = new SqlConnection(Application["strCn"].ToString());
                con.Open();
                SqlCommand pcom = new SqlCommand();
                SqlDataReader rdr;
                pcom = con.CreateCommand();
                pcom.CommandText = "select KODE_CABANG,KODE_INSTANSI FROM taUNIT where KODE_UNIT = '" + ddlKodeUnit.SelectedValue + "'";
                rdr = pcom.ExecuteReader();
                rdr.Read();
                e.Command.Parameters["@KODE_CABANG"].Value = rdr["KODE_CABANG"].ToString();
                e.Command.Parameters["@KODE_INSTANSI"].Value = rdr["KODE_INSTANSI"].ToString();
                rdr.Close();
                con.Close();

                e.Command.Parameters["@KODE_UNIT"].Value = ddlKodeUnit.SelectedValue;
                e.Command.Parameters["@KODE_DEPUTI"].Value = ddlKodeDeputi.SelectedValue;
                e.Command.Parameters["@KODE_BIRO"].Value = ddlBiro.SelectedValue;
                e.Command.Parameters["@KODE_BAGIAN"].Value = ddlBagian.SelectedValue;
                e.Command.Parameters["@KODE_SUBBAGIAN"].Value = ddlSubBagian.SelectedValue;

                TextBox txtTMT = (TextBox)FvKaryawan.FindControl("txtTMT");
                TextBox txtAktif = (TextBox)FvKaryawan.FindControl("txtAktif");
                TextBox txtNonAktif = (TextBox)FvKaryawan.FindControl("txtNonAktif");
                TextBox txtTglLahir = (TextBox)FvKaryawan.FindControl("txtTglLahir");

                try
                {
                    if (txtTMT.Text.Trim() != "")
                    {
                        DateTime TMT = DateTime.Parse(txtTMT.Text);
                        e.Command.Parameters["@TMT"].Value = TMT;
                    }
                    if (txtAktif.Text.Trim() != "")
                    {
                        DateTime Aktif = DateTime.Parse(txtAktif.Text);
                        e.Command.Parameters["@AKTIF"].Value = Aktif;
                    }
                    if (txtNonAktif.Text.Trim() != "")
                    {
                        DateTime NON_AKTIF = DateTime.Parse(txtNonAktif.Text);
                        e.Command.Parameters["@NON_AKTIF"].Value = NON_AKTIF;
                    }
                    if (txtTglLahir.Text.Trim() != "")
                    {
                        DateTime TGL_LAHIR = DateTime.Parse(txtTglLahir.Text);
                        e.Command.Parameters["@TGL_LAHIR"].Value = TGL_LAHIR;
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblerrorEdit.Text;
                    e.Cancel = true;
                }
            }

            protected void dsKaryawanManajemen_Updating(object sender, SqlDataSourceCommandEventArgs e)
            {
                DropDownList ddlKodeUnit = (DropDownList)FvKaryawan.FindControl("ddlKodeUnit");
                DropDownList ddlKodeDeputi = (DropDownList)FvKaryawan.FindControl("ddlKodeDeputi");
                DropDownList ddlBiro = (DropDownList)FvKaryawan.FindControl("ddlBiro");
                DropDownList ddlBagian = (DropDownList)FvKaryawan.FindControl("ddlBagian");
                DropDownList ddlSubBagian = (DropDownList)FvKaryawan.FindControl("ddlSubBagian");
                DropDownList ddlJabatan = (DropDownList)FvKaryawan.FindControl("ddlJabatan");
                DropDownList ddlGolongan = (DropDownList)FvKaryawan.FindControl("ddlGolongan");
                DropDownList ddlGrade = (DropDownList)FvKaryawan.FindControl("ddlGrade");
                DropDownList ddlEselon = (DropDownList)FvKaryawan.FindControl("ddlEselon");
                DropDownList ddlStatusPegawai = (DropDownList)FvKaryawan.FindControl("ddlStatusPegawai");
                //DropDownList ddlShift = (DropDownList)FvKaryawan.FindControl("ddlShift");

                SqlConnection con = new SqlConnection(Application["strCn"].ToString());
                con.Open();
                SqlCommand pcom = new SqlCommand();
                SqlDataReader rdr;
                pcom = con.CreateCommand();
                pcom.CommandText = "select KODE_CABANG,KODE_INSTANSI FROM taUNIT where KODE_UNIT = '" + ddlKodeUnit.SelectedValue + "'";
                rdr = pcom.ExecuteReader();
                rdr.Read();
                e.Command.Parameters["@KODE_CABANG"].Value = rdr["KODE_CABANG"].ToString();
                e.Command.Parameters["@KODE_INSTANSI"].Value = rdr["KODE_INSTANSI"].ToString();
                rdr.Close();
                con.Close();

                e.Command.Parameters["@KODE_UNIT"].Value = ddlKodeUnit.SelectedValue;
                e.Command.Parameters["@KODE_DEPUTI"].Value = ddlKodeDeputi.SelectedValue;
                e.Command.Parameters["@KODE_BIRO"].Value = ddlBiro.SelectedValue;
                e.Command.Parameters["@KODE_BAGIAN"].Value = ddlBagian.SelectedValue;
                e.Command.Parameters["@KODE_SUBBAGIAN"].Value = ddlSubBagian.SelectedValue;
                e.Command.Parameters["@KODE_JABATAN"].Value = ddlJabatan.SelectedValue;
                e.Command.Parameters["@KODE_GOLONGAN"].Value = ddlGolongan.SelectedValue;
                e.Command.Parameters["@KODE_GRADE"].Value = ddlGrade.SelectedValue;
                e.Command.Parameters["@KODE_ESELON"].Value = ddlEselon.SelectedValue;
                e.Command.Parameters["@KODE_STATUS_PEGAWAI"].Value = ddlStatusPegawai.SelectedValue;
                //e.Command.Parameters["@KODE_SHIFT"].Value = ddlShift.SelectedValue;
                {
                TextBox txtTMT = (TextBox)FvKaryawan.FindControl("txtTMT");
                TextBox txtAktif = (TextBox)FvKaryawan.FindControl("txtAktif");
                TextBox txtNonAktif = (TextBox)FvKaryawan.FindControl("txtNonAktif");
                TextBox txtTglLahir = (TextBox)FvKaryawan.FindControl("txtTglLahir");

                try
                {
                    if (txtTMT.Text.Trim() != "")
                    {
                        DateTime TMT = DateTime.Parse(txtTMT.Text);
                        e.Command.Parameters["@TMT"].Value = TMT;
                    }
                    if (txtAktif.Text.Trim() != "")
                    {
                        DateTime Aktif = DateTime.Parse(txtAktif.Text);
                        e.Command.Parameters["@AKTIF"].Value = Aktif;
                    }
                    if (txtNonAktif.Text.Trim() != "")
                    {
                        DateTime NON_AKTIF = DateTime.Parse(txtNonAktif.Text);
                        e.Command.Parameters["@NON_AKTIF"].Value = NON_AKTIF;
                    }
                    if (txtTglLahir.Text.Trim() != "")
                    {
                        DateTime TGL_LAHIR = DateTime.Parse(txtTglLahir.Text);
                        e.Command.Parameters["@TGL_LAHIR"].Value = TGL_LAHIR;
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblerrorEdit.Text;
                    e.Cancel = true;
                }
                }
            }

            protected void dsKaryawanManajemen_Inserted(object sender, SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter insert maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text; //& " (" & e.Exception.Message & ")"
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1301", e.Command.Parameters["@NIP"].Value.ToString(), Application["strCn"].ToString());
                }
                GvKaryawan.DataBind();
                setInitialComponent();
                showGridView(true);
            }

            protected void dsKaryawanManajemen_Updated(object sender, SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter update maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = e.Exception.Message;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1302", e.Command.Parameters["@NIP"].Value.ToString(), Application["strCn"].ToString());
                }
                GvKaryawan.DataBind();
                showGridView(true);
            }

            protected void HiddenUnit_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenUnit = (HiddenField)(FvKaryawan.FindControl("HiddenUnit"));
                if (HiddenUnit.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlKodeUnit"))).SelectedValue = HiddenUnit.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlKodeUnit"))).SelectedValue = "0";
                }
            }

            protected void HiddenDeputi_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenDeputi = (HiddenField)(FvKaryawan.FindControl("HiddenDeputi"));
                if (HiddenDeputi.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlKodeDeputi"))).SelectedValue = HiddenDeputi.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlKodeDeputi"))).SelectedValue = "000";
                }
            }

            protected void HiddenBiro_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenBiro = (HiddenField)(FvKaryawan.FindControl("HiddenBiro"));
                if (HiddenBiro.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlBiro"))).SelectedValue = HiddenBiro.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlBiro"))).SelectedValue = "0000";
                }
            }

            protected void HiddenBagian_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenBagian = (HiddenField)(FvKaryawan.FindControl("HiddenBagian"));
                if (HiddenBagian.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlBagian"))).SelectedValue = HiddenBagian.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlBagian"))).SelectedValue = "00000";
                }
            }

            protected void HiddenSubBagian_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenSubBagian = (HiddenField)(FvKaryawan.FindControl("HiddenSubBagian"));
                if (HiddenSubBagian.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlSubBagian"))).SelectedValue = HiddenSubBagian.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlSubBagian"))).SelectedValue = "000000";
                }
            }

            protected void HiddenJabatan_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenJabatan = (HiddenField)(FvKaryawan.FindControl("HiddenJabatan"));
                if (HiddenJabatan.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlJabatan"))).SelectedValue = HiddenJabatan.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlJabatan"))).SelectedValue = "0";
                }
            }

            protected void HiddenGolongan_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenGolongan = (HiddenField)(FvKaryawan.FindControl("HiddenGolongan"));
                if (HiddenGolongan.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlGolongan"))).SelectedValue = HiddenGolongan.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlGolongan"))).SelectedValue = "00";
                }
            }

            protected void HiddenGrade_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenGrade = (HiddenField)(FvKaryawan.FindControl("HiddenGrade"));
                if (HiddenGrade.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlGrade"))).SelectedValue = HiddenGrade.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlGrade"))).SelectedValue = "0";
                }
            }

            protected void HiddenEselon_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenEselon = (HiddenField)(FvKaryawan.FindControl("HiddenEselon"));
                if (HiddenEselon.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlEselon"))).SelectedValue = HiddenEselon.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlEselon"))).SelectedValue = "0";
                }
            }

            protected void HiddenStatusPegawai_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenStatusPegawai = (HiddenField)(FvKaryawan.FindControl("HiddenStatusPegawai"));
                if (HiddenStatusPegawai.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlStatusPegawai"))).SelectedValue = HiddenStatusPegawai.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlStatusPegawai"))).SelectedValue = "0";
                }
            }

            protected void HiddenShift_DataBinding(object sender, EventArgs e)
            {
                HiddenField HiddenShift = (HiddenField)(FvKaryawan.FindControl("HiddenShift"));
                if (HiddenShift.Value.Trim() != "")
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlShift"))).SelectedValue = HiddenShift.Value;
                }
                else
                {
                    ((DropDownList)(FvKaryawan.FindControl("ddlShift"))).SelectedValue = "0";
                }
            }

            private void setInitialComponent()
            {
                ((TextBox)FvKaryawan.FindControl("txtNIP")).Text = "";
                ((TextBox)FvKaryawan.FindControl("txtPIN")).Text = "";
                ((TextBox)FvKaryawan.FindControl("txtNAMA")).Text = "";
                ((TextBox)FvKaryawan.FindControl("txtTMT")).Text = "";
                ((TextBox)FvKaryawan.FindControl("txtAktif")).Text = "";
                ((TextBox)FvKaryawan.FindControl("txtNonAktif")).Text = "";
                ((TextBox)FvKaryawan.FindControl("txtTglLahir")).Text = "";
                ((TextBox)FvKaryawan.FindControl("txtNoRek")).Text = "";
                ((TextBox)FvKaryawan.FindControl("txtNipBaru")).Text = "";
                ((DropDownList)FvKaryawan.FindControl("ddlKodeUnit")).SelectedIndex = 0;
                ((DropDownList)FvKaryawan.FindControl("ddlKodeDeputi")).SelectedIndex = 0;
                ((DropDownList)FvKaryawan.FindControl("ddlBiro")).SelectedIndex = 0;
                ((DropDownList)FvKaryawan.FindControl("ddlBagian")).SelectedIndex = 0;
                ((DropDownList)FvKaryawan.FindControl("ddlSubBagian")).SelectedIndex = 0;
                ((DropDownList)FvKaryawan.FindControl("ddlJabatan")).SelectedIndex = 0;
                ((DropDownList)FvKaryawan.FindControl("ddlGolongan")).SelectedIndex = 0;
                ((DropDownList)FvKaryawan.FindControl("ddlGrade")).SelectedIndex = 0;
                ((DropDownList)FvKaryawan.FindControl("ddlEselon")).SelectedIndex = 0;
                //((DropDownList)FvKaryawan.FindControl("ddlStatusPegawai")).SelectedIndex = 0;
                ((DropDownList)FvKaryawan.FindControl("ddlShift")).SelectedIndex = 0;
            }

            protected void FvKaryawan_DataBound(object sender, EventArgs e)
            {
                if (FvKaryawan.CurrentMode == FormViewMode.Insert)
                {
                    ((DropDownList)FvKaryawan.FindControl("ddlStatusPegawai")).SelectedValue = "5";
                    ((DropDownList)FvKaryawan.FindControl("ddlStatusPegawai")).Enabled = false;
                }
                else if (FvKaryawan.CurrentMode == FormViewMode.Edit)
                {
                    if (((DropDownList)FvKaryawan.FindControl("ddlStatusPegawai")).SelectedValue == "5")
                    {
                        ((DropDownList)FvKaryawan.FindControl("ddlStatusPegawai")).Enabled = false;
                    }
                }

                //if (Session["GradeID"].ToString() == "1a")
                //{
                //    if (FvKaryawan.CurrentMode == FormViewMode.Edit)
                //    {
                //        ((TextBox)FvKaryawan.FindControl("txtPIN")).Enabled = false;
                //        ((TextBox)FvKaryawan.FindControl("txtNAMA")).Enabled = false;
                //        ((TextBox)FvKaryawan.FindControl("txtTMT")).Enabled = false;
                //        ((TextBox)FvKaryawan.FindControl("txtAktif")).Enabled = false;
                //        ((TextBox)FvKaryawan.FindControl("txtNonAktif")).Enabled = false;
                //        ((TextBox)FvKaryawan.FindControl("txtTglLahir")).Enabled = false;
                //        ((TextBox)FvKaryawan.FindControl("txtNipBaru")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlKodeUnit")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlKodeDeputi")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlBiro")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlBagian")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlSubBagian")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlJabatan")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlGolongan")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlGrade")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlEselon")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlStatusPegawai")).Enabled = false;
                //        ((DropDownList)FvKaryawan.FindControl("ddlShift")).Enabled = false;
                //    }
                //}
                else if ((Session["GradeID"].ToString() == "3") || (Session["GradeID"].ToString() == "3a") || (Session["GradeID"].ToString() == "4"))
                {
                    if (FvKaryawan.CurrentMode == FormViewMode.ReadOnly)
                    {
                        ((ImageButton)FvKaryawan.FindControl("btnEdit")).Visible = false;
                        ((LinkButton)FvKaryawan.FindControl("lbedit")).Visible = false;
                    }
                }
            }

            protected void lnkCol2Footer_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtFilterItem0";
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
                    if (Session["Triger"].ToString() == "txtFilterItem0")
                    {
                        this.txtFilterItem0.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                    }

                    Session.Remove("Triger");
                }

                setInitialLookupState();
                UpdatePanel1.Update();
            }

            protected void lbledit_Click(object sender, EventArgs e)
            {

               
                DropDownList ddlKodeUnit = (DropDownList)FvKaryawan.FindControl("ddlKodeUnit");
                DropDownList ddlKodeDeputi = (DropDownList)FvKaryawan.FindControl("ddlKodeDeputi");
                DropDownList ddlKodeBiro = (DropDownList)FvKaryawan.FindControl("ddlBiro");
            
                DropDownList ddlBagian = (DropDownList)FvKaryawan.FindControl("ddlBagian");
                DropDownList ddlSubBagian = (DropDownList)FvKaryawan.FindControl("ddlSubBagian");
                DropDownList ddlJabatan = (DropDownList)FvKaryawan.FindControl("ddlJabatan");
                DropDownList ddlGolongan = (DropDownList)FvKaryawan.FindControl("ddlGolongan");
                DropDownList ddlGrade = (DropDownList)FvKaryawan.FindControl("ddlGrade");
                DropDownList ddlEselon = (DropDownList)FvKaryawan.FindControl("ddlEselon");
                DropDownList ddlStatusPegawai = (DropDownList)FvKaryawan.FindControl("ddlStatusPegawai");
                //DropDownList ddlShift = (DropDownList)FvKaryawan.FindControl("ddlShift");
                
                TextBox Tahun = (TextBox)FvKaryawan.FindControl("txtTahunEdit");
                TextBox Bulan = (TextBox)FvKaryawan.FindControl("txtBulanEdit");
                TextBox NIP = (TextBox)FvKaryawan.FindControl("txtNIPEdit");
                
                TextBox NoRekBank = (TextBox)FvKaryawan.FindControl("txtNoRek");
                CheckBox LapKeuangan = (CheckBox)FvKaryawan.FindControl("lapKeuEdit");
                bool lapKeuVal = LapKeuangan.Checked;

                CheckBox um = (CheckBox)FvKaryawan.FindControl("CheckBox2");
                bool umVal = um.Checked;

                Label tracing = (Label)FvKaryawan.FindControl("Label36");
                string query = "";
                try
                {
                   
                  query = "UPDATE taRiwayatKaryawan SET KODE_UNIT='" + ddlKodeUnit.SelectedValue + "',KODE_BIRO='" + ddlKodeBiro.SelectedValue + "',KODE_DEPUTI='" + ddlKodeDeputi.SelectedValue + "',KODE_BAGIAN='" + ddlBagian.SelectedValue + "',KODE_SUBBAGIAN='" + ddlSubBagian.SelectedValue + "',KODE_JABATAN='"+ddlJabatan.SelectedValue+"',KODE_ESELON='" + ddlEselon.SelectedValue + "',KODE_STATUS_PEGAWAI ='"+ddlStatusPegawai.SelectedValue+"',KODE_GRADE='"+ddlGrade.SelectedValue+"',KODE_GOLONGAN='"+ddlGolongan.SelectedValue+"',NOREK_BANK='"+NoRekBank.Text+"',LAP_KEUANGAN='"+lapKeuVal+"',UM='"+umVal+"' WHERE NIP='" + NIP.Text + "' AND BULAN = '" + Bulan.Text + "' AND TAHUN = '" + Tahun.Text + "' AND BULAN='"+Bulan.Text+"'";

                   

                    SqlConnection con = new SqlConnection(Application["strCn"].ToString());
                    SqlCommand cmd = new SqlCommand(query, con);
                     
                    con.Open();
                
             //     tracing.Text = query;
                   cmd.ExecuteNonQuery();
                   con.Close();
                   
                     

                }
                catch (SqlException ex)
                {
                  //  Label Error = (Label)FvKaryawan.FindControl("Label36");
                   // Error.Text = ex.Message;
                   // (Label)FvKaryawan.FindControl("Label36").ToString() = Error;
                    //M
                    // FvKaryawan.Visible = false;
                //    NIP.Text = query;
                    tracing.Text = query;
                }  

            }

            protected void btnEdit_Click(object sender, ImageClickEventArgs e)
            {

            }
            protected void btnEkspor_Click(object sender, EventArgs e)
            {
                       
                System.Diagnostics.ProcessStartInfo psi =
                   new System.Diagnostics.ProcessStartInfo(@"E:\DataSQL\DTS\DTS_norek.bat");
                 psi.RedirectStandardOutput = true;
                 psi.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                 psi.UseShellExecute = false;
                 
                 System.Diagnostics.Process listFiles;
                 listFiles = System.Diagnostics.Process.Start(psi);

                 System.IO.StreamReader myOutput = listFiles.StandardOutput;
                 listFiles.WaitForExit(2000);
                 if (listFiles.HasExited)
                 {
                     string output = myOutput.ReadToEnd();
                     this.Response.Write(output);
                 }
/*
string pkgLocation = @"E:\DataSQL\DTS\taRiwayatKaryawan.dtsx";
Microsoft.SqlServer.Dts.Runtime.Application app = new Microsoft.SqlServer.Dts.Runtime.Application();

Package pkg = new Package(); 
pkg = app.LoadPackage(pkgLocation, null);

DTSExecResult result = pkg.Execute(); 

if (result==DTSExecResult.Success) 
{ 
            ExceptionDetails.Text = "Package Success"; 
} 
else 
{ 
            ExceptionDetails.Text = "Package Failed"; 
}
*/
            }
}
	}
