///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : summary_report.aspx.cs                             (Pseudo code)

//        File terkait  : summary_report.aspx                                (Form)
//                        \App_LocalResources\summary_report.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\summary_report.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan Laporan tahunan

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
		public partial class summary_report : BasePage
		{
			
			ReportDocument crys;
			bool rptOpen = false;
			
			protected void Page_Load(object sender, EventArgs e)
			{
				//jika userid kosong maka akan di link ke halaman awal
				if (! rtwin.azlib.AksesHalaman(22, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}
				
				string strfilerpt = "";
				string strkolomrpt = "";
				string strkolomgroup = "";
				string strkolomfilter = "";
                string strtiperpt = "";

                string q = "SELECT KOLOM, FILE_LAPORAN, KOLOM_GROUP, KOLOM_FILTER, TIPE_LAPORAN FROM taLaporan WHERE KODE_LAPORAN = '" + Session["strKodeRpt"] + "'";
				string cn = Application["strCnRpt"].ToString(); //ConfigurationManager.AppSettings("StrCnRpt")
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
					strkolomgroup = dsRpt.Tables[0].Rows[0][2].ToString();
					strkolomfilter = dsRpt.Tables[0].Rows[0][3].ToString();
					//Response.Write(strfilerpt)
					//Response.Write(Session("strTgl") & "  " & Session("strTgl2") & "  " & Session("strFilter"))
				}
                strtiperpt = dsRpt.Tables[0].Rows[0][4].ToString();

                byte i = 1;
                string[] arIjin = new string[22] { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" };
                if (rptOpen)
				{
                    if ((Session["strKodeRpt"].ToString() == "D1"))
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

                    string TTD1Header = "";
                    string TTD1 = "";
                    string TTD2Header = "";
                    string TTD2 = "";
                    string TTD3Header = "";
                    string TTD3 = "";
                    q = "SELECT TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3 FROM taLaporanPengesahan WHERE KODE_LAPORAN = '" + Session["strKodeRpt"] + "' AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
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
                    crys.SetDatabaseLogon("rekabio", "Meinardi", Application["DatabaseServer"].ToString(), "DataReal");
                    //crys.DataSourceConnections[0].SetConnection("localhost", "DataReal", false);
                    //crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
                    if (strtiperpt == "4")
                    {
                        DataSet ds = new DataSet();
                        if (Session["strKodeRpt"].ToString() == "I1")
                        {
                            q = "select " + strkolomrpt + " from q_LambatCepatPulang WHERE TAHUN = '" + Session["strTgl"].ToString().Substring(0, 4) + "' ORDER BY JML_LAMBAT_CPTPLG," + Session["strOrder"];
                        }
                        else if (Session["strKodeRpt"].ToString() == "I2")
                        {
                            q = "select " + strkolomrpt + " from q_Pelanggaran WHERE PERIODE_PELANGGARAN = '" + Session["strTgl"].ToString() + "' ORDER BY JML_MANGKIR," + Session["strOrder"];
                        }
                        else if (Session["strKodeRpt"].ToString() == "I3")
                        {
                            q = "select " + strkolomrpt + " from q_Pelanggaran_dan_Akumulasi WHERE PERIODE_PELANGGARAN = '" + Session["strTgl"].ToString() + "' ORDER BY JML_MANGKIR," + Session["strOrder"];
                        }
                        //Response.Write(q);
                        SqlCommand sc = new SqlCommand(q, con);
                        sc.CommandTimeout = 0;

                        SqlDataAdapter daRpt = new SqlDataAdapter(sc);
                        //Dim daRpt As New SqlDataAdapter(q, con)
                        daRpt.Fill(ds, "qRB_RekapAbsen");
                        //daRpt.Fill(ds, "qRB")
                        con.Close();
                        rptOpen = true;

                        crys.SetDataSource(ds);
                        crys.Refresh();
                    }
                    else
                    {
                        if (Session["strKodeRpt"].ToString() == "B5")
					    {
						    crys.VerifyDatabase();
					    }
					    //crys.SetDataSource(ds)
                        if (Session["strKodeRpt"].ToString().Substring(0, 1) != "H")
                        {
                            crys.SetParameterValue("@dTglAwal", Session["strTgl"].ToString());
                            crys.SetParameterValue("@dTglAkhir", Session["strTgl2"].ToString());
                        }
                        else
                        {
                            crys.SetParameterValue("@iTahun", Session["strTgl"].ToString().Substring(0, 4));
                        }
                        crys.SetParameterValue("@sSqlFilter", Session["strFilter"].ToString() + strkolomfilter);
                        if (Session["strKodeRpt"].ToString().Substring(0, 1) == "H")
                            {
                                crys.SetParameterValue("@sTypeGroup", Session["strMode"].ToString());
                                //crys.SummaryInfo.ReportTitle = "LAPORAN STATISTIK KETIDAKHADIRAN TANPA ALASAN";
                            }
					    else if (Session["strKodeRpt"].ToString() != "B5")
					    {
                            crys.SetParameterValue("@sSqlOrder", " ORDER BY " + Session["strOrder"].ToString());
					    }
                    }
                    crys.SetParameterValue("Satker", Session["Cabang"].ToString());
					//crys.SetParameterValue("Tanggal", "Tanggal: " & Session("strTglTxt") & " - " & Session("strTgl2Txt"))
                    crys.SetParameterValue("Tanggal", Session["strTahun"].ToString());
                    crys.SetParameterValue("Kelompok", Session["strKriteria".ToString()]);
                    if (Session["strKodeRpt"].ToString().Substring(0, 1) != "H")
                    {
                        crys.SetParameterValue("TTD1.Header", TTD1Header);
                        crys.SetParameterValue("TTD1", TTD1);
                        crys.SetParameterValue("TTD2.Header", TTD2Header);
                        crys.SetParameterValue("TTD2", TTD2);
                        crys.SetParameterValue("TTD3.Header", TTD3Header);
                        crys.SetParameterValue("TTD3", TTD3);
                        if ((Session["strKodeRpt"].ToString() == "D1") || (Session["strKodeRpt"].ToString() == "EC"))
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
                    }
                    crRekap.EnableParameterPrompt = true;
					crRekap.DisplayGroupTree = false;
					crRekap.HasCrystalLogo = false;
					//crRekap.SelectionFormula = "{qR.nip} = '" & Request.QueryString("nip") & "'"
					crRekap.ReportSource = crys;
					crRekap.DataBind();
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
					crys.Close();
					crys.Dispose();
				}
			}
		}
	}
