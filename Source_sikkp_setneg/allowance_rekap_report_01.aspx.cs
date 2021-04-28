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
            string q = "";
            string TTD1Header = "";
            string TTD1 = "";
            string TTD2Header = "";
            string TTD2 = "";
            string TTD3Header = "";
            string TTD3 = "";
            if (Session["tipeRekap"].ToString() == "1")
            {

                DataSet ds = new DataSet();
                string kodeRapel = Session["strKodeRapel"].ToString();
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                using (SqlConnection openCon = new SqlConnection(Application["strCn"].ToString()))
                {
                    using (SqlCommand cmdRekapIndividu = new SqlCommand("exec proc_rpt_rapel_tk " + Session["strKodeRapel"].ToString() + "", cn))
                    {
                        cmdRekapIndividu.Connection = openCon;
                        openCon.Open();
                        // cmdRekapIndividu.CommandType = CommandType.StoredProcedure;
                        //cmdRekapIndividu.Parameters.AddWithValue("@KodeRapel", Session["strKodeRapel"].ToString());

                        cmdRekapIndividu.CommandTimeout = 1000;
                        cmdRekapIndividu.ExecuteNonQuery();
                        SqlDataAdapter da = new SqlDataAdapter(cmdRekapIndividu);


                        da.Fill(ds);

                        crys = new ReportDocument();
                        crys.Load(Server.MapPath("App_Data/RapelTKIndividu_font.rpt"));
                        crys.DataSourceConnections[0].SetConnection("localhost", "DataReal", false);
                        crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
                        crys.VerifyDatabase();
                        crys.SetDataSource(ds);

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tblRekap = ds.Tables[0];
                            foreach (DataRow myRow in tblRekap.Rows)
                            {
                                /* TTD1Header = myRow["TTD1.Header"].ToString();
                                 TTD1 = myRow["TTD1"].ToString();
                                 TTD2Header = myRow["TTD2_HEADER"].ToString();
                                 TTD2 = myRow["TTD2"].ToString();
                                 TTD3Header = myRow["TTD3_HEADER"].ToString();
                                 TTD3 = myRow["TTD3"].ToString();*/
                                //   Response.Write(myRow["PAJAK_TK_KEKURANGAN"].ToString());
                            }
                        }
                        // Response.Write(Session["strKodeRapel"].ToString());

                        crys.SetParameterValue("@KodeRapel", Session["strKodeRapel"].ToString());// );
                        // Response.Write("<br/><br/>" + Session["strKodeRapel"].ToString());
                        crys.SetParameterValue("TTD1.Header", "");
                        crys.SetParameterValue("TTD1", "");
                        crys.SetParameterValue("TTD2.Header", "");
                        crys.SetParameterValue("TTD2", "");
                        crys.SetParameterValue("TTD3.Header", "");
                        crys.SetParameterValue("TTD3", "");
                        // crys

                        //  crys.Refresh();

                         crAllowanceRekap.DisplayGroupTree = false;
                        // crAllowanceRekap.HasCrystalLogo = false;
                        //  crys.PrintOptions.PrinterName = "PRINTERNAME";
                        // crys.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperLegal;
                        crAllowanceRekap.ReportSource = crys;
                        crAllowanceRekap.DataBind();


                        openCon.Close();
                    }
                }
                 
            }
            else if (Session["tipeRekap"].ToString() == "2")
            {
               
                DataSet ds = new DataSet();
                string kodeRapel = Session["strKodeRapel"].ToString();
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                using (SqlConnection openCon = new SqlConnection(Application["strCn"].ToString()))
                {
                    using (SqlCommand cmdRekapIndividu = new SqlCommand("exec proc_rpt_rekap_rapel_tk " + Session["strKodeRapel"].ToString() + "", cn))
                    {
                        cmdRekapIndividu.Connection = openCon;
                        openCon.Open();
                       // cmdRekapIndividu.CommandType = CommandType.StoredProcedure;
                        //cmdRekapIndividu.Parameters.AddWithValue("@KodeRapel", Session["strKodeRapel"].ToString());

                        cmdRekapIndividu.CommandTimeout = 1000;
                        cmdRekapIndividu .ExecuteNonQuery();
                        SqlDataAdapter da = new SqlDataAdapter(cmdRekapIndividu);

                        
                        da.Fill(ds);
                       
                        crys = new ReportDocument();
                        crys.Load(Server.MapPath("App_Data/RekapRapelTK_font.rpt"));
                        crys.DataSourceConnections[0].SetConnection("localhost", "DataReal", false);
                        crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
                        crys.VerifyDatabase();
                        crys.SetDataSource(ds);

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tblRekap = ds.Tables[0];
                            foreach (DataRow myRow in tblRekap.Rows)
                            {
                               /* TTD1Header = myRow["TTD1.Header"].ToString();
                                TTD1 = myRow["TTD1"].ToString();
                                TTD2Header = myRow["TTD2_HEADER"].ToString();
                                TTD2 = myRow["TTD2"].ToString();
                                TTD3Header = myRow["TTD3_HEADER"].ToString();
                                TTD3 = myRow["TTD3"].ToString();*/
                             //   Response.Write(myRow["PAJAK_TK_KEKURANGAN"].ToString());
                            }
                        }
                       // Response.Write(Session["strKodeRapel"].ToString());

                        crys.SetParameterValue("@KodeRapel", Session["strKodeRapel"].ToString());// );
                       // Response.Write("<br/><br/>" + Session["strKodeRapel"].ToString());
                         crys.SetParameterValue("TTD1.Header", "");
                         crys.SetParameterValue("TTD1", "");
                         crys.SetParameterValue("TTD2.Header", "");
                         crys.SetParameterValue("TTD2", "");
                         crys.SetParameterValue("TTD3.Header", "");
                         crys.SetParameterValue("TTD3", ""); 
                       // crys
                       
                      //  crys.Refresh();
                       
                      //  crAllowanceRekap.DisplayGroupTree = false;
                       // crAllowanceRekap.HasCrystalLogo = false;
                        //  crys.PrintOptions.PrinterName = "PRINTERNAME";
                        // crys.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperLegal;
                        crAllowanceRekap.ReportSource = crys;
                        crAllowanceRekap.DataBind();

                    
                        openCon.Close();
                    }
                }
            }

            else if (Session["tipeRekap"].ToString() == "3")
            {

                DataSet ds = new DataSet();
                string kodeRapel = Session["strKodeRapel"].ToString();
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                using (SqlConnection openCon = new SqlConnection(Application["strCn"].ToString()))
                {
                    using (SqlCommand cmdRekapIndividu = new SqlCommand("exec proc_rpt_rekap_rapel_tk_unit " + Session["strKodeRapel"].ToString() + "", cn))
                    {
                        cmdRekapIndividu.Connection = openCon;
                        openCon.Open();
                        // cmdRekapIndividu.CommandType = CommandType.StoredProcedure;
                        //cmdRekapIndividu.Parameters.AddWithValue("@KodeRapel", Session["strKodeRapel"].ToString());

                        cmdRekapIndividu.CommandTimeout = 1000;
                        cmdRekapIndividu.ExecuteNonQuery();
                        SqlDataAdapter da = new SqlDataAdapter(cmdRekapIndividu);


                        da.Fill(ds);

                        crys = new ReportDocument();
                        crys.Load(Server.MapPath("App_Data/RekapRapelTKperUnit_font.rpt"));
                        crys.DataSourceConnections[0].SetConnection("localhost", "DataReal", false);
                        crys.DataSourceConnections[0].SetLogon("rekabio", "Meinardi");
                        crys.VerifyDatabase();
                        crys.SetDataSource(ds);

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable tblRekap = ds.Tables[0];
                            foreach (DataRow myRow in tblRekap.Rows)
                            {
                                /* TTD1Header = myRow["TTD1.Header"].ToString();
                                 TTD1 = myRow["TTD1"].ToString();
                                 TTD2Header = myRow["TTD2_HEADER"].ToString();
                                 TTD2 = myRow["TTD2"].ToString();
                                 TTD3Header = myRow["TTD3_HEADER"].ToString();
                                 TTD3 = myRow["TTD3"].ToString();*/
                                //   Response.Write(myRow["PAJAK_TK_KEKURANGAN"].ToString());
                            }
                        }
                        // Response.Write(Session["strKodeRapel"].ToString());

                        crys.SetParameterValue("@KodeRapel", Session["strKodeRapel"].ToString()); 
                        crys.SetParameterValue("TTD1.Header", "");
                        crys.SetParameterValue("TTD1", "");
                        crys.SetParameterValue("TTD2.Header", "");
                        crys.SetParameterValue("TTD2", "");
                        crys.SetParameterValue("TTD3.Header", "");
                        crys.SetParameterValue("TTD3", "");
                        crys.SetParameterValue("Tanggal", DateTime.Now.Date.ToString("dd/MM/yyyy"));
                        crys.SetParameterValue("Kelompok","");
                        crys.SetParameterValue("Satker", "");
                        // crys

                        //  crys.Refresh();

                        //  crAllowanceRekap.DisplayGroupTree = false;
                        // crAllowanceRekap.HasCrystalLogo = false;
                        //  crys.PrintOptions.PrinterName = "PRINTERNAME";
                        // crys.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.PaperLegal;
                        crAllowanceRekap.ReportSource = crys;
                        crAllowanceRekap.DataBind();


                        openCon.Close();
                    }
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
