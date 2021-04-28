///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : download.aspx.cs                             (Pseudo code)

//        File terkait  : download.aspx                                (Form)
//                        \App_LocalResources\download.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\download.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk mendoenload file yg telah disediakan

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
//        First Release
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
using Udev.MasterPageWithLocalization.Classes;
using System.Data.SqlClient;

	namespace rtwin
	{
		public partial class download : BasePage
		{
			protected void Page_Load(object sender, EventArgs e)
			{
				if (Session["UserID"].ToString() == "")
				{
					Response.Redirect("notauthorized.aspx");
				}
				else
				{
					SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
					DataSet mydataset = new DataSet();
					SqlDataAdapter myadapter = new SqlDataAdapter();
					string strField = "";
					if (Session["strlang"].ToString() == "en")
					{
						strField = "_en";
					}
					string strFilter = "";
					if (Session["GradeID"].ToString() == "1") //admin
					{
						strFilter = " WHERE FILE_ADMIN =1";
					}
					else if (Session["GradeID"].ToString() == "1a") //admin keuangan
					{
						strFilter = " WHERE FILE_KEUANGAN =1";
					}
                    else if (Session["GradeID"].ToString() == "2") //validator
                    {
                        strFilter = " WHERE FILE_VALIDATOR =1";
                    }
                    else if (Session["GradeID"].ToString() == "3") //operator
                    {
                        strFilter = " WHERE FILE_OPERATOR =1";
                    }
                    else // viewer & user
                    {
                        strFilter = " WHERE FILE_USER =1";
                    }
                    SqlCommand mycomand = new SqlCommand("SELECT NAMA_FILE,NAMA_DOK" + strField + " FROM taDownload" + strFilter, myconection);
					ListItem li;
					myadapter.SelectCommand = mycomand;
					myadapter.Fill(mydataset, "Tabel_Download");
					
					//jika tidak terdapat record pada taRange maka sisipkan null
					Label1.Text = "";
					if (mydataset.Tables["Tabel_Download"].Rows.Count == 0)
					{
						li = new ListItem(" ", "");
						myadapter.Dispose();
						mydataset.Clear();
					}
					else
					{
						//jika ada maka sisipkan null lalu sisipkan kode range ke dropdownlist
						DataTable myTabel = mydataset.Tables["Tabel_Download"];
						
						foreach (DataRow myRow in myTabel.Rows)
						{
							Label1.Text += "<a href='download/" + myRow["NAMA_FILE"] + "'>" + myRow["NAMA_DOK"] + strField + "</a><br/>";
						}
						myadapter.Dispose();
						mydataset.Clear();
					}
					
					if (Session["GradeID"].ToString() == "1") //admin
					{
						linkUpload.Visible = true;
					}
					else
					{
						linkUpload.Visible = false;
					}
					
				}
				
			}
			
		}
	}
