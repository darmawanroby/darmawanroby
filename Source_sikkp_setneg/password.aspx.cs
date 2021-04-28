///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : password.aspx.cs                                (Pseudo code)
//        File terkait  : password.aspx                                   (Form)
//                        \App_LocalResources\password.aspx.id.resx       (Display label bahasa Indonesia)
//                        \App_LocalResources\password.aspx.en.resx       (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                              (Library/class)
//                        \App_Code\comon.cs                              (Library/class)
//
//        Deskripsi     : Halaman untuk merubah password user
//
// 2. Penulis Program
//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Retza Fudiawan, Bayu Widiaiswara, Desmond
//
// 3. Tanggal update    : 11/09/2009
//
// 4. Versi             : 2.0.3
//
// 5. Historis revisi
//        Versi 2.0.1   : penambahan dokumentasi dan perbaikan bugs pada halaman password.aspx
//        Versi 2.0.2   : pengaturan tampilan menggunakan style
//        Versi 2.0.3   : Implementasi AJAX
//
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Data.SqlClient;
using Udev.MasterPageWithLocalization.Classes;

namespace rtwin
	{
		
		public partial class password : BasePage
		{
			string strCn;
			SqlConnection cn;
			SqlCommand cmd = new SqlCommand();
			DataSet dsUsers = new DataSet();
			SqlDataReader rdr;
			string strPassword;

            protected void Page_Load(object sender, EventArgs e)
			{
				//jika userid kosong maka akan di link ke halaman awal
                if (!rtwin.azlib.AksesHalaman(25, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
                {
                    Response.Redirect("notauthorized.aspx");
                }

				strCn = Application["strCn"].ToString();
				//buka koneksi database
				cn = new SqlConnection(strCn);
				cn.Open();
				//mengambil password dari tabel taUsers berdasrkan user
				cmd = cn.CreateCommand();
				cmd.CommandText = "SELECT passw FROM taUsers WHERE username = '" + Session["UserID"].ToString() + "'";
				rdr = cmd.ExecuteReader();
				try
				{
					rdr.Read();
					strPassword = rdr["passw"].ToString();
				}
				catch
				{
					strPassword = "";
				}
				rdr.Close();
				cn.Close();
			}
			
			protected void btnOK_Click(object sender, EventArgs e)
			{
                if (Page.IsValid)
                {
                    //jika salah satu isian password tidak kosong lakukan perintah
                    //jika tidak terdapat informasi pada user pemakai
                    if ((!Session["UserID"].ToString().Equals("Aas")) || (strPassword != null))
                    {
                        if (txtNewPass.Text.Length >= 8)
                        {
                            //jika halaman bisa diakses dan password baru sama dengan password pembanding sama
                            if (Page.IsValid && strPassword.Equals(common.cekuser(txtOldPass.Text), StringComparison.CurrentCultureIgnoreCase))// || (txtOldPass.Text.Trim() == Session["NIPID"].ToString()))
                            {
                                strPassword = common.cekuser(txtNewPass.Text.Trim());
                                //buka koneksi database
                                cn.Open();
                                //query update taUsers berdasrkan username
                                cmd.CommandText = "UPDATE taUsers SET passw = '" + strPassword + "' , Last_Update = '" + DateTime.Now.ToString("MM/dd/yyyy") + "' WHERE username = '" + Session["UserID"].ToString() + "'";
                                cmd.CommandType = CommandType.Text;
                                cmd.Connection = cn;
                                try
                                {
                                    cmd.ExecuteNonQuery();
                                    ExceptionDetails.Text = lblsukses.Text;
                                    strPassword = txtNewPass2.Text;
                                    //mencatat event user
                                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4115", Session["UserID"].ToString(), strCn);
                                }
                                catch (Exception)
                                {
                                    //jika terdapat kegagalan update maka akan memunculkan info password tidak dapat diubah
                                    ExceptionDetails.Text = lblnotsukses.Text;
                                }
                                //tutup koneksi database
                                cn.Close();
                            }
                            else
                            {
                                ExceptionDetails.Text = lblgacocok.Text;
                            }
                        }
                        else
                        {
                            ExceptionDetails.Text = "Password min 8 char";
                        }
                    }
                    else
                    {
                        ExceptionDetails.Text = lblread.Text;
                    }
                }
			}
		}
		
	}
