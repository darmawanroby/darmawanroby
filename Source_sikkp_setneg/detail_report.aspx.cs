///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : detail_report.aspx.cs                             (Pseudo code)

//        File terkait  : detail_report.aspx                                (Form)
//                        \App_LocalResources\detail_report.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\detail_report.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan Laporan Bulanan

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
using System.IO;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;
using Udev.MasterPageWithLocalization.Classes;


	namespace rtwin
	{
		public partial class detail_report : BasePage
		{
			
			ReportDocument crys;
			bool rptOpen = false;
			
			protected void Page_Load(object sender, EventArgs e)
			{
				//jika userid kosong maka akan di link ke halaman awal
				if (! rtwin.azlib.AksesHalaman(21, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}

                string strfilerpt = "";
				string strkolomrpt = "";
				string strkolomfilter = "";
				string strtiperpt = "";
				
				string q = "SELECT KOLOM, FILE_LAPORAN, KOLOM_FILTER, TIPE_LAPORAN FROM taLaporan WHERE KODE_LAPORAN = '" + Session["strKodeRpt"] + "'";
                string cn = "";
                if (Convert.ToInt32(Session["strTglTxt"].ToString().Substring(Session["strTglTxt"].ToString().Length - 4)) >= 2014)
                {
                    cn = Application["strCn"].ToString(); //ConfigurationManager.AppSettings("StrCn")
                }
                else
                {
                    cn = Application["strCnRpt"].ToString(); //ConfigurationManager.AppSettings("StrCnRpt")
                }
				//Response.Write(Session["strTglTxt"].ToString());
				SqlConnection con = new SqlConnection(cn);
				con.Open();
				SqlDataAdapter da = new SqlDataAdapter(q, con);
				DataSet dsRpt = new DataSet();
				da.Fill(dsRpt);
				if (dsRpt.Tables[0].Rows.Count == 0)
				{
					lblMessage.Text = "No Report Found";
					//Response.Write(q)
				}
				else
				{
					strkolomrpt = dsRpt.Tables[0].Rows[0][0].ToString();
                    if ((Session["strlang"].ToString() == "id") || (Session["strlang"].ToString() == ""))
					{
                        strfilerpt = "app_data/" + dsRpt.Tables[0].Rows[0][1].ToString() + ".rpt";
					}
					else
					{
                        strfilerpt = "app_data/" + dsRpt.Tables[0].Rows[0][1].ToString() + "_en.rpt";
					}
					if (! File.Exists(Server.MapPath(strfilerpt)))
					{
						lblMessage.Text = "File Report Not Found";
					}
					else
					{
						rptOpen = true;
					}
					strkolomfilter = dsRpt.Tables[0].Rows[0][2].ToString();
					strtiperpt = dsRpt.Tables[0].Rows[0][3].ToString();
					//Response.Write(strfilerpt)
				}

                byte i=1;
                string[] arIjin = new string[24] { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" };
                string[] arLibur = new string[32] { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" };
                if (rptOpen)
				{
                    string jml_data_bln_lalu = "0";
                    string jml_penambahan_pegawai = "0";
                    string jml_pengurangan_pegawai = "0";
                    string jml_data_bln_ini = "0";
                    if ((Session["strKodeRpt"].ToString() == "B1") || (Session["strKodeRpt"].ToString() == "C1") || (Session["strKodeRpt"].ToString() == "C9") || (Session["strKodeRpt"].ToString() == "E4") || (Session["strKodeRpt"].ToString() == "E6"))
                    {
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
                    }
                    else if ((Session["strKodeRpt"].ToString() == "E2") || (Session["strKodeRpt"].ToString() == "E9") || (Session["strKodeRpt"].ToString() == "ED") || (Session["strKodeRpt"].ToString() == "EA"))
                    {
                        i = 1;
                        DateTime tmpDate = DateTime.Parse(Session["strTgl"].ToString());
                        //Response.Write(tmpDate.ToString());
                        //SqlDataAdapter db;
                        DataSet dsLibur = new DataSet();
                        for (i = 1; i <= 31; i++)
                        {
                            int dow = (int)tmpDate.DayOfWeek;
                            if (dow == 6 || dow == 0)
                            {
                                arLibur[i] = "1";
                            }
                            else
                            {
                                //Response.Write(tmpDate.ToString("MM/dd/yyyy"));
                                //arLibur[i] = "0";
                                arLibur[i] = azlib.getLibur(tmpDate, Application["strCn"].ToString());
                            }
                            tmpDate = tmpDate.AddDays(1);
                        }
                    }
                    else if (Session["strKodeRpt"].ToString() == "EE")
                    {
                        q = "SELECT COUNT(*) as jml_data_bln_lalu from taRptUangMakan WHERE BULAN = MONTH('" + Session["strTgl"] + "')-1" + " AND TAHUN = YEAR('" + Session["strTgl2"] + "')" + Session["strFilter"] + " " + strkolomfilter + " ";
                        SqlDataAdapter db = new SqlDataAdapter(q, con);
                        DataSet dsJml = new DataSet();
                        db.Fill(dsJml);
                        if (dsJml.Tables[0].Rows.Count > 0)
                        {
                            DataTable tblIjin = dsJml.Tables[0];
                            foreach (DataRow myRow in tblIjin.Rows)
                            {
                                jml_data_bln_lalu = myRow["jml_data_bln_lalu"].ToString();
                            }
                        }
                        q = "SELECT COUNT(*) as jml_penambahan_pegawai from q_PerubahanUM WHERE BULAN = MONTH('" + Session["strTgl"] + "')" + " AND TAHUN = YEAR('" + Session["strTgl2"] + "')" + Session["strFilter"] + " " + strkolomfilter + " and perubahan = 'Pemberian UM baru'";
                        SqlDataAdapter db3 = new SqlDataAdapter(q, con);
                        DataSet dsJml2 = new DataSet();
                        db3.Fill(dsJml2);
                        if (dsJml2.Tables[0].Rows.Count > 0)
                        {
                            DataTable tblIjin2 = dsJml2.Tables[0];
                            foreach (DataRow myRow in tblIjin2.Rows)
                            {
                                jml_penambahan_pegawai = myRow["jml_penambahan_pegawai"].ToString();
                            }
                        }
                        q = "SELECT COUNT(*) as jml_pengurangan_pegawai from q_PerubahanUM WHERE BULAN = MONTH('" + Session["strTgl"] + "')" + " AND TAHUN = YEAR('" + Session["strTgl2"] + "')" + Session["strFilter"] + " " + strkolomfilter + " and perubahan = 'Pemberhentian UM'";
                        SqlDataAdapter db4 = new SqlDataAdapter(q, con);
                        DataSet dsJml3 = new DataSet();
                        db4.Fill(dsJml3);
                        if (dsJml3.Tables[0].Rows.Count > 0)
                        {
                            DataTable tblIjin3 = dsJml3.Tables[0];
                            foreach (DataRow myRow in tblIjin3.Rows)
                            {
                                jml_pengurangan_pegawai = myRow["jml_pengurangan_pegawai"].ToString();
                            }
                        }
                        q = "SELECT COUNT(*) as jml_data_bln_ini from taRptUangMakan WHERE BULAN = MONTH('" + Session["strTgl"] + "')" + " AND TAHUN = YEAR('" + Session["strTgl2"] + "')" + Session["strFilter"] + " " + strkolomfilter + " ";
                        SqlDataAdapter db5 = new SqlDataAdapter(q, con);
                        DataSet dsJml4 = new DataSet();
                        db5.Fill(dsJml4);
                        if (dsJml4.Tables[0].Rows.Count > 0)
                        {
                            DataTable tblIjin4 = dsJml4.Tables[0];
                            foreach (DataRow myRow in tblIjin4.Rows)
                            {
                                jml_data_bln_ini = myRow["jml_data_bln_ini"].ToString();
                            }
                        }
                    }

                    string TTD1Header = "";
                    string TTD1 = "";
                    string TTD2Header = "";
                    string TTD2 = "";
                    string TTD3Header = "";
                    string TTD3 = "";
                    if (((Session["strKodeRpt"].ToString() == "E3") && (Session["CabangID"].ToString() != "001")) || (Session["strKodeRpt"].ToString() == "E9") || (Session["strKodeRpt"].ToString() == "EB")  || (Session["strKodeRpt"].ToString() == "EC") || (Session["strKodeRpt"].ToString() == "E8") || (Session["strKodeRpt"].ToString() == "ED"))
                    {
                        q = "SELECT TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3 FROM taLaporanPengesahanLembur WHERE KODE_LAPORAN = '" + Session["strKodeRpt"] + "' AND USERNAME='" + Session["UserID"].ToString() + "'";
                    }
                    else
                    {
                        q = "SELECT TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3 FROM taLaporanPengesahan WHERE KODE_LAPORAN = '" + Session["strKodeRpt"] + "' AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                    }
                    
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

                    crys = new ReportDocument();
					crys.Load(Server.MapPath(strfilerpt));
					if (strtiperpt == "1")
					{
						DataSet ds = new DataSet();
                        if (Session["strKodeRpt"].ToString() != "EE")
                        {
                            q = "select " + strkolomrpt + " from q_AbsenHarianDetil WHERE TGL_MASUK BETWEEN '" + Session["strTgl"] + "'" + " AND '" + Session["strTgl2"] + "'" + Session["strFilter"] + " " + strkolomfilter + " ORDER BY KODE_UNIT," + Session["strOrder"];
                        }
                        else
                        {
                            q = "select " + strkolomrpt + " from q_PerubahanUM WHERE BULAN = MONTH('" + Session["strTgl"] + "')" + " AND TAHUN = YEAR('" + Session["strTgl2"] + "')" + Session["strFilter"] + " " + strkolomfilter + " ORDER BY KODE_SATKER," + Session["strOrder"];
                        }
						//Response.Write(q);
						SqlCommand sc = new SqlCommand(q, con);
						sc.CommandTimeout = 0;
						
						SqlDataAdapter daRpt = new SqlDataAdapter(sc);
						//Dim daRpt As New SqlDataAdapter(q, con)
                        if (Session["strKodeRpt"].ToString() != "EE")
                        {
                            daRpt.Fill(ds, "q_AbsenHarianDetil");
                        }
                        else
                        {
                            daRpt.Fill(ds, "q_PerubahanUM");
                        }
						//daRpt.Fill(ds, "qRB")
						con.Close();
						rptOpen = true;
						
						crys.SetDataSource(ds);
                        crys.Refresh();
                        if (Session["strKodeRpt"].ToString() == "EE")
                        {
                            crys.DataSourceConnections[0].SetConnection("localhost", "DataReal", false);
                            crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
                            crys.VerifyDatabase();
                            crys.SetParameterValue("umbulanlalu", jml_data_bln_lalu);
                            crys.SetParameterValue("penambahanpegawai", jml_penambahan_pegawai);
                            crys.SetParameterValue("penguranganpegawai", jml_pengurangan_pegawai);
                            crys.SetParameterValue("umbulanini", jml_data_bln_ini);
                        }
                    }
					else
                    {
                        con.Close();
                        //crys.DataSourceConnections.Item(0).IntegratedSecurity = False
                        if (Convert.ToInt32(Session["strTglTxt"].ToString().Substring(Session["strTglTxt"].ToString().Length - 4)) >= 2014)
                        {
                            crys.DataSourceConnections[0].SetConnection("localhost", "DataReal", false);
							crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
                        }
                        else
                        {
                            crys.DataSourceConnections[0].SetConnection("siapdb", "DataReal", false);
							crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
							crys.VerifyDatabase();
                        }
                        //crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
                        //crys.SetDatabaseLogon("rekabio", "Meinardi", Application("DatabaseServer"), "DataReal")
                        if (Session["strKodeRpt"].ToString() != "AA")
                        {
                            //crys.VerifyDatabase();
                        }
                        if ((Session["strKodeRpt"].ToString() == "E7") || (Session["strKodeRpt"].ToString() == "E8") || (Session["strKodeRpt"].ToString() == "E9"))
                        {
                            crys.VerifyDatabase();
                        }
                        //crys.SetDataSource(ds)
                        { } crys.SetParameterValue("@dTglAwal", Session["strTgl"].ToString());
                        { } crys.SetParameterValue("@dTglAkhir", Session["strTgl2"].ToString());
                        crys.SetParameterValue("@sSqlFilter", Session["strFilter"].ToString() + strkolomfilter);
						//Response.Write(Session["strFilter"].ToString());
                        if (Session["strKodeRpt"].ToString().Substring(0, 1) == "G")
                        {
                            crys.SetParameterValue("@sTypeStatistik", Session["strKodeRpt"].ToString().Substring(1, 1));
                            crys.SetParameterValue("@sTypeGroup", Session["strMode"].ToString());
                            if (Session["strKodeRpt"].ToString().Substring(1, 1) == "1")
                            {
                                crys.SummaryInfo.ReportTitle = "LAPORAN STATISTIK KEHADIRAN";
                            }
                            else if (Session["strKodeRpt"].ToString().Substring(1, 1) == "2")
                            {
                                crys.SummaryInfo.ReportTitle = "LAPORAN STATISTIK KETERLAMBATAN";
                            }
                            else if (Session["strKodeRpt"].ToString().Substring(1, 1) == "3")
                            {
                                crys.SummaryInfo.ReportTitle = "LAPORAN STATISTIK PULANG CEPAT";
                            }
                            else if (Session["strKodeRpt"].ToString().Substring(1, 1) == "4")
                            {
                                crys.SummaryInfo.ReportTitle = "LAPORAN STATISTIK KETIDAKHADIRAN HARIAN";
                            }
                            else if (Session["strKodeRpt"].ToString().Substring(1, 1) == "5")
                            {
                                crys.SummaryInfo.ReportTitle = "LAPORAN STATISTIK LEMBUR";
                            }
                            else if (Session["strKodeRpt"].ToString().Substring(1, 1) == "6")
                            {
                                crys.SummaryInfo.ReportTitle = "LAPORAN STATISTIK TINGKAT KEDISIPLINAN";
                            }
                        }
                        else
                        {
                            if ((Session["strKodeRpt"].ToString() == "E3") || (Session["strKodeRpt"].ToString() == "E8"))
                            {
                            crys.SetParameterValue("@sSqlOrder", " HAVING SUM(HADIR_MAKAN) > 0 ORDER BY KODE_UNIT," + Session["strOrder"]);
                            }
                            else if (Session["strKodeRpt"].ToString() != "H2")
                            {
                            crys.SetParameterValue("@sSqlOrder", " ORDER BY KODE_UNIT," + Session["strOrder"]);
                            }
                        }
                    }
                    crys.SetParameterValue("Satker", Session["Cabang"].ToString());
                    crys.SetParameterValue("Tanggal", Session["strBulan"].ToString());
                    //crys.SetParameterValue("Tanggal", Session["strTglTxt"].ToString() + " - " + Session["strTgl2Txt"].ToString());
                    crys.SetParameterValue("Kelompok", Session["strKriteria"].ToString());
                    if ((strtiperpt == "1") && (Session["strKodeRpt"].ToString() != "EE"))
                    {
                        crys.SetParameterValue("Kriteria", Session["strKriteria2"].ToString());
                        crys.SetParameterValue("AbsenManual", false);
                    }
                    if (strtiperpt != "3")
                    {
                        crys.SetParameterValue("TTD1.Header", TTD1Header);
                        crys.SetParameterValue("TTD1", TTD1);
                        crys.SetParameterValue("TTD2.Header", TTD2Header);
                        crys.SetParameterValue("TTD2", TTD2);
                        crys.SetParameterValue("TTD3.Header", TTD3Header);
                        crys.SetParameterValue("TTD3", TTD3);
                        if ((Session["strKodeRpt"].ToString() == "B1") || (Session["strKodeRpt"].ToString() == "C1") || (Session["strKodeRpt"].ToString() == "C9") || (Session["strKodeRpt"].ToString() == "E4") || (Session["strKodeRpt"].ToString() == "E6"))
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
                            if ((Session["strKodeRpt"].ToString() == "B1") && (Convert.ToInt32(Session["strTglTxt"].ToString().Substring(Session["strTglTxt"].ToString().Length - 4)) >= 2014))
                            {
                                crys.SetParameterValue("Ket22", arIjin[22]);
                                crys.SetParameterValue("Ket23", "FL : Waktu Fleksibel");
                                crys.SetParameterValue("Ket24", "TL : Terlambat");
                                crys.SetParameterValue("Ket25", "PSW : Pulang Sebelum Waktunya");
                            }
                        }
                        if ((Session["strKodeRpt"].ToString() == "E2") || (Session["strKodeRpt"].ToString() == "E9") || (Session["strKodeRpt"].ToString() == "EC") || (Session["strKodeRpt"].ToString() == "ED") || (Session["strKodeRpt"].ToString() == "EA"))
                        {
                            crys.SetParameterValue("Libur01", arLibur[1]);
                            crys.SetParameterValue("Libur02", arLibur[2]);
                            crys.SetParameterValue("Libur03", arLibur[3]);
                            crys.SetParameterValue("Libur04", arLibur[4]);
                            crys.SetParameterValue("Libur05", arLibur[5]);
                            crys.SetParameterValue("Libur06", arLibur[6]);
                            crys.SetParameterValue("Libur07", arLibur[7]);
                            crys.SetParameterValue("Libur08", arLibur[8]);
                            crys.SetParameterValue("Libur09", arLibur[9]);
                            crys.SetParameterValue("Libur10", arLibur[10]);
                            crys.SetParameterValue("Libur11", arLibur[11]);
                            crys.SetParameterValue("Libur12", arLibur[12]);
                            crys.SetParameterValue("Libur13", arLibur[13]);
                            crys.SetParameterValue("Libur14", arLibur[14]);
                            crys.SetParameterValue("Libur15", arLibur[15]);
                            crys.SetParameterValue("Libur16", arLibur[16]);
                            crys.SetParameterValue("Libur17", arLibur[17]);
                            crys.SetParameterValue("Libur18", arLibur[18]);
                            crys.SetParameterValue("Libur19", arLibur[19]);
                            crys.SetParameterValue("Libur20", arLibur[20]);
                            crys.SetParameterValue("Libur21", arLibur[21]);
                            crys.SetParameterValue("Libur22", arLibur[22]);
                            crys.SetParameterValue("Libur23", arLibur[23]);
                            crys.SetParameterValue("Libur24", arLibur[24]);
                            crys.SetParameterValue("Libur25", arLibur[25]);
                            crys.SetParameterValue("Libur26", arLibur[26]);
                            crys.SetParameterValue("Libur27", arLibur[27]);
                            crys.SetParameterValue("Libur28", arLibur[28]);
                            crys.SetParameterValue("Libur29", arLibur[29]);
                            crys.SetParameterValue("Libur30", arLibur[30]);
                            crys.SetParameterValue("Libur31", arLibur[31]);
                        }
                    }
					crPeriode.EnableParameterPrompt = true;
					crPeriode.DisplayGroupTree = false;
					crPeriode.HasCrystalLogo = false;
					//crPeriode.SelectionFormula = "{qRB.nip} = '" & Request.QueryString("nip") & "'"
					crPeriode.ReportSource = crys;
					crPeriode.DataBind();
				}
				else
				{
					con.Close();
				}
			}
			
			protected void Page_Unload(object sender, EventArgs e)
			{
				if (rptOpen)
				{
					try
					{
					crys.Close();
					crys.Dispose();
					}
					catch
					{
					}
				}
			}
		}
	}
