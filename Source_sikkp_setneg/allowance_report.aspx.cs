///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : allowance_report.aspx.cs                             (Pseudo code)

//        File terkait  : allowance_report.aspx                                (Form)
//                        \App_LocalResources\allowance_report.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\allowance_report.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan Laporan Tunjangan

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
				if (! rtwin.azlib.AksesHalaman(23, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}
				
				string strfilerpt = "";
				string strkolomrpt = "";
				string strkolomfilter = "";
				string strtiperpt = "";
				
				string q = "SELECT KOLOM, FILE_LAPORAN, KOLOM_FILTER, TIPE_LAPORAN FROM taLaporan WHERE KODE_LAPORAN = '" + Session["strKodeRpt"] + "'";
                string cn = "";
                if (Convert.ToInt32(Session["strTglTxt"].ToString().Substring(Session["strTglTxt"].ToString().Length - 4)) >= 2013)
                {
                    cn = Application["strCn"].ToString(); //ConfigurationManager.AppSettings("StrCn")
                }
                else
                {
                    cn = Application["strCnRpt"].ToString(); //ConfigurationManager.AppSettings("StrCnRpt")
                }
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
					strfilerpt = "app_data/";
					if (Convert.ToInt32(Session["strTglTxt"].ToString().Substring(Session["strTglTxt"].ToString().Length - 4)) < 2013)
					{
					strfilerpt += "siapdb/";
					}
                    if ((Session["strlang"].ToString() == "id") || (Session["strlang"].ToString() == ""))
					{
                        strfilerpt += dsRpt.Tables[0].Rows[0][1].ToString() + ".rpt";
					}
					else
					{
                        strfilerpt += dsRpt.Tables[0].Rows[0][1].ToString() + "_en.rpt";
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
				
				if (rptOpen)
				{
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
					if (strtiperpt == "1")
					{
						DataSet ds = new DataSet();
                        q = "select " + strkolomrpt + " from q_PerubahanTK WHERE BULAN = MONTH('" + Session["strTgl"] + "')" + " AND TAHUN = YEAR('" + Session["strTgl2"] + "')" + Session["strFilter"] + " " + strkolomfilter + " ORDER BY KODE_UNIT," + Session["strOrder"];
                        //Response.Write(q);
                        SqlCommand sc = new SqlCommand(q, con);
						sc.CommandTimeout = 0;
						
						SqlDataAdapter daRpt = new SqlDataAdapter(sc);
						//Dim daRpt As New SqlDataAdapter(q, con)
                        daRpt.Fill(ds, "q_PerubahanTK");
						//daRpt.Fill(ds, "qRB")
						con.Close();
						rptOpen = true;
						
						crys.SetDataSource(ds);
						crys.Refresh();
					}
					else
					{
						con.Close();
						//crys.DataSourceConnections.Item(0).IntegratedSecurity = False
                        if (Convert.ToInt32(Session["strTglTxt"].ToString().Substring(Session["strTglTxt"].ToString().Length - 4)) >= 2013)
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
						//crys.SetDatabaseLogon("rekabio", "Meinardi", Application("DatabaseServer"), "DataReal")
						if (Session["strKodeRpt"].ToString() != "AA")
						{
							//crys.VerifyDatabase();
						}
						//crys.SetDataSource(ds)
						//crys.SetParameterValue("@dTglAwal", Session["strTgl"]);
						//crys.SetParameterValue("@dTglAkhir", Session["strTgl2"]);
                        if (Session["strKodeRpt"].ToString() != "J6")
                        {
                        //Response.Write(Convert.ToInt16((Convert.ToDateTime(Session["strTgl"])).ToString("MM")));
                        if ((Convert.ToInt16((Convert.ToDateTime(Session["strTgl"])).ToString("MM")) == 1) && (Convert.ToInt16((Convert.ToDateTime(Session["strTgl2"])).ToString("MM")) == 12))
                        {
                            crys.SetParameterValue("@Bulan", "13");
                        }
                        else
                        {
                            crys.SetParameterValue("@Bulan", Convert.ToInt16((Convert.ToDateTime(Session["strTgl"])).ToString("MM")));
                        }
                        }
                        else
                        {
                            crys.SetParameterValue("@sSqlOrder", " ORDER BY KODE_UNIT," + Session["strOrder"]);
                        }
                        crys.SetParameterValue("@Tahun", Convert.ToInt16((Convert.ToDateTime(Session["strTgl"])).ToString("yyyy")));
                        if (Session["strKodeRpt"].ToString().Substring(0,1) == "F")
                        {
                            crys.SetParameterValue("@Potongan", ((bool)Session["TanpaPotongan"]) ? 0 : 1);//dicentang nilainya 0 gk dicentang = 1
                            crys.SetParameterValue("@sSqlOrder", " ORDER BY KODE_UNIT," + Session["strOrder"]);
                        }
                        crys.SetParameterValue("@sSqlFilter", Session["strFilter"] + strkolomfilter);
                        //Response.Write(Session["strFilter"].ToString());
                    }

                    crys.SetParameterValue("Satker", Session["Cabang"].ToString());
                    crys.SetParameterValue("Tanggal", Session["strBulan"].ToString());
                    //crys.SetParameterValue("Tanggal", Session["strTglTxt"].ToString() + " - " + Session["strTgl2Txt"].ToString());
                    crys.SetParameterValue("Kelompok", Session["strKriteria"].ToString());

                    crys.SetParameterValue("TTD1.Header", TTD1Header);
                    crys.SetParameterValue("TTD1", TTD1);
                    crys.SetParameterValue("TTD2.Header", TTD2Header);
                    crys.SetParameterValue("TTD2", TTD2);
                    crys.SetParameterValue("TTD3.Header", TTD3Header);
                    crys.SetParameterValue("TTD3", TTD3);
                    if ((Session["strKodeRpt"].ToString() == "B1") || (Session["strKodeRpt"].ToString() == "C1"))
                    {
                        crys.SetParameterValue("Ket1", "");
                        crys.SetParameterValue("Ket2", "");
                        crys.SetParameterValue("Ket3", "");
                        crys.SetParameterValue("Ket4", "");
                        crys.SetParameterValue("Ket5", "");
                        crys.SetParameterValue("Ket6", "");
                        crys.SetParameterValue("Ket7", "");
                        crys.SetParameterValue("Ket8", "");
                        crys.SetParameterValue("Ket9", "");
                        crys.SetParameterValue("Ket10", "");
                        crys.SetParameterValue("Ket11", "");
                        crys.SetParameterValue("Ket12", "");
                        crys.SetParameterValue("Ket13", "");
                        crys.SetParameterValue("Ket14", "");
                        crys.SetParameterValue("Ket15", "");
                        crys.SetParameterValue("Ket16", "");
                        crys.SetParameterValue("Ket17", "");
                        crys.SetParameterValue("Ket18", "");
                        crys.SetParameterValue("Ket19", "");
                        crys.SetParameterValue("Ket20", "");
                        crys.SetParameterValue("Ket21", "");
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
					crys.Close();
					crys.Dispose();
				}
			}
		}
	}
