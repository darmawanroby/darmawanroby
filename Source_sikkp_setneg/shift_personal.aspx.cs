///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : shift_personal.aspx.cs                              (Pseudo code)

//        File terkait  : shift_personal.aspx                                (Form)
//                        \App_LocalResources\shift_personal.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\shift_personal.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                           (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk mengubah Pola secara Individu (taPolaIndividu)

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 11/09/2009
//
// 4. Versi             : 2.0.1
//
// 5. Historis revisi
//        Versi 2.0.1   : Implementasi AJAX
//
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System.Configuration;
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
using System.Data.SqlClient;
using Udev.MasterPageWithLocalization.Classes;
using System.Drawing;

    namespace rtwin
	{
		public partial class shift_personal : BasePage
		{
            private void doFiltering()
            {
                if (Session["GradeID"].ToString() != "1")
                {
                    string strSelect = " Where KODE_RANGE in (Select KODE_RANGE from taRangeDetail Where Kode_departemen = '---' or kode_departemen = '" + Session["DepartemenID"].ToString().Substring(0, 5) + "0')";
                    dsRange.SelectCommand += strSelect;
                }
            }

            private void generateDropDownBulan(DropDownList ddlBulan)
            {
                byte i;
                ListItem li = new ListItem();
                for (i = 1; i <= 12; i++)
                {
                    li = new ListItem((DateTime.Parse(i.ToString() + "/" + i.ToString() + " /1900")).ToString("MMMM"), i.ToString());
                    ddlBulan.Items.Add(li);
                }
            }

            private void generateDropDownTahun(DropDownList ddlTahun)
            {
                ListItem li = new ListItem(Convert.ToString(DateTime.Now.Year - 1), Convert.ToString(DateTime.Now.Year - 1));
                ddlTahun.Items.Add(li);
                li = new ListItem(DateTime.Now.Year.ToString(), DateTime.Now.Year.ToString());
                ddlTahun.Items.Add(li);
                li = new ListItem(Convert.ToString(DateTime.Now.Year + 1), Convert.ToString(DateTime.Now.Year + 1));
                ddlTahun.Items.Add(li);
            }
			
			//Fungsi untuk men-set warna Background DropDownlist menjadi kuning apabila
			//terjadi perbedaan antara nilai pada Dropdownlist dengan nilai awal pola
			public DropDownList setColor(DropDownList Drop, int i, int j, int[] sl, int y)
			{
				//jika terjadi perbedaan antara nilai pada Dropdownlist dengan nilai awal pola
				//set warna Background Dropdownlist menjadi kuning jika tidak set menjadi putih
				if (lblShiftKFormat.Text.Substring(i, j) != lblShiftIFormat.Text.Substring(i, j))
				{
					Drop.BackColor = Color.Yellow;
				}
				else
				{
					Drop.BackColor = Color.White;
				}
				
				for (int x = 1; x <= y; x++)
				{
					if ((i / 2) + 1 == sl[x])
					{
						Drop.ForeColor = Color.Red;
						break;
					}
					else
					{
						Drop.ForeColor = Color.Black;
					}
				}
				return Drop;
			}
			
			//Fungsi untuk men-set nilai Format jika terjadi perubahan
			public string setString(DropDownList Drop, int i, int j)
			{
				string str;
				if (Drop.SelectedValue == lblShiftKFormat.Text.Substring(i, j))
				{
					str = "**";
				}
				else
				{
					str = Drop.SelectedValue;
				}
				return str;
			}
			
			public void resetDropDown()
			{
				DropDownList1.SelectedValue = "";
				DropDownList2.SelectedValue = "";
				DropDownList3.SelectedValue = "";
				DropDownList4.SelectedValue = "";
				DropDownList5.SelectedValue = "";
				DropDownList6.SelectedValue = "";
				DropDownList7.SelectedValue = "";
				DropDownList8.SelectedValue = "";
				DropDownList9.SelectedValue = "";
				DropDownList10.SelectedValue = "";
				DropDownList11.SelectedValue = "";
				DropDownList12.SelectedValue = "";
				DropDownList13.SelectedValue = "";
				DropDownList14.SelectedValue = "";
				DropDownList15.SelectedValue = "";
				DropDownList16.SelectedValue = "";
				DropDownList17.SelectedValue = "";
				DropDownList18.SelectedValue = "";
				DropDownList19.SelectedValue = "";
				DropDownList20.SelectedValue = "";
				DropDownList21.SelectedValue = "";
				DropDownList22.SelectedValue = "";
				DropDownList23.SelectedValue = "";
				DropDownList24.SelectedValue = "";
				DropDownList25.SelectedValue = "";
				DropDownList26.SelectedValue = "";
				DropDownList27.SelectedValue = "";
				DropDownList28.SelectedValue = "";
				DropDownList29.SelectedValue = "";
				DropDownList30.SelectedValue = "";
				DropDownList31.SelectedValue = "";
				ImgSimpan.Enabled = false;
				lbSimpan.Enabled = false;
				ImgCancel.Enabled = false;
				lbCancel.Enabled = false;
				ImgReset.Enabled = false;
				lbReset.Enabled = false;
			}

            protected void setHari()
            {
                if (DropBulan.SelectedValue == "2")
                {
                    if ((System.Convert.ToInt32(ddlTahun.SelectedValue)) % 4 == 0)
                    {
                        DropDownList29.Enabled= true;
                        //Label1.Visible = true;
                        DropDownList30.Enabled = false;
                        //Label4.Visible = false;
                        DropDownList31.Enabled = false;
                        //Label5.Visible = false;
                    }
                    else
                    {
                        DropDownList29.Enabled = false;
                        //Label1.Visible = false;
                        DropDownList30.Enabled = false;
                        //Label4.Visible = false;
                        DropDownList31.Enabled = false;
                        //Label5.Visible = false;
                    }
                }
                else if ((((DropBulan.SelectedValue == "4") || (DropBulan.SelectedValue == "6")) || (DropBulan.SelectedValue == "9")) || (DropBulan.SelectedValue == "11"))
                {
                    DropDownList29.Enabled = true;
                    //Label1.Visible = true;
                    DropDownList30.Enabled = true;
                    //Label4.Visible = true;
                    DropDownList31.Enabled = false;
                    //Label5.Visible = false;
                }
                else
                {
                    DropDownList29.Enabled = true;
                    //Label1.Visible = true;
                    DropDownList30.Enabled = true;
                    //Label4.Visible = true;
                    DropDownList31.Enabled = true;
                    //Label5.Visible = true;
                }
            }
			
			protected void Page_Load(object sender, EventArgs e)
			{
				//Seleksi Hak akses Halaman
				if (! rtwin.azlib.AksesHalaman(19, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					//Redirect ke page notauthorized.aspx bila tidak berhak mengakses
					Response.Redirect("notauthorized.aspx");
				}
				
				//jika halaman tidak di post back maka set item dropdownlist
				if (! Page.IsPostBack)
				{
                    generateDropDownBulan(DropBulan);
                    DropBulan.SelectedValue = DateTime.Now.Month.ToString();
                    generateDropDownTahun(ddlTahun);
                    ddlTahun.SelectedValue = DateTime.Now.Year.ToString();

                    if (isEntryUseNIP())
                    {
                        lblPIN.Visible = false;
                    }
                    else
                    {
                        lblNIP.Visible = false;
                    }
				}

                doFiltering();
                doFilteringLookup();
			}
			
			//Method yang dieksekusi ketika user merubah bulan
			protected void DropBulan_SelectedIndexChanged(object sender, EventArgs e)
			{
				btnGenerate_Click(sender, e);
			}
			
			//Method yang dieksekusi ketika user merubah tahun
			protected void ddlTahun_SelectedIndexChanged(object sender, EventArgs e)
			{
				btnGenerate_Click(sender, e);
			}

            //Menentukan NIP karyawan yang akan di manipulasi
            protected void txtNIP_TextChanged(object sender, EventArgs e)
            {
                setNama(txtNIP, lblNama, lblKodeShift, lblKetPola);
                if (txtNIP.Text.Trim() != "")
                {
                    btnGenerate_Click(sender, e);
                }
            }

            //Fungsi untuk meng-Generate nilai-nilai hasil substring dari format untuk di set menjadi nilai dari DropDownList
            protected void btnGenerate_Click(object sender, EventArgs e)
            {
                try
                {
                    SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
                    DataSet mydataset = new System.Data.DataSet();
                    SqlDataAdapter myadapter = new SqlDataAdapter();
                    DataSet mydataset2 = new DataSet();
                    SqlDataAdapter myadapter2 = new SqlDataAdapter();
                    string bulan = DropBulan.SelectedValue;
                    string Tahun = ddlTahun.SelectedValue;
                    string NIP;
                    if (isEntryUseNIP())
                    {
                        NIP = txtNIP.Text;
                    }
                    else
                    {
                        NIP = azlib.getNIP(txtNIP.Text, Application["strCn"].ToString());
                    }
                    string Kode_Shift = lblKodeShift.Text;
                    string Tanggal;

                    if (lblNama.Text != "")
                    {

                        //Seleksi Inputan tahun tidak boleh Null,harus numeric,harus berada antara 1900 dan 3000
                        if (Tahun != null)
                        {
                            if (azlib.IsNumeric(Tahun))
                            {
                                if (int.Parse(Tahun) > 1900 && int.Parse(Tahun) < 3000)
                                {
                                    DateTime Tanggal2;
                                    Tanggal2 = new DateTime(int.Parse(Tahun), int.Parse(bulan), 1, 0, 0, 0);
                                    //Response.Write(CDate(Tanggal2).ToString())
                                    if (Tanggal2 >= azlib.FirstDate(DateTime.Now.AddMonths(-12), Session["strLang"].ToString()))
                                    {

                                        setHari();
                                        //Seleksi untuk mendapatkan tanggal dalam bentuk yang sesuai dengan culture
                                        Tanggal = bulan + "/1/" + Tahun;

                                        //Query untuk mendapatkan shiftKformat dan ShiftIformat
                                        SqlCommand mycomand = new SqlCommand("SELECT dbo.ShiftKFormat('" + Kode_Shift + "','" + Tanggal + "') as Format1," + " dbo.ShiftIFormat('" + NIP + "','" + Kode_Shift + "','" + Tanggal + "') as Format2", myconection);

                                        SqlCommand mycomand2 = new SqlCommand("SELECT DatePart(day,TGL_LIBUR) As Tanggal_Libur from taLibur where (TGL_LIBUR BETWEEN dbo.FirstDate('" + Tanggal + "') AND dbo.LastDate('" + Tanggal + "')) order by Tanggal_Libur", myconection);

                                        myadapter.SelectCommand = mycomand;
                                        myadapter.Fill(mydataset, "Tabel_Range");

                                        myadapter2.SelectCommand = mycomand2;
                                        myadapter2.Fill(mydataset2, "Tabel_Range");

                                        //Seleksi jika terdapat error
                                        if (mydataset.Tables["Tabel_Range"].Rows.Count == 0)
                                        {
                                            lblShiftIFormat.Text = "Error Data Empty";
                                            lblShiftKFormat.Text = "Error Data Empty";

                                            myadapter.Dispose();
                                            mydataset.Clear();
                                        }
                                        else
                                        {
                                            //Jika tidak terdapat error maka set nilai-nilai dropdownlist dengan nilai hasil sub dari format
                                            //lalu seleksi terhadap perubahan untuk men - set warna background
                                            DataTable myTabel = mydataset.Tables["Tabel_Range"];
                                            DataRow myRow = myTabel.Rows[0];
                                            lblShiftKFormat.Text = myRow["Format1"].ToString();
                                            lblShiftIFormat.Text = myRow["Format2"].ToString();

                                            int[] stateLibur = new int[32];
                                            int i = 0;

                                            if (mydataset2.Tables["Tabel_Range"].Rows.Count == 0)
                                            {
                                                //Tidak ada hari libur
                                                i = 1;
                                                stateLibur[i] = 32;
                                                myadapter2.Dispose();
                                                mydataset2.Clear();
                                            }
                                            else
                                            {
                                                //ada hari libur
                                                DataTable t_Events = mydataset2.Tables["tabel_Range"];


                                                foreach (DataRow myRow2 in t_Events.Rows)
                                                {
                                                    //ambil nilai dari rownya
                                                    i++;
                                                    stateLibur[i] = System.Convert.ToInt32(myRow2["Tanggal_Libur"]);
                                                }

                                                //dataset dan adapter di bersihkan kembali
                                                myadapter2.Dispose();
                                                mydataset2.Clear();
                                            }

                                            DropDownList1.SelectedValue = lblShiftIFormat.Text.Substring(0, 2);
                                            DropDownList1 = setColor(DropDownList1, 0, 2, stateLibur, i);
                                            DropDownList2.SelectedValue = lblShiftIFormat.Text.Substring(2, 2);
                                            DropDownList2 = setColor(DropDownList2, 2, 2, stateLibur, i);
                                            DropDownList3.SelectedValue = lblShiftIFormat.Text.Substring(4, 2);
                                            DropDownList3 = setColor(DropDownList3, 4, 2, stateLibur, i);
                                            DropDownList4.SelectedValue = lblShiftIFormat.Text.Substring(6, 2);
                                            DropDownList4 = setColor(DropDownList4, 6, 2, stateLibur, i);
                                            DropDownList5.SelectedValue = lblShiftIFormat.Text.Substring(8, 2);
                                            DropDownList5 = setColor(DropDownList5, 8, 2, stateLibur, i);
                                            DropDownList6.SelectedValue = lblShiftIFormat.Text.Substring(10, 2);
                                            DropDownList6 = setColor(DropDownList6, 10, 2, stateLibur, i);
                                            DropDownList7.SelectedValue = lblShiftIFormat.Text.Substring(12, 2);
                                            DropDownList7 = setColor(DropDownList7, 12, 2, stateLibur, i);
                                            DropDownList8.SelectedValue = lblShiftIFormat.Text.Substring(14, 2);
                                            DropDownList8 = setColor(DropDownList8, 14, 2, stateLibur, i);
                                            DropDownList9.SelectedValue = lblShiftIFormat.Text.Substring(16, 2);
                                            DropDownList9 = setColor(DropDownList9, 16, 2, stateLibur, i);
                                            DropDownList10.SelectedValue = lblShiftIFormat.Text.Substring(18, 2);
                                            DropDownList10 = setColor(DropDownList10, 18, 2, stateLibur, i);
                                            DropDownList11.SelectedValue = lblShiftIFormat.Text.Substring(20, 2);
                                            DropDownList11 = setColor(DropDownList11, 20, 2, stateLibur, i);
                                            DropDownList12.SelectedValue = lblShiftIFormat.Text.Substring(22, 2);
                                            DropDownList12 = setColor(DropDownList12, 22, 2, stateLibur, i);
                                            DropDownList13.SelectedValue = lblShiftIFormat.Text.Substring(24, 2);
                                            DropDownList13 = setColor(DropDownList13, 24, 2, stateLibur, i);
                                            DropDownList14.SelectedValue = lblShiftIFormat.Text.Substring(26, 2);
                                            DropDownList14 = setColor(DropDownList14, 26, 2, stateLibur, i);
                                            DropDownList15.SelectedValue = lblShiftIFormat.Text.Substring(28, 2);
                                            DropDownList15 = setColor(DropDownList15, 28, 2, stateLibur, i);
                                            DropDownList16.SelectedValue = lblShiftIFormat.Text.Substring(30, 2);
                                            DropDownList16 = setColor(DropDownList16, 30, 2, stateLibur, i);
                                            DropDownList17.SelectedValue = lblShiftIFormat.Text.Substring(32, 2);
                                            DropDownList17 = setColor(DropDownList17, 32, 2, stateLibur, i);
                                            DropDownList18.SelectedValue = lblShiftIFormat.Text.Substring(34, 2);
                                            DropDownList18 = setColor(DropDownList18, 34, 2, stateLibur, i);
                                            DropDownList19.SelectedValue = lblShiftIFormat.Text.Substring(36, 2);
                                            DropDownList19 = setColor(DropDownList19, 36, 2, stateLibur, i);
                                            DropDownList20.SelectedValue = lblShiftIFormat.Text.Substring(38, 2);
                                            DropDownList20 = setColor(DropDownList20, 38, 2, stateLibur, i);
                                            DropDownList21.SelectedValue = lblShiftIFormat.Text.Substring(40, 2);
                                            DropDownList21 = setColor(DropDownList21, 40, 2, stateLibur, i);
                                            DropDownList22.SelectedValue = lblShiftIFormat.Text.Substring(42, 2);
                                            DropDownList22 = setColor(DropDownList22, 42, 2, stateLibur, i);
                                            DropDownList23.SelectedValue = lblShiftIFormat.Text.Substring(44, 2);
                                            DropDownList23 = setColor(DropDownList23, 44, 2, stateLibur, i);
                                            DropDownList24.SelectedValue = lblShiftIFormat.Text.Substring(46, 2);
                                            DropDownList24 = setColor(DropDownList24, 46, 2, stateLibur, i);
                                            DropDownList25.SelectedValue = lblShiftIFormat.Text.Substring(48, 2);
                                            DropDownList25 = setColor(DropDownList25, 48, 2, stateLibur, i);
                                            DropDownList26.SelectedValue = lblShiftIFormat.Text.Substring(50, 2);
                                            DropDownList26 = setColor(DropDownList26, 50, 2, stateLibur, i);
                                            DropDownList27.SelectedValue = lblShiftIFormat.Text.Substring(52, 2);
                                            DropDownList27 = setColor(DropDownList27, 52, 2, stateLibur, i);
                                            DropDownList28.SelectedValue = lblShiftIFormat.Text.Substring(54, 2);
                                            DropDownList28 = setColor(DropDownList28, 54, 2, stateLibur, i);
                                            DropDownList29.SelectedValue = lblShiftIFormat.Text.Substring(56, 2);
                                            DropDownList29 = setColor(DropDownList29, 56, 2, stateLibur, i);
                                            DropDownList30.SelectedValue = lblShiftIFormat.Text.Substring(58, 2);
                                            DropDownList30 = setColor(DropDownList30, 58, 2, stateLibur, i);
                                            DropDownList31.SelectedValue = lblShiftIFormat.Text.Substring(60, 2);
                                            DropDownList31 = setColor(DropDownList31, 60, 2, stateLibur, i);

                                            myadapter.Dispose();
                                            mydataset.Clear();
                                        }

                                        string tgl;
                                        if (Session["strLang"].ToString() == "en")
                                        {
                                            tgl = Tanggal;
                                        }
                                        else
                                        {
                                            tgl = "1" + "/" + bulan + "/" + Tahun;
                                        }
                                        //Response.Write(tgl.ToString() & " " & Session("tglTutup").ToString & " " & Session("tglBatas").ToString())
                                        if ((DateTime.Parse(tgl) < DateTime.Parse(Session["tglTutup"].ToString())) || (DateTime.Parse(tgl) > DateTime.Parse(Session["tglBatas"].ToString())))
                                        {
                                            ImgSimpan.Enabled = false;
                                            lbSimpan.Enabled = false;
                                            ImgCancel.Enabled = false;
                                            lbCancel.Enabled = false;
                                            ImgReset.Enabled = false;
                                            lbReset.Enabled = false;
                                        }
                                        else
                                        {
                                            ImgSimpan.Enabled = true;
                                            lbSimpan.Enabled = true;
                                            ImgCancel.Enabled = true;
                                            lbCancel.Enabled = true;
                                            ImgReset.Enabled = true;
                                            lbReset.Enabled = true;
                                        }
                                    }
                                    else
                                    {
                                        resetDropDown();
                                        ExceptionDetails.Text = lblPeriode.Text;
                                    }
                                }
                                else
                                {
                                    ExceptionDetails.Text = ValidasiTahun1.Text;
                                    ddlTahun.SelectedValue = DateTime.Now.Year.ToString();
                                }
                            }
                            else
                            {
                                ExceptionDetails.Text = ValidasiTahun1.Text;
                                ddlTahun.SelectedValue = DateTime.Now.Year.ToString();
                            }
                        }
                        else
                        {
                            ExceptionDetails.Text = ValidasiTahun2.Text;
                            ddlTahun.SelectedValue = DateTime.Now.Year.ToString();
                        }
                    }
                    else
                    {
                        ExceptionDetails.Text = lblCannotEmpty.Text;
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = ex.Message;
                }
            }

            //Method untuk melakukan perubahan terhadap database (Insert/Update)
            protected void ImgSimpan_Click(object sender, System.Web.UI.ImageClickEventArgs e)
            {
                lbSimpan_Click(sender, e);
            }

            protected void lbSimpan_Click(object sender, EventArgs e)
            {
                try
                {
                    string bulan = DropBulan.SelectedValue;
                    string Tahun = ddlTahun.SelectedValue;
                    string NIP;
                    if (isEntryUseNIP())
                    {
                        NIP = txtNIP.Text;
                    }
                    else
                    {
                        NIP = azlib.getNIP(txtNIP.Text, Application["strCn"].ToString());
                    }

                    if (lblNama.Text != "")
                    {
                        //Seleksi Inputan tahun tidak boleh Null,harus numeric,harus berada antara 1900 dan 3000
                        if (Tahun != null)
                        {
                            if (azlib.IsNumeric(Tahun))
                            {
                                if (int.Parse(Tahun) > 1900 && int.Parse(Tahun) < 3000)
                                {

                                    DateTime Tanggal2;
                                    Tanggal2 = new DateTime(int.Parse(Tahun), int.Parse(bulan), 1, 0, 0, 0);
                                    //Response.Write(CDate(Tanggal2).ToString())
                                    //If CDate(Tanggal2) >= azlib.FirstDate(DateAdd(DateInterval.Month, -3, Now()), CStr(Session("strLang"))) Then
                                    if ((Tanggal2 >= DateTime.Parse(Session["tglTutup"].ToString())) && (Tanggal2 <= DateTime.Parse(Session["tglBatas"].ToString())))
                                    {

                                        SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());

                                        //membangun Format hasil
                                        string FormatHasil = setString(DropDownList1, 0, 2) + setString(DropDownList2, 2, 2) + setString(DropDownList3, 4, 2) + setString(DropDownList4, 6, 2) + setString(DropDownList5, 8, 2) + setString(DropDownList6, 10, 2) + setString(DropDownList7, 12, 2) + setString(DropDownList8, 14, 2) + setString(DropDownList9, 16, 2) + setString(DropDownList10, 18, 2) + setString(DropDownList11, 20, 2) + setString(DropDownList12, 22, 2) + setString(DropDownList13, 24, 2) + setString(DropDownList14, 26, 2) + setString(DropDownList15, 28, 2) + setString(DropDownList16, 30, 2) + setString(DropDownList17, 32, 2) + setString(DropDownList18, 34, 2) + setString(DropDownList19, 36, 2) + setString(DropDownList20, 38, 2) + setString(DropDownList21, 40, 2) + setString(DropDownList22, 42, 2) + setString(DropDownList23, 44, 2) + setString(DropDownList24, 46, 2) + setString(DropDownList25, 48, 2) + setString(DropDownList26, 50, 2) + setString(DropDownList27, 52, 2) + setString(DropDownList28, 54, 2) + setString(DropDownList29, 56, 2) +
                                            setString(DropDownList30, 58, 2) + setString(DropDownList31, 60, 2);

                                        //Dim bulan As String = DropBulan.SelectedValue
                                        //Dim Tahun As String = ddlTahun.SelectedValue
                                        //Dim nip As String = txtNIP.Text
                                        string Tanggal;

                                        //Seleksi untuk mendapatkan tanggal dalam bentuk yang sesuai dengan culture
                                        Tanggal = bulan + "/1/" + Tahun;

                                        DataSet mydataset = new DataSet();
                                        SqlDataAdapter myadapter = new SqlDataAdapter();


                                        SqlCommand cmd = new SqlCommand("Select FORMAT FROM taPolaindividu WHERE(NIP = '" + NIP + "' AND PERIODE = '" + Tanggal + "')", myconection);

                                        myadapter.SelectCommand = cmd;
                                        myadapter.Fill(mydataset, "Tabel_Range");

                                        //seleksi apakah sudah terdapat perubahan sebelumnya
                                        //jika sudah maka lakukan Update
                                        //jika belum maka lakukan insert
                                        if (mydataset.Tables["Tabel_Range"].Rows.Count == 0)
                                        {
                                            //insert
                                            SqlCommand myUpdateCommand = new SqlCommand("Insert Into taPolaIndividu (NIP, PERIODE, FORMAT) VALUES ('" + NIP + "', '" + Tanggal + "','" + FormatHasil + "')", myconection);

                                            myUpdateCommand.Connection.Open();
                                            myUpdateCommand.ExecuteNonQuery();
                                            myUpdateCommand.Connection.Close();

                                            btnGenerate_Click(sender, e);

                                        }
                                        else
                                        {
                                            //Update
                                            SqlCommand myUpdateCommand = new SqlCommand("Update taPolaIndividu set FORMAT = '" + FormatHasil + "' where (NIP = '" + NIP + "' and PERIODE = '" + Tanggal + "')", myconection);

                                            myUpdateCommand.Connection.Open();
                                            myUpdateCommand.ExecuteNonQuery();
                                            myUpdateCommand.Connection.Close();

                                            btnGenerate_Click(sender, e);
                                        }

                                        //catat ke log update taPolaIndividu
                                        rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2602", NIP, Application["strCn"].ToString());

                                        myadapter.Dispose();
                                        mydataset.Clear();
                                    }
                                    else
                                    {
                                        ExceptionDetails.Text = lblPeriode.Text;
                                    }
                                }
                                else
                                {
                                    ExceptionDetails.Text = ValidasiTahun1.Text;
                                    ddlTahun.SelectedValue = DateTime.Now.Year.ToString();
                                }
                            }
                            else
                            {
                                ExceptionDetails.Text = ValidasiTahun1.Text;
                                ddlTahun.SelectedValue = DateTime.Now.Year.ToString();
                            }
                        }
                        else
                        {
                            ExceptionDetails.Text = ValidasiTahun2.Text;
                            ddlTahun.SelectedValue = DateTime.Now.Year.ToString();
                        }
                    }
                    else
                    {
                        ExceptionDetails.Text = lblCannotEmpty.Text;
                    }
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = ex.Message;
                }
            }
			
			//Method yang dieksekusi ketika user melakukan pembatalan terhadap perubahan
			protected void ImgCancel_Click(object sender, System.Web.UI.ImageClickEventArgs e)
			{
				lbCancel_Click(sender, e);
			}

            protected void lbCancel_Click(object sender, EventArgs e)
            {
                btnGenerate_Click(sender, e);
            }
			
			//reset nilai-nilai perubahan kembali ke awal / delete record taPolaKolektif
			protected void ImgReset_Click(object sender, System.Web.UI.ImageClickEventArgs e)
			{
                lbReset_Click(sender, e);
			}

			protected void lbReset_Click(object sender, EventArgs e)
			{
				try
				{
					SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
					string bulan = DropBulan.SelectedValue;
					string Tahun = ddlTahun.SelectedValue;
					string nip;
                    if (isEntryUseNIP())
                    {
                        nip = txtNIP.Text;
                    }
                    else
                    {
                        nip = azlib.getNIP(txtNIP.Text, Application["strCn"].ToString());
                    }
					string Tanggal;
					
					Tanggal = bulan + "/1/" + Tahun;
					
					SqlCommand mycomand = new SqlCommand("delete from taPolaIndividu where (NIP = '" + nip + "' and PERIODE = '" + Tanggal + "')", myconection);
					
					mycomand.Connection.Open();
					mycomand.ExecuteNonQuery();
					mycomand.Connection.Close();
					
					//catat ke log pen-deletan data pada taPolaIndividu
					rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "2603", nip, Application["strCn"].ToString());
					
					btnGenerate_Click(sender, e);
				}
				catch (Exception)
				{
					//Error penghapusan
				}
			}

            protected void lnkFilterItem2_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtNIP";
                GvLookupPegawai.DataBind();
                LookupMPE.Show();
            }

            private void setNama(TextBox txtNIP, Label lblNama, Label lblKodeShift, Label lblKetPola)
            {
                string strSelect;
                if ((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "1a"))
                {
                    if (isEntryUseNIP())
                    {
                        strSelect = "SELECT taKaryawan.NAMA, taKaryawan.KODE_SHIFT, taPola.NAMA_GROUP FROM taKaryawan INNER JOIN taPola ON taKaryawan.KODE_SHIFT = taPola.KODE_SHIFT WHERE(NIP = '" + txtNIP.Text.Replace("'", "''") + "')";
                    }
                    else
                    {
                        txtNIP.Text = azlib.FillNull(txtNIP.Text, 10);
                        strSelect = "SELECT taKaryawan.NAMA, taKaryawan.KODE_SHIFT, taPola.NAMA_GROUP FROM taKaryawan INNER JOIN taPola ON taKaryawan.KODE_SHIFT = taPola.KODE_SHIFT WHERE(NIP = '" + azlib.getNIP(txtNIP.Text.Replace("'", "''"),Application["strCn"].ToString()) + "')";
                    }
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

                    if (isEntryUseNIP())
                    {
                        strSelect = "SELECT taKaryawan.NAMA, taKaryawan.KODE_SHIFT, taPola.NAMA_GROUP FROM taKaryawan INNER JOIN taPola ON taKaryawan.KODE_SHIFT = taPola.KODE_SHIFT WHERE(NIP = '" + txtNIP.Text.Replace("'", "''") + "')" + strFilter;
                    }
                    else
                    {
                        txtNIP.Text = azlib.FillNull(txtNIP.Text, 10);
                        strSelect = "SELECT taKaryawan.NAMA, taKaryawan.KODE_SHIFT, taPola.NAMA_GROUP FROM taKaryawan INNER JOIN taPola ON taKaryawan.KODE_SHIFT = taPola.KODE_SHIFT WHERE(NIP = '" + azlib.getNIP(txtNIP.Text.Replace("'", "''"), Application["strCn"].ToString()) + "')" + strFilter;
                    }
                }

                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                SqlDataAdapter adpSQL = new SqlDataAdapter(strSelect, Application["strCn"].ToString());
                DataSet dsPegawai = new DataSet();

                adpSQL.Fill(dsPegawai);
                int recordCount = dsPegawai.Tables[0].Rows.Count;
                if (recordCount > 0)
                {
                    lblNama.Text = dsPegawai.Tables[0].Rows[0][0].ToString();
                    lblKodeShift.Text = dsPegawai.Tables[0].Rows[0][1].ToString();
                    if (lblKodeShift.Text.Substring(0, 1) == "M")
                    {
                        lblKetPola.Text = lblMingguan.Text;
                    }
                    else
                    {
                        lblKetPola.Text = lblHarian.Text;
                    }

                    lblKetPola.Text += " '" + dsPegawai.Tables[0].Rows[0][2].ToString() + "'";
                }
                else
                {
                    ExceptionDetails.Text = lblIDNotFound.Text;
                    ExceptionDetails.Visible = true;
                    txtNIP.Text = "";
                    lblNama.Text = "";
                    lblKodeShift.Text = "";
                    lblKetPola.Text = "";
                    txtNIP.Focus();
                }
                cn.Close();
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
                    if (Session["Triger"].ToString() == "txtNIP")
                    {
                        if (isEntryUseNIP())
                        {
                            txtNIP.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                        }
                        else
                        {
                            txtNIP.Text = GvLookupPegawai.SelectedRow.Cells[1].Text;
                        }
                        setNama(txtNIP,lblNama,lblKodeShift,lblKetPola);
                        btnGenerate_Click(sender, e);
                    }

                    Session.Remove("Triger");
                }

                setInitialLookupState();
                UpdatePanel1.Update();
            }
}
	}
