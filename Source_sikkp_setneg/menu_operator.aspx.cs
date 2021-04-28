///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     :  menu_operator.aspx.cs                                (Pseudo code)
//        File terkait  :  menu_operator.aspx                                   (Form)
//                        \App_LocalResources\ menu_operator.aspx.id.resx       (Display label bahasa Indonesia)
//                        \App_LocalResources\ menu_operator.en.resx            (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                                    (Library/class)
//                        \App_Code\comon.cs                                    (Library/class)
//
//        Deskripsi     : Halaman untuk convigurasi hak akses halaman
//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 10/09/2009
//
// 4. Versi             : 2.0.4
//
// 5. Historis revisi
//        Versi 2.0.1   : penyelesaian bugs
//        Versi 2.0.2   : pengaturan hak berdasarkan group level
//        Versi 2.0.3   : hak terstrukur + encrypt
//        Versi 2.0.4   : Pengimplementasian AJAX
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Data.SqlClient;
using Udev.MasterPageWithLocalization.Classes;
using System.Xml;


namespace rtwin
{

    public partial class menu_operator : BasePage
    {

        //fungsi untuk convert char ke boolean
        public bool Str2Bool(string str)
        {
            if (str=="1")
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //fungsi untuk convert char ke boolean
        public string Bool2Str(bool chk)
        {
            if (chk)
            {
                return "1";
            }
            else
            {
                return "0";
            }
        }

        private void setXML(string Nama_Level, string menu_id)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(Server.MapPath("App_Data/menu.xml"));
            XmlNode xmlNdeRoot = doc.DocumentElement.SelectSingleNode(@"/menu");
            XmlNode xmlNdeAdmin = xmlNdeRoot.SelectSingleNode(@"//level[@name='Administrator']").CloneNode(true);

            xmlNdeRoot.RemoveChild(xmlNdeRoot.SelectSingleNode(@"//level[@name='" + Nama_Level + "']"));

            xmlNdeAdmin.Attributes["name"].Value = Nama_Level;

            //master
            if ((menu_id.Substring(0, 1) == "0") && (menu_id.Substring(1, 1) == "0") && (menu_id.Substring(2, 1) == "0") && (menu_id.Substring(3, 1) == "0") && (menu_id.Substring(29, 1) == "0") && (menu_id.Substring(30, 1) == "0") && (menu_id.Substring(4, 1) == "0") && (menu_id.Substring(5, 1) == "0") && (menu_id.Substring(6, 1) == "0") && (menu_id.Substring(7, 1) == "0") && (menu_id.Substring(8, 1) == "0") && (menu_id.Substring(9, 1) == "0") && (menu_id.Substring(10, 1) == "0"))
            {
                xmlNdeAdmin.SelectSingleNode(@"//menu_parent[@title='Master']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_parent[@title='Master']"));
            }
            else
            {
                //tabel
                if ((menu_id.Substring(0, 1) == "0") && (menu_id.Substring(1, 1) == "0") && (menu_id.Substring(2, 1) == "0") && (menu_id.Substring(3, 1) == "0") && (menu_id.Substring(29, 1) == "0") && (menu_id.Substring(30, 1) == "0"))
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Table']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Table']"));
                }
                else
                {
                    if (menu_id.Substring(0, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Waktu Kerja']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Waktu Kerja']"));
                    }
                    if (menu_id.Substring(1, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Pola Jadwal']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Pola Jadwal']"));
                    }
                    if (menu_id.Substring(2, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Libur']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Libur']"));
                    }
                    if (menu_id.Substring(3, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Status Absen']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Status Absen']"));
                    }
                    if (menu_id.Substring(29, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Parameter Lembur']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Parameter Lembur']"));
                    }
                    if (menu_id.Substring(30, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Potongan']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Potongan']"));
                    }
                }

                //unit kerja
                if ((menu_id.Substring(4, 1) == "0") && (menu_id.Substring(5, 1) == "0") && (menu_id.Substring(6, 1) == "0") && (menu_id.Substring(7, 1) == "0") && (menu_id.Substring(8, 1) == "0") && (menu_id.Substring(9, 1) == "0"))
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Unit Kerja']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Unit Kerja']"));
                }
                else
                {
                    if (menu_id.Substring(4, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Satuan Kerja']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Satuan Kerja']"));
                    }
                    if (menu_id.Substring(5, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Jabatan']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Jabatan']"));
                    }
                    if (menu_id.Substring(6, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Golongan']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Golongan']"));
                    }
                    if (menu_id.Substring(7, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Grade']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Grade']"));
                    }
                    if (menu_id.Substring(8, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Eselon']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Eselon']"));
                    }
                    if (menu_id.Substring(9, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Status']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Status']"));
                    }
                }

                //pegawai
                if (menu_id.Substring(10, 1) == "0")
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Pegawai']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Pegawai']"));
                }
            }
            
            //transaksi
            if ((menu_id.Substring(11, 1) == "0") && (menu_id.Substring(12, 1) == "0") && (menu_id.Substring(13, 1) == "0") && (menu_id.Substring(14, 1) == "0") && (menu_id.Substring(15, 1) == "0") && (menu_id.Substring(17, 1) == "0") && (menu_id.Substring(18, 1) == "0") && (menu_id.Substring(31, 1) == "0"))
            {
                xmlNdeAdmin.SelectSingleNode(@"//menu_parent[@title='Transaksi']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_parent[@title='Transaksi']"));
            }
            else
            { 
                //manual
                if (menu_id.Substring(12, 1) == "0")
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Kehadiran Manual']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Kehadiran Manual']"));
                }

                //Tidak hadir
                if ((menu_id.Substring(11, 1) == "0") && (menu_id.Substring(13, 1) == "0") && (menu_id.Substring(14, 1) == "0"))
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Tidak Hadir']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Tidak Hadir']"));
                }
                else
                {
                    if (menu_id.Substring(11, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Saldo Ijin/Cuti']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Saldo Ijin/Cuti']"));
                    }

                    if (menu_id.Substring(13, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Per Hari']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Per Hari']"));
                    }
                    if (menu_id.Substring(14, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Per Jam']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Per Jam']"));
                    }
                }

                //lembur
                if (menu_id.Substring(15, 1) == "0")
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Lembur']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Lembur']"));
                }

                //perubahan pola
                if ((menu_id.Substring(17, 1) == "0") && (menu_id.Substring(18, 1) == "0"))
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Perubahan Pola']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Perubahan Pola']"));
                }
                else
                {
                    if (menu_id.Substring(17, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Kolektif']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Kolektif']"));
                    }
                    if (menu_id.Substring(18, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Individual']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Individual']"));
                    }
                }

                //hukuman disiplin
                if (menu_id.Substring(31, 1) == "0")
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Hukuman Disiplin']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Hukuman Disiplin']"));
                }
            }
            
            //laporan
            if ((menu_id.Substring(19, 1) == "0") && (menu_id.Substring(20, 1) == "0") && (menu_id.Substring(21, 1) == "0") && (menu_id.Substring(22, 1) == "0"))
            {
                xmlNdeAdmin.SelectSingleNode(@"//menu_parent[@title='Laporan']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_parent[@title='Laporan']"));
            }
            else
            { 
                //kehadiran
                if ((menu_id.Substring(19, 1) == "0") && (menu_id.Substring(20, 1) == "0") && (menu_id.Substring(21, 1) == "0"))
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Kehadiran']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Kehadiran']"));
                }
                else
                {
                    if (menu_id.Substring(19, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Harian']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Harian']"));
                    }
                    if (menu_id.Substring(20, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Bulanan']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Bulanan']"));
                    }
                    if (menu_id.Substring(21, 1) == "0")
                    {
                        xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Tahunan']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child2[@subtitle2='Tahunan']"));
                    }
                }

                //keuangan
                if (menu_id.Substring(22, 1) == "0")
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Tunjangan']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Tunjangan']"));
                }
            }

            //utility
            if ((menu_id.Substring(23, 1) == "0") && (menu_id.Substring(24, 1) == "0") && (menu_id.Substring(25, 1) == "0") && (menu_id.Substring(26, 1) == "0"))
            {
                xmlNdeAdmin.SelectSingleNode(@"//menu_parent[@title='Utility']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_parent[@title='Utility']"));
            }
            else
            {
                if (menu_id.Substring(23, 1) == "0")
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Hak Akses Menu']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Hak Akses Menu']"));
                }
                if (menu_id.Substring(24, 1) == "0")
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Users']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Users']"));
                }
                if (menu_id.Substring(25, 1) == "0")
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Aktivitas Pemakai']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Aktivitas Pemakai']"));
                }
                if (menu_id.Substring(26, 1) == "0")
                {
                    xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Data Murni']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_child[@subtitle='Data Murni']"));
                }
            }

            //Download


            //Konfigurasi
            if (menu_id.Substring(28, 1) == "0")
            {
                xmlNdeAdmin.SelectSingleNode(@"//menu_parent[@title='Konfigurasi']").ParentNode.RemoveChild(xmlNdeAdmin.SelectSingleNode(@"//menu_parent[@title='Konfigurasi']"));
            }
            
            xmlNdeRoot.AppendChild(xmlNdeAdmin);
            doc.Save(Server.MapPath("App_Data/menu.xml"));
            doc.RemoveAll();
        }

        //fungsi: mengatur kondisi checkbox
        public void setMenu()
        {
            try
            {
                SqlConnection cn;
                System.Data.DataSet dsMenu = new System.Data.DataSet();
                string strSelect;
                SqlDataAdapter adpSQL;
                string strMenu;
                
                cn = new SqlConnection(Application["strCn"].ToString());

                //query untuk mengambil hak akses halaman
                strSelect = "SELECT MENU_RTE FROM taUserLevel WHERE KODE_LEVEL = '" + ddlLevel.SelectedValue + "'";
                //menyimpan virtual tabel ke sqladapter dan menyimpan data pada dataset
                adpSQL = new SqlDataAdapter(strSelect, cn);
                adpSQL.Fill(dsMenu);
                strMenu = rtwin.common.DecryptText(dsMenu.Tables[0].Rows[0][0].ToString());
                //split menu akses user dan menyimpan pada check box
                //cekbox pada halaman yang mengakses tabel-tabel master
                chkWorkSchedule.Checked = Str2Bool(strMenu.Substring(0, 1));
                chkShiftGroup.Checked = Str2Bool(strMenu.Substring(1, 1));
                chkHoliday.Checked = Str2Bool(strMenu.Substring(2, 1));
                chkLeave.Checked = Str2Bool(strMenu.Substring(3, 1));
                chkBranch.Checked = Str2Bool(strMenu.Substring(4, 1));
                chkPosition.Checked = Str2Bool(strMenu.Substring(5, 1));
                chkGroup.Checked = Str2Bool(strMenu.Substring(6, 1));
                chkGrade.Checked = Str2Bool(strMenu.Substring(7, 1));
                chkEchelon.Checked = Str2Bool(strMenu.Substring(8, 1));
                chkStatus.Checked = Str2Bool(strMenu.Substring(9, 1));
                chkEmployee.Checked = Str2Bool(strMenu.Substring(10, 1));
                chkLeaveAccrual.Checked = Str2Bool(strMenu.Substring(11, 1));
                //cekbox pada tabel-tabel halaman yang mengakses  transaksi
                chkManualAttendance.Checked = Str2Bool(strMenu.Substring(12, 1));
                chkDayOff.Checked = Str2Bool(strMenu.Substring(13, 1));
                chkTimeOff.Checked = Str2Bool(strMenu.Substring(14, 1));
                chkOvertime.Checked = Str2Bool(strMenu.Substring(15, 1));
                //16 untuk skl
                chkkolektif.Checked = Str2Bool(strMenu.Substring(17, 1));
                chkindividu.Checked = Str2Bool(strMenu.Substring(18, 1));
                //cekbox pada halaman yang mengakses  tabel-tabel laporan
                chkDaily.Checked = Str2Bool(strMenu.Substring(19, 1));
                chkDetail.Checked = Str2Bool(strMenu.Substring(20, 1));
                chkSummary.Checked = Str2Bool(strMenu.Substring(21, 1));
                chkFinance.Checked = Str2Bool(strMenu.Substring(22, 1));
                //cekbox pada halaman yang mengakses  tabel-tabel utility
                chkMenu.Checked = Str2Bool(strMenu.Substring(23, 1));
                chkUser.Checked = Str2Bool(strMenu.Substring(24, 1));
                chkEventLog.Checked = Str2Bool(strMenu.Substring(25, 1));
                chkRawData.Checked = Str2Bool(strMenu.Substring(26, 1));
                chkconfig.Checked = Str2Bool(strMenu.Substring(28, 1));
                //cekbox pada halaman yang mengakses  tabel-tabel tambahan
                chkOvertimeConfig.Checked = Str2Bool(strMenu.Substring(29, 1));
                chkDeduction.Checked = Str2Bool(strMenu.Substring(30, 1));
                chkPunishment.Checked = Str2Bool(strMenu.Substring(31, 1));

                cn.Close();
            }
            catch (Exception ex)
            {
                ExceptionDetails.Text = ex.Message;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
       {
            //Validasi halaman dari taUser
           if (!rtwin.azlib.AksesHalaman(24, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
           {
               Response.Redirect("notauthorized.aspx");
           }
            //membuka koneksi database
            if (!Page.IsPostBack)
            {
                ddlLevel.SelectedIndex = 4;
            }
        }

        //fungsi: Handle ketika ada perubahan level
        protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e)
        {
            setMenu();
        }

        //fungsi: Handle ketika btnOK di klik 
        protected void btnOK_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection cn;
                SqlCommand cmd = new SqlCommand();
                string strMenu;

                cn = new SqlConnection(Application["strCn"].ToString());

                //mendeklarasikan strmenu dan mengambil dari nilai-nilai checkbox
                //strMenu = Bool2Str(chkWorkSchedule.Checked) + "" + Bool2Str(chkShiftGroup.Checked) + "" + Bool2Str(chkHoliday.Checked) + "" + Bool2Str(chkLeave.Checked) + "" + Bool2Str(chkBranch.Checked) + "" + Bool2Str(chkPosition.Checked) + "" + Bool2Str(chkGroup.Checked) + "" + Bool2Str(chkGrade.Checked) + "" + Bool2Str(chkEchelon.Checked) + "" + Bool2Str(chkStatus.Checked) + "" + Bool2Str(chkEmployee.Checked) + "" + Bool2Str(chkLeaveAccrual.Checked) + "" + Bool2Str(chkManualAttendance.Checked) + "" + Bool2Str(chkDayOff.Checked) + "" + Bool2Str(chkTimeOff.Checked) + "" + Bool2Str(chkOvertime.Checked) + "" + Bool2Str(chkkolektif.Checked) + "" + Bool2Str(chkindividu.Checked) + "" + Bool2Str(chkPunishment.Checked) + "" + Bool2Str(chkDaily.Checked) + "" + Bool2Str(chkDetail.Checked) + "" + Bool2Str(chkSummary.Checked) + "" + Bool2Str(chkFinance.Checked) + "" + Bool2Str(chkMenu.Checked) + "" + Bool2Str(chkUser.Checked) + "" + Bool2Str(chkEventLog.Checked) + "" + Bool2Str(chkRawData.Checked) + "" + Bool2Str(chkconfig.Checked) + "" + Bool2Str(chkOvertimeConfig.Checked) + "" + "" + Bool2Str(chkDeduction.Checked);
                strMenu = /*1*/Bool2Str(chkWorkSchedule.Checked) + "" + /*2*/Bool2Str(chkShiftGroup.Checked) + "" + /*3*/Bool2Str(chkHoliday.Checked) + "" + /*4*/Bool2Str(chkLeave.Checked) + "" + /*5*/Bool2Str(chkBranch.Checked) + "" + /*6*/Bool2Str(chkPosition.Checked) + "" + /*7*/Bool2Str(chkGroup.Checked) + "" + /*8*/Bool2Str(chkGrade.Checked) + "" + /*9*/Bool2Str(chkEchelon.Checked) + "" + /*10*/Bool2Str(chkStatus.Checked) + "" + /*11*/Bool2Str(chkEmployee.Checked) + "" + /*12*/Bool2Str(chkLeaveAccrual.Checked) + "" + /*13*/Bool2Str(chkManualAttendance.Checked) + "" + /*14*/Bool2Str(chkDayOff.Checked) + "" + /*15*/Bool2Str(chkTimeOff.Checked) + "" + /*16*/Bool2Str(chkOvertime.Checked) + "" + /*17*/Bool2Str(chkOvertime.Checked) + "" + /*18*/Bool2Str(chkkolektif.Checked) + "" + /*19*/Bool2Str(chkindividu.Checked) + "" + /*20*/Bool2Str(chkDaily.Checked) + "" + /*21*/Bool2Str(chkDetail.Checked) + "" + /*22*/Bool2Str(chkSummary.Checked) + "" + /*23*/Bool2Str(chkFinance.Checked) + "" + /*24*/Bool2Str(chkMenu.Checked) + "" + /*25*/Bool2Str(chkUser.Checked) + "" + /*26*/Bool2Str(chkEventLog.Checked) + "" + /*27*/Bool2Str(chkRawData.Checked) + "" + /*28*/Bool2Str(chkconfig.Checked) + "" + /*29*/Bool2Str(chkconfig.Checked) + "" + /*30*/Bool2Str(chkOvertimeConfig.Checked) + "" + /*31*/Bool2Str(chkDeduction.Checked) + "" + /*32*/Bool2Str(chkPunishment.Checked);
                //menutup koneksi database
                //ExceptionDetails.Text = strMenu + " Length: " + strMenu.Length.ToString();
                cn.Open();
                //update hak akses halaman pada database
                cmd.CommandText = "UPDATE taUserLevel SET menu_rte = '" + rtwin.common.EncryptText(strMenu) + "' WHERE KODE_LEVEL = '" + ddlLevel.SelectedValue + "'";
                cmd.CommandType = CommandType.Text;
                cmd.Connection = cn;
                cmd.ExecuteNonQuery();
                rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4116", ddlLevel.SelectedItem.Text, Application["strCn"].ToString());
                cn.Close();
                lblResult.Text = "";

                string nama_level = "";

                if (ddlLevel.SelectedValue == "1")
                {
                    nama_level = "Administrator";
                }
                if (ddlLevel.SelectedValue == "1a")
                {
                    nama_level = "Finance";
                }
                else if (ddlLevel.SelectedValue == "2")
                {
                    nama_level = "Validator";
                }
                else if (ddlLevel.SelectedValue == "3")
                {
                    nama_level = "Operator";
                }
                else if (ddlLevel.SelectedValue == "3a")
                {
                    nama_level = "Viewer";
                }
                else if (ddlLevel.SelectedValue == "4")
                {
                    nama_level = "User";
                }

                setXML(nama_level, strMenu);
            }
            catch (Exception ex)
            {
                ExceptionDetails.Text = ex.Message;
            }
        }

        //fungsi: mengatur kondisi checkbox
        private void setChecked(bool state)
        {
            chkWorkSchedule.Checked = state;
            chkShiftGroup.Checked = state;
            chkHoliday.Checked = state;
            chkLeave.Checked = state;
            chkBranch.Checked = state;
            chkPosition.Checked = state;
            chkGroup.Checked = state;
            chkGrade.Checked = state;
            chkEchelon.Checked = state;
            chkStatus.Checked = state;
            chkEmployee.Checked = state;
            chkLeaveAccrual.Checked = state;
            chkOvertimeConfig.Checked = state;
            chkDeduction.Checked = state;
            //cekbox pada tabel-tabel halaman yang mengakses  transaksi
            chkManualAttendance.Checked = state;
            chkDayOff.Checked = state;
            chkTimeOff.Checked = state;
            chkOvertime.Checked = state;
            chkkolektif.Checked = state;
            chkindividu.Checked = state;
            chkPunishment.Checked = state;
            //cekbox pada halaman yang mengakses  tabel-tabel laporan
            chkDaily.Checked = state;
            chkDetail.Checked = state;
            chkSummary.Checked = state;
            chkFinance.Checked = state;
            //cekbox pada halaman yang mengakses  tabel-tabel utility
            chkMenu.Checked = state;
            chkUser.Checked = state;
            chkEventLog.Checked = state;
            chkRawData.Checked = state;
            chkconfig.Checked = state;
        }

        //fungsi: Handle ketika ada permintaan cek all atau un cek all
        protected void chkCekOrUnCekAll_CheckedChanged(object sender, EventArgs e)
        {
            if (chkCekOrUnCekAll.Checked)
            {
                setChecked(true);
            }
            else
            {
                setChecked(false);
            }
        }
}
}
