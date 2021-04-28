///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : MasterPage.master.cs                                   
//        File terkait  : MasterPage.master
//        Deskripsi     : Halaman Awal dan validasi login
//
// 2. Penulis Program
//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 06/09/2009
//
// 4. Versi             : 2.0.3
//
// 5. Historis revisi
//        Versi 2.0.1   : Penambahan fungsi-fungsi
//        Versi 2.0.2   : Pengorganisasian Import
//        Versi 2.0.3   : Penyempurnaan fungsi dan Format Dokumen
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System.Web.UI.WebControls;
using System;
using Udev.MasterPageWithLocalization.Classes;
using System.Data;
using System.Data.SqlClient;

namespace rtwin
{

    public partial class MasterPage : System.Web.UI.MasterPage
    {
        //fungsi: Menghapus Seluruh session yang berlaku di Aplikasi
        private void HapusSession()
        {
            Session["UserID"] = "";
            Session["GradeID"] = "4";
            Session.Remove("RealGrade");
            Session.Remove("MenuID");
            Session.Remove("NIPID");
            Session.Remove("Nama");
            Session.Remove("CabangID");
            Session.Remove("Cabang");
            Session.Remove("DepartemenID");
            Session.Remove("tglTutup");
            Session.Remove("tglBatas");
            Session.Remove("strKey");
            Session.Remove("strKey2");
            Session.Remove("strKodeRpt");
            Session.Remove("strTgl");
            Session.Remove("strTgl2");
            Session.Remove("strFilter");
            Session.Remove("strKriteria");
            Session.Remove("strKriteria2");
            Session.Remove("strMode");
            Session.Remove("TipeEntry");
            Session.Remove("PINID");
            Session.Remove("SatkerID");
            Session.Remove("tglValidasiLembur");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["strlang"].ToString() == "en")
            {
                //bahasa Inggris
                ddlBahasa.SelectedIndex = 1;
                tvMenu.DataBindings[0].TextField = "title_en";
                tvMenu.DataBindings[1].TextField = "subtitle_en";
                tvMenu.DataBindings[2].TextField = "subtitle2_en";
                tvMenu.DataBindings[3].TextField = "subtitle3_en";
            }
            if (Session["UserID"].ToString() == "")
            {
                homeLink.Visible = true;
            }
            else
            {
                homeLink.Visible = false;
            }
            Session["linkHm"] = homeLink.Visible == false;
            if (Page.IsPostBack == false)
            {
                if (Session["UserID"].ToString() == "")
                {
                    lblUser.Text = "";
                    lblCabang.Text = "";
                    lnkLogout.Visible = false;
                    show2.Visible = true;
                    tvMenu.Visible = false;
                    smpNavigasi.Visible = false;
                    formLogin.Visible = true;
                    formUser.Visible = false;
                }
                else
                {
                    Server.MapPath("~/App_Data/menu.xml");
                    if (Session["GradeID"].ToString() == "1")
                    {
                        lblUser.Text = "Administrator: " + Session["UserID"].ToString() + " (" + Session["NIPID"].ToString() + ")";
                        XMLMenuSource.XPath = "menu/level[@name='Administrator']/menu_parent";
                    }
                    else if (Session["GradeID"].ToString() == "1a")
                    {
                        lblUser.Text = "Operator Keuangan: " + Session["UserID"].ToString() + " (" + Session["NIPID"].ToString() + ")";
                        XMLMenuSource.XPath = "menu/level[@name='Finance']/menu_parent";

                    }
                    else if (Session["GradeID"].ToString() == "2")
                    {
                        lblUser.Text = "Validator Kepegawaian: " + Session["UserID"].ToString() + " (" + Session["NIPID"].ToString() + ")";
                        XMLMenuSource.XPath = "menu/level[@name='Validator']/menu_parent";

                    }
                    else if (Session["GradeID"].ToString() == "3")
                    {
                        lblUser.Text = "Operator Kepegawaian: " + Session["UserID"].ToString() + " (" + Session["NIPID"].ToString() + ")";
                        XMLMenuSource.XPath = "menu/level[@name='Operator']/menu_parent";
                    }
                    else if (Session["GradeID"].ToString() == "3a")
                    {
                        lblUser.Text = "Viewer Laporan: " + Session["UserID"].ToString() + " (" + Session["NIPID"].ToString() + ")";
                        XMLMenuSource.XPath = "menu/level[@name='Viewer']/menu_parent";
                    }
                    else if (Session["GradeID"].ToString() == "4")
                    {
                        lblUser.Text = "User: " + Session["UserID"].ToString() + " (" + Session["NIPID"].ToString() + ")";
                        XMLMenuSource.XPath = "menu/level[@name='User']/menu_parent";
                        //set Visible DropDown Ganti bahasa
                        lblLang.Visible = false;
                        ddlBahasa.Visible = false;
                    }

                    if (Session["RealGrade"].ToString() == "4")
                    {
                        linkLevel.Visible = false;
                    }

                    lblCabang.Text = Session["Cabang"].ToString();
                    lnkLogout.Visible = true;
                    tvMenu.Visible = true;
                    show2.Visible = true;
                    formLogin.Visible = false;
                    smpNavigasi.Visible = true;
                    formUser.Visible = true;
                }
            }
        }
 
        //fungsi: Handle ketika ada permintaan perubahan bahasa
        protected void RequestLanguageChange_Click(object sender, EventArgs e)
        {
            //store requested language as new culture in the session
            Session[Global.SESSION_KEY_CULTURE] = ddlBahasa.SelectedValue;
            Session["strlang"] = Session[Global.SESSION_KEY_CULTURE].ToString().Substring(0, 2);

            //reload last requested page with new culture
            Server.Transfer(Request.Path);
        }

        //fungsi: Handle permintaan Login
        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            string strCn;
            SqlConnection cn;
            SqlCommand cmd = new SqlCommand();
            DataSet dsUsers = new DataSet();
            string strSelect;
            SqlDataAdapter adpSQL;
            DataSet dsPegawai = new DataSet();
            bool validpg = false;
            if (Page.IsValid)
            {
                Session["RealGrade"] = "4";
                Session["GradeID"] = "4";
                Session["tglBatas"] = DateTime.Now.Date.AddMonths(3);
            }

            //Buka koneksi database DataReal
            strCn = Application["strCn"].ToString();
            cn = new SqlConnection(strCn);

            //Mengambil data dari tabel untuk dijadikan Id user dan seleksi user
            //strSelect = "SELECT q_Users.USERNAME, q_Users.KODE_LEVEL, q_Users.MENU_RTE, q_Users.NIP, q_Users.NAMA, q_Users.KODE_CABANG, q_Users.NAMA_CABANG, q_Users.KODE_DEPARTEMEN, q_Users.TGL_TUTUP, q_Users.Last_Update, q_Users.PIN FROM q_Users WHERE (username = '" + txtUserID.Text.Replace("'", "''") + "' AND PASSW = '" + common.cekuser(txtPassword.Text.Replace("'", "''")) + "')";
            strSelect = "SELECT q_Users.USERNAME, q_Users.KODE_LEVEL, q_Users.MENU_RTE, q_Users.NIP, q_Users.NAMA, q_Users.KODE_CABANG, q_Users.NAMA_CABANG, q_Users.KODE_DEPARTEMEN, q_Users.TGL_TUTUP, q_Users.Last_Update, q_Users.PIN, q_Users.TIPE_ENTRY, q_Users.ENTRY_BERSAMBUNG, q_Users.KODE_SATKER, q_Users.TGL_SKL FROM q_Users WHERE (username = '" + txtUserID.Text.Replace("'", "''") + "' AND PASSW = '" + common.cekuser(txtPassword.Text.Replace("'", "''")) + "')";
            adpSQL = new SqlDataAdapter(strSelect, cn);
            adpSQL.Fill(dsUsers);

            int recordCount = dsUsers.Tables[0].Rows.Count;
            //jika user ditemukan maka user valid untuk mengakses sebagai level aksesnya
            if (recordCount > 0)
            {
                Session["UserID"] = txtUserID.Text;
                Session["GradeID"] = dsUsers.Tables[0].Rows[0][1].ToString();
                Session["RealGrade"] = dsUsers.Tables[0].Rows[0][1].ToString();
                Session["MenuID"] = rtwin.common.DecryptText(dsUsers.Tables[0].Rows[0][2].ToString());
                Session["NIPID"] = dsUsers.Tables[0].Rows[0][3].ToString().Trim();
                Session["Nama"] = dsUsers.Tables[0].Rows[0][4].ToString();
                Session["CabangID"] = dsUsers.Tables[0].Rows[0][5].ToString();
                Session["Cabang"] = dsUsers.Tables[0].Rows[0][6].ToString();
                Session["DepartemenID"] = dsUsers.Tables[0].Rows[0][7].ToString();
                Session["tglTutup"] = dsUsers.Tables[0].Rows[0][8];
                Session["PINID"] = dsUsers.Tables[0].Rows[0][10].ToString().Trim();
                Session["TipeEntry"] = dsUsers.Tables[0].Rows[0][11].ToString();
                Session["SambungEntry"] = Convert.ToBoolean(dsUsers.Tables[0].Rows[0][12].ToString());
                Session["SatkerID"] = dsUsers.Tables[0].Rows[0][13].ToString();
                Session["tglValidasiLembur"] = dsUsers.Tables[0].Rows[0][14];
 
                if ((txtUserID.Text == txtPassword.Text) /*|| (System.Convert.ToDateTime(dsUsers.Tables[0].Rows[0][9]).AddMonths(3) <= DateTime.Now)*/)
                {
                    Response.Redirect("password.aspx");
                }
                else
                {
                    validpg = true;
                }
            }

            if (validpg)
            {
                //mencatat user yang login
                azlib.AddUserAct(Session["UserID"].ToString(), "0015", "", strCn);

                //Semua orang yang login default levelnya adalah user lalu langsung di Redirect ke laporan detail
                Session["GradeID"] = "4";
                if (Session["RealGrade"].ToString() == "4")
                {
                    Response.Redirect("detail.aspx");
                }
                else
                {
                    Response.Redirect("level.aspx");
                }
            }
            else
            {
                //Memberikan informasi user tidak teraftar atau tidak valid
                lblResult.Text = "Invalid User";
                HapusSession();
            }
            //menutup koneksi database
            cn.Close();
        }

        //fungsi: Handle permintaan Logout
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            azlib.AddUserAct(Session["UserID"].ToString(), "0025", "", Application["strCn"].ToString());
            HapusSession();
            Server.Transfer("default.aspx");
        }

        protected void linkLevel_Click(object sender, EventArgs e)
        {
            Server.Transfer("level.aspx");
        }
    
        protected void tvMenu_Select(object sender, EventArgs e)
        {
            tvMenu.SelectedNode.Expand();
        }

        protected void tvMenu_PreRender(object sender, EventArgs e)
        {
            if (tvMenu.SelectedNode == null)
            {
                SelectCurrentPageTreeNode(tvMenu);
            }
        }
        
        private void SelectCurrentPageTreeNode(TreeView tvTreeView)
        {
            if ((Request.Url.PathAndQuery != null) & (Request.Url.PathAndQuery.ToString() != "/level.aspx") & (Request.Url.PathAndQuery.ToString() != "/alert.aspx"))
            {
                tvTreeView.CollapseAll();
                ExpandTreeViewNodes(tvTreeView, Request.Url.PathAndQuery);
            }
        }

        private TreeNode ExpandTreeViewNodes(TreeView tvTreeView, string sPathAndQuery)
        {
            if (tvTreeView != null)
            {
                if (!string.IsNullOrEmpty(sPathAndQuery))
                {
                    sPathAndQuery = sPathAndQuery.ToLower().Substring(1, sPathAndQuery.Length - 1);
                    {
                        TreeNode tnWorkTreeNode = null;

                        for (int iLoop = 0; iLoop < tvTreeView.Nodes.Count; iLoop++)
                        {
                            tvTreeView.Nodes[iLoop].Expand();

                            tvTreeView.Nodes[iLoop].Selected = true;
                            if (tvTreeView.Nodes[iLoop].NavigateUrl.ToLower() == sPathAndQuery)
                            {
                                return (tvTreeView.Nodes[iLoop]);
                            }
                            else
                            {
                                tnWorkTreeNode = ExpandTreeViewNodesR(tvTreeView.Nodes[iLoop], sPathAndQuery);
                            }

                            if (tnWorkTreeNode != null)
                            {
                                return (tnWorkTreeNode);
                            }

                            tvTreeView.Nodes[iLoop].Collapse();
                        }
                    }
                }
            }

            return (null);
        }

        private static TreeNode ExpandTreeViewNodesR(TreeNode tvTreeNode, string sPathAndQuery)
        {
            TreeNode tnReturnTreeNode = null;

            if (tvTreeNode != null)
            {
                tvTreeNode.Expand();
                if (tvTreeNode.NavigateUrl.ToLower() == sPathAndQuery)
                {
                    return (tvTreeNode);
                }
                else
                {
                    tnReturnTreeNode = null;

                    for (int iLoop = 0; iLoop < tvTreeNode.ChildNodes.Count; iLoop++)
                    {
                        tvTreeNode.ChildNodes[iLoop].Selected = true;
                        tnReturnTreeNode = ExpandTreeViewNodesR(tvTreeNode.ChildNodes[iLoop], sPathAndQuery);

                        if (tnReturnTreeNode != null)
                        {
                            return (tnReturnTreeNode);
                        }
                    }
                    tvTreeNode.Collapse();
                }
            }
            return (null);
        }
    }
}