using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Drawing;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web.Caching;
using System.Diagnostics;
using System.Web.Security;
using System.Text;
using Microsoft.VisualBasic;
using System.Web.UI.HtmlControls;
using System.Web.SessionState;
using System.Text.RegularExpressions;
using System.Web.Profile;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Specialized;
using Udev.MasterPageWithLocalization.Classes;

namespace rtwin
{
    public partial class exportrekap : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            divTable.Visible = false;
            if (!rtwin.azlib.AksesHalaman(32, Session["UserID"].ToString(), Session["GradeID"].ToString(), Session["MenuID"].ToString()))
            {
                Response.Redirect("notauthorized.aspx");
            }

           
            if (!IsPostBack)
            {
                this.BindGrid();
                int bln = DateTime.Now.Month;

                byte i;
                ListItem li = new ListItem();
                for (i = 1; i <= 12; i++)
                {
                    li = new ListItem((DateTime.Parse(i.ToString() + "/" + i.ToString() + " /1900")).ToString("MMMM"), i.ToString()); //Format(DateTime.Parse(CStr(i) & "/" & CStr(i) & " /1900"), "MMMM"), CStr(i))
                    ddlBulan.Items.Add(li);
                }

                ddlBulan.SelectedValue = bln.ToString();
            }
          
        }

        protected void BindGrid()
        {
            GridView1.AllowPaging = false;
        }

        protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }

        protected void ExportToExcel(object sender, EventArgs e)
        {
            Response.Redirect("cs.aspx");
          /*
            string attachment = "attachment; filename=Contacts.xls";

            Response.ClearContent();
            Response.Charset = "";
            Response.AddHeader("content-disposition", attachment);

            Response.ContentType = "application/ms-excel";

            using (StringWriter sw = new StringWriter())
            {

                HtmlTextWriter htw = new HtmlTextWriter(sw);

                GridView1.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in GridView1.HeaderRow.Cells)
                {
                    cell.BackColor = GridView1.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in GridView1.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                            cell.Attributes.Add("class", "textmode");
                        }
                        else
                        {
                            cell.BackColor = GridView1.RowStyle.BackColor;
                            cell.Attributes.Add("class", "textmode");
                        }
                        cell.CssClass = "textmode";
                    }
                }

                // Create a form to contain the grid

                HtmlForm frm = new HtmlForm();

                GridView1.Parent.Controls.Add(frm);

                frm.Attributes["runat"] = "server";

                frm.Controls.Add(GridView1);



                //frm.RenderControl(htw);

                GridView1.RenderControl(htw);
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
              //Response.Write(sw.ToString());
                Response.Output.Write(sw.ToString());
                Response.End();
            }
////=====================================
  /*          Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.xls");
            Response.Charset = "";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);
                 GridView1.AllowPaging = false;
                 GridView1.DataBind();
              
              

                GridView1.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in GridView1.HeaderRow.Cells)
                {
                    cell.BackColor = GridView1.HeaderStyle.BackColor;
                }
                foreach (GridViewRow row in GridView1.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                        }
                        else
                        {
                            cell.BackColor = GridView1.RowStyle.BackColor;
                        }
                        cell.CssClass = "textmode";
                    }
                }

             GridView1.RenderControl(hw);
                HtmlForm frm = new HtmlForm();

                GridView1.Parent.Controls.Add(frm);

                frm.Attributes["runat"] = "server";

                frm.Controls.Add(GridView1);
               // frm.RenderControl(hw);

                //style to format numbers to string
                string style =  @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }*/
        }


        protected void Button1_Click(object sender, EventArgs e)
        {

             divTable.Visible =true;
           //  Button1.Visible = false;
            string bulan = ddlBulan.SelectedValue.ToString();
            string tahun = txtTahun.Text.ToString();
            string jenis = ddlJenis.SelectedValue.ToString();

            string strQuery = "";
            if ((Session["GradeID"].ToString().Substring(0, 1) == "1") || (Session["GradeID"].ToString() == "2"))//admin & validator
            {


                if (Session["GradeID"].ToString() == "2") //validator
                {

                    strQuery = " WHERE KODE_CABANG =" + Session["CabangID"].ToString() + "";

                }
                else if (Session["GradeID"].ToString() == "1a") //operator keuangan 
                {
                    strQuery = " WHERE KODE_CABANG IN (SELECT KODE_CABANG FROM taOtoritasCabang WHERE USERNAME=''" + Session["UserID"].ToString() + "'')";

                }
                else
                {
                    strQuery = "";
                }
            }
            // string strConnString = new SqlConnection(Application["strCn"].ToString()); 
            using (SqlConnection con = new SqlConnection(Application["strCn"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("exec proc_export_tk '" + bulan + "','" + tahun + "','" + jenis + "','"+strQuery+"'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                          //  dsAllowance.d = dt;
                          GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
                    }
                }
            }
            Session["bulan"] = bulan.ToString();
            Session["tahun"] = tahun.ToString();
            Session["jenis"] = jenis.ToString();
            Session["strQuery"] = strQuery.ToString();
          
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }
    }


}