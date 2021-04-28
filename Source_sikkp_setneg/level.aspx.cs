///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : level.aspx.cs                                   
//        File terkait  : level.aspx
//        Deskripsi     : Halaman Ubah Hak Akses USer Aktif
//
// 2. Penulis Program
//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 10/09/2009
//
// 4. Versi             : 2.0.1
//
// 5. Historis revisi
//        Versi 2.0.1   : Penambahan fungsi-fungsi
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using Udev.MasterPageWithLocalization.Classes;

namespace rtwin
{
    public partial class level : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"].ToString() == "")
            {
                Response.Redirect("notauthorized.aspx");
            }

            if (Session["RealGrade"].ToString() == "1")
            {
                radAdmin.Visible = true;
                radKeuangan.Visible = true;
                radValidator.Visible = true;
                radOperator.Visible = true;
                radViewer.Visible = true;
                radUser.Visible = true;
            }
            else if (Session["RealGrade"].ToString() == "1a")
            {
                radAdmin.Visible = false;
                radKeuangan.Visible = true;
                radValidator.Visible = false;
                radOperator.Visible = false;
                radViewer.Visible = false;
                radUser.Visible = true;
            }
            else if (Session["RealGrade"].ToString() == "2")
            {
                radAdmin.Visible = false;
                radKeuangan.Visible = false;
                radValidator.Visible = true;
                radOperator.Visible = false;
                radViewer.Visible = false;
                radUser.Visible = true;
            }
            else if (Session["RealGrade"].ToString() == "3")
            {
                radAdmin.Visible = false;
                radKeuangan.Visible = false;
                radValidator.Visible = false;
                radOperator.Visible = true;
                radViewer.Visible = false;
                radUser.Visible = true;
            }
            else if (Session["RealGrade"].ToString() == "3a")
            {
                radAdmin.Visible = false;
                radKeuangan.Visible = false;
                radValidator.Visible = false;
                radOperator.Visible = false;
                radViewer.Visible = true;
                radUser.Visible = true;
            }
            else if (Session["RealGrade"].ToString() == "4")
            {
                Response.Redirect("notauthorized.aspx");
            }

            if (!Page.IsPostBack)
            {
                if (Session["GradeID"].ToString() == "1")
                {
                    radAdmin.Checked = true;
                }
                else if (Session["GradeID"].ToString() == "1a")
                {
                    radKeuangan.Checked = true;
                }
                else if (Session["GradeID"].ToString() == "2")
                {
                    radValidator.Checked = true;
                }
                else if (Session["GradeID"].ToString() == "3")
                {
                    radOperator.Checked = true;
                }
                else if (Session["GradeID"].ToString() == "3a")
                {
                    radViewer.Checked = true;
                }
                else
                {
                    radUser.Checked = true;
                }
            }
        }

        //fungsi: handle permintaan Ubah Level
        protected void btnChangeLevel_Click(object sender, EventArgs e)
        {
            if (radAdmin.Checked)
            {
                Session["GradeID"] = "1";
            }
            else if (radKeuangan.Checked)
            {
                Session["GradeID"] = "1a";
            }
            else if (radValidator.Checked)
            {
                Session["GradeID"] = "2";
            }
            else if (radOperator.Checked)
            {
                Session["GradeID"] = "3";
            }
            else if (radViewer.Checked)
            {
                Session["GradeID"] = "3a";
            }
            else
            {
                Session["GradeID"] = "4";
            }

            if (Convert.ToSByte(Session["GradeID"].ToString().Substring(0,1)) <= 4)
            {
                Response.Redirect("alert.aspx");
            }
            else
            {
                Server.Transfer(Request.Path);
            }
        }
    }
}
