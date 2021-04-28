///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : daily_report.aspx.cs                             (Pseudo code)

//        File terkait  : daily_report.aspx                                (Form)
//                        \App_LocalResources\daily_report.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\daily_report.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan Laporan Harian

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 12/09/2009
//
// 4. Versi             : 2.0.1
//
// 5. Historis revisi
//        Versi 2.0.1   : Penyesuaian tampilan dan kolom-kolom laporan
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
using CrystalDecisions.CrystalReports.Engine;
using Udev.MasterPageWithLocalization.Classes;


	namespace rtwin
	{
		public partial class daily_report : BasePage
		{
			
			ReportDocument crys;
			
			protected void Page_Load(object sender, EventArgs e)
            {
                //jika userid kosong maka akan di link ke halaman awal
                if (!rtwin.azlib.AksesHalaman(20, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    Response.Redirect("notauthorized.aspx");
                }
                string q = "";
                string cn = "";
                if (Convert.ToInt32(Session["strTgl"].ToString().Substring(Session["strTgl"].ToString().Length - 4)) >= 2014)
                {
                    cn = Application["strCn"].ToString(); //ConfigurationManager.AppSettings("StrCn")
                }
                else
                {
                    cn = Application["strCnRpt"].ToString(); //ConfigurationManager.AppSettings("StrCnRpt")
                }
                SqlConnection con = new SqlConnection(cn);
                con.Open();

                byte i = 1;
                string[] arIjin = new string[24] { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" };
                q = "SELECT KODE_IJIN+': '+KET_IJIN AS DESKRIPSI_IJIN FROM taIjin WHERE KODE_TIDAK_HADIR>='1' AND KODE_TIDAK_HADIR<='5' ORDER BY KODE_TIDAK_HADIR, KODE_IJIN";
                SqlDataAdapter db = new SqlDataAdapter(q, con);
                DataSet dsIjin = new DataSet();
                db.Fill(dsIjin);
                if (dsIjin.Tables[0].Rows.Count > 0)
                {
                    DataTable tblIjin = dsIjin.Tables[0];
                    foreach (DataRow myRow in tblIjin.Rows)
                    {
                        arIjin[i] = myRow["DESKRIPSI_IJIN"].ToString();
                        i++;
                    }
                }

                string TTD1Header = "";
                string TTD1 = "";
                string TTD2Header = "";
                string TTD2 = "";
                string TTD3Header = "";
                string TTD3 = "";
                q = "SELECT TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3 FROM taLaporanPengesahan WHERE KODE_LAPORAN = 'A1' AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                SqlDataAdapter db2 = new SqlDataAdapter(q, con);
                DataSet dsPengesahan = new DataSet();
                db2.Fill(dsPengesahan);
                if (dsPengesahan.Tables[0].Rows.Count > 0)
                {
                    DataTable tblPengesahan = dsPengesahan.Tables[0];
                    foreach (DataRow myRow in tblPengesahan.Rows)
                    {
                        TTD1Header = myRow["TTD1_HEADER"].ToString();
                        TTD1 = myRow["TTD1"].ToString();
                        TTD2Header = myRow["TTD2_HEADER"].ToString();
                        TTD2 = myRow["TTD2"].ToString();
                        TTD3Header = myRow["TTD3_HEADER"].ToString();
                        TTD3 = myRow["TTD3"].ToString();
                    }
                }

                DataSet ds = new DataSet();
                //q = "select NIP, NAMA, JAM_MASUK, JAM_KELUAR, JAM_AWAL, JAM_AKHIR, TERLAMBAT, CEPAT_PULANG, CEPAT_DATANG, LAMBAT_PULANG, KODE_RANGE, KETERANGAN, NAMA_SEKTOR, NAMA_DIREKTORAT, NAMA_BIRO, NAMA_SEKSI, STATUS_A, STATUS_BAK, STATUS_CB, STATUS_CH, STATUS_CMP, STATUS_CS, STATUS_CT, STATUS_CX, STATUS_D, STATUS_DP, STATUS_DS, STATUS_L, STATUS_PN, STATUS_PS, STATUS_PT, STATUS_S, STATUS_SC, STATUS_TP, STATUS_LA, STATUS_HTT, BUKTI_IJIN, JAM_TENGAH, mmEFEKTIF, KODE_BIRO_SEKSI from q_AbsenHarianDetil" + Session["strMode"] + " WHERE TGL_MASUK='" + Session["strTgl"] + "'" + Session["strFilter"] + " ORDER BY KODE_BIRO_SEKSI," + Session["strOrder"];
                if (Session["strKodeRpt"].ToString() == "A1") //harian
                {
                    q = "select * from q_AbsenHarianDetil WHERE TGL_MASUK='" + Session["strTgl"] + "'" + Session["strFilter"] + " ORDER BY KODE_INSTANSI, KODE_UNIT, KODE_DEPUTI, KODE_BIRO, KODE_BAGIAN, KODE_SUBBAGIAN," + Session["strOrder"];
                }
                else if (Session["strKodeRpt"].ToString() == "A3") //rekap harian
                {
                    q = "select * from q_absenkehadiran WHERE TGL_MASUK='" + Session["strTgl"] + "'" + Session["strFilter"] + "";
                }
                else //upacara 
                {
                    q = "select * from q_AbsenUpacaraDetil WHERE TGL_MASUK='" + Session["strTgl"] + "'" + Session["strFilter"] + " ORDER BY KODE_INSTANSI, KODE_UNIT, KODE_DEPUTI, KODE_BIRO, KODE_BAGIAN, KODE_SUBBAGIAN," + Session["strOrder"];
                }
                //Response.Write(q);

                SqlCommand sc = new SqlCommand(q, con);
                sc.CommandTimeout = 0;

                SqlDataAdapter da = new SqlDataAdapter(sc);
                if (Session["strKodeRpt"].ToString() != "A3") 
                {
                da.Fill(ds, "q_AbsenHarianDetil");
                }
                else
                {
                da.Fill(ds, "q_AbsenKehadiran");
                }

                con.Close();

                crys = new ReportDocument();
                if (Session["strKodeRpt"].ToString() == "A1") //harian
                {
                    crys.Load(Server.MapPath("App_Data/RptLap_Harian.rpt"));
                }
                else if (Session["strKodeRpt"].ToString() == "A3") //rekap harian
                {
                    crys.Load(Server.MapPath("App_Data/RptLap_RekapitulasiKehadiran.rpt"));
                }
                else //upacara
                {
                    crys.Load(Server.MapPath("App_Data/RptLap_Upacara.rpt"));
                }
                if (Session["strKodeRpt"].ToString() != "A1")
                {
                    if (Convert.ToInt32(Session["strTgl"].ToString().Substring(Session["strTgl"].ToString().Length - 4)) >= 2014)
                    {
                        crys.DataSourceConnections[0].SetConnection("localhost", "DataReal", false);
                    }
                    else
                    {
                        crys.DataSourceConnections[0].SetConnection("siapdb", "DataReal", false);
                    }
                    crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
                }
                crys.SetDataSource(ds);
                //crys.VerifyDatabase();
                crys.SetParameterValue("Satker", Session["Cabang"].ToString());
                crys.SetParameterValue("Tanggal", "Tanggal: " + Session["strTglTxt"].ToString());
                crys.SetParameterValue("Kelompok", Session["strKriteria"].ToString());
                if (Session["strKodeRpt"].ToString() != "A3")
                {
                    crys.SetParameterValue("Kriteria", Session["strKriteria2"].ToString());
                    crys.SetParameterValue("AbsenManual", false);
                }
                crys.SetParameterValue("TTD1.Header", TTD1Header);
                crys.SetParameterValue("TTD1", TTD1);
                crys.SetParameterValue("TTD2.Header", TTD2Header);
                crys.SetParameterValue("TTD2", TTD2);
                crys.SetParameterValue("TTD3.Header", TTD3Header);
                crys.SetParameterValue("TTD3", TTD3);
                if (Session["strKodeRpt"].ToString() != "A3")
                {
                    crys.SetParameterValue("Ket1", arIjin[1]);
                    crys.SetParameterValue("Ket2", arIjin[2]);
                    crys.SetParameterValue("Ket3", arIjin[3]);
                    crys.SetParameterValue("Ket4", arIjin[4]);
                    crys.SetParameterValue("Ket5", arIjin[5]);
                    crys.SetParameterValue("Ket6", arIjin[6]);
                    crys.SetParameterValue("Ket7", arIjin[7]);
                    crys.SetParameterValue("Ket8", arIjin[8]);
                    crys.SetParameterValue("Ket9", arIjin[9]);
                    crys.SetParameterValue("Ket10", arIjin[10]);
                    crys.SetParameterValue("Ket11", arIjin[11]);
                    crys.SetParameterValue("Ket12", arIjin[12]);
                    crys.SetParameterValue("Ket13", arIjin[13]);
                    crys.SetParameterValue("Ket14", arIjin[14]);
                    crys.SetParameterValue("Ket15", arIjin[15]);
                    crys.SetParameterValue("Ket16", arIjin[16]);
                    crys.SetParameterValue("Ket17", arIjin[17]);
                    crys.SetParameterValue("Ket18", arIjin[18]);
                    crys.SetParameterValue("Ket19", arIjin[19]);
                    crys.SetParameterValue("Ket20", arIjin[20]);
                    crys.SetParameterValue("Ket21", arIjin[21]);
                }
                //crHarian.EnableParameterPrompt = true;
                crHarian.DisplayGroupTree = false;
                crHarian.HasCrystalLogo = false;
                //crHarian.SelectionFormula = "{qRB.nip} = '" & Request.QueryString("nip") & "'";
                crHarian.ReportSource = crys;
                crHarian.DataBind();
            }
			
			protected void Page_Unload(object sender, EventArgs e)
			{
				try
				{
					crys.Close();
					crys.Dispose();
				}
				catch (Exception)
				{
				}
			}
		}
	}
