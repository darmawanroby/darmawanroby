///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : config.aspx.cs                  (Pseudo code)

//        File terkait  : config.aspx                                (Form)
//                        config.aspx.cs                             (pseudo code)
//                        \App_LocalResources\config.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\config.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                        (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : mengedit tabel Variabel (taVariabel)

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 11/09/2009
//
// 4. Versi             : 2.0.2
//
// 5. Historis revisi
//        Versi 2.0.1   : Validasi Update Config
//        Versi 2.0.2   : Implementasi AJAX
//
//
///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Udev.MasterPageWithLocalization.Classes;

	namespace rtwin
	{
		
		public partial class config2 : BasePage
		{
			
			private void Page_Load(object sender, EventArgs e)
			{
				if (! rtwin.azlib.AksesHalaman(29, Session["UserID"].ToString().ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}
                else if (Session["GradeID"].ToString() == "1") //admin
                {
                    Response.Redirect("config.aspx");
                }

			}

            protected void dsVariable_Updated(object sender, SqlDataSourceStatusEventArgs e)
            {
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter update maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblConfigNotUpdated.Text + " - " + e.Exception.Message; //& " (" & e.Exception.Message & ")"
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4405", "", Application["strCn"].ToString().ToString());
                    ExceptionDetails.Text = lblConfigUpdated.Text;
                }
            }

            protected void dsVariable_Updating(object sender, SqlDataSourceCommandEventArgs e)
            {
                try
                {
                }
                catch (Exception ex)
                {
                    ExceptionDetails.Text = lblConfigNotUpdated.Text + " (" + ex.Message + ")";
                    e.Cancel = true;
                }
            }

}
		
	}
