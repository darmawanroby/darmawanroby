///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
// 1. Identifikasi Program
//        Nama file     : grant_branch.aspx.cs                             (Pseudo code)

//        File terkait  : grant_branch.aspx                                (Form)
//                        \App_LocalResources\grant_branch.aspx.id.resx    (Display label bahasa Indonesia)
//                        \App_LocalResources\grant_branch.aspx.en.resx    (Display label bahasa Inggris)
//                        \App_Code\azlib.cs                         (Kumpulan fungsi-fungsi)
//
//
//        Deskripsi     : Halaman untuk menampilkan dan mengolah hak akses cabang (taOtoritasCabang)

//
// 2. Penulis Program

//        Programer     : Aas Meinardi, Irwan Asminan
//        Co-Programmer : Bayu Widiaiswara
//
// 3. Tanggal update    : 12/09/2009
//
// 4. Versi             : 2.0.3
//
// 5. Historis revisi
//        Versi 2.0.1   : First Release
//        Versi 2.0.2   : Penyesuaian tampilan
//        Versi 2.0.3   : Penyederhanaan query
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
using Udev.MasterPageWithLocalization.Classes;

	namespace rtwin
	{
		
		public partial class grant_department : BasePage
		{
            //fungsi: Menyimpan kode cabang yg menjadi hak user dari database pertama kali dan menyimpannya di session
            private void RememberOldValuesFirstTime()
            {
                ArrayList categoryIDList = new ArrayList();

                SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());
            
                DataSet mydataset = new DataSet();

                SqlDataAdapter myadapter = new SqlDataAdapter();

                SqlCommand mycommand = new SqlCommand("SELECT KODE_CABANG FROM q_OtoritasCabang WHERE (USERNAME = '" + Session["strUser"].ToString() + "' AND HAK = 1) ",myconection);
            
                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taCabang");

                /*Seleksi apakah hasil Query null atau tidak
                'jika null maka item hanya null
                'jika tidak null maka item diisi oleh kode range yang didapat*/
                if (mydataset.Tables["taCabang"].Rows.Count == 0)
                {
                    myadapter.Dispose();
                    mydataset.Clear();
                }
                else
                {
                    DataTable myTabel = mydataset.Tables["taCabang"];
                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        categoryIDList.Add(myRow["KODE_CABANG"].ToString());
                    }

                    if (categoryIDList != null)
                    {
                        if (categoryIDList.Count > 0)
                        {
                            Session["CHECKED_ITEMS"] = categoryIDList;
                        }
                    }
                    myadapter.Dispose();
                    mydataset.Clear();

                    if (Session["UNCHECKED"] != null)
                    {
                        Session.Remove("UNCHECKED");
                    }
                }
            }

            //fungsi: Menyimpan kode cabang yg menjadi hak user dari GridView dan menyimpannya di session
        private void RememberOldValues()
        {
            ArrayList categoryIDList = new ArrayList();
            ArrayList categoryIDList2 = new ArrayList();
            String index;

            //' Check in the Session 
            if (Session["CHECKED_ITEMS"] != null)
            {
                categoryIDList = (ArrayList)Session["CHECKED_ITEMS"];
            }

            if (Session["UNCHECKED"] != null)
            {
                categoryIDList2 = (ArrayList)Session["UNCHECKED"];
            }

            foreach (GridViewRow row in GvOtoritasCabang.Rows)
            {
                index = GvOtoritasCabang.DataKeys[row.RowIndex].Value.ToString();

                Boolean result = ((CheckBox)(row.FindControl("chkSelect"))).Checked;

                if (result)
                {
                    if (!categoryIDList.Contains(index))
                    {
                        categoryIDList.Add(index);
                    }
                    categoryIDList2.Remove(index);
                }
                else
                {
                    categoryIDList.Remove(index);
                    if (!categoryIDList2.Contains(index))
                    {
                        categoryIDList2.Add(index);
                    }
                }
            }

            if (categoryIDList != null)
            {
                if (categoryIDList.Count > 0)
                {
                    Session["CHECKED_ITEMS"] = categoryIDList;
                }
            }
            if (categoryIDList2 != null)
            {
                if (categoryIDList2.Count > 0)
                {
                    Session["UNCHECKED"] = categoryIDList2;
                }
            }
        }

        //fungsi: Menampilkan kode cabang yg menjadi hak user dari database
        private void RePopulateValues()
        {
            ArrayList categoryIDList = (ArrayList)Session["CHECKED_ITEMS"];

            if (categoryIDList != null)
            {
                if (categoryIDList.Count > 0)
                {
                    foreach (GridViewRow row in GvOtoritasCabang.Rows)
                    {
                        String index = GvOtoritasCabang.DataKeys[row.RowIndex].Value.ToString();

                        CheckBox myCheckBox = (CheckBox)row.Cells[2].FindControl("chkSelect");

                        if (categoryIDList.Contains(index))
                        {
                            myCheckBox.Checked = true;
                        }
                        else
                        {
                            myCheckBox.Checked = false;
                        }
                    }
                }
            }
            else
            {
                foreach(GridViewRow row in GvOtoritasCabang.Rows)
                {
                    CheckBox myCheckBox = (CheckBox)row.Cells[2].FindControl("chkSelect");
                    myCheckBox.Checked = false;
                }
            }
        }
			
			private void Page_Load(object sender, EventArgs e)
			{
				if (!rtwin.azlib.AksesHalaman(25, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
				{
					Response.Redirect("notauthorized.aspx");
				}

                string StrUser = Session["strUser"].ToString();
				
				SqlConnection cn = new SqlConnection(Application["strCn"].ToString());

				string strQuery = "SELECT KODE_LEVEL FROM taUsers Where USERNAME = '" + StrUser + "'";

				DataSet dsLevel = new DataSet();

				SqlDataAdapter adLevel = new SqlDataAdapter(strQuery, cn);

				adLevel.Fill(dsLevel, "T_Level");

				DataTable Mytable = dsLevel.Tables["T_Level"];

				DataRow MyRow = Mytable.Rows[0];
				
				if (MyRow["KODE_LEVEL"].ToString() == "1")
				{
					GvOtoritasCabang.Visible = false;
                    btnUpdate.Visible = false;
					lblKetAdmin.Visible = true;
				}
				
				adLevel.Dispose();
				dsLevel.Clear();
				cn.Close();
				
				if (! Page.IsPostBack)
				{
					lblUser.Text = "User: " + StrUser;
				}
			}

            //fungsi: Handle Ketika data pada database telah diupdate
			protected void dsOtoritasCabang_Updated(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
			{
                //Seleksi apakah terjadi error atau tidak
                //jika tidak ada record yang ter delete maka terjadi error
                if (e.AffectedRows == 0)
                {
                    ExceptionDetails.Text = lblCannotEditApproved.Text; //e.Exception.Message
                    ExceptionDetails.Visible = true;
                    e.ExceptionHandled = true;
                }
                else
                {
                    //Catat ke Log
                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4125", e.Command.Parameters["@USERNAME"].Value + "," + e.Command.Parameters["@KODE_CABANG"].Value, Application["strCn"].ToString());
                }
			}

            //fungsi: Handle Ketika data pada database telah didelete
			protected void dsOtoritasCabang_Deleted(object sender, System.Web.UI.WebControls.SqlDataSourceStatusEventArgs e)
			{
				//Seleksi apakah terjadi error atau tidak
				//jika tidak ada record yang ter delete maka terjadi error
				if (e.AffectedRows == 0)
				{
					ExceptionDetails.Text = lblCannotEditApproved.Text; //e.Exception.Message
					ExceptionDetails.Visible = true;
					e.ExceptionHandled = true;
				}
				else
				{
					//Catat ke Log
					rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4126", e.Command.Parameters["@USERNAME"].Value + "," + e.Command.Parameters["@KODE_CABANG"].Value, Application["strCn"].ToString());
				}
			}
			
            protected void GvOtoritasCabang_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
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
			
			protected void GvOtoritasCabang_DataBound(object sender, EventArgs e)
			{
				if (!Page.IsPostBack)
                {
                    RememberOldValuesFirstTime();
                }
                else
                {
                    RePopulateValues();
                }

                GridViewRow rowPager = GvOtoritasCabang.BottomPagerRow;
				
				if (rowPager != null)
				{
					// get your controls from the gridview
					TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));
					Label lblJumlahHalaman = (Label) (rowPager.Cells[0].FindControl("lblJumlahHalaman"));
					
					txtHalaman.Text = (GvOtoritasCabang.PageIndex + 1).ToString();
					// populate page count
					lblJumlahHalaman.Text = GvOtoritasCabang.PageCount.ToString();
				}
            }

            //fungsi: Handle ketika terjadi Perintah pada GridView
            protected void GvOtoritasCabang_RowCommand(object sender, GridViewCommandEventArgs e)
            {
                if (e.CommandName == "Page")
                {
                    RememberOldValues();
                }
            }
			
			protected void txtHalaman_TextChanged(object sender, EventArgs e)
			{
				GridViewRow rowPager = GvOtoritasCabang.BottomPagerRow;
				TextBox txtHalaman = (TextBox) (rowPager.Cells[0].FindControl("txtHalaman"));
				
				try
				{
					if (int.Parse(txtHalaman.Text)<= GvOtoritasCabang.PageCount + 1 && int.Parse(txtHalaman.Text)> 0)
					{
                        RememberOldValues();
						GvOtoritasCabang.PageIndex = (int.Parse(txtHalaman.Text))- 1;
						GvOtoritasCabang.DataBind();
					}
				}
				catch (Exception)
				{
					txtHalaman.Text = (GvOtoritasCabang.PageIndex + 1).ToString();
				}
			}

            //fungsi: mulai proses update
            protected void btnUpdate_Click(object sender, EventArgs e)
            {
                SqlConnection cn = new SqlConnection(Application["strCn"].ToString());
                SqlCommand cmd = new SqlCommand();
                
                RememberOldValues();

                ArrayList categoryIDList2 = (ArrayList)Session["UNCHECKED"];
                
                int n;

                if (categoryIDList2 != null)
                {
                    if (categoryIDList2.Count > 0)
                    {
                        for (n = 0; n < categoryIDList2.Count; n++)
                        {
                            String KODE_CABANG = categoryIDList2[n].ToString();
                            cmd.CommandText = "DELETE FROM taOtoritasCabang WHERE USERNAME='" + Session["strUser"].ToString() + "' AND KODE_CABANG='" + KODE_CABANG + "'";
                            cmd.CommandType = CommandType.Text;
                            cn.Open();
                            cmd.Connection = cn;
                            try
                            {
                                cmd.ExecuteNonQuery();
                                rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4126", Session["strUser"].ToString(), Application["strCn"].ToString());
                            }
                            catch (Exception ex)
                            {
                                ExceptionDetails.Text = ex.Message;
                                ExceptionDetails.Visible = true; 
                            }
                            cn.Close();
                        }
                    }
                }
                //

                ArrayList categoryIDList3 = new ArrayList();

                DataSet mydataset = new DataSet();

                SqlDataAdapter myadapter = new SqlDataAdapter();

                SqlConnection myconection = new SqlConnection(Application["strCn"].ToString());

                SqlCommand mycommand = new SqlCommand("SELECT KODE_CABANG FROM taOtoritasCabang WHERE (USERNAME = '" + Session["strUser"].ToString() + "')", myconection);
            
                myadapter.SelectCommand = mycommand;
                myadapter.Fill(mydataset, "taCabang");

                /*Seleksi apakah hasil Query null atau tidak
                'jika null maka item hanya null
                'jika tidak null maka item diisi oleh kode range yang didapat*/
                if (mydataset.Tables["taCabang"].Rows.Count == 0)
                {
                    myadapter.Dispose();
                    mydataset.Clear();
                }
                else
                {
                    DataTable myTabel = mydataset.Tables["taCabang"];
                    foreach (DataRow myRow in myTabel.Rows)
                    {
                        categoryIDList3.Add(myRow["KODE_CABANG"].ToString());
                    }
                    myadapter.Dispose();
                    mydataset.Clear();
                }

                //

                ArrayList categoryIDList = (ArrayList)Session["CHECKED_ITEMS"];
                int i;

                if (categoryIDList!= null)
                {
                    if (categoryIDList.Count > 0)
                    {
                        for (i = 0 ;i < categoryIDList.Count;i++)
                        {
                            if (!categoryIDList3.Contains(categoryIDList[i]))
                            {
                                String KODE_CABANG = categoryIDList[i].ToString();
                                cmd.CommandText = "INSERT INTO taOtoritasCabang(USERNAME,KODE_CABANG) VALUES('" + Session["strUser"].ToString() + "','" + KODE_CABANG + "')";
                                cmd.CommandType = CommandType.Text;
                                cn.Open();
                                cmd.Connection = cn;

                                try
                                {
                                    cmd.ExecuteNonQuery();
                                    rtwin.azlib.AddUserAct(Session["UserID"].ToString(), "4125", Session["strUser"].ToString(), Application["strCn"].ToString());
                                }
                                catch (Exception ex)
                                {
                                    ExceptionDetails.Text = ex.Message + " " + KODE_CABANG;
                                    ExceptionDetails.Visible = true;
                                }
                                cn.Close();
                            }
                        }
                    }
                }
            }
    }
		
}
