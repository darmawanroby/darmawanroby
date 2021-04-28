///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : employee.aspx.cs                             (Pseudo code)
//        File terkait  : employee.aspx                                (Form)
//                        \App_LocalResources\employee.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\employee.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                           (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk mengelola data pegawai
//
// 2. Penulis Program
//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 11/09/2009
//
// 4. Versi             : 2.0.3
//
// 5. Historis revisi
//        Versi 2.0.1   : Pembatasan hak entry tambah, edit, hapus menjadi read-only keuali bagi administrator
//        Versi 2.0.2   : Menggunakan AJAX
//        Versi 2.0.3   : Pengaturan Hak Akses untuk setiap level
//
//
///''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Udev.MasterPageWithLocalization.Classes;
using Microsoft.SqlServer.Server;
using Microsoft.SqlServer.Dts.Runtime;

namespace rtwin
{
    public partial class allowancepension : BasePage
    {
        public string count(string q)
        {
            string a;
            SqlConnection con = new SqlConnection(Application["strCn"].ToString());
            con.Open();
            SqlCommand pcom = new SqlCommand();
            SqlDataReader rdr;
            pcom = con.CreateCommand();
            pcom.CommandText = "select count(*) as jml FROM [q_Karyawan]" + q;
            rdr = pcom.ExecuteReader();

            rdr.Read();
            a = rdr["jml"].ToString();

            rdr.Close();
            con.Close();
            return a;
        }

        private void showGridView(Boolean show)
        {
            GvKaryawan.Visible = show;
            tableFilter.Visible = show;

        }

        private void doFiltering()
        {
            string strFilter = "";
            /* if (txtFilterItem0.Text.Trim() != "")
             {
                 strFilter += " AND (NIP = '" + txtFilterItem0.Text.Replace("'", "''") + "')";
             } 
            */
            /*    if ((ddlFilterItem1.SelectedValue != "---") && (ddlFilterItem1.SelectedValue != ""))
                {
                    if (strFilter != "")
                    {
                        strFilter += " AND (KODE_CABANG = '" + ddlFilterItem1.SelectedValue + "')";
                    }
                    else
                    {
                        strFilter += " WHERE (KODE_CABANG = '" + ddlFilterItem1.SelectedValue + "')";
                    }
                }*/

            /* if ((ddlFilterItem2.SelectedValue != "00000") && (ddlFilterItem2.SelectedValue != ""))
             {
                 if (strFilter != "")
                 {
                     strFilter += " AND (KODE_BAGIAN = '" + ddlFilterItem2.SelectedValue + "')";
                 }
                 else
                 {
                     strFilter += " WHERE (KODE_BAGIAN = '" + ddlFilterItem2.SelectedValue + "')";
                 }
             }

             if ((((ddlFilterItem1.SelectedValue == "000") || (ddlFilterItem1.SelectedValue == "")) && ((ddlFilterItem2.SelectedValue == "00000") || (ddlFilterItem2.SelectedValue == "")))) //Operator
             {
                 if ((Session["GradeID"].ToString() == "2"))
                 {
                     if (strFilter != "")
                     {
                         strFilter += " AND KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                     }
                     else
                     {
                         strFilter += " WHERE KODE_CABANG='" + Session["CabangID"].ToString() + "'";
                     }
                 }
                 else if ((Session["GradeID"].ToString().Substring(0, 1) == "3"))
                 {
                     if (strFilter != "")
                     {
                         strFilter += " AND KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                     }
                     else
                     {
                         strFilter += " WHERE KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
                     }
                 }
             }*/

            /*if (ddlFilterItem3.SelectedValue == "1")
            {
                if (strFilter != "")
                {
                    strFilter += " AND Not TEMPLATE is NULL";
                }
                else
                {
                    strFilter += " WHERE Not TEMPLATE is NULL";
                }
            }
            else if (ddlFilterItem3.SelectedValue == "2")
            {
                if (strFilter != "")
                {
                    strFilter += " AND TEMPLATE is NULL";
                }
                else
                {
                    strFilter += " WHERE TEMPLATE is NULL";
                }
            }*/

            lblJmlRecord.Text = count(strFilter);

            dsKaryawan.SelectCommand += strFilter;// +" order by KODE_GRADE DESC, KODE_JABATAN, KODE_GOLONGAN DESC";
            //Response.Write(dsKaryawan.SelectCommand.ToString());
        }

        private void setFilter()
        {
            /*   if (Session["GradeID"].ToString() == "2")
               {
                   dsBiro.FilterExpression = "KODE_BIRO = '0000' OR KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
               }
               else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
               {
                   dsBiro.SelectCommand = "SELECT KODE_BIRO, NAMA_BIRO FROM q_Biro";
                   dsBiro.SelectCommand += " WHERE KODE_BIRO = '0000' OR KODE_BIRO IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE username='" + Session["UserID"].ToString() + "')";
               }
               else if ((Session["GradeID"].ToString() == "3a") || (Session["GradeID"].ToString() == "4"))
               {
                   txtFilterItem0.Text = Session["NIPID"].ToString();
                   tableFilter.Visible = false;
               }*/
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            //jika userid kosong maka akan di link ke halaman awal
            if (!rtwin.azlib.AksesHalaman(11, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
            {
                Response.Redirect("notauthorized.aspx");
            }


            //jika halaman bukan postback
            if (!Page.IsPostBack)
            {
                setFilter();

                showGridView(true);
                int bln = DateTime.Now.Month;

                byte i;
                ListItem li = new ListItem();
                for (i = 1; i <= 12; i++)
                {
                    li = new ListItem((DateTime.Parse(i.ToString() + "/" + i.ToString() + " /1900")).ToString("MMMM"), i.ToString()); //Format(DateTime.Parse(CStr(i) & "/" & CStr(i) & " /1900"), "MMMM"), CStr(i))
                    DropBulan.Items.Add(li);
                }

                DropBulan.SelectedValue = bln.ToString();

                li = new ListItem(System.Convert.ToString(DateTime.Now.Year - 1), System.Convert.ToString(DateTime.Now.Year - 1));
                ddlTahun.Items.Add(li);
                li = new ListItem(DateTime.Now.Year.ToString(), DateTime.Now.Year.ToString());
                ddlTahun.Items.Add(li);
                ddlTahun.SelectedValue = DateTime.Now.Year.ToString();
            }
            Session["iBulan"] = DropBulan.SelectedValue.ToString();
            Session["iTahun"] = ddlTahun.SelectedValue.ToString();
            doFiltering();
            doFilteringLookup();
          //  Response.Write(dsKaryawan.SelectCommand.ToString());
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {

            /* dsKaryawan.SelectCommand = "SELECT NIP, NAMA,NAMA_CABANG,STATUS_PENSIUN from taRapelTK where BULAN = '" + Session["iBulan"].ToString() + "' AND TAHUN= '" + Session["iTahun"].ToString() + "'";
             if (txtFilterItem0.Text.Trim() != "")
             {
                 lblTitle.Text = txtFilterItem0.Text;
            }*/
           /* if (ddlFilterItem1.SelectedValue != "---")
            {
                dsKaryawan.SelectCommand += "AND KODE_CABANG ='" + ddlFilterItem1.SelectedValue + "'";
                GvKaryawan.DataBind();
            }*/
          
           /* if (txtFilterItem0.Text.Trim() != "")
            {
                string strFilter = "";
                strFilter += " AND (NIP = '" + txtFilterItem0.Text.Replace("'", "''") + "')";
                Response.Write(strFilter);
            }*/
            // showGridView(false);
         //   Label24.Text = txtFilterItem0.Text;
            dsKaryawan.SelectCommand += "AND NIP='" + txtFilterItem0.Text + "'";
            GvKaryawan.DataBind();
        }


        protected void GvKaryawan_DataBound(object sender, EventArgs e)
        {
            //seleksi jumlah data kosong atau tidak
            if (GvKaryawan.Rows.Count > 0)
            {
                GridViewRow rowPager = GvKaryawan.BottomPagerRow;

                if (rowPager != null)
                {
                   // int iTotalRecords = ((DataTable)(GvKaryawan.DataSource)).Rows.Count;
                    // get your controls from the gridview
                    TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                    Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                    txtHalaman.Text = (GvKaryawan.PageIndex + 1).ToString();
                    // populate page count
                    lblJumlahHalaman.Text = GvKaryawan.PageCount.ToString();

                    Label lbljml = (Label)(rowPager.Cells[0].FindControl("lbljml"));
                  lbljml.Text = "Jumlah Record : " + lblJmlRecord.Text;
                   // textBox1.Text = gridView1.RowCount.ToString();
                     
                }
                //showGridView(true);
            }
            else
            {
                //Data kosong, set gridview visible false, formview visible true
                //showGridView(false);
            }
        }

        //Menyisipkan javascript untuk confirm sebelum delete
        protected void GvKaryawan_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            //menambahkan State Row on Hover
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView gv = ((GridView)sender);

                String className = ((e.Row.RowState == DataControlRowState.Alternate) ? gv.AlternatingRowStyle.CssClass : gv.RowStyle.CssClass);

                e.Row.Attributes.Add("onmouseover", "this.className='datagrid_hovcol';");

                e.Row.Attributes.Add("onmouseout", "this.className='" + className + "';");
            }
        }

        protected void GvKaryawan_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            if (Page.IsValid)
            {
                GvKaryawan.EditIndex = e.NewEditIndex;
                GvKaryawan.DataBind();
                //this.ScriptManager1.SetFocus(GvBranch.Rows[e.NewEditIndex].Cells[1].FindControl("txtCol1Edit").ClientID);
            }
            else
            {
                e.Cancel = true;
            }
        }

        protected void GvKaryawan_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Detail")
            {
                if (Page.IsValid)
                {


                }
            }
        }



        protected void txtHalaman_TextChanged(object sender, EventArgs e)
        {
            GridViewRow rowPager = GvKaryawan.BottomPagerRow;
            TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));

            try
            {
                if (int.Parse(txtHalaman.Text) <= GvKaryawan.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                {
                    GvKaryawan.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                    GvKaryawan.DataBind();
                }
            }
            catch (Exception ex)
            {
                txtHalaman.Text = (GvKaryawan.PageIndex + 1).ToString();
            }
        }





        protected void lnkCol2Footer_Click(object sender, EventArgs e)
        {
            Session["Triger"] = "txtFilterItem0";
            GvLookupPegawai.DataBind();
            LookupMPE.Show();
        }

        //Lookup Code
        private void doFilteringLookup()
        {
            string strFilter = "";

            if (txtLookupCariPegawai.Text.Trim() != "")
            {
                strFilter = "NAMA LIKE '%" + txtLookupCariPegawai.Text + "%'";
            }
            if ((Session["GradeID"].ToString() != "1") && (Session["GradeID"].ToString() != "1a"))
            {
                if (strFilter != "")
                {
                    strFilter += "AND ";
                }
                if (Session["GradeID"].ToString() == "2")
                {
                    strFilter += "KODE_CABANG = '" + Session["CabangID"].ToString() + "'";
                }
                else if (Session["GradeID"].ToString().Substring(0, 1) == "3")
                {
                    strFilter += "KODE_DEPARTEMEN IN (SELECT KODE_DEPARTEMEN FROM taOtoritasDepartemen WHERE USERNAME = '" + Session["UserID"].ToString() + "')";
                }
                else if (Session["GradeID"].ToString() == "4")
                {
                    strFilter += "NIP = '" + Session["NIPID"].ToString() + "'";
                }
            }
            //dsLookup.FilterExpression = strFilter;
            dsLookup.SelectCommand = "SELECT NIP, PIN, NAMA FROM taKaryawan";
            if (strFilter != "")
            {
                dsLookup.SelectCommand += " WHERE " + strFilter;
            }
            dsLookup.SelectCommand += " ORDER BY NIP";
        }

        protected void txtHalamanLookup_TextChanged(object sender, EventArgs e)
        {
            GridViewRow rowPager = GvLookupPegawai.BottomPagerRow;
            TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
            try
            {
                if (int.Parse(txtHalaman.Text) <= GvLookupPegawai.PageCount + 1 && int.Parse(txtHalaman.Text) > 0)
                {
                    GvLookupPegawai.PageIndex = (int.Parse(txtHalaman.Text)) - 1;
                    GvLookupPegawai.DataBind();
                }
            }
            catch (Exception)
            {
                txtHalaman.Text = (GvLookupPegawai.PageIndex + 1).ToString();
            }
        }

        protected void GvLookupPegawai_DataBound(object sender, EventArgs e)
        {
            //Data tidak kosong
            GridViewRow rowPager = GvLookupPegawai.BottomPagerRow;

            //seleksi pager Row apakah ada atau tidak
            if (rowPager != null)
            {
                //set property control di pager Row
                TextBox txtHalaman = (TextBox)(rowPager.Cells[0].FindControl("txtHalaman"));
                Label lblJumlahHalaman = (Label)(rowPager.Cells[0].FindControl("lblJumlahHalaman"));

                txtHalaman.Text = Convert.ToString(GvLookupPegawai.PageIndex + 1);
                lblJumlahHalaman.Text = GvLookupPegawai.PageCount.ToString();
            }
        }

        private void setInitialLookupState()
        {
            txtLookupCariPegawai.Text = "";
            GvLookupPegawai.PageIndex = 0;
            GvLookupPegawai.SelectedIndex = -1;
        }

        protected void imgLookupCancel_Click(object sender, ImageClickEventArgs e)
        {
            lnkLookupClose_Click(sender, e);
        }

        protected void lnkLookupClose_Click(object sender, EventArgs e)
        {
            setInitialLookupState();
            UpdatePanel1.Update();
        }

        protected void btnLookupCari_Click(object sender, EventArgs e)
        {
            GvLookupPegawai.DataBind();
        }

        protected void GvLookupPegawai_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["Triger"] != null)
            {
                if (Session["Triger"].ToString() == "txtFilterItem0")
                {
                    this.txtFilterItem0.Text = ((Label)GvLookupPegawai.SelectedRow.Cells[0].FindControl("Label1")).Text;
                }

                Session.Remove("Triger");
            }

            setInitialLookupState();
            UpdatePanel1.Update();
        }



        protected void ddlFilterItem1_SelectedIndexChanged(object sender, EventArgs e)
        {
            dsKaryawan.SelectCommand += "AND KODE_CABANG='" + ddlFilterItem1.SelectedValue + "'";
            GvKaryawan.DataBind();
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GvKaryawan.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    //Below captures the checkbox value (yes or no)
                   
                    CheckBox chk = (CheckBox)row.FindControl("CheckBox1");
                    Label NIP = (Label)row.FindControl("lblCol0Item");
                    if (chk.Checked)
                    {
                        string sql = "update taRapelTK set status_pensiun='1' where nip='" + NIP.Text + "' AND BULAN='" + Session["iBulan"].ToString() + "' AND TAHUN='" + Session["iTahun"].ToString() + "'";
                        SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                        using (SqlConnection openCon = new SqlConnection(Application["strCn"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("update taRapelTK set status_pensiun='1' where nip='" + NIP.Text + "' AND BULAN='" + Session["iBulan"].ToString() + "' AND TAHUN='" + Session["iTahun"].ToString() + "'", cn))
                            {
                                openCon.Open();
                                cmd.Connection = openCon;

                                cmd.ExecuteNonQuery();
                                openCon.Close();
                                Label27.Text = "Update Pensiun Berhasil";
                            }

                        }
                        // Label24.Text = sql;// NIP.Text;
                        // Response.Write(sql);
                    }

                    else {
                        SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                        using (SqlConnection openCon = new SqlConnection(Application["strCn"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("update taRapelTK set status_pensiun='0' where nip='" + NIP.Text + "' AND BULAN='" + Session["iBulan"].ToString() + "' AND TAHUN='" + Session["iTahun"].ToString() + "'", cn))
                            {
                                openCon.Open();
                                cmd.Connection = openCon;

                                cmd.ExecuteNonQuery();
                                openCon.Close();
                                Label27.Text = "Update Pensiun Berhasil";
                            }

                        }
                    }
                }
            }
        }
}
}
