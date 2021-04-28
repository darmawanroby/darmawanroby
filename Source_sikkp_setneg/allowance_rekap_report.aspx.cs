///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : performance_report.aspx.cs                             (Pseudo code)
//        File terkait  : performance_report.aspx                                (Form)
//                        \App_LocalResources\performance_report.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\performance_report.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                                     (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan Laporan Kinerja
//
// 2. Penulis Program
//        Programer     : Aas Meinardi, Asep Saepulloh
//
// 3. Tanggal update    : 26/09/2013
//
// 4. Versi             : 1.0.0
//
// 5. Historis revisi
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
    public partial class rekapreport : BasePage
    {

        ReportDocument crys;

        protected void Page_Load(object sender, EventArgs e)
        {
            //jika userid kosong maka akan di link ke halaman awal
            if (!rtwin.azlib.AksesHalaman(32, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
            {
                Response.Redirect("notauthorized.aspx");
            }

            string strQuery = "";
            if ((Session["GradeID"].ToString().Substring(0, 1) == "1") || (Session["GradeID"].ToString() == "2"))//admin & validator
            {


                if (Session["GradeID"].ToString() == "2") //validator
                {

                    strQuery = " AND KODE_CABANG =" + Session["CabangID"].ToString() + "";
                   
                }
                else if (Session["GradeID"].ToString() == "1a") //operator keuangan 
                {
                    strQuery = " AND KODE_CABANG IN (SELECT KODE_CABANG FROM taOtoritasCabang WHERE USERNAME='" + Session["UserID"].ToString() + "')";
                     
                }
                else
                {
                    strQuery = "";
                }
            }

            if (Session["tipeRekap"].ToString() == "1")
            {
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());

                string q = "";
                string TTD1Header = "";
                string TTD1 = "";
                string TTD2Header = "";
                string TTD2 = "";
                string TTD3Header = "";
                string TTD3 = "";
                // q = "SELECT TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3 FROM taLaporanPengesahan WHERE KODE_LAPORAN = '" + Session["strKodeRpt"] + "' AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                q = "SELECT TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3 FROM taLaporanPengesahan WHERE KODE_LAPORAN = 'K1' AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                //Response.Write(q);

                SqlDataAdapter db2 = new SqlDataAdapter(q, cn);
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
                string kodeRapel = Session["strKodeRapel"].ToString();

                using (SqlConnection openCon = new SqlConnection(Application["strCn"].ToString()))
                {

                    crys = new ReportDocument();
                    crys.Load(Server.MapPath("App_Data/RapelTKIndividu_font.rpt"));
                    crys.DataSourceConnections[0].SetConnection("localhost", "DataReal", false);
                    crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
                    //crys.VerifyDatabase();

                    crys.SetParameterValue("@KodeRapel", Session["strKodeRapel"].ToString());
                    crys.SetParameterValue("@sSqlFilter", strQuery);
                   // crys.SetParameterValue("Tanggal", "BULAN JANUARI S.D. FEBRUARI 2018");
                    crys.SetParameterValue("TTD1.Header", TTD1Header);
                    crys.SetParameterValue("TTD1", TTD1);
                    crys.SetParameterValue("TTD2.Header", TTD2Header);
                    crys.SetParameterValue("TTD2", TTD2);
                    crys.SetParameterValue("TTD3.Header", TTD3Header);
                    crys.SetParameterValue("TTD3", TTD3);
crys.SetParameterValue("Tanggal", "BULAN JANUARI S.D. FEBRUARI 2018");
                  

                    crAllowanceRekap.DisplayGroupTree = false;
                    crAllowanceRekap.ReportSource = crys;
                    crAllowanceRekap.DataBind();

                }

            }
            else if (Session["tipeRekap"].ToString() == "2")
            {
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());

                string q = "";
                string TTD1Header = "";
                string TTD1 = "";
                string TTD2Header = "";
                string TTD2 = "";
                string TTD3Header = "";
                string TTD3 = "";
                // q = "SELECT TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3 FROM taLaporanPengesahan WHERE KODE_LAPORAN = '" + Session["strKodeRpt"] + "' AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                q = "SELECT TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3 FROM taLaporanPengesahan WHERE KODE_LAPORAN = 'K2' AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                //Response.Write(q);

                SqlDataAdapter db2 = new SqlDataAdapter(q, cn);
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
                string kodeRapel = Session["strKodeRapel"].ToString();
                
                using (SqlConnection openCon = new SqlConnection(Application["strCn"].ToString()))
                {
                    

                        crys = new ReportDocument();
                        crys.Load(Server.MapPath("App_Data/RekapRapelTK_font.rpt"));
                        crys.DataSourceConnections[0].SetConnection("localhost", "DataReal", false);
                        crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
                        //crys.VerifyDatabase();

                        crys.SetParameterValue("@KodeRapel", Session["strKodeRapel"].ToString());
                        crys.SetParameterValue("@sSqlFilter", strQuery);
                       // crys.SetParameterValue("Tanggal", "BULAN JANUARI S.D. FEBRUARI 2018");
                        crys.SetParameterValue("TTD1.Header", TTD1Header);
                        crys.SetParameterValue("TTD1", TTD1);
                        crys.SetParameterValue("TTD2.Header", TTD2Header);
                        crys.SetParameterValue("TTD2", TTD2);
                        crys.SetParameterValue("TTD3.Header", TTD3Header);
                        crys.SetParameterValue("TTD3", TTD3);

                       crys.SetParameterValue("Tanggal", "BULAN JANUARI S.D. FEBRUARI 2018");

                        crAllowanceRekap.DisplayGroupTree = false;
                        crAllowanceRekap.ReportSource = crys;
                        crAllowanceRekap.DataBind();
                }
            }

            else if (Session["tipeRekap"].ToString() == "3")
            {
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());

                string q = "";
                string TTD1Header = "";
                string TTD1 = "";
                string TTD2Header = "";
                string TTD2 = "";
                string TTD3Header = "";
                string TTD3 = "";
                // q = "SELECT TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3 FROM taLaporanPengesahan WHERE KODE_LAPORAN = '" + Session["strKodeRpt"] + "' AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                q = "SELECT TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3 FROM taLaporanPengesahan WHERE KODE_LAPORAN = 'K3' AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                //Response.Write(q);

                SqlDataAdapter db2 = new SqlDataAdapter(q, cn);
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
                string kodeRapel = Session["strKodeRapel"].ToString();

                using (SqlConnection openCon = new SqlConnection(Application["strCn"].ToString()))
                {


                    crys = new ReportDocument();
                    crys.Load(Server.MapPath("App_Data/RekapRapelTKperUnit_font.rpt"));
                    crys.DataSourceConnections[0].SetConnection("localhost", "DataReal", false);
                    crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");

                    crys.SetParameterValue("@KodeRapel", Session["strKodeRapel"].ToString());
                    crys.SetParameterValue("@sSqlFilter", strQuery);
                    crys.SetParameterValue("TTD1.Header", "");
                    crys.SetParameterValue("TTD1", "");
                    crys.SetParameterValue("TTD2.Header", "");
                    crys.SetParameterValue("TTD2", "");
                    crys.SetParameterValue("TTD3.Header", "");
                    crys.SetParameterValue("TTD3", "");
                    crys.SetParameterValue("Tanggal", "BULAN JANUARI S.D. FEBRUARI 2018");
                    crys.SetParameterValue("Kelompok", "");
                    crys.SetParameterValue("Satker", "");
                    crAllowanceRekap.DisplayGroupTree = false;
                    crAllowanceRekap.ReportSource = crys;
                    crAllowanceRekap.DataBind();


                    openCon.Close();
                }
            }


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
