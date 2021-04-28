///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : summary.aspx.cs                             (Pseudo code)

//        File terkait  : summary.aspx                                (Form)
//                        \App_LocalResources\summary.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\summary.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan filter laporan tahunan

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 12/09/2009
//
// 4. Versi             : 2.0.2
//
// 5. Historis revisi
//        Versi 2.0.1   : Penyempurnaan Filter
//        Versi 2.0.2   : Implementasi AJAX
//
//
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
//using rtwin.azlib;


	namespace rtwin
	{
		
		public partial class summary : BasePage
		{
			//fungsi: set isi Dropdownlist
			public void setDepartemen()
			{
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                string strQuery = "";

                if (ddlInstansi.Items.Count == 0)
                {
                    if (Session["GradeID"].ToString().Substring(0, 1) == "1") //admin
                    {
                        strQuery = "SELECT KODE_INSTANSI, NAMA_INSTANSI FROM taInstansi";
                        DataSet dsInstansi = new DataSet();
                        SqlDataAdapter adInstansi = new SqlDataAdapter(strQuery, cn);
                        adInstansi.Fill(dsInstansi, "Tabel_Instansi");
                        ddlInstansi.DataSource = dsInstansi.Tables["Tabel_Instansi"].DefaultView;
                        ddlInstansi.DataTextField = "NAMA_INSTANSI";
                        ddlInstansi.DataValueField = "KODE_INSTANSI";
                        ddlInstansi.DataBind();
                        adInstansi.Dispose();
                        dsInstansi.Clear();
                    }
                    else
                    {
                        lblInstansi.Visible = false;
                        ddlInstansi.Visible = false;
                    }
                }

                if ((ddlUnit.Items.Count == 0) || (ddlUnit.SelectedValue == "-"))
                {
                    if ((Session["GradeID"].ToString().Substring(0, 1) == "1") || (Session["GradeID"].ToString() == "2"))//admin & validator
                    {
                        strQuery = "SELECT KODE_UNIT,NAMA_UNIT FROM taUnit";
                        if (Session["GradeID"].ToString() == "2") //validator
                        {
                            strQuery += " WHERE KODE_CABANG ='" + Session["CabangID"].ToString() + "' OR KODE_UNIT='-'";
                        }
                        else if ((ddlInstansi.Items.Count > 0) && (ddlInstansi.SelectedValue != "-"))
                        {
                            strQuery += " WHERE KODE_INSTANSI='" + ddlInstansi.SelectedValue + "' OR KODE_UNIT='-'";
                        }
                        DataSet dsUnit = new DataSet();
                        SqlDataAdapter adUnit = new SqlDataAdapter(strQuery, cn);
                        adUnit.Fill(dsUnit, "Tabel_Unit");
                        ddlUnit.DataSource = dsUnit.Tables["Tabel_Unit"].DefaultView;
                        ddlUnit.DataTextField = "NAMA_UNIT";
                        ddlUnit.DataValueField = "KODE_UNIT";
                        ddlUnit.DataBind();
                        adUnit.Dispose();
                        dsUnit.Clear();
                    }
                    else
                    {
                        lblUnit.Visible = false;
                        ddlUnit.Visible = false;
                    }
                }

                if ((ddlDeputi.Items.Count == 0) || (ddlDeputi.SelectedValue == "000"))
                {
                    if ((Session["GradeID"].ToString().Substring(0, 1) == "1") || (Session["GradeID"].ToString() == "2") || (Session["GradeID"].ToString() == "3a"))//admin & validator
                    {
                        strQuery = "SELECT KODE_DEPUTI,NAMA_DEPUTI FROM q_Deputi";
                        if (Session["GradeID"].ToString() == "2") //validator
                        {
                            strQuery += " WHERE (KODE_CABANG ='" + Session["CabangID"].ToString() + "' OR KODE_DEPUTI='000')";
                        }
                        else if (Session["GradeID"].ToString() == "3a") //viewer
                        {
                            strQuery += " WHERE (KODE_DEPUTI IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE USERNAME ='" + Session["UserID"].ToString() + "') OR KODE_DEPUTI='000')";
                        }
                        else
                        {
                            if ((ddlInstansi.Items.Count > 0) && (ddlInstansi.SelectedValue != "-"))
                            {
                                strQuery += " WHERE (KODE_INSTANSI='" + ddlInstansi.SelectedValue + "' OR KODE_UNIT='-')";
                            }
                            else
                            {
                                strQuery += " WHERE 1=1";
                            }
                        }
                        if ((ddlUnit.Items.Count > 0) && (ddlUnit.SelectedValue != "-"))
                        {
                            strQuery += " AND (KODE_UNIT='" + ddlUnit.SelectedValue + "' OR KODE_DEPUTI='000')";
                        }
                        DataSet dsDeputi = new DataSet();
                        SqlDataAdapter adDeputi = new SqlDataAdapter(strQuery, cn);
                        adDeputi.Fill(dsDeputi, "Tabel_Deputi");
                        ddlDeputi.DataSource = dsDeputi.Tables["Tabel_Deputi"].DefaultView;
                        ddlDeputi.DataTextField = "NAMA_DEPUTI";
                        ddlDeputi.DataValueField = "KODE_DEPUTI";
                        ddlDeputi.DataBind();
                        adDeputi.Dispose();
                        dsDeputi.Clear();
                    }
                    else
                    {
                        lblDeputi.Visible = false;
                        ddlDeputi.Visible = false;
                    }
                }

                if ((ddlBiro.Items.Count == 0) || (ddlBiro.SelectedValue == "0000"))
                {
                    strQuery = "SELECT KODE_BIRO,NAMA_BIRO FROM q_Biro";
                    if (Session["GradeID"].ToString() == "2") //validator
                    {
                        strQuery += " WHERE (KODE_CABANG ='" + Session["CabangID"].ToString() + "' OR KODE_BIRO='0000')";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3") //operator
                    {
                        strQuery += " WHERE (KODE_BIRO IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "') OR KODE_BIRO='0000')";
                    }
                    else
                    {
                        strQuery += " WHERE 1=1";
                    }
                    if ((ddlDeputi.Items.Count > 0) && (ddlDeputi.SelectedValue != "000"))
                    {
                        strQuery += " AND (KODE_DEPUTI='" + ddlDeputi.SelectedValue + "' OR KODE_BIRO='0000')";
                    }
                    else if ((ddlUnit.Items.Count > 0) && (ddlUnit.SelectedValue != "-"))
                    {
                        strQuery += " AND (KODE_UNIT='" + ddlUnit.SelectedValue + "' OR KODE_DEPUTI='000')";
                    }
                    else if ((ddlInstansi.Items.Count > 0) && (ddlInstansi.SelectedValue != "-"))
                    {
                        strQuery += " AND (KODE_INSTANSI='" + ddlInstansi.SelectedValue + "' OR KODE_UNIT='-')";
                    }
                    DataSet dsBiro = new DataSet();
                    SqlDataAdapter adBiro = new SqlDataAdapter(strQuery, cn);
                    adBiro.Fill(dsBiro, "Tabel_Biro");
                    ddlBiro.DataSource = dsBiro.Tables["Tabel_Biro"].DefaultView;
                    ddlBiro.DataTextField = "NAMA_BIRO";
                    ddlBiro.DataValueField = "KODE_BIRO";
                    ddlBiro.DataBind();
                    adBiro.Dispose();
                    dsBiro.Clear();
                }

                if ((ddlBagian.Items.Count == 0) || (ddlBagian.SelectedValue == "00000"))
                {
                    strQuery = "SELECT KODE_BAGIAN,NAMA_BAGIAN FROM q_Bagian";
                    if (Session["GradeID"].ToString() == "2") //validator
                    {
                        strQuery += " WHERE (KODE_CABANG ='" + Session["CabangID"].ToString() + "' OR KODE_BAGIAN='00000')";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3") //operator
                    {
                        strQuery += " WHERE (LEFT(KODE_BAGIAN,4) IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "') OR KODE_BAGIAN='00000')";
                    }
                    else
                    {
                        strQuery += " WHERE 1=1";
                    }
                    if ((ddlBiro.Items.Count > 0) && (ddlBiro.SelectedValue != "0000"))
                    {
                        strQuery += " AND (KODE_BIRO='" + ddlBiro.SelectedValue + "' OR KODE_BAGIAN='00000')";
                    }
                    else if ((ddlDeputi.Items.Count > 0) && (ddlDeputi.SelectedValue != "000"))
                    {
                        strQuery += " AND (KODE_DEPUTI='" + ddlDeputi.SelectedValue + "' OR KODE_BIRO='0000')";
                    }
                    else if ((ddlUnit.Items.Count > 0) && (ddlUnit.SelectedValue != "-"))
                    {
                        strQuery += " AND (KODE_UNIT='" + ddlUnit.SelectedValue + "' OR KODE_DEPUTI='000')";
                    }
                    else if ((ddlInstansi.Items.Count > 0) && (ddlInstansi.SelectedValue != "-"))
                    {
                        strQuery += " AND (KODE_INSTANSI='" + ddlInstansi.SelectedValue + "' OR KODE_UNIT='-')";
                    }
                    DataSet dsBagian = new DataSet();
                    SqlDataAdapter adBagian = new SqlDataAdapter(strQuery, cn);
                    adBagian.Fill(dsBagian, "Tabel_Bagian");
                    ddlBagian.DataSource = dsBagian.Tables["Tabel_Bagian"].DefaultView;
                    ddlBagian.DataTextField = "NAMA_BAGIAN";
                    ddlBagian.DataValueField = "KODE_BAGIAN";
                    ddlBagian.DataBind();
                    adBagian.Dispose();
                    dsBagian.Clear();
                }

                if ((ddlSubbagian.Items.Count == 0) || (ddlSubbagian.SelectedValue == "000000"))
                {
                    strQuery = "SELECT KODE_SUBBAGIAN,NAMA_SUBBAGIAN FROM q_Subbagian";
                    if (Session["GradeID"].ToString() == "2") //validator
                    {
                        strQuery += " WHERE (KODE_CABANG ='" + Session["CabangID"].ToString() + "' OR KODE_SUBBAGIAN='000000')";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3") //operator
                    {
                        strQuery += " WHERE (LEFT(KODE_SUBBAGIAN,4) IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "') OR KODE_SUBBAGIAN='000000')";
                    }
                    else
                    {
                        strQuery += " WHERE 1=1";
                    }
                    if ((ddlBagian.Items.Count > 0) && (ddlBagian.SelectedValue != "00000"))
                    {
                        strQuery += " AND (KODE_BAGIAN='" + ddlBagian.SelectedValue + "' OR KODE_SUBBAGIAN='000000')";
                    }
                    if ((ddlBiro.Items.Count > 0) && (ddlBiro.SelectedValue != "0000"))
                    {
                        strQuery += " AND (KODE_BIRO='" + ddlBiro.SelectedValue + "' OR KODE_BAGIAN='00000')";
                    }
                    else if ((ddlDeputi.Items.Count > 0) && (ddlDeputi.SelectedValue != "000"))
                    {
                        strQuery += " AND (KODE_DEPUTI='" + ddlDeputi.SelectedValue + "' OR KODE_BIRO='0000')";
                    }
                    else if ((ddlUnit.Items.Count > 0) && (ddlUnit.SelectedValue != "-"))
                    {
                        strQuery += " AND (KODE_UNIT='" + ddlUnit.SelectedValue + "' OR KODE_DEPUTI='000')";
                    }
                    else if ((ddlInstansi.Items.Count > 0) && (ddlInstansi.SelectedValue != "-"))
                    {
                        strQuery += " AND (KODE_INSTANSI='" + ddlInstansi.SelectedValue + "' OR KODE_UNIT='-')";
                    }
                    DataSet dsSubbagian = new DataSet();
                    SqlDataAdapter adSubbagian = new SqlDataAdapter(strQuery, cn);
                    adSubbagian.Fill(dsSubbagian, "Tabel_Subbagian");
                    ddlSubbagian.DataSource = dsSubbagian.Tables["Tabel_Subbagian"].DefaultView;
                    ddlSubbagian.DataTextField = "NAMA_SUBBAGIAN";
                    ddlSubbagian.DataValueField = "KODE_SUBBAGIAN";
                    ddlSubbagian.DataBind();
                    adSubbagian.Dispose();
                    dsSubbagian.Clear();
                }

                if (ddlJabatan.Items.Count == 0)
                {
                    strQuery = "SELECT KODE_JABATAN,NAMA_JABATAN FROM taJabatan";
                    DataSet dsJabatan = new System.Data.DataSet();
                    SqlDataAdapter adJabatan = new SqlDataAdapter(strQuery, cn);
                    adJabatan.Fill(dsJabatan, "Tabel_Jabatan");
                    ddlJabatan.DataSource = dsJabatan.Tables["Tabel_Jabatan"].DefaultView;
                    ddlJabatan.DataTextField = "NAMA_JABATAN";
                    ddlJabatan.DataValueField = "KODE_JABATAN";
                    ddlJabatan.DataBind();
                    adJabatan.Dispose();
                    dsJabatan.Clear();
                }

                if (ddlGolongan.Items.Count == 0)
                {
                    strQuery = "SELECT KODE_GOLONGAN,NAMA_GOLONGAN FROM taGolongan";
                    DataSet dsGolongan = new DataSet();
                    SqlDataAdapter adGolongan = new SqlDataAdapter(strQuery, cn);
                    adGolongan.Fill(dsGolongan, "Tabel_Golongan");
                    ddlGolongan.DataSource = dsGolongan.Tables["Tabel_Golongan"].DefaultView;
                    ddlGolongan.DataTextField = "NAMA_GOLONGAN";
                    ddlGolongan.DataValueField = "KODE_GOLONGAN";
                    ddlGolongan.DataBind();
                    adGolongan.Dispose();
                    dsGolongan.Clear();
                }

                if (ddlGrade.Items.Count == 0)
                {
                    strQuery = "SELECT KODE_GRADE FROM taGrade";
                    DataSet dsGrade = new DataSet();
                    SqlDataAdapter adGrade = new SqlDataAdapter(strQuery, cn);
                    adGrade.Fill(dsGrade, "Tabel_Grade");
                    ddlGrade.DataSource = dsGrade.Tables["Tabel_Grade"].DefaultView;
                    ddlGrade.DataTextField = "KODE_GRADE";
                    ddlGrade.DataValueField = "KODE_GRADE";
                    ddlGrade.DataBind();
                    adGrade.Dispose();
                    dsGrade.Clear();
                }

                if (ddlEselon.Items.Count == 0)
                {
                    strQuery = "SELECT KODE_ESELON,NAMA_ESELON FROM taEselon";
                    DataSet dsEselon = new DataSet();
                    SqlDataAdapter adEselon = new SqlDataAdapter(strQuery, cn);
                    adEselon.Fill(dsEselon, "Tabel_Eselon");
                    ddlEselon.DataSource = dsEselon.Tables["Tabel_Eselon"].DefaultView;
                    ddlEselon.DataTextField = "NAMA_ESELON";
                    ddlEselon.DataValueField = "KODE_ESELON";
                    ddlEselon.DataBind();
                    adEselon.Dispose();
                    dsEselon.Clear();
                }

                if (ddlStatus.Items.Count == 0)
                {
                    strQuery = "SELECT KODE_STATUS_PEGAWAI,NAMA_STATUS_PEGAWAI FROM taStatusPegawai";
                    DataSet dsStatus = new DataSet();
                    SqlDataAdapter adStatus = new SqlDataAdapter(strQuery, cn);
                    adStatus.Fill(dsStatus, "Tabel_StatusPegawai");
                    ddlStatus.DataSource = dsStatus.Tables["Tabel_StatusPegawai"].DefaultView;
                    ddlStatus.DataTextField = "NAMA_STATUS_PEGAWAI";
                    ddlStatus.DataValueField = "KODE_STATUS_PEGAWAI";
                    ddlStatus.DataBind();
                    adStatus.Dispose();
                    dsStatus.Clear();
                }
                cn.Close();
            }
			
            //fungsi: menampilkan tipe-tipe laporan
			public void setTipeReport()
			{
				SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
				string strQuery = "";
				
				strQuery = "SELECT KODE_LAPORAN, NAMA_LAPORAN AS NAMA_LAPORAN FROM taLaporan WHERE PERIODE_LAPORAN='2'/* AND (TIPE_LAPORAN='1' OR TIPE_LAPORAN='2')*/ ";
                if ((Session["GradeID"].ToString() == "4") || (Session["GradeID"].ToString() == "3a")) //user
                {
                    strQuery += " AND LAP_USER = 1";
                }
                else if (Session["GradeID"].ToString() == "3") //operator
                {
                    strQuery += " AND LAP_OPERATOR = 1";
                }
                else if (Session["GradeID"].ToString() == "1a") //keuangan
                {
                    strQuery += " AND LAP_KEUANGAN = 1";
                }
                if ((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "2")) //admin + validator
                {
                    strQuery += " AND LAP_ADMIN = 1";
                }

                DataSet dsLaporan = new DataSet();
				SqlDataAdapter adLaporan = new SqlDataAdapter(strQuery, cn);
				adLaporan.Fill(dsLaporan, "Tabel_Laporan");
				rblReportType.DataSource = dsLaporan.Tables["Tabel_Laporan"].DefaultView;
				rblReportType.DataTextField = "NAMA_LAPORAN";
				rblReportType.DataValueField = "KODE_LAPORAN";
				rblReportType.DataBind();
				adLaporan.Dispose();
				dsLaporan.Clear();
				
				cn.Close();
			}
			
			protected void Page_Load(object sender, EventArgs e)
			{
				//jika userid kosong maka akan di link ke halaman awal
				if (! rtwin.azlib.AksesHalaman(22, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}

                if ((Session["GradeID"].ToString() != "4") /*&& (Session["GradeID"].ToString() != "1a")*/) //Admin / Operator
                {
                    setDepartemen();
                }
                
                //jika halaman bukan postback
				if (! Page.IsPostBack)
				{
					
					//Set Bulan dan Tahun
					int bln = DateTime.Now.Month;
					
					txtTahun1.Text = DateTime.Now.Year.ToString();
					byte i;
					ListItem li = new ListItem();
					for (i = 1; i <= 12; i++)
					{
						li = new ListItem((DateTime.Parse(i.ToString() + "/" + i.ToString() + " /1900")).ToString("MMMM"), i.ToString()); //Format(DateTime.Parse(CStr(i) & "/" & CStr(i) & " /1900"), "MMMM"), CStr(i))
						DropBulan.Items.Add(li);
					}
					
					DropBulan.SelectedValue = bln.ToString();
					
					li = new ListItem(System.Convert.ToString(DateTime.Now.Year - 2), System.Convert.ToString(DateTime.Now.Year - 2));
					ddlTahun.Items.Add(li);
					li = new ListItem(System.Convert.ToString(DateTime.Now.Year - 1), System.Convert.ToString(DateTime.Now.Year - 1));
					ddlTahun.Items.Add(li);
					li = new ListItem(DateTime.Now.Year.ToString(), DateTime.Now.Year.ToString());
					ddlTahun.Items.Add(li);
					ddlTahun.SelectedValue = DateTime.Now.Year.ToString();
					
					radTahun.Checked = true;
					
					//insialisasi nilai dropdownlist
                    if ((Session["GradeID"].ToString() != "4") /*&& (Session["GradeID"].ToString() != "1a")*/) //Admin / Operator
                    {
                        if (Session["GradeID"].ToString().Substring(0, 1) == "3") // Operator
                        {
                            hideAdmin2.Visible = false;
                        }
                        else if (Session["GradeID"].ToString() == "1a") // Operator Keuangan
                        {
                            hideAdmin2.Visible = false;
                        }
                    }
                    else
                    {
                        if (isEntryUseNIP())
                        {
                            txtFilterNIP.Text = Session["NIPID"].ToString();
                        }
                        else
                        {
                            txtFilterNIP.Text = Session["PINID"].ToString();
                        }
                        txtFilterNIP.Visible = false;
                        lblNIP.Visible = false;
                        lblPIN.Visible = false;
                        hide.Visible = false;
                    }
                    setTipeReport();
					
					//insialisasi jenis laporan
					rblReportType.SelectedIndex = 0;
					
					//inisialisasi control default value dan visible mode
					txtFilterItem0.Text = azlib.FirstDate(DateTime.Now.Date, Session["strLang"].ToString()).ToShortDateString();
					txtFilterItem1.Text = DateTime.Now.Date.ToShortDateString();

                    btnUpload.Visible = ((Session["GradeID"].ToString() == "1") || (Session["GradeID"].ToString() == "2"));

                    if (isEntryUseNIP())
                    {
                        lblPIN.Visible = false;
                    }
                    else
                    {
                        lblNIP.Visible = false;
                    }
				}
                doFilteringLookup();
			}
			
            //fungsi: Handle Proses Show Laporan
			protected void btnShow_Click(object sender, EventArgs e)
			{
                if (Page.IsValid)
                {
                    string strFilter = "";
                    string strKriteria = "";
                    string tgl = "";
                    string tgl2 = "";
                    //seleksi kondisi
                    if (txtFilterNIP.Text != "")
                    {
                        if (isEntryUseNIP())
                        {
                            strFilter += " AND NIP='" + txtFilterNIP.Text.Replace("'", "''") + "'";
                            strKriteria = "NIP: " + txtFilterNIP.Text;
                        }
                        else
                        {
                            strFilter += " AND PIN='" + azlib.FillNull(txtFilterNIP.Text, 10).Replace("'", "''") + "'";
                            strKriteria = "PIN: " + txtFilterNIP.Text;
                        }
                    }
                    if ((ddlInstansi.Items.Count > 0) && (ddlInstansi.SelectedValue != "-"))
                    {
                        strFilter += " AND KODE_INSTANSI='" + ddlInstansi.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Instansi: " + ddlInstansi.SelectedItem.Text);
                    }
                    if ((ddlUnit.Items.Count > 0) && (ddlUnit.SelectedValue != "-"))
                    {
                        strFilter += " AND KODE_UNIT='" + ddlUnit.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Unit: " + ddlUnit.SelectedItem.Text);
                    }
                    if ((ddlDeputi.Items.Count > 0) && (ddlDeputi.SelectedValue != "000"))
                    {
                        //strFilter += " AND KODE_DEPARTEMEN LIKE'" + ddlDeputi.SelectedValue.ToString().Substring(0,3) + "%'";
                        strFilter += " AND KODE_DEPUTI='" + ddlDeputi.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Satuan Organisasi: " + ddlDeputi.SelectedItem.Text);
                    }
                    if ((ddlBiro.Items.Count > 0) && (ddlBiro.SelectedValue != "0000"))
                    {
                        //strFilter += " AND KODE_DEPARTEMEN LIKE'" + ddlBiro.SelectedValue.ToString().Substring(0,4) + "%'";
                        strFilter += " AND KODE_BIRO='" + ddlBiro.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Satuan Organisasi: " + ddlBiro.SelectedItem.Text);
                    }
                    if ((ddlBagian.Items.Count > 0) && (ddlBagian.SelectedValue != "00000"))
                    {
                        //strFilter += " AND KODE_DEPARTEMEN LIKE'" + ddlBagian.SelectedValue.ToString().Substring(0,5) + "%'";
                        strFilter += " AND KODE_BAGIAN='" + ddlBagian.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Satuan Organisasi: " + ddlBagian.SelectedItem.Text);
                    }
                    if ((ddlSubbagian.Items.Count > 0) && (ddlSubbagian.SelectedValue != "000000"))
                    {
                        //strFilter += " AND KODE_DEPARTEMEN ='" + ddlSubbagian.SelectedValue.ToString() + "'";
                        strFilter += " AND KODE_SUBBAGIAN='" + ddlSubbagian.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Satuan Organisasi: " + ddlSubbagian.SelectedItem.Text);
                    }
                    if ((ddlJabatan.Items.Count > 0) && (ddlJabatan.SelectedValue != "000"))
                    {
                        strFilter += " AND KODE_JABATAN='" + ddlJabatan.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Jabatan: " + ddlJabatan.SelectedItem.Text);
                    }
                    if ((ddlGolongan.Items.Count > 0) && (ddlGolongan.SelectedValue != "00"))
                    {
                        strFilter += " AND KODE_GOLONGAN='" + ddlGolongan.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Golongan: " + ddlGolongan.SelectedItem.Text);
                    }
                    if ((ddlGrade.Items.Count > 0) && (ddlGrade.SelectedValue != "0"))
                    {
                        strFilter += " AND KODE_GRADE='" + ddlGrade.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Grade: " + ddlGrade.SelectedItem.Text);
                    }
                    if ((ddlEselon.Items.Count > 0) && (ddlEselon.SelectedValue != "0"))
                    {
                        strFilter += " AND KODE_ESELON='" + ddlEselon.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Eselon: " + ddlEselon.SelectedItem.Text);
                    }
                    if ((ddlStatus.Items.Count > 0) && (ddlStatus.SelectedValue != "0"))
                    {
                        strFilter += " AND KODE_STATUS_PEGAWAI='" + ddlStatus.SelectedValue + "'";
                        strKriteria = azlib.StringComma(strKriteria, "Status: " + ddlStatus.SelectedItem.Text);
                    }
                    if (Session["GradeID"].ToString().Substring(0, 1) == "2")
                    {
                        strFilter += " AND KODE_CABANG ='" + Session["CabangID"].ToString() + "'";
                    }
                    else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                    {
                        //if ((ddlBiro.SelectedValue == "0000") && (ddlBagian.SelectedValue == "00000") && (ddlSubbagian.SelectedValue == "000000")) //Operator
                        //{
                        strFilter += " AND KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                        //}
                    }

                    Session["strKodeRpt"] = rblReportType.SelectedValue;
                    if (radTanggal.Checked)
                    {
                        Session["strTgl"] = DateTime.Parse(txtFilterItem0.Text).ToString("yyyy-MM-dd HH:mm:ss");
                        Session["strTgl2"] = DateTime.Parse(txtFilterItem1.Text).ToString("yyyy-MM-dd HH:mm:ss");
                        Session["strTglTxt"] = txtFilterItem0.Text.Replace("'", "''");
                        Session["strTgl2Txt"] = txtFilterItem1.Text.Replace("'", "''");
                        Session["strTahun"] = "Tahun " + DateTime.Parse(txtFilterItem1.Text).ToString("yyyy");
                    }
                    else if (radBulan.Checked)
                    {
                        if (azlib.IsNumeric(txtTahun1.Text))
                        {
                            if (Session["strLang"].ToString() == "en")
                            {
                                tgl = DropBulan.SelectedValue + "/" + "1" + "/" + txtTahun1.Text;
                                tgl2 = azlib.LastDate(DateTime.Parse(tgl), "en").ToString("MM/dd/yyyy");
                                Session["strTgl"] = (DateTime.Parse(tgl)).ToString("yyyy-MM-dd HH:mm:ss");
                                Session["strTgl2"] = azlib.LastDate(DateTime.Parse(tgl), "en").ToString("yyyy-MM-dd HH:mm:ss");
                            }
                            else
                            {
                                tgl = "1" + "/" + DropBulan.SelectedValue + "/" + txtTahun1.Text;
                                tgl2 = azlib.LastDate(DateTime.Parse(tgl), "id").ToString("dd/MM/yyyy");
                                Session["strTgl"] = (DateTime.Parse(tgl)).ToString("yyyy-MM-dd HH:mm:ss");
                                Session["strTgl2"] = azlib.LastDate(DateTime.Parse(tgl), "id").ToString("yyyy-MM-dd HH:mm:ss");
                            }
                            Session["strTglTxt"] = tgl.Replace("'", "''");
                            Session["strTgl2Txt"] = tgl2.Replace("'", "''");
                            Session["strTahun"] = "Tahun " + txtTahun1.Text;
                        }
                        else
                        {
                            Response.Redirect(Request.Path);
                        }
                    }
                    else if (radTahun.Checked)
                    {
                        if (azlib.IsNumeric(ddlTahun.SelectedValue) && System.Convert.ToInt32(ddlTahun.SelectedValue) >= 1900)
                        {
                            if (Session["strLang"].ToString() == "en")
                            {
                                tgl = "1/1/" + ddlTahun.SelectedValue;
                                tgl2 = "12/31/" + ddlTahun.SelectedValue;
                                Session["strTgl"] = (DateTime.Parse(tgl)).ToString("yyyy-MM-dd HH:mm:ss");
                                Session["strTgl2"] = (DateTime.Parse(tgl2)).ToString("yyyy-MM-dd HH:mm:ss");
                            }
                            else
                            {
                                tgl = "1/1/" + ddlTahun.SelectedValue;
                                tgl2 = "31/12/" + ddlTahun.SelectedValue;
                                Session["strTgl"] = (DateTime.Parse(tgl)).ToString("yyyy-MM-dd HH:mm:ss");
                                Session["strTgl2"] = (DateTime.Parse(tgl2)).ToString("yyyy-MM-dd HH:mm:ss");
                            }
                            Session["strTglTxt"] = tgl.Replace("'", "''");
                            Session["strTgl2Txt"] = tgl2.Replace("'", "''");
                            Session["strTahun"] = "Tahun " + ddlTahun.SelectedValue;
                        }
                        else
                        {
                            Server.Transfer(Request.Path);
                        }
                    }
                    //Session("strTglTxt") = AspxdeTglAwal.Text.Replace("'", "''")
                    //Session("strTgl2Txt") = AspxdeTglAkhir.Text.Replace("'", "''")
                    Session["strFilter"] = strFilter;
                    Session["strKriteria2"] = "";
                    if (cbFilter.Checked)
                    {
                        Session["strKriteria"] = strKriteria;
                    }
                    else
                    {
                        Session["strKriteria"] = "";
                    }
                    Session["strOrder"] = rblSort.SelectedValue;

                    if ((rblReportType.SelectedValue.Substring(0, 1) == "G") || (rblReportType.SelectedValue.Substring(0, 1) == "H"))
                    {
                        if (ddlSubbagian.SelectedValue != "000000")
                        {
                            Session["strMode"] = "5";
                        }
                        else if (ddlBagian.SelectedValue != "00000")
                        {
                            Session["strMode"] = "4";
                        }
                        else if (ddlBiro.SelectedValue != "0000")
                        {
                            Session["strMode"] = "3";
                        }
                        else if (ddlDeputi.SelectedValue != "000")
                        {
                            Session["strMode"] = "2";
                        }
                        else
                        {
                            Session["strMode"] = "1";
                        }
                    }
                    //Response.Write(strFilter)
                    Response.Redirect("summary_report.aspx");
                }
			}

            //fungsi: Handle redirect ke halaman upload laporan
            protected void btnUpload_Click(object sender, EventArgs e)
            {
                Response.Redirect("upload_report.aspx");
            }

            //tampilkan Lookup Pegawai
            protected void lnkFilterNIP_Click(object sender, EventArgs e)
            {
                Session["Triger"] = "txtFilterNIP";
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
                    if (Session["Triger"].ToString() == "txtFilterNIP")
                    {
                        if (isEntryUseNIP())
                        {
                            this.txtFilterNIP.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                        }
                        else
                        {
                            this.txtFilterNIP.Text = GvLookupPegawai.SelectedRow.Cells[1].Text;
                        }
                    }
                    Session.Remove("Triger");
                }

                setInitialLookupState();
                UpdatePanel1.Update();
            }
}
	}
