///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : timecard.aspx.cs                             (Pseudo code)
//        File terkait  : timecard.aspx                                (Form)
//                        \App_LocalResources\timecard.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\timecard.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                           (Kumpulan fungsi-fungsi)
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah tabel batas waktu kerja (taRange)
//                        Berfungsi sebagai aturan / ketentuan jam kerja yang berlaku
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
//        Versi 2.0.1   : Penambahan kolom jam kerja dan istirahat untuk keperluan waktu flexy
//        Versi 2.0.2   : Pembacaan entri 24 jam (24:00) pada jam kerja
//        Versi 2.0.3   : Tambah validasi data entri oleh admin 1 validator
//        Versi 2.0.4   : Implementasi AJAX
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;

	namespace rtwin
	{		
		public partial class timecard : BasePage
		{
            //variable sebagai penanda page index gridview harus pindah ke index terakhir
            private bool sendToLastPage = false;

            string str;
            SqlConnection cn;
			
			//Function untuk mengambil nilai kode Range terurut
			public string GetCode()
			{
                str = Application["strCn"].ToString();
                cn = new SqlConnection(str);
				string val;
				string temp;
				temp = "0";
				int ival;
				SqlCommand pcom = new SqlCommand();
				SqlDataReader rdr;
				pcom = cn.CreateCommand();
				pcom.CommandText = "SELECT KODE_RANGE from taRange order by KODE_RANGE desc";
				cn.Open();
				rdr = pcom.ExecuteReader();
				rdr.Read();
				try
				{
					ival = System.Convert.ToInt32(rdr["KODE_RANGE"]);
				}
				catch (Exception)
				{
					ival = 0;
				}
				rdr.Close();
				cn.Close();
				
				ival++;
				if (ival <= 9)
				{
					val = temp + ival.ToString();
				}
				else
				{
					val = ival.ToString();
				}
				
				return val;
			}
            
            //fungsi: mengatur visible gridview dan formview
            //jika parameter bernilai true maka Gridview ditampilkan FormView di hidden, berlaku sebaliknya
            private void showGridView(Boolean show)
            {
                GVTimeCard.Visible = show;
                FvTimeCard.Visible = !show;
                if (show)
                {
                    FvTimeCard.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            //method yang di eksekusi ketika halaman di load
            protected void Page_Load(object sender, EventArgs e)
            {
                //Seleksi Hak akses Halaman
                if (!rtwin.azlib.AksesHalaman(1, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    //Redirect ke page notauthorized.aspx bila tidak berhak mengakses
                    Response.Redirect("notauthorized.aspx");
                }
                else
                {
                    //seleksi jika selain Administrator (Administrator: Session["GradeID"] = 1)
                    if (Session["GradeID"].ToString() != "1")
                    {
                        lnkBtnInsert.Visible = false;
                        ImgBtnAdd.Visible = false;
                        lblDetail.Visible = false;
                        GVTimeCard.Columns[3].Visible = false;
                        GVTimeCard.Columns[4].Visible = false;
                        GVTimeCard.Columns[5].Visible = false;
                        GVTimeCard.Columns[6].Visible = false;
                        GVTimeCard.Columns[9].Visible = false;
                        GVTimeCard.Columns[10].Visible = false;
                    }
                }
            }

            protected void GVTimeCard_DataBound(object sender, EventArgs e)
            {
                //seleksi jumlah data kosong atau tidak
                if (GVTimeCard.Rows.Count > 0)
                {
                    //Data tidak kosong
                    GridViewRow rowPager = GVTimeCard.BottomPagerRow;

                    //seleksi pager Row apakah ada atau tidak
                    if (rowPager != null)
                    {
                        //pager Row ada
                        //seleksi apakah page index gridview harus pindah ke index terakhir
                        if (sendToLastPage == true)
                        {
                            GVTimeCard.PageIndex = GVTimeCard.PageCount - 1;
                        }

                        //set property control di pager Row
                        TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                        Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                        txtHalaman.Text = Convert.ToString(GVTimeCard.PageIndex + 1);
                        lblJumlahHalaman.Text = GVTimeCard.PageCount.ToString();
                    }
                    showGridView(true);
                }
                else
                {
                    //Data kosong, set gridview visible false, formview visible true
                    showGridView(false);
                }
            }

            protected void GVTimeCard_RowEditing(object sender, GridViewEditEventArgs e)
            {
                if (Page.IsValid)
                {
                    GVTimeCard.EditIndex = e.NewEditIndex;
                    GVTimeCard.DataBind();
                    this.ScriptManager1.SetFocus(GVTimeCard.Rows[e.NewEditIndex].Cells[1].FindControl("txtCol1Edit").ClientID);
                }
                else
                {
                    e.Cancel = true;
                }
            }

            //Method yang dieksekusi ketika terjadi command pada row gridview
            protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                if (e.CommandName == "Insert")
                {
                    if (Page.IsValid)
                    {
                        dsTimeCard.Insert();
                    }
                }
                else if (e.CommandName == "Cancel_Insert")
                {
                    GVTimeCard.ShowFooter = false;
                }
            }

            //method yang dieksekusi Ketika Gridview melakukan Bound perbaris
            //Fungsinya menyisipkan Javascript untuk konfirmasi button Delete
            protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
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

            protected void lblTambah_1_Click(object sender, EventArgs e)
            {
                if (Page.IsValid)
                {
                    //Seleksi apakah data kosong atau tidak, 
                    //jika kosong maka proses tambah data dilakukan melalui formView, 
                    //jika tidak kosong maka proses tambah data dilakukan melalui GridView, 
                    if (GVTimeCard.Rows.Count > 0)
                    {
                        //Data tidak kosong
                        sendToLastPage = true;
                        GVTimeCard.ShowFooter = true;
                        this.ScriptManager1.SetFocus(GVTimeCard.FooterRow.Cells[0].FindControl("txtCol0Footer").ClientID);
                    }
                    else
                    {
                        //Data Kosong
                        FvTimeCard.DefaultMode = FormViewMode.Insert;
                        this.ScriptManager1.SetFocus(FvTimeCard.FindControl("txtCol0FormView"));
                    }
                }
            }

            //Method untuk melakukan penambahan baris untuk penambahan data baru
            protected void ImageButton6_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lblTambah_1_Click(sender, e);
            }
            
            protected void FvTimeCard_ItemCommand(object sender, FormViewCommandEventArgs e)
            {
                if (e.CommandName == "Cancel")
                {
                    FvTimeCard.DefaultMode = FormViewMode.ReadOnly;
                }
            }

            protected void SqlDataSource1_Deleted(object sender, SqlDataSourceStatusEventArgs e)
            {
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotUpdate.Text;
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1113", e.Command.Parameters["@KODE_RANGE"].Value.ToString(), Application["strCn"].ToString());
                }
            }

            protected void txtHalaman_TextChanged(object sender, EventArgs e)
            {
                GridViewRow rowPager = GVTimeCard.BottomPagerRow;
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

                try
                {
                    if (int.Parse(txtHalaman.Text) <= GVTimeCard.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                    {
                        GVTimeCard.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                        GVTimeCard.DataBind();
                    }
                }
                catch (Exception)
                {
                    txtHalaman.Text = (GVTimeCard.PageIndex + 1).ToString();
                }
            }

			//Method yang dieksekusi sebelum melakukan penambahan kedalam data base
			//fungsinya untuk mengambil nilai-nilai dari kontrol-kontrol, memanipulasi lalu
			//memasukannya pada parameter Query database
			protected void SqlDataSource1_Insert_Update(object sender, SqlDataSourceCommandEventArgs e)
			{
                TextBox txtKodeRange, txtJamAwal, txtJamAkhir, txtTolMasuk, txtTolPulang, txtLimitAwal, txtLimitAkhir, txtJamKerja,txtWaktuFlexi;
                
                if (GVTimeCard.Rows.Count > 0)
                {
                    if (GVTimeCard.EditIndex >= 0)
                    {
                        //Pengambilan Nilai dari kontrol-kontrol GridView Editing
                        txtKodeRange = new TextBox();
                        txtTolMasuk = new TextBox();
                        txtTolPulang = new TextBox();
                        txtJamAwal = (TextBox)GVTimeCard.Rows[GVTimeCard.EditIndex].FindControl("txtCol1Edit");
                        txtJamAkhir = (TextBox)GVTimeCard.Rows[GVTimeCard.EditIndex].FindControl("txtCol2Edit");
                        txtLimitAwal = (TextBox)GVTimeCard.Rows[GVTimeCard.EditIndex].FindControl("txtCol5Edit");
                        txtLimitAkhir = (TextBox)GVTimeCard.Rows[GVTimeCard.EditIndex].FindControl("txtCol6Edit");
                        txtJamKerja = (TextBox)GVTimeCard.Rows[GVTimeCard.EditIndex].FindControl("txtCol7Edit");
                        txtWaktuFlexi = (TextBox)GVTimeCard.Rows[GVTimeCard.EditIndex].FindControl("txtCol9Edit");
                    }
                    else
                    {
                        //Pengambilan Nilai dari kontrol-kontrol Gridview
                        txtKodeRange = (TextBox)GVTimeCard.FooterRow.FindControl("txtCol0Footer");
                        txtJamAwal = (TextBox)GVTimeCard.FooterRow.FindControl("txtCol1Footer");
                        txtJamAkhir = (TextBox)GVTimeCard.FooterRow.FindControl("txtCol2Footer");
                        txtTolMasuk = (TextBox)GVTimeCard.FooterRow.FindControl("txtCol3Footer");
                        txtTolPulang = (TextBox)GVTimeCard.FooterRow.FindControl("txtCol4Footer");
                        txtLimitAwal = (TextBox)GVTimeCard.FooterRow.FindControl("txtCol5Footer");
                        txtLimitAkhir = (TextBox)GVTimeCard.FooterRow.FindControl("txtCol6Footer");
                        txtJamKerja = (TextBox)GVTimeCard.FooterRow.FindControl("txtCol7Footer");
                        txtWaktuFlexi = (TextBox)GVTimeCard.Rows[GVTimeCard.EditIndex].FindControl("txtCol9Footer");
                    }
                }
                else
                {
                    //Pengambilan Nilai dari kontrol-kontrol FormView
                    txtKodeRange = (TextBox)FvTimeCard.FindControl("txtCol0FormView");
                    txtJamAwal = (TextBox)FvTimeCard.FindControl("txtCol1FormView");
                    txtJamAkhir = (TextBox)FvTimeCard.FindControl("txtCol2FormView");
                    txtTolMasuk = (TextBox)FvTimeCard.FindControl("txtCol3FormView");
                    txtTolPulang = (TextBox)FvTimeCard.FindControl("txtCol4FormView");
                    txtLimitAwal = (TextBox)FvTimeCard.FindControl("txtCol5FormView");
                    txtLimitAkhir = (TextBox)FvTimeCard.FindControl("txtCol6FormView");
                    txtJamKerja = (TextBox)FvTimeCard.FindControl("txtCol7FormView");
                    txtWaktuFlexi = (TextBox)FvTimeCard.FindControl("txtCol9FormView");
                }

                bool TimeSpanValidation = false;

                try
                {
                    TimeSpan tsJamAwal = TimeSpan.Parse(txtJamAwal.Text);
                    TimeSpan tsJamAkhir = TimeSpan.Parse(txtJamAkhir.Text);
                    TimeSpan tsLimitAwal = TimeSpan.Parse(txtLimitAwal.Text);
                    TimeSpan tsLimitAkhir = TimeSpan.Parse(txtLimitAkhir.Text);
                    TimeSpan tsJamKerja = TimeSpan.Parse(txtJamKerja.Text);

                    TimeSpanValidation = true;
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblWrongInput.Text;
                    e.Cancel = true;
                }

                if (TimeSpanValidation)
                {
                    //Memanipulasi nilai untuk di konvert menjadi tanggal
                    //seleksi culture untuk set tanggal
                    string JamAwal;
                    string JamAkhir;
                    string LimitAwal;
                    string LimitAkhir;
                    string jam_kerja;
                    string tgl;
                    string tgl2;

                    if (Session["strlang"].ToString() == "en")
                    {
                        tgl = "1/1/1900 ";
                        tgl2 = "1/2/1900 ";
                    }
                    else
                    {
                        tgl = "1/1/1900 ";
                        tgl2 = "2/1/1900 ";
                    }

                    JamAwal = tgl + txtJamAwal.Text + ":00";

                    if (TimeSpan.Parse(txtJamAwal.Text) < TimeSpan.Parse(txtJamAkhir.Text))
                    {
                        JamAkhir = tgl + txtJamAkhir.Text + ":00";
                    }
                    else
                    {
                        JamAkhir = tgl2 + txtJamAkhir.Text + ":00";
                    }

                    if (TimeSpan.Parse(txtLimitAwal.Text) <= TimeSpan.Parse(txtJamAwal.Text))
                    {
                        LimitAwal = tgl + txtLimitAwal.Text + ":00";
                    }
                    else
                    {
                        LimitAwal = tgl + txtJamAwal.Text + ":00";
                    }

                    if (TimeSpan.Parse(txtJamAwal.Text) <= TimeSpan.Parse(txtJamAkhir.Text))
                    {
                        LimitAkhir = tgl + txtLimitAkhir.Text + ":00";
                    }
                    else
                    {
                        LimitAkhir = tgl2 + txtLimitAkhir.Text + ":00";
                    }

                    jam_kerja = tgl + txtJamKerja.Text + ":00";

                    e.Command.Parameters["@JAM_AWAL"].Value = DateTime.Parse(JamAwal);
                    e.Command.Parameters["@JAM_AKHIR"].Value = DateTime.Parse(JamAkhir);
                    e.Command.Parameters["@LIMIT_AWAL"].Value = DateTime.Parse(LimitAwal);
                    e.Command.Parameters["@LIMIT_AKHIR"].Value = DateTime.Parse(LimitAkhir);
                    e.Command.Parameters["@JAM_KERJA"].Value = DateTime.Parse(jam_kerja);

                    if (!((GVTimeCard.Rows.Count > 0) && (GVTimeCard.EditIndex >= 0)))
                    {
                        try
                        {
                            //memasukan nilai-nilai kedalam parameter Query
                            e.Command.Parameters["@KODE_RANGE"].Value = txtKodeRange.Text;
                            e.Command.Parameters["@TOL_MASUK"].Value = txtTolMasuk.Text;
                            e.Command.Parameters["@TOL_PULANG"].Value = txtTolPulang.Text;
                            e.Command.Parameters["@WAKTU_FLEXI"].Value = txtWaktuFlexi.Text;
                        }
                        catch (Exception ex)
                        {
                            ExceptionDetails.Text = ex.Message;
                            ExceptionDetails.Visible = true;
                        }
                    }
                }
			}			
			//Method yang dieksekusi setelah melakukan input pada database
			protected void SqlDataSource1_Inserted(object sender, SqlDataSourceStatusEventArgs e)
			{
				//seleksi apakah terjadi error
				if (e.AffectedRows == 0)
				{
					if (Session["SalahSelisih"] != null)
					{
						if ((bool)Session["SalahSelisih"])
						{
							ExceptionDetails.Text = lblWrongWorkTime.Text; //"Jumlah Jam Kerja tidak boleh lebih besar dari Selisih Jam Awal dan Jam Akhir"
							ExceptionDetails.Visible = true;
							Session.Remove("SalahSelisih");
						}
					}
					else
					{
						ExceptionDetails.Text = lblNotSaved.Text + " (" + e.Exception.Message + ")";
						ExceptionDetails.Visible = true;
					}
					e.ExceptionHandled = true;
				}
				else
				{
					rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1111", e.Command.Parameters["@KODE_RANGE"].Value.ToString(), Application["strCn"].ToString());
				}
				GVTimeCard.ShowFooter = false;
                showGridView(true);
			}
			
			//Method yang dieksekusi setelah melakukan Update pada Database
			//Fungsi untuk melakukan pengecekan terhadap error
			protected void SqlDataSource1_Updated(object sender, SqlDataSourceStatusEventArgs e)
			{
				//seleksi apakah terjadi error
				if (e.AffectedRows == 0)
				{
					if (Session["SalahSelisih"] != null)
					{
						if ((bool)Session["SalahSelisih"])
						{
							ExceptionDetails.Text = lblWrongWorkTime.Text; //"Jumlah Jam Kerja tidak boleh lebih besar dari Selisih Jam Awal dan Jam Akhir"
							ExceptionDetails.Visible = true;
							Session.Remove("SalahSelisih");
						}
					}
					else
					{
						ExceptionDetails.Text = lblCannotUpdate.Text; //& " (" & e.Exception.Message & ")"
						ExceptionDetails.Visible = true;
					}
					e.ExceptionHandled = true;
				}
				else
				{
					rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "1112", e.Command.Parameters["@KODE_RANGE"].Value.ToString(), Application["strCn"].ToString());
				}
			}
}
	}
