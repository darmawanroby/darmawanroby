///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : daily.aspx.cs                             (Pseudo code)

//        File terkait  : daily.aspx                                (Form)
//                        \App_LocalResources\daily.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\daily.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan filter laporan Harian

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

namespace rtwin
	{
		
		public partial class daily : BasePage
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

            //fungsi: menampilkan tipe-tipe ijin
            public void setKodeIjin()
			{
				SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
				string strQuery = "";
				
				strQuery = "SELECT KODE_IJIN, KODE_IJIN + ': ' + KET_IJIN AS KETERANGAN_IJIN FROM taIjin where kode_tidak_hadir = '1' or kode_tidak_hadir = '2'";
				SqlDataAdapter adIjin = new SqlDataAdapter(strQuery, cn);
				DataSet dsIjin = new DataSet();
				adIjin.Fill(dsIjin, "Tabel_Ijin");
				cblKodeIjin.DataSource = dsIjin.Tables["Tabel_Ijin"].DefaultView;
				cblKodeIjin.DataTextField = "KETERANGAN_IJIN";
				cblKodeIjin.DataValueField = "KODE_IJIN";
				cblKodeIjin.DataBind();
				adIjin.Dispose();
				dsIjin.Clear();
				
				cn.Close();
			}
			
			protected void Page_Load(object sender, EventArgs e)
			{
				//jika userid kosong maka akan di link ke halaman awal
				if (! rtwin.azlib.AksesHalaman(20, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
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
					//insialisasi nilai dropdownlist
                    if ((Session["GradeID"].ToString() != "4") /*&& (Session["GradeID"].ToString() != "1a")*/) //Admin / Operator
                    {
                        if (Session["GradeID"].ToString().Substring(0, 1) == "3") // Operator
                        {
                            hideAdmin2.Visible = false;
                            hideAdmin2_2.Visible = false;
                        }
                        else if (Session["GradeID"].ToString() == "1a") // Operator Keuangan
                        {
                            hideAdmin2.Visible = false;
                            hideAdmin2_2.Visible = false;
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
					setKodeIjin();
					
					//inisialisasi control default value dan visible mode
                    txtFilterItem0.Text = DateTime.Now.Date.ToShortDateString();
					
					byte i;
					for (i = 0; i <= cblKriteria.Items.Count - 1; i++)
					{
						cblKriteria.Items[i].Selected = true;
					}
					for (i = 0; i <= cblKodeIjin.Items.Count - 1; i++)
					{
						cblKodeIjin.Items[i].Selected = true;
					}

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
                            strFilter += " AND PIN='" + azlib.FillNull(txtFilterNIP.Text,10).Replace("'", "''") + "'";
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

                    string strOperand;
                    if (rblOperand.Items[0].Selected)
                    {
                        strOperand = " AND";
                    }
                    else
                    {
                        strOperand = " OR";
                    }

                    byte intSelectCount = 0;
                    byte i;
                    for (i = 0; i <= cblKriteria.Items.Count - 1; i++)
                    {
                        if (cblKriteria.Items[i].Selected)
                        {
                            intSelectCount++;
                        }
                    }

                    byte intSelectCount2 = 0;
                    for (i = 0; i <= cblKodeIjin.Items.Count - 1; i++)
                    {
                        if (cblKodeIjin.Items[i].Selected)
                        {
                            intSelectCount2++;
                        }
                    }

                    string strFilter2 = "";
                    string strKriteria2 = "";
                    if ((cblKriteria.Items.Count != intSelectCount) && (intSelectCount != 0) || (cblKodeIjin.Items.Count != intSelectCount2))
                    {
                        if (cblKriteria.Items[0].Selected)
                        {
                            //strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (KETERANGAN='H' AND terlambat=0 AND cepat_pulang=0) ");
                            strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (JAM_MASUK <> JAM_KELUAR AND terlambat=0 AND cepat_pulang=0) ");
                            strKriteria2 = "Hadir Normal";
                        }
                        if (cblKriteria.Items[1].Selected)
                        {
                            //strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " ((KODE_IJIN='A')) ");
                            strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " ((STATUS_A=1)) ");
                            strKriteria2 = azlib.StringComma(strKriteria2, "Alpa");
                        }
                        if (cblKriteria.Items[2].Selected)
                        {
                            //strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (KETERANGAN = 'BAK') ");
                            strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " ((STATUS_BAK=1)) ");
                            strKriteria2 = azlib.StringComma(strKriteria2, "Belum Ada Keterangan");
                        }
                        if (cblKriteria.Items[3].Selected)
                        {
                            if ((cblKodeIjin.Items.Count == intSelectCount2) || (intSelectCount2 == 0))
                            {
                                strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (KODE_TIDAK_HADIR='1')");
                                strKriteria2 = azlib.StringComma(strKriteria2, "Alasan");
                            }
                            else
                            {
                                string strIjin = "";
                                for (i = 0; i <= cblKodeIjin.Items.Count - 1; i++)
                                {
                                    if (cblKodeIjin.Items[i].Selected == true)
                                    {
                                        if (strIjin == "")
                                        {
                                            strIjin = "'" + cblKodeIjin.Items[i].Text + "'";
                                        }
                                        else
                                        {
                                            strIjin += ",'" + cblKodeIjin.Items[i].Text + "'";
                                        }
                                    }
                                }
                                strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (KETERANGAN IN (" + strIjin + "))");
                                strKriteria2 = azlib.StringComma(strKriteria2, "Ijin (" + strIjin + ")");
                            }
                        }
                        if (cblKriteria.Items[4].Selected)
                        {
                            strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (terlambat > 0) ");
                            strKriteria2 = azlib.StringComma(strKriteria2, "Terlambat");
                        }
                        if (cblKriteria.Items[5].Selected)
                        {
                            strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (cepat_pulang > 0) ");
                            strKriteria2 = azlib.StringComma(strKriteria2, "Cepat Pulang");
                        }
                        if (cblKriteria.Items[6].Selected)
                        {
                            strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (total_lembur > 0) ");
                            strKriteria2 = azlib.StringComma(strKriteria2, "Lembur");
                        }
                        if (cblKriteria.Items[7].Selected)
                        {
                            //strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (keterangan LIKE '?%') ");
                            strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " ((JAM_MASUK=JAM_KELUAR) AND (KODE_ABSEN='1')) ");
                            strKriteria2 = azlib.StringComma(strKriteria2, "Absen 1x");
                        }
                        if (cblKriteria.Items[8].Selected)
                        {
                            strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (kode_range ='00' AND not (keterangan LIKE 'NA%')) ");
                            strKriteria2 = azlib.StringComma(strKriteria2, "Libur");
                        }
                        if (cblKriteria.Items[9].Selected)
                        {
                            strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (isi_manual ='Y') ");
                            strKriteria2 = azlib.StringComma(strKriteria2, "Absen Manual");
                        }
                        //If cblKriteria.Items[10].Selected Then
                        //    strFilter2 = azlib.StringKurungBuka(strFilter2, strOperand, " (NOT ket_ijin IS null) ")
                        //End If
                        if (strFilter2 != "")
                        {
                            strFilter += " AND " + strFilter2 + ")";
                            strKriteria2 = "Kriteria: " + strKriteria2;
                        }
                    }

                    Session["strTgl"] = DateTime.Parse(txtFilterItem0.Text).ToString("MM/dd/yyyy");
                    Session["strTglTxt"] = txtFilterItem0.Text.Replace("'", "''");
                    Session["strFilter"] = strFilter;
                    if (cbKriteria.Checked)
                    {
                        Session["strKriteria2"] = strKriteria2;
                    }
                    else
                    {
                        Session["strKriteria2"] = "";
                    }
                    if (cbFilter.Checked)
                    {
                        Session["strKriteria"] = strKriteria;
                    }
                    else
                    {
                        Session["strKriteria"] = "";
                    }
                    Session["strOrder"] = rblSort.SelectedValue;
                    //Response.Write(strFilter);
                    Session["strKodeRpt"] = "A1";
                    Response.Redirect("daily_report.aspx");
                }
			}
			
			protected void btnAllKriteria_Click(object sender, EventArgs e)
			{
				byte i;
				for (i = 0; i <= cblKriteria.Items.Count - 1; i++)
				{
					cblKriteria.Items[i].Selected = true;
				}
			}
			
			protected void btnClearKriteria_Click(object sender, EventArgs e)
			{
				byte i;
				for (i = 0; i <= cblKriteria.Items.Count - 1; i++)
				{
					cblKriteria.Items[i].Selected = false;
				}
			}
			
			protected void btnAllKodeIjin_Click(object sender, EventArgs e)
			{
				byte i;
				for (i = 0; i <= cblKodeIjin.Items.Count - 1; i++)
				{
					cblKodeIjin.Items[i].Selected = true;
				}
			}
			
			protected void btnClearKodeIjin_Click(object sender, EventArgs e)
			{
				byte i;
				for (i = 0; i <= cblKodeIjin.Items.Count - 1; i++)
				{
					cblKodeIjin.Items[i].Selected = false;
				}
			}

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
